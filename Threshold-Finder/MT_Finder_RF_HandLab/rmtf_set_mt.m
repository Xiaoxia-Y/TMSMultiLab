%% set posiible intensities that could use for detecting threshold 
% tms.intensity.min: the min possible value
% tms.intensity.max: the max possible value
% tms.resolution: granularity (1%) 
% The first column of the mt vector is set to values ranging from tms.intensity.min : resolution : tms.intensity.max


% COLUMNS
% 1 HITS at this intensity
% 2 MISSES at this intensity
% 3 INTENSITY = tms.resolution : tms.resolution : tms.intensity.max
% 4 INDEX to this intensity


% intensity here
tms.intensity.range = tms.intensity.min : tms.resolution: tms.intensity.max;% MSO


% index here
tms.index.range = 1:length(tms.intensity.range);                            % position in array

% set vector
mt = nan(length(tms.index.range),4);                                        % vector for possible intensities (mt(min %MSO : max %MSO,[valid,invalid]);
mt(:,3) = tms.intensity.range;                                              % column 3: intensity
mt(:,4) = tms.index.range;                                                  % column 4: index 


% save variables
tms.maxtrial = 10;
emg.data.raw = nan(length(tms.index.range),tms.maxtrial,emg.asynch.samplesize);     % raw data of each pulse
emg.data.average = nan(length(tms.index.range),tms.maxtrial,emg.asynch.samplesize); % averaged data
emg.baseline.raw = nan(length(tms.index.range),tms.maxtrial,emg.baseline.samplesize);         % raw data of emg before the pulse
emg.mep.summary = nan(length(tms.index.range),tms.maxtrial,5);                      % columns: 1-> miss or hit, 2-> mep amplitude, 3-> rms amplitude 4-> criterion 5-> intensity


