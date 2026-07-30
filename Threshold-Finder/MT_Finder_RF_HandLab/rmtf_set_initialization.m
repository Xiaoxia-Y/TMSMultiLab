%% Preallocation for the progromme
% Initialize these variables when the current intensity (i) is NaN.
% Once mt(i,:) is set to 0, this condition will no longer be true.
% This ensures that the TMS can only be armed once.

if isnan(mt(i,:))                                                          

    %% set intensity
    TMS.setAmplitudeA(i);

    %% Mark this intensity as initialized
    mt(i,:)= 0;

    %% Reset the time pulse count
    T=0;

    %% clock for the pulse
    clock = GetSecs;

    %% arm TMS 
    TMS.arm();

end
