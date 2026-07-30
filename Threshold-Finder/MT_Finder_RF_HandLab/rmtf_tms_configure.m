%% SET UP TMS MACHINE - REQUIRES MAGIC TOOLBOX_____________________________
tms.port='COM8';                                                            % serial port address to control your Magstim TMS machine
tms.resolution = 1;                                                         % interval between successive TMS intensities, in % MSO
TMS = magstim(tms.port);                                                    % use MAGIC toolbox to control Magstim TMS
TMS.connect();                                                              % establish a connection
tms.trigger.time = 0;                                                       % trigger timer
tms.trigger.condition=false;                                                % trigger condition