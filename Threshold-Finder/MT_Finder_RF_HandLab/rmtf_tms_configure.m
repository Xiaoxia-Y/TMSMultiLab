%% DESIGN for TMS__________________________________________________________
tms.trials = 1;                                                             % average this number of trials before assessing MEP amplitude
tms.hit = 5;                                                                % need this many hits before changing intensity
tms.miss = 6;                                                               % need this many misses before changing intensity
tms.currenttrial = 0;                                                       % pulse count


% TMS interval
% Different TMS intervals are used in different versions
switch rmtf_version

    case 1                                                                  % AUTO
        tms.interval = 7.5 + (rand - 0.5) * 5;  % NEED RANGE HERE [5, 10] ? % min and max interval between TMS pulses
        tms.intensity.min = 20;                                             % min TMS intensity
        tms.intensity.max = 90;                                             % max TMS intensity

    case 2                                                                  % RAPID AUTO
        tms.interval = 4.5;                                                 % fixed interval between TMS pulses
        tms.intensity.hotspot = str2double(inputdlg('TMS hotspot intensity (approx) %MSO'));
        tms.intensity.min = tms.intensity.hotspot-10;                       % min TMS intensity
        tms.intensity.max = tms.intensity.hotspot+10;                       % max TMS intensity

    otherwise
        tms.interval = str2double(inputdlg('TMS interval'));                % custom
        tms.intensity.min = str2double(inputdlg('TMS minimum intensity'));  % custom
        tms.intensity.max = str2double(inputdlg('TMS maximum intensity'));  % custom

end

%% SET UP TMS MACHINE - REQUIRES MAGIC TOOLBOX_____________________________
% Please check the COM port for your TMS device before running this program
tms.port = 'COM8';                                                          % serial port address to control your Magstim TMS machine
tms.resolution = 1;                                                         % interval between successive TMS intensities, in % MSO
TMS = magstim(tms.port);                                                    % use MAGIC toolbox to control Magstim TMS
TMS.connect();                                                              % establish a connection
tms.trigger.time = 0;                                                       % initialise start time for TMS interval
tms.trigger.condition = false;                                              % has TMS been presented?
tms.intensity.sequence = [];                                                % vector contains a sequence of intensity values





