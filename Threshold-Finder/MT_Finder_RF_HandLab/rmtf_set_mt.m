%% set posiible intensities that could use for detecting threshold 
% tms.intensity.min: the min possible value
% tms.intensity.max: the max possible value
% g: granularity (1%)
% The first column of the mt vector is set to values ranging from 1 to tms.intensity.max.
% This allows the current intensity (i) to be located directly in the first column
% rather than by using an index. A more efficient implementation will be added later.

mt=nan(tms.intensity.max,2);                                 % vector for possible intensities (mt(min %MSO : max %MSO,[valid,invalid]);