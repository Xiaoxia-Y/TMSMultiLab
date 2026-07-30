%% Acquire EMG data synch
% not sure should we calculate RMS after collect enough data or use RMS window average data (the first one is more fluent on screen) 

for f=1:emg.rms.sample                                                      % sample number
    emg.(emg.choice).data(f,p,:)=s_synch.inputSingleScan*ni_gain;                      % 1.2ms (60 samples = 72ms = 4.3 frames)
    emg.(emg.choice).time(f,p,:)=toc;                                                % toc for each data point
end
