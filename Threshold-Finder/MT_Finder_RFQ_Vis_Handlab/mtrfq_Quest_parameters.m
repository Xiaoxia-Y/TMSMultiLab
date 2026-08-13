%% parameters for QUEST
quest.guess = tms.intensity.hotspot*0.85;                                   % mean of initial quest
quest.SD = quest.guess;                                                     % SD of initial quest                                                               
quest.threshold = 0.75;
quest.beta = 3.5; 
quest.delta = 0.01;                                                         % proportion of trials blind/mistaken responses
quest.gamma = 0.01;                                                         % response if the signal is 0
quest.grain = 0.01;                                                         % resolution of underlying distribution (%MSO)
quest.range = 2 .* quest.guess;                                             % range of TMS
quest.q = QuestCreate(quest.guess, ...
    quest.SD(1),quest.threshold,quest.beta, ...
    quest.delta,quest.gamma,quest.grain,quest.range);                       % create QUEST model
quest.q.normalizePdf=1;

tms.intensity.quest = round(QuestQuantile(quest.q));                        % first Intensity 



%% whether choose QUEST
quest.condition = true;