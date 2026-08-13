%% measure MVC


mvc.rms.average = nan(3,1);                                                 % averaged MVC  
mvc.rms.data = nan(3, 100000);                                              % rms value
mvc.raw.data = nan(3,1000000);                                              % raw value (not sure to use rms or raw data in this case)
mvc.duration = 2;                                                           % MVC duration
trial.mvc.current = 1;                                                      % trial control
trial.mvc.maxtrial = 3;                                                     % number of MVC trials

%% show instrctions
mtfr_present_instruction(win, wsize, ins)                                   % MVC instructions
WaitSecs(1); 
KbWait;

%% trial control
while trial.mvc.current <= trial.mvc.maxtrial                               % test 3 times
    
    %% show instruction (whether participant is ready)
    mtfr_present_instruction(win, wsize, ready);                            % ready
    WaitSecs(1);
    KbWait;                                                                 % press button
    
    %% fixation cross
    Screen('DrawLines', win, fix.line, 2, [255 255 255]);                   % fixition cross
    Screen('Flip', win);  
    WaitSecs(1);                                                            % one second 
    
    %% instruction (squeeze)
    mtfr_present_instruction(win, wsize, squeeze);                           

    %% preallocation 
    mvc.rms.record = [];                                                    % buffer for one trial
    mvc.rms.rawrecord = [];                                                 % buffer for one trial
    
    %% assess data size
    last_n = size(emg_asynch_data(:,emg.muscle));                           % callback control, when we have a new chunk, then use it
    
     %% get time
    mvc.starttime=GetSecs;                                                  % start timer                                          

    %% squeeze duration
    while GetSecs - mvc.starttime <= mvc.duration                           % 2 seconds
        
        %% PROCESS CALLBACKS
        drawnow;

        current_n = size(emg_asynch_data,1);
%         [MVC.rms,options.mep,wait_for_data] = rmtf_acquire_emg_asynch( ... % EXTRACT MEP WINDOW
%             emg_asynch_data(:,emg.muscle) * ni_gain, ...
%             s_asynch.Rate,trigger.onset_ms,emg.mep.record);
        %% acquire rms
        if current_n > last_n
        [rms] = rmtf_measure_RMS(emg_asynch_chunk(:,emg.muscle)*ni_gain);   % require rms
        
        % save rms
        mvc.rms.record = [mvc.rms.record; rms.value];
        mvc.rms.rawrecord = [mvc.rms.rawrecord; emg_asynch_chunk(:,emg.muscle)*ni_gain];
        last_n = current_n;
        end

    end
    
    %% save mvc
    mvc.raw.index = size(mvc.rms.rawrecord,1);
    mvc.raw.data(trial.mvc.current,1:mvc.raw.index) = mvc.rms.rawrecord;
    mvc.rms.index = size(mvc.rms.record,1);
    mvc.rms.data(trial.mvc.current,1:mvc.rms.index) = mvc.rms.record;
    mvc.rms.average(trial.mvc.current,:) = nanmean(mvc.rms.data(trial.mvc.current,1:mvc.rms.index));  % average

    %% instruction (relax)
    mtfr_present_instruction(win, wsize, relax);                            % relax
    WaitSecs(1);

    %% show MVC
    mvc.instruction.t1=(['MaxGrip: ',num2str(mvc.rms.average(trial.mvc.current,:),4)]);    % maxgrip value
    mtfr_present_instruction(win, wsize, mvc.instruction);                  % display maxgrip
    WaitSecs(2);
    
    %% instruction (enourage, show we keep this?)
    mtfr_present_instruction(win, wsize, enc);                
    WaitSecs(1);

    %% whether accepte current value
    accepted = mtfr_askAccept();                                            % ask if we accepte  this trial
    
    if accepted 
        trial.mvc.current = trial.mvc.current + 1;                          
    end

end

%% calculate scale
mvc.value = mean(mvc.rms.average,1);                                        % value of MVC









