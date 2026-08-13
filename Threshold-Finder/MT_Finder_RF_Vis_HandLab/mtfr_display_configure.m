%% display constant
Screen('Preference', 'SkipSyncTests', 3);                                   % start psychtoolbox
[win,wsize]=Screen('Openwindow',1,[0 0 0]);                                 % open window


%% constant of Display
display.startY = 1000;                                                      % start coordinate of y axis
display.endY = 50;                                                          % end coordinate of y axis
display.Yrange = display.startY - display.endY;                             % y range                                   
display.crossSize = 20;                                                     % the size of fixition cross                                        
display.boxbottom = 1000;                                                   % coordinate on the screen
display.gain = 0.3;                                                         % percentage of MVC
display.center = wsize(3)/2;                                                % coordinate of center
display.barWidth = 150;                                                     % force bar width 
display.line.Width = 3;                                                     % target line width
display.line.overlength = 100;                                              % the length that target longer than bar
display.line.color = [255,0,0];                                             % line color


%% constant of emg
emg.filter.size =60;                                                        % filter window
emg.startin = 0;                                                            % in window control
emg.inwindow.tolerate = 0.2;                                                % Time the participant stays within the target window before delivering the TMS pulse.

%% constant of MVC
mvc.proportion=[0.1;0.2;0.3;0.4];                                           % The proportions of MVC

