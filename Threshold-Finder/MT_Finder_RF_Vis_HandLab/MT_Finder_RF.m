%% CONFIGURE
rmtf_version = 2;   % 1 = Auto RMT-Finder
                    % 2 = Fast Auto RMT-Finder
%% CONSTANTS
rmtf_constants;                                                             % LOAD CONSTANTS
mtfr_MVC_constant;
%% SET UP TMS DEVICE
%rmtf_tms_configure;                                                         % CONFIGURE MAGIC TMS COMMUNICATION

%% SET UP National Instruments DEVICE
rmtf_ni_configure;                                                          % channels configration
stop(s_asynch);
global emg_asynch_data emg_asynch_time emg_asynch_chunk emg_asynch_chunktime
emg_asynch_data=[];
emg_asynch_time=[];
s_asynch.startBackground();
%% SET UP VECTOR FOR mt
%rmtf_possible_threshold                                                     % set vector for possible intensities used to detecting threshold

mtfr_MVC_instructions;
mtfr_MVC_constant;
mtfr_initial_RMS;
mtfr_max_RMS;



choice=3;
mtfr_MVC_show_instrction;
% mtfr_MVC_waitpedal; 
%% main part
emg.choice=emg.segment.choice{choice};
mvc.startin=0;                                                              % initialize (time interval that participants stay in the target window)
mtfr_switch_mvc;
while_choice =true;
while while_choice                                                          % time loop for TMS - time since the last TMS pulse (or start of hand)
    mtfr_preallocation_candelectwhenfinish;
    while running
        drawnow
        p=p+validp;                                                         % if p is valid (subject is relaxed), add one p
        mtfr_measure_RMS;
        mtfr_display_MVC;
        mtfr_MVC_judgement;
        Screen('Flip',win);
    end
    mtfr_show_relax;
end
