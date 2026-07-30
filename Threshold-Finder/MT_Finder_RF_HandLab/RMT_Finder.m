%% CONFIGURE
rmtf_version = 2;   % 1 = Auto RMT-Finder
                    % 2 = Fast Auto RMT-Finder
%% CONSTANTS
rmtf_constants;                                                             % LOAD CONSTANTS

%% SET UP TMS DEVICE
rmtf_tms_configure;                                                         % CONFIGURE MAGIC TMS COMMUNICATION

%% SET UP National Instruments DEVICE
rmtf_ni_configure;                                                          % CONFIGURE NI CARD

%% SET mt
rmtf_set_mt                                                                 % INITIALIZE mt VECTOR 

%% WHILE LOOP CONTROL
run_next_intensity = true;                                                  % TRANSITION TO THE NEXT INTESNITY

while run_next_intensity                                                    % INTENSITY CONTROL

    %% FIND THE CURRENT INTENSITY
    i = rmtf_midpoint(tms.intensity.min,tms.intensity.max);                 % CALCULATE MIDPOINT BETWEEN MIN INTENSITY AND MAX INTENSITY

    %% WHETHER CURRENT i HAS BEEN TESTED
    has_value = rmtf_has_value(mt(i,:));                                    % CHECK IF CURRENT i HAS VALUE

    if has_value                                                            % IF CURRENT i HAS VALUE
        run_next_intensity = false;                                         % STOP TEST
        idx = find(mt(:,1) >= 5, 1, 'first');                               % INDEX FOR MOTOR THRESHOLD
        MT = mt(idx, 1);                                                    % FIND THE MOTOR THRESHOLD
    end

    %% IF CURRENT i has not been tested
    while ~has_value                                                        % IF CURRENT i HAS NOT BEEN TESTED

        %% SET TMS, mt, T, AND CLOCK
        rmtf_set_initialization;                                            % INITIALIZATION

        drawnow;                                                            % ALLOW THE BACKGROUD CALLBACK TO UPDATA THE THE EMG DATA

        %% IS THE TIME FIFFERENCE BETWEEN THE NEXT PULSE ADN THE PREVIOUS PULSE GREATER THAN TMS INTERVAL
        [wait,tms.clock,tms.update.time] = rmtf_wait(tms.interval,tms.trigger.time); % CHECK TIME INTERIVAL 

        %% MEASURE RMS
        [rms] = rmtf_measure_RMS(emg_asynch_chunk(:,emg.muscle) * ni_gain);   % MEASURE RMS FOR EACH CHUNK OF DATA

        %% ASSESS RMS 
        [rms.inrange] = rmtf_is_in_range(rms.value,emg.rms.min,emg.rms.max);  % ASSESS WHETHER RMS IS IN RANGE
        
        %% PRESENT TMS 
        [tms] = rmtf_present_TMS(s_tms,tms,rms.inrange,wait);                 % PRESENT TMS IF ALL CRITERIONS MET

        %% ACQUIRE EMG 
        if ~isempty(emg_asynch_data)                                        % WHEN EMG_ASYNCH_DATA COLLECTED DATA
            
            %% DETECT TRIGGER 
            [trigger] = rmtf_trigger(emg_asynch_data(:,emg.trigger), s_asynch.Rate); % WHETHER TRIGGER DETECTED

            %% ACQUIRE EMG
            if trigger.active  
                options.before = emg.mep.record.start;                      % TIME BEFOR THE PULSE 
                options.after  = emg.mep.record.end;                        % TIME AFTER THE PULSE
                [asynch_data,options,wait_for_data] = rmtf_acquire_emg_asynch( ... % EXTRACT MEP WINDOW 
                    emg_asynch_data(:,emg.muscle) * ni_gain, ...
                    s_asynch.Rate,trigger.onset_ms,options);
                
                %% SAVE MEP WINDOW (This is useful for averaging multiple pulses) 
                if ~wait_for_data
                    emg.asynch.data(T,:) = asynch_data;                     % SAVE MEP WINDOW FOR CURRENT PULSE
                end

                %% UPDATE T
                [T] = rmtf_update_valid(T, ~wait_for_data, 1);              % UPDATA T WHEN WE ACQUIRED MEP WINDOW
            end

        end

        %% CHECK WHETHER ENOUGH TRIALS HAVE BEEN COMPLETED
        [trial.count] = rmtf_count(T,tms.trials);                           % T = trials?

        if trial.count && ~wait_for_data                                    % WHEN HAVE ENOUGH TRIALS AND MEP WINDOW
            
            T = 0;

            %% CLEAN BUFFER AND REOPEN S_ASYNCH
            stop(s_asynch);                                                 % STOP ASYNCH
            emg_asynch_data = [];                                           % CLEAN BUFFER
            emg_asynch_time = [];                                           % CLEAN BUFFER
            s_asynch.startBackground();                                     % START ASYNCH

            %% AVERAGE MEP
            [average] = rmtf_average(emg.asynch.data);                      

            %% MEASURE MEP
            options.baseline = 1:(abs(emg.mep.record.start)-1);
            [mep,options] = MEP(average, s_asynch.Rate, abs(emg.mep.record.start),options);

            %% ASSESS MEP
            [mep.inrange] = rmtf_is_in_range(mep.amp(1),emg.mep.min,emg.mep.max); % WHETHER MEP IS IN RANGE

            %% UPDATE mt
            mt(i,1) = rmtf_update_valid(mt(i,1), mep.inrange, 1);           % SET mt(i,1)+1
            mt(i,2) = rmtf_update_valid(mt(i,2), ~mep.inrange, 1);          % SET mt(i,2)+1

            %% ASSESS mt
            [hit.count] = rmtf_count(mt(i,1),tms.hit);                      % mt(i,1) == tms.hit?
            [miss.count] = rmtf_count(mt(i,2),tms.miss);                    % mt(i,2) == tms.miss?
            
            if hit.count
                %% update max intensity
                [tms.intensity.max] = rmtf_update_valid(i, hit.count, -1);  % SET Max = i - 1
            elseif miss.count
                %% update min intensity
                [tms.intensity.min] = rmtf_update_valid(i, miss.count, 1);  % SET Min = i + 1
            end

            %% Exit CURRENT INTENSITY
            if hit.count || miss.count
                has_value = 1;                                              % EXIT CURRENT INTENSITY
                TMS.disarm();                                               % DISARM TMS
            end

        end
            
    end

end


