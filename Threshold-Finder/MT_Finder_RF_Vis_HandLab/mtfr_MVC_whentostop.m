if timeinwindow>=4 && pedal(p,emg.pedal)==1
    running=false;
    trigger_channel=reshape(emg.(emg.choice).data(:,:,emg.trigger),[],1);  % trigger channel (channel 1)
    time_channel=reshape(emg.(emg.choice).time(:,:,1),[],1);
    trigger_index=find(time_channel>inwindow_time,1,"first");
    trigger_channel(trigger_index)=5;
    emg_channel=reshape(emg.(emg.choice).data(:,:,emg.muscle),[],1);    % emg_channel
    Data(qn,:,1)=emg_channel;                                           % save trigger channel
    Data(qn,:,2)=trigger_channel;                                       % save trigger channel
    Data(qn,:,3)=time_channel;                                          % save time
    emg.mvc.data(:,:,:)=nan;                                            % refresh
    qn=qn+1;                                                            % add a trial
end