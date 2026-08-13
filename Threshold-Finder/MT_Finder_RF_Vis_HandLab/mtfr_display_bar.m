function [rms,bar,target,options] = mtfr_display_bar(MVC,baseline,RMS,win,wsize,options)
% This function displays a bar and a target. The bar can represent grip force.
% Each RMS vector corresponds to one display frame. When used in a while loop,
% this function provides real-time feedback.

%% RMS(Nx1) -> vevtor for rms 
%% MVC && baseline of grip force
%% win & wsize related to the psychtoolbox
%% options




%% options
if ~isfield(options,'boxbottom')
    options.boxbottom = 1000;                                                % Starting position of the bar
end

if ~isfield(options,'Yrange')
    options.Yrange = 950;                                                   % display range of y axis                                                     
end

if ~isfield(options,'gain')
    options.gain = 0.3;                                                     % MVC target proportion
end

if ~isfield(options,'line') || ~isfield(options.line,'color')               % target line color
    options.line.color = [255,0,0];
end

if ~isfield(options,'center')
    options.center = wsize(3)/2;                                            % position of display center
end

if ~isfield(options,'barWidth')
    options.barWidth = 150;                                                 % grip bar width
end

if ~isfield(options,'line') || ~isfield(options.line,'Width')
    options.line.Width = 3;                                                 % target line width
end 

if ~isfield(options,'line') || ~isfield(options.line,'overlength')
    options.line.overlength = 100;                                          % how long does line longer than bar
end


%% boxscale
bar.scale = options.Yrange ./ (MVC - baseline);                             % scaling factor to convert dynamo to pixels, where 100%=whole screen

%% filter the RMS 
rms.mean = mean(RMS);                                                       % filter the rms 

%% bar points
bar.current_high = options.boxbottom-rms.mean*bar.scale;                    % high of the bar, related to the current rms                   

%% target line coordinate
target.line.Ypostion = options.boxbottom - (MVC-baseline).*options.gain.*bar.scale;  % line position in pixels (converted from dyna)_left hand
target.line.position=[
    options.center - options.barWidth/2 - options.line.overlength,...
    target.line.Ypostion,...
    options.center + options.barWidth/2 + options.line.overlength,... 
    target.line.Ypostion
    ];


%% target window
target.window.bottom = options.boxbottom - (MVC-baseline) .* (options.gain) .* bar.scale;   % bottom of window
target.window.top = options.boxbottom - (MVC-baseline).*(options.gain + 0.1) .* bar.scale;  % top of window


%% target Line color change
if target.window.bottom >= bar.current_high && bar.current_high >= target.window.top   % participants reach the target
    options.line.color = [255,0,0];                                         % change to red line
else
    options.line.color = [255,255,255];                                     % keep white line
end


%% draw target line
Screen('Drawline',win,options.line.color,target.line.position(1),target.line.position(2),target.line.position(3),target.line.position(4),options.line.Width);


%% bar position
bar.position=[
    options.center - options.barWidth/2,... 
    bar.current_high,... 
    options.center + options.barWidth/2,...
    options.boxbottom
    ];                                                                      % rectangle coordinates for the grip box (right hand)


%% show bar
if ~isempty(bar.position) && bar.current_high<options.boxbottom              % if participants grip
    Screen('FillRect',win,[255 0 0],bar.position);                           % show grip bar
end

%% judgement if reach the target 
target.inwindow.count = bar.current_high<= (options.boxbottom-(MVC-baseline)*(options.gain*bar.scale)) && bar.current_high>=target.window.top; % participants reach the target?

%% timer
target.clock = GetSecs;                                                     % record start time for time loop to control TMS

end


