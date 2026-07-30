Screen('Preference', 'SkipSyncTests', 3);                                   % skip synchronization tests in Psychtoolbox
DrawFormattedText(win,text.t10,'center',wsize(4)/2-12*crossSize,[255 255 255]); % instruction
Screen('DrawText',win,text.t11,wsize(3)/2-100,wsize(4)/2,[255 255 255]);    % instruction
Screen('Flip', win);                                                        % show instruction
WaitSecs(2);