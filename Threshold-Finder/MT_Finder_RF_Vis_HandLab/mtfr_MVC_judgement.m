%% determine whether the participant's grip reached the target

if p<=windowsize
    if emg.(emg.choice).smoothrms(p)>initialRMSE % smoothRMSE(p,1)>initialRMSE_R  %% if EMG not relaxed, then frame not valid
        validp=0;
        Screen('DrawText',win,text.t7,312.5,482.5,[255 255 255 255]); % show please relax
    else
        validp=1;                                                   % smoothRMSE(p,1)<initialRMSE_R  %% if EMG not relaxed, then frame not valid
    end
else
    %% (RMSE diff) x Gain -> pixel
    %% RMSE velocity (rmse(p)-rmse(p-1))/(t(p)-t(p-1)) x Gain -> pixel
%    pedal(p,:)=s_synch.inputSingleScan;                                % add pedal channel
    barPosition=[position+coordi_box_x,current_high,position+barWidth/2+coordi_box_y,boxbottom]; % rectangle coordinates for the grip box (right hand)
    if ~isempty(barPosition) && current_high<boxbottom              % if participants grip
        Screen('FillRect',win,[255 0 0],barPosition);               % show grip bar
    else                                                            % if not
        Screen('FillRect',win,[255 0 0],defaultBarPosition);        % show defalt
    end
    inwindow = current_high <= (boxbottom-(maxGrip-initialRMSE)*(MVC_proportion(qn)*boxscale))  && current_high>=target_window_top; % participants reach the target (left hand)?
    mvc.time = toc;                                                  % record start time for time loop to control TMS
    if inwindow
        if mvc.startin == 0                                             % if this is the first frame inside window
            mvc.startin = mvc.time;                                      % record start time
        end
        timeinwindow = mvc.time - mvc.startin;                           % duration in the target window
        if timeinwindow >= 0.1 && timeinwindow <= 0.2                          % participants reach the target
            %% trigger the TMS
            inwindow_time=toc;
        end
        %% determine when to stop or trigger (add trigger)
        if choice==2
        mtfr_MVC_whentostop;
        end
    else
        mvc.startin = 0;                                                % reset timeinwindow to 0
    end
end