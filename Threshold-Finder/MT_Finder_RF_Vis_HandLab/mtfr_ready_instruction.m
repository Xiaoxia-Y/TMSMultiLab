    DrawFormattedText(win,text.t4,'center',wsize(4)/2-8*crossSize,[255 255 255]); %instruction
    DrawFormattedText(win,text.t5,'center',wsize(4)/2-4*crossSize,[255 255 255]); %instruction
    DrawFormattedText(win,text.t6,'center',wsize(4)/2,[255 255 255]);         % instruction
    Screen('Flip',win);
    Screen('Drawline',win,[255 255 255],wsize(3)/2-crossSize,wsize(4)/2,wsize(3)/2+crossSize,wsize(4)/2,2); % cross
    Screen('Drawline',win,[255 255 255],wsize(3)/2,wsize(4)/2-crossSize,wsize(3)/2,wsize(4)/2+crossSize,2); % cross
    Screen('Flip', win);
    WaitSecs(1);
    Screen('DrawText',win,text.t9,wsize(3)/2-50,wsize(4)/2,[255 255 255]);   % instruction
    Screen('Flip',win);