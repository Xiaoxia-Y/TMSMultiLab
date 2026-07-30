%% display MVC
current_high=(boxbottom-emg.(emg.choice).smoothrms(p)*boxscale);
target_window_bottom=(boxbottom-(maxGrip-initialRMSE).*(MVC_proportion(qn))*boxscale);
target_window_top=(boxbottom-(maxGrip-initialRMSE).*(MVC_proportion(qn)+0.1)*boxscale);
%% 30% MVC target Line
if target_window_bottom >= current_high && current_high >= target_window_top % participants reach the target
    line_color=[255,0,0];                                                    % change to red
else
    line_color=[255,255,255];                                                % keep white
end
%% qn_number
qn_number=(['qn: ',num2str(qn)]);
Screen('DrawText',win,qn_number,wsize(3)/2+400,wsize(4)/2+450,[255 255 255]);
%% reach or not reach the traget
Screen('Drawline',win,line_color,linePosition(1),linePosition(2),linePosition(3),linePosition(4),2); % if hand=1, show left targe
