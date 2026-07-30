%% constant for Display MVC
emg.rms.sample=48;
emg.rms.number=25;
emg.ini.data=nan(emg.rms.sample,emg.rms.number,6);


emg.mvc.time=nan(emg.rms.sample,100000,1);
emg.mvc.data=nan(emg.rms.sample,100000,6);
Data=nan(4,emg.rms.sample*100000,3);
pedal=nan(100000,6);


%% display constant
Screen('Preference', 'SkipSyncTests', 3);
[win,wsize]=Screen('Openwindow',1,[0 0 0]);
startX=50;                                                                  % starting curse x pixel
endX=1655;                                                                  % ending curse x pixel
startY=1000;                                                                % starting curse y pixel
endY=50;                                                                    % ending curse y pixel
crossSize=20;                                                               % cross diameter
windowsize=60;
position=wsize(4)/2;                                           % x center and y center
coordi_line_x=-100;
coordi_line_y=220;
boxbottom=1000;
barWidth=60;                                                                % the barWidth of grip bar
coordi_box_x=-barWidth/2+0;
coordi_box_y=-barWidth/2+120;
emg.segment.choice={'rmt','mvc','amt'};
MVC_proportion=[0.1,0.2,0.3,0.4];                   % The proportion of MV

    
