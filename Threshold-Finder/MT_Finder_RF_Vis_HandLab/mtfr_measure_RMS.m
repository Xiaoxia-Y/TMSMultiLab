%% measure RMS for each frame

[rms]=rmtf_measure_RMS(emg_asynch_chunk(:,emg.muscle)*ni_gain);
emg.(emg.choice).rms (p,:) = rms.value;
if p<=windowsize                                                    % control the curse in the tarting position
    emg.(emg.choice).smoothrms(p)=mean(emg.(emg.choice).rms(1:p,emg.muscle),1);                            % if p==1, curse pixel is (xpos(1), ypos(1)). %% second matrix (1 is right,2 is left)
else
    emg.(emg.choice).smoothrms(p)=mean(emg.(emg.choice).rms(p-windowsize+1:p,emg.muscle),1);
end