Screen('DrawText',win,text.t7,wsize(3)/2-100,wsize(4)/2,[255 255 255]);
Screen('Flip',win);
WaitSecs(1);
pedal_control=s_synch.inputSingleScan;
while pedal_control(emg.pedal)==0
    pedal_control=s_synch.inputSingleScan;                                     % check inputs
end