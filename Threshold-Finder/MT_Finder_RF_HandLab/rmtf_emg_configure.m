%% DEFINE CONSTANTS FOR HOW THE ALGORITHM WILL RUN
% This section defines the EMG acceptance criteria, MEP measurement
% windows, threshold-search rules, TMS intensity limits, and inter-pulse
% intervals used by the resting motor threshold procedure.
% Please check these settings before running the program.

% EMG-RELATED

% RMS-RELATED
emg.rms.duration = 150;                                                     % duration for RMS recording to check background EMG signal (seconds)
% emg.rms.after = -2;                                                           % when to stop record the RMS (relative to the TMS pulse, seconds)
% emg.rms.before = emg.rms.after - emg.rms.duration;                             % when to record the RMS (relative to the TMS pulse, seconds)
emg.rms.min = 0;                                                            % minimum acceptable RMS to trigger a TMS pulse (same unit as the powerlab)
emg.rms.max = 0.01;                                                         % maximum acceptable RMS to trigger a TMS pulse (same unit as the powerlab)

% BASELINE-RELATED
emg.baseline.before = -50;
emg.baseline.after = -20;



% MEP-RELATED
emg.mep.on = 10;                                                            % start of MEP measurement window after TMS
emg.mep.off = 50;                                                           % end of MEP measurement window after TMS
emg.mep.min = 0.05;                                                         % minimum acceptable MEP amplitude for a Hit (mV)
emg.mep.max = Inf;                                                          % maximum acceptable MEP amplitude for a Hit (mV)
emg.mep.record.before = -300;                                                % start of recorded EMG epoch relative to TMS (ms)
emg.mep.record.after = 700;                                                   % end of recorded EMG epoch relative to TMS (ms)

% emg.mep.subtract_baseline = true / false % subtract emg p-to-peak from mep?






