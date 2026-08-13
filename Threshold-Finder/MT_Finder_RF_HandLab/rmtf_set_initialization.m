%% Preallocation for the progromme
% Initialize these variables when the current intensity (i) is NaN.
% Once mt(i,:) is set to 0, this condition will no longer be true.
% This ensures that the TMS can only be armed once.

if sum(isnan(mt(idx,1:2)))==2                                                         

    %% set intensity
    TMS.setAmplitudeA(i); % i used as an INTENSITY

    %% Mark this intensity as initialized
    mt(idx,1:2) = 0; % idx used as an index

    %% Reset the TMS trials (repetitions per average MEP) pulse count (from 0 to tms.trials)
    T = 0;

    %% clock for the pulse
    clock = GetSecs;

    %% arm TMS 
    TMS.arm();

end
