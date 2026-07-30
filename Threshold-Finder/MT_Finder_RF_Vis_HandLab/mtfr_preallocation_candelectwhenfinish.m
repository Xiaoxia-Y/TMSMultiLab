    validp=1;                                                               % valid p
    p=0;                                                                    % p = 48 data points,p = approximately 4 frames
    running=true;                                                           % loop control
    xpos(1:windowsize)=startX;                                              % starting x position in first p
    ypos(1:windowsize)=startY;                                              % starting y position in first p
    defaultBarPosition=[position-barWidth/2,boxbottom-80,position-barWidth/2+120,boxbottom]; % defalt bar when no p
    line=boxbottom-(maxGrip-initialRMSE).*MVC_proportion(qn).*boxscale;              % line position in pixels (converted from dyna)_left hand
    linePosition=[position-barWidth/2+coordi_line_x,line,position-barWidth/2+coordi_line_y,line];% rectangle coordinates for the target line
    tic;                                                                    % start the timer
    PreT=0;  