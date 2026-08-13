%% measure baseline when participant relax 

%% initialize trial
trial.baseline = 1;
baseline.mean = [];
baseline.duration = 2;                                                      % seconds

%% trial control
while trial.baseline <= 1
    %% show instructions
    mtfr_present_instruction(win, wsize, relax);                           % relax hand, record initialgrip
    
    %% get time 
    baseline.starttime = GetSecs;

    %% 2s duration for recording baseline
    while GetSecs - baseline.starttime <= baseline.duration
        
        %% PROCESS CALLBACKS
        drawnow;

        %% Require rms 
        [rms.baseline] = rmtf_measure_RMS(emg_asynch_chunk(:,emg.muscle)*ni_gain);

        %% save baseline mean
        baseline.mean = [baseline.mean, rms.baseline.value];
    end
    
    %% fixation cross
    Screen('DrawLines', win, fix.line, 2, [255 255 255]);                   % cross
    Screen('Flip', win);
    
    %% wait 
    WaitSecs(1);
    
    %% calculate baselie
    baseline.value = nanmean(baseline.mean);                                  % left hand initial
    
    %% show baseline
    basline.t1=(['initialGrip_L: ',num2str(baseline.value)]);                  % display
    mtfr_present_instruction(win, wsize, basline);                       % relax hand, record baseline
    
    %% wait
    WaitSecs(2);
    
    %% whether accept values
    accepted = mtfr_askAccept();
    if accepted 
        trial.baseline = trial.baseline + 1;
    end

end