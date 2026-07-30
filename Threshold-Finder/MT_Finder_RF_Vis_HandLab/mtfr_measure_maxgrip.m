function [max] = mtfr_measure_maxgrip(data,trials,trial_duration,asynch_rms)
%% data -> N*1 emg_asynch_chunk(:,emg.muscle)*ni_gain  
%% asynch_rms, is your collect system asynch or synch

options.crosssize = 


%% instructions for detecting MVC
text.t1= 'You will see a fixation cross on the screen. Please look at the fixation cross and get ready.';
text.t2= 'When SQUEEZE appears, Please pinch the dynamometer with your thumb and index finger as hard and as quick as you can';
text.t3= 'Each grip will last for 2 seconds, Please exert force during that time';
text.t4= 'Before the grip strength task starts, make sure you are ready';
text.t5= 'When you are ready, please press any key to start';
text.t6= 'Are you ready?';
text.t7= 'Please relax';
text.t8= 'You are doing excellent job';
text.t9= 'SQUEEZE';

%% preallocations
max.rms = nan(trials,100000);
max.mean = nan(trials,1);

%% instrctions for how to do the Maxmimum contruction
DrawFormattedText(win,text.t1,'center',wsize(4)/2-8*crossSize,[255 255 255]); % instruction
DrawFormattedText(win,text.t2,'center',wsize(4)/2-4*crossSize,[255 255 255]); % instruction
DrawFormattedText(win,text.t3,'center',wsize(4)/2,[255 255 255]);             % instruction
Screen('Flip',win);                                                           % flip instruction
KbWait;

%% record RMS for MVC 
current_trial = 1;
while current_trial < trials + 1                                              % trials for MVC
    %% make sure participant is ready
    DrawFormattedText(win,text.t4,'center',wsize(4)/2-8*crossSize,[255 255 255]); 
    DrawFormattedText(win,text.t5,'center',wsize(4)/2-4*crossSize,[255 255 255]); 
    DrawFormattedText(win,text.t6,'center',wsize(4)/2,[255 255 255]);         
    Screen('Flip',win);

    %% fixation cross
    Screen('Drawline',win,[255 255 255],wsize(3)/2-crossSize,wsize(4)/2,wsize(3)/2+crossSize,wsize(4)/2,2); % cross
    Screen('Drawline',win,[255 255 255],wsize(3)/2,wsize(4)/2-crossSize,wsize(3)/2,wsize(4)/2+crossSize,2); % cross
    Screen('Flip', win);
    WaitSecs(1);

    %% squeeze instruction
    Screen('DrawText',win,text.t9,wsize(3)/2-50,wsize(4)/2,[255 255 255]);   % instruction
    Screen('Flip',win);

    max.starttime=GetSecs;                                                   % when did the MVC start
    
    %% flush max.data
    max.data = [];                                                           % pre allocation for the rms raw data                                     
    
    %% record max data
    while GetSecs - max.starttime <= trial_duration                          % trial duration for each measurement
        if asynch_rms
            drawnow                                                              % if it's asynch, drownow is needed
        end
        [max]=rmtf_measure_RMS(data);
        max.data= [max.data, max.value];
    end

    %% save data
    index = size(max.data,2);                                               % find how many rms we collected
    max.rms(current_trial,1:index) = [max.data];                            % save all the values for this trial
    max.mean(current_trial,:) = nanmean(max.rms(current_trial,1:index));    % average all the rms we received
    
    %% show feedback
    Screen('DrawText',win,text.t7,wsize(3)/2-100,wsize(4)/2,[255 255 255]); % instruct participant to relax
    Screen('Flip',win);
    WaitSecs(1);
    maxGripText=(['MaxGrip: ',num2str(max.mean(current_trial,1),4)]);          % display maxgrip value
    Screen('DrawText',win,maxGripText,wsize(3)/2-300,wsize(4)/2,[255 255 255]);% display maxgrip value
    Screen('Flip',win);
    WaitSecs(2);
    DrawFormattedText(win,text.t8,'center',wsize(4)/2,[255 255 255]);       % encourage participant
    Screen('Flip',win);
    WaitSecs(1);


    %% whether accept the value
    reply=input('Accepted (y) or Not accepted (n)? [y]\n','s');             % whether accept the value
    
    if isempty(reply)                                                       % if reply = 1, which means accept
        reply = 'y';
    end

    if reply=='y'                                                           % if yes, move to the next one
        current_trial = current_trial + 1;
    end

end

%% finial MVC
max.grip = mean(max.mean,1);                                                % average all trials' averaged MVC                                       
