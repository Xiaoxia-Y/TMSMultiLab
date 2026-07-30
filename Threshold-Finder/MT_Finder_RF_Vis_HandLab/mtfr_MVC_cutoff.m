MVC_display=[10,20,30,40];                                      % presentage of the MVC
MVC_proportion=[0.1,0.2,0.3,0.4];                               % MVC proportion
mvc_trigger_channel=2;
%% Matlab data
mvc.data=nan(4,4000);                                                    % left hand EMG in the matlab
for qn=1:4                                                                  % left hand (qn from 1-4)
    mvc.trigger=find(diff(Data(qn,:,mvc_trigger_channel))>2);                        % when did participant above the target
    mvc.data(qn,:)=Data(qn,mvc.trigger+1:mvc.trigger+4000,1); % extract EMG 
end

mvc.windowsize=25;                                                           % divide 4000 sample into 25 windows
mvc.windowdata=nan(4,160,25);                                           % qn, 160 sample in each window, windows
matlab_window_right=nan(4,160,25);
for qn=1:4                                                                  % left trials
    for t=1:160                                                             % each window
        mvc.windowdata(qn,t,:)=mvc.data(qn,(t-1)*mvc.windowsize+1:t*mvc.windowsize); % save each window
    end
end

%% average
mvc.windowaverage=nan(4,32,25);
mvc.windowdifference=nan(4,32,1);
for maxg=1:4                                                                % each MVC percentage 
    for i=1:32                                                              % 160./5
    mvc.windowaverage(maxg,i,:)=mean(mvc.windowdata(maxg,1+(i-1)*5:i*5,:),2); % window of 5 samples
    mvc.windowdifference(maxg,i,:)=max(mvc.windowaverage(maxg,i,:))-min(mvc.windowaverage(maxg,i,:)); % find max and min in each window
    end
end

mvc_cutoff=nan(4,2);
mvc_gripforce=nan(4,1);
% histogram
for maxg=1:4
    percent=MVC_display(maxg);
    realval=MVC_proportion(maxg)*maxGrip;
    MVC_size=sprintf('%d%% MVC=%g',percent,realval);
    mvc_cutoff(maxg,:)=prctile(reshape(mvc.windowdifference(maxg,:,:),[],1),[2.5,97.5]); % find cutoff for the different between max and min
    mvc_gripforce(maxg,:)=realval;
%     figure(maxg)
%     histogram(matlab_different(maxg,:,:,1));
%     annotation('textbox',[0.65,0.6,0.4,0.05],'string',MVC_size,'EdgeColor','none');
%     figurename=fullfile(FileFolder2,sprintf('figure_%dM.png',maxg));        % name
%     saveas(gcf,figurename);                                                 % save the figure
%     close;
end

%% plot figure
plot(mvc_gripforce,mvc_cutoff(:,2),'o');
mdl=fitlm(mvc_gripforce,mvc.cutoff(:,2));
intercept=mdl.Coefficients.Estimate(1);
slope=mdl.Coefficients.Estimate(2);
criterion=intercept+slope*0.3*maxGrip;
xlabel('MVC (RMS)');
ylabel('95% cutoff');
% figurename=fullfile(rawfolder,sprintf('figure_cutoff.png'));          % name
% saveas(gcf,figurename);                                                 % save the figure
% close;
disp(['criterion=',num2str(criterion)]);
disp(['MaxGrip=',num2str(maxGrip)]);
disp(['initialRMSE=',num2str(initialRMSE)]);
filename_constant=['constant_H' num2str(e.hid) '.mat'];
save(filename_constant,'criterion','maxGrip','initialRMSE');