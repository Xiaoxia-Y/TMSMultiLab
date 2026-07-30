%% DEFINE CONSTANTS FOR HOW THE ALGORITHM WILL RUN
% This section defines the EMG acceptance criteria, MEP measurement
% windows, threshold-search rules, TMS intensity limits, and inter-pulse
% intervals used by the resting motor threshold procedure.
% Please check these settings before running the program.

% EMG-RELATED
emg.rms.duration = 0.1;                                                     % duration for RMS recording to check background EMG signal (seconds)
emg.rms.start = -0.102;                                                     % when to record the RMS (relative to the TMS pulse, seconds)
emg.rms.end = -0.002;                                                       % when to stop record the RMS (relative to the TMS pulse, seconds)
emg.rms.min = 0;                                                            % minimum acceptable RMS to trigger a TMS pulse (same unit as the powerlab)
emg.rms.max = 10;                                                           % maximum acceptable RMS to trigger a TMS pulse (same unit as the powerlab)

emg.mep.on = 10;                                                            % start of MEP measurement window after TMS
emg.mep.off = 50;                                                           % end of MEP measurement window after TMS
emg.mep.min = 0.05;                                                         % minimum acceptable MEP amplitude for a Hit (mV)
emg.mep.max = Inf;                                                          % maximum acceptable MEP amplitude for a Hit (mV)
emg.mep.record.start = -50;                                                 % start of recorded EMG epoch relative to TMS (ms)
emg.mep.record.end = 100;                                                   % end of recorded EMG epoch relative to TMS (ms)

% DESIGN for TMS
tms.trials = 1;                                                             % average this number of trials before assessing MEP
tms.hit = 5;                                                                % need this many hits before changing intensity
tms.miss = 6;                                                               % need this many misses before changing intensity
g = 1;                                                                      % TMS granularity

% TMS interval
% Different TMS intervals are used in different versions
switch rmtf_version

    case 1                                                                  % AUTO
        tms.interval = 7.5 + (rand - 0.5) * 5;                              % min and max interval between TMS pulses
        tms.intensity.min = 20;                                             % min TMS intensity
        tms.intensity.max = 90;                                             % max TMS intensity

    case 2                                                                  % RAPID AUTO
        tms.interval = 4.5;                                                 % fixed interval between TMS pulses
        tms.intensity.hotspot = str2double(inputdlg('TMS hotspot intensity (approx) %MSO'));
        tms.intensity.min = tms.intensity.hotspot-10;                       % min TMS intensity
        tms.intensity.max = tms.intensity.hotspot+10;                       % max TMS intensity

    otherwise
        tms.interval = str2double(inputdlg('TMS interval'));                % custom
end
                                       








