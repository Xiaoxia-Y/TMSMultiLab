%% INSTRUCTIONS 

%% MVC instrctions
ins.t1= 'You will see a fixation cross on the screen. Please look at the fixation cross and get ready.';
ins.t2= 'When SQUEEZE appears, please pinch the dynamometer with your thumb and index finger as hard and as quick as you can';
ins.t3= 'Each grip will last for 2 seconds, Please exert force during that time';

%% Make sure participant is ready
ready.t1= 'Before the grip strength task starts, make sure you are ready';
ready.t2= 'When you are ready, please press any key to start';
ready.t3= 'Are you ready?';

%% relax 
relax.t1= 'Please relax';

%% encourage 
enc.t1= 'You are doing excellent job';                                      % not sure whether we keep this 

%% squeeze
squeeze.t1= 'SQUEEZE';

%% fixation cross
fix.line = [
    wsize(3)/2-display.crossSize,  wsize(3)/2+display.crossSize,  wsize(3)/2,            wsize(3)/2;
    wsize(4)/2,            wsize(4)/2,            wsize(4)/2-display.crossSize,  wsize(4)/2+display.crossSize
];


%% mvc criterion
mvc.criterion.instrustion.t1 = 'Now you will perform a grip-matching task.';
mvc.criterion.instrustion.t2 = 'During the task, please pinch the grip device to control the red bar on the screen.';
mvc.criterion.instrustion.t3 = 'Please keep gripping until the red bar reaches the white line.';
mvc.criterion.instrustion.t4 = 'When you reach the white line, it will turn red. Please hold the bar at that position and keep the line red for 5 seconds';
mvc.criterion.instrustion.t5 = 'There are 4 target levels in total.';


%% maintain in target percentage
main.t1 = 'Now you will perform a grip-matching task.';
main.t2 = 'During the task, please pinch the grip device to control the red bar on the screen.';
main.t3 = 'Please keep gripping until the red bar reaches the white line.';
main.t4 = 'When you reach the white line, it will turn red. Please hold the bar at that position and keep the line red.';
main.t5 = 'While you are holding the bar on the target, we may deliver TMS to your head at any time.';
main.t6 = 'If you feel tired at any time, please relax your hand. When you are ready, repeat the process.';
















