%% wait pedal
pedal_control=s_synch.inputSingleScan;
while pedal_control(emg.pedal)==0
    pedal_control=s_synch.inputSingleScan;                                  % check inputs
end 