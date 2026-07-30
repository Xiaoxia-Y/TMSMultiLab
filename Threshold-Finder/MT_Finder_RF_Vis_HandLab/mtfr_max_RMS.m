%mtfr_MVC_constant;
emg.max.data=nan(emg.rms.sample,emg.rms.number,6);
Xrange=endX-startX;                                                         % x range
Yrange=startY-endY;                                                         % y range
maxRMSE=nan(3,1);
%% show instrctions
DrawFormattedText(win,text.t1,'center',wsize(4)/2-8*crossSize,[255 255 255]); % instruction
DrawFormattedText(win,text.t2,'center',wsize(4)/2-4*crossSize,[255 255 255]); % instruction
DrawFormattedText(win,text.t3,'center',wsize(4)/2,[255 255 255]);             % instruction
Screen('Flip',win);                                                           % flip instruction
KbWait;
mvc.RMS = nan(3, 100000);
%% record RMS for MVC 
trial_max = 1;
while trial_max < 4                                                         % test 3 times
    mtfr_ready_instruction;
    mvc.starttime=GetSecs;
    mvc.mean = [];
    while GetSecs - mvc.starttime <= 2
        drawnow
        [rms]=rmtf_measure_RMS(emg_asynch_chunk(:,emg.muscle)*ni_gain);
        mvc.mean= [mvc.mean, rms.value];
    end
    index = size(mvc.mean,2);
    mvc.RMS(trial_max,1:index) = [mvc.mean];
    maxRMSE(trial_max,:) = nanmean(mvc.RMS(trial_max,1:index));             % average
    Screen('DrawText',win,text.t7,wsize(3)/2-100,wsize(4)/2,[255 255 255]); % instruction
    Screen('Flip',win);
    WaitSecs(1);
    maxGripText=(['MaxGrip: ',num2str(maxRMSE(trial_max,1),4)]);             % display maxgrip for left hand
    Screen('DrawText',win,maxGripText,wsize(3)/2-300,wsize(4)/2,[255 255 255]);
    Screen('Flip',win);
    WaitSecs(2);
    DrawFormattedText(win,text.t8,'center',wsize(4)/2,[255 255 255]);
    Screen('Flip',win);
    WaitSecs(1);
    reply=input('Accepted (y) or Not accepted (n)? [y]\n','s');             % whether accept the value
    if isempty(reply)
        reply = 'y';
    end
    if reply=='y'                                                           % if yes, move to the next one
        trial_max=trial_max+1;
    end
end
maxGrip=mean(maxRMSE(:,:),1);
boxscale=Yrange./(maxGrip-initialRMSE);                            % scaling factor to convert dynamo to pixels, where 100%=whole screen