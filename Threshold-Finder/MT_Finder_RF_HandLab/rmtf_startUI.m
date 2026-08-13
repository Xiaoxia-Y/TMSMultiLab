function settings = rmtf_startUI ()



%% UI for all configurable variables
fig = uifigure('Name', 'Experiment settings', 'Position',[800,500,700,500]);

% %settings.input.folder = uieditfield(fig, 'text', ...
%     'Position', [150 500 500 35], ...
%     'Placeholder', 'Select input folder...');


%% 1. input folder 
uilabel(fig, ...
    'Text', '1. Input Folder', ...
    'FontWeight', 'bold', ...
    'Position', [80 450 150 25],'FontSize',15);


input.pathfolder = uieditfield(fig, 'text', ...
    'Position', [80 410 485 35]);

uibutton(fig, 'push', ...
    'Text', '...', ...
    'Position', [580 410 50 35], ...
    'ButtonPushedFcn', @(btn,event) selectFolder(fig,input.pathfolder));

%% 2. output folder 

uilabel(fig, ...
    'Text', '2. Output Folder', ...
    'FontWeight', 'bold', ...
    'Position', [80 380 150 25],'FontSize',15);


input.savefolder = uieditfield(fig, 'text', ...
    'Position', [80 340 485 35]);

uibutton(fig, 'push', ...
    'Text', '...', ...
    'Position', [580 340 50 35], ...
    'ButtonPushedFcn', @(btn,event) selectFolder(fig,input.savefolder));


%% 3. version 
uilabel(fig, ...
    'Text', '3. Version', ...
    'FontWeight', 'bold', ...
    'Position', [80 300 150 25],'FontSize',15);


input.version = uieditfield(fig, 'text',...
    'Position', [80 260 200 35]);

uidropdown(fig, ...
    'Items', {'Select...', 'Auto RMT-Finder', 'Fast Auto RMT-Finder', 'Manuel'}, ...
    'Position', [295 260 50 35],'ValueChangedFcn', @(dd,event) updateText(dd, input.version));




%% 4. subject ID

uilabel(fig, ...
    'Text', '4. Subject ID', ...
    'FontWeight', 'bold', ...
    'Position', [360 300 150 25],'FontSize',15);


input.subjectID = uieditfield(fig, 'text',...
    'Position', [360 260 203 35]);


%% 5. Hot spot

uilabel(fig, ...
    'Text', '5. Hot spot', ...
    'FontWeight', 'bold', ...
    'Position', [80 220 150 25],'FontSize',15);


input.hotspot = uieditfield(fig, 'numeric', ...
    'Position', [80 180 200 35], ...
    'HorizontalAlignment', 'left');



%% 6. Algorithm

uilabel(fig, ...
    'Text', '6. Algorithm', ...
    'FontWeight', 'bold', ...
    'Position', [360 220 150 25],'FontSize',15);


input.algorithm = uieditfield(fig, 'text',...
    'Position', [360 180 200 35]);


uidropdown(fig, ...
    'Items', {'Select...', 'QUEST', 'Robbins–Monro stochastic approximation'}, ...
    'Position', [580 180 50 35],'ValueChangedFcn', @(dd,event) updateText(dd, input.algorithm));





%% 7. percentage of MVC
uilabel(fig, ...
    'Text', '7. Percentage of MVC', ...
    'FontWeight', 'bold', ...
    'Position', [80 140 300 25],'FontSize',15);


input.mvc = uieditfield(fig, 'text',...
    'Position', [80 100 200 35]);

uidropdown(fig, ...
    'Items',  ['Select...', string(0:100)], ...
    'Position', [295 100 50 35],'ValueChangedFcn', @(dd,event) updateText(dd, input.mvc));



%% save 
saveButton = uibutton(fig, 'push', ...
    'Text', 'Save', ...
    'Position', [570 30 90 35], ...
    'ButtonPushedFcn', @(btn,event) saveSettings(fig, input));



uiwait(fig);


settings = fig.UserData.settings;

delete(fig);

end   





%% functions 

%% select folder
function selectFolder(fig,folderField)
    folderPath = uigetdir(pwd, 'Select Input Folder');

    if folderPath ~= 0
        folderField.Value = folderPath;
    end

    figure(fig);

end


%% text feed
function updateText(dd, textField)
    textField.Value = dd.Value;
end


%% save 
function saveSettings(fig, input)

    settings.inputFolder  = input.pathfolder.Value;
    settings.outputFolder = input.savefolder.Value;
    settings.version      = input.version.Value;
    settings.subjectID    = input.subjectID.Value;
    settings.hotSpot      = input.hotspot.Value;
    settings.algorithm    = input.algorithm.Value;
    settings.MVC          = input.mvc.Value;

    fig.UserData.settings = settings;

    uiresume(fig);

end


