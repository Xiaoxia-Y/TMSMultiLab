
trial_initial = 1;
initial.mean =[];
while trial_initial <= 1
    DrawFormattedText(win,text.t7,'center','center',[255 255 255]);         % relax hand, record initialgrip
    Screen('Flip',win);
    initial.starttime = GetSecs;
    while GetSecs - initial.starttime <= 2
        drawnow;
        [rms]=rmtf_measure_RMS(emg_asynch_chunk(:,emg.muscle)*ni_gain);
        initial.mean= [initial.mean, rms.value];
    end
    Screen('Drawline',win,[255 255 255],wsize(3)/2-crossSize,wsize(4)/2,wsize(3)/2+crossSize,wsize(4)/2,2);
    Screen('Drawline',win,[255 255 255],wsize(3)/2,wsize(4)/2-crossSize,wsize(3)/2,wsize(4)/2+crossSize,2);
    Screen('Flip', win);
    WaitSecs(1);
    initialRMSE=nanmean(initial.mean);                                % left hand initial
    initialGripText_L=(['initialGrip_L: ',num2str(initialRMSE)]);         % display
    Screen('DrawText',win,initialGripText_L,wsize(3)/2-300,wsize(4)/2,[255 255 255]); % instruction
    Screen('Flip',win);                                                     % flip
    WaitSecs(2);
    reply=input('Accepted (y) or Not accepted (n)? [y]\n','s');             % accept or not accept the initial
    if isempty(reply)                                                       % is yes, reply = y
        reply = 'y';
    end
    if reply=='y'                                                           % if yes, stop the while loop
        trial_initial=trial_initial+1;
    end
end