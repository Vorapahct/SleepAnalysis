function sleepanalysis
  
% Check to see if GUI has been created already (Singleton behaviour):
mainGUI_handle = findall(0,'tag','mainGUIFig');

if (isempty(mainGUI_handle))
    %Launch the figure
    colour    = [0.94, 0.94, 0.94];
    
    mainGUIFig = figure('Name', 'Sleep Analysis', 'tag', 'mainGUIFig', 'Visible', 'off',...
    'Units', 'pixels', 'Position', [680,315,451,351], 'Resize', 'off', ...
    'menubar', 'none', 'numbertitle', 'off', 'Color', colour,...
    'CloseRequestFcn', {@mainGUI_CloseRequestFcn});

    mainFontSize = 11;
    mainFontUnits = 'points';

    % Generate the handles structure.
    handles = guihandles;
    
    handles.colour = colour;
    handles.mainFontSize = mainFontSize;
    handles.mainFontUnits = mainFontUnits;
    handles.isDataLoaded = 0;

    % Update handles structure:
    guidata(mainGUIFig, handles);

    % Create other UI elements:

    %============================ panelMain =============================
    position = [19, 15, 409, 315];
    %position = [3.6, 1.7692307692307694, 81.80000000000001, 23.53846153846154];
    handles.panelMain = uipanel(mainGUIFig,'Title', 'No current file loaded',...
        'TitlePosition', 'lefttop','FontSize', 16, 'FontUnits', mainFontUnits,...
        'Units', 'pixels', 'Position', position, 'tag', 'panelMain',...
        'BackgroundColor', colour);

    % Update handles structure
    guidata(handles.panelMain, handles);

    % Move uipanelMain to the centre of the window:
    align(handles.panelMain,'Center','none');
    % =========================== END panelMain =========================

    %============================ uiLabels ================================
    labelXPos  = 11;
    labelYPos  = 263;
    labelWidth = 336;
    
    position = [labelXPos, labelYPos, labelWidth, 23];
    handles.labelLoadFile = uicontrol('Parent', handles.panelMain,...
        'Style', 'text', 'tag', 'labelLoadFile', 'String',...
        '- Load a .edf or .rec file:','Units', 'pixels',...
        'Position', position, 'FontSize', 13, 'FontUnits', mainFontUnits,...
        'BackgroundColor', colour, 'HorizontalAlignment', 'left');

    align(handles.labelLoadFile,'Left','none');

    % Update handles structure
    guidata(handles.labelLoadFile, handles);
    
    %----------------------------------------------------------------------
    labelYPos = 201;
    position = [labelXPos, labelYPos, labelWidth, 23];
    handles.labelGenerate = uicontrol('Parent', handles.panelMain,...
        'Style', 'text', 'tag', 'labelGenerate', 'String',...
        '- Generate:', 'Units', 'pixels', 'Position',...
        position, 'FontSize', 13, 'FontUnits', mainFontUnits,...
        'BackgroundColor', colour, 'HorizontalAlignment', 'left');

    align(handles.labelGenerate,'Left','none');

    % Update handles structure
    guidata(handles.labelGenerate, handles);
    
    %----------------------------------------------------------------------
    labelYPos = 112;
    position = [labelXPos, labelYPos, labelWidth, 23];
    handles.labelPlot = uicontrol('Parent', handles.panelMain,...
        'Style', 'text', 'tag', 'labelPlot', 'String',...
        '- Plot:', 'Units', 'pixels', 'Position',...
        position, 'FontSize', 13, 'FontUnits', mainFontUnits,...
        'BackgroundColor', colour, 'HorizontalAlignment', 'left');

    align(handles.labelPlot,'Left','none');

    % Update handles structure
    guidata(handles.labelPlot, handles);
    
    %----------------------------------------------------------------------
    labelYPos = 50;
    position = [labelXPos, labelYPos, labelWidth, 23];
    handles.labelCustomBins = uicontrol('Parent', handles.panelMain,...
        'Style', 'text', 'tag', 'labelCustomBins', 'String',...
        '- Custom Bins:', 'Units', 'pixels', 'Position',...
        position, 'FontSize', 13, 'FontUnits', mainFontUnits,...
        'BackgroundColor', colour, 'HorizontalAlignment', 'left');

    align(handles.labelCustomBins,'Left','none');

    % Update handles structure
    guidata(handles.labelCustomBins, handles);
    
    %----------------------- Load File Instructions -----------------------
    labelYPos = 232;
    labelXPos = 35;
    position = [labelXPos, labelYPos, labelWidth, 23];
    handles.labelLoadInstruction = uicontrol('Parent', handles.panelMain,...
        'Style', 'text', 'tag', 'labelLoadInstruction', 'String',...
        'Click File >> Import EDF/REC File', 'Units', 'pixels', 'Position',...
        position, 'FontSize', 13, 'FontUnits', mainFontUnits,...
        'BackgroundColor', colour, 'HorizontalAlignment', 'left');

    align(handles.labelLoadInstruction,'Left','none');

    % Update handles structure
    guidata(handles.labelLoadInstruction, handles);
    
    %------------------------ GenerateGUI Info ----------------------------
    labelYPos = 176;
    position = [labelXPos, labelYPos, labelWidth, 23];
    instructionText = 'Only enabled once a file is loaded.'; 
    
    handles.labelGenerateInfo_1 = uicontrol('Parent', handles.panelMain,...
        'Style', 'text', 'tag', 'labelGenerateInfo_1', 'String',...
        instructionText, 'Units', 'pixels', 'Position',...
        position, 'FontSize', 13, 'FontUnits', mainFontUnits,...
        'BackgroundColor', colour, 'HorizontalAlignment', 'left');

    align(handles.labelGenerateInfo_1,'Left','none');

    % Update handles structure
    guidata(handles.labelGenerateInfo_1, handles);
    
    labelYPos = labelYPos-25;
    position = [labelXPos, labelYPos, labelWidth, 23];
    instructionText = 'Excel file is generated for selected Channel.'; 
    
    handles.labelGenerateInfo_2 = uicontrol('Parent', handles.panelMain,...
        'Style', 'text', 'tag', 'labelGenerateInfo_2', 'String',...
        instructionText, 'Units', 'pixels', 'Position',...
        position, 'FontSize', 13, 'FontUnits', mainFontUnits,...
        'BackgroundColor', colour, 'HorizontalAlignment', 'left');

    align(handles.labelGenerateInfo_2,'Left','none');

    % Update handles structure
    guidata(handles.labelGenerateInfo_2, handles);
    
    %-------------------------- plotGUI Info ------------------------------
    labelYPos = 85;
    position = [labelXPos, labelYPos, labelWidth, 23];
    instructionText = 'Epochs of selected Channel can be plotted.'; 
    
    handles.labelPlotInfo = uicontrol('Parent', handles.panelMain,...
        'Style', 'text', 'tag', 'labelPlotInfo', 'String',...
        instructionText, 'Units', 'pixels', 'Position',...
        position, 'FontSize', 13, 'FontUnits', mainFontUnits,...
        'BackgroundColor', colour, 'HorizontalAlignment', 'left');

    align(handles.labelPlotInfo,'Left','none');
    
    %------------------------ customBinGUI Info ----------------------------
    labelYPos = 19;
    position = [labelXPos, labelYPos, labelWidth, 23];
    instructionText = 'Range of Frequencies can be summed.'; 
    
    handles.labelcustomBinInfo = uicontrol('Parent', handles.panelMain,...
        'Style', 'text', 'tag', 'labelcustomBinInfo', 'String',...
        instructionText, 'Units', 'pixels', 'Position',...
        position, 'FontSize', 13, 'FontUnits', mainFontUnits,...
        'BackgroundColor', colour, 'HorizontalAlignment', 'left');

    align(handles.labelcustomBinInfo,'Left','none');
    
    %========================== END uiLabels ==============================

    %=========================== file_menu_Main ===========================
    handles.file_menu_Main = uimenu(mainGUIFig, 'Label', 'File', 'tag',...
        'file_menu_Main');

    % Update handles structure
    guidata(handles.file_menu_Main, handles);
    %=========================== End file_menu_Main =======================
    
    
    %=============================== import_data_Main =====================
    % Create Item
    handles.import_data_Main = uimenu(handles.file_menu_Main, 'Label', 'Import EDF/REC file',...
        'Accelerator', 'I', 'tag', 'import_data_Main');
    set(handles.import_data_Main, 'Callback', {@import_data_Main_Callback});

    % Update handles structure
    guidata(handles.import_data_Main, handles);
        
    %========================== End import_data_Main ======================
    
    %============================= exit_Main ==============================
    % Create Item
    handles.exit_Main = uimenu(handles.file_menu_Main, 'Label', 'Exit',...
        'Accelerator', 'E', 'tag', 'exit_Main', 'Separator', 'on');
    set(handles.exit_Main, 'Callback', {@exit_Main_Callback});

    % Update handles structure
    guidata(handles.exit_Main, handles);
        
    %============================ End exit_Main ===========================
    
    
    %======================== generate_menu_Main ==========================
    handles.generate_menu_Main = uimenu(mainGUIFig, 'Label', 'Generate', 'tag',...
        'generate_menu_Main', 'Enable', 'off');
    
    % Update handles structure
    guidata(handles.generate_menu_Main, handles);
    
    set(handles.generate_menu_Main, 'Callback',{@generate_menu_Main_Callback});
    
    % Update handles structure
    guidata(handles.generate_menu_Main, handles);
    %====================== End generate_menu_Main ========================


    % Move GUI to the centre of the screen:
    movegui(mainGUIFig, 'center');

    % Display GUI after all objects have been rendered:
    %set(panelMain, 'Visible', 'on');
    set(mainGUIFig, 'Visible', 'on');

else    
    % Set the figure in focus:
    figure(mainGUI_handle);
end%if

% ===================== MAIN GUI CALLBACK Functions =======================
    %------------------------ Main GUI Functions --------------------------
    % --- Executes when user attempts to close mainGUIFig.
    function mainGUI_CloseRequestFcn(hObject, eventdata)
    % hObject    handle to mainGUIFig (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: delete(hObject) closes the figure
        % Look for main GUI figure tag:
        mainGUI_h = findall(0,'tag','mainGUIFig');
        
        %Set it to focus:
        figure(mainGUI_h);
        
        % Close all other figures except main GUI figure:
        delete( setdiff( findall(0, 'type', 'figure'), mainGUI_h));
     
        % Close main GUI figure:
        delete(hObject);
    %end%mainGUI_CloseRequestFcn
    
    
    % -------------------------Main MENU Functions-------------------------
    function import_data_Main_Callback(hObject, eventdata)  
    % hObject    handle to import_data_Main_Callback (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
        handles = guidata(gcbo);
        [filename, filepath, EEG_Data, record] = importdata();

        if filename~=0
            % Save data to base workspace:
            assignin('base','filename',filename);
            assignin('base','filepath',filepath);   
            assignin('base','EEG_Data',EEG_Data);
            assignin('base','record',record);

            if ~isempty(record), handles.isDataLoaded = 1; end%if
            isEnabled(handles.generate_menu_Main, handles);
            
            % Update uipanelMain Title:
            set(handles.panelMain, 'Title', filename(1:end-4));
            
            try
                % Delete labels (static text) that showed the instructions:
                handles = deleteUIElement(handles, 'labelLoadFile');
                handles = deleteUIElement(handles, 'labelLoadInstruction');
				
				handles = deleteUIElement(handles, 'labelGenerate');
                handles = deleteUIElement(handles, 'labelGenerateInfo_1');
				handles = deleteUIElement(handles, 'labelGenerateInfo_2');
				
                handles = deleteUIElement(handles, 'labelPlot');
				handles = deleteUIElement(handles, 'labelPlotInfo');
				
				handles = deleteUIElement(handles, 'labelCustomBins');
				handles = deleteUIElement(handles, 'labelcustomBinInfo');
				
				% Update GUI :
                displayFileInfo(EEG_Data);
            catch
                % Update GUI :
                displayFileInfo(EEG_Data);
				
            end% try
        end%if
        
        % Update handles structure
        guidata(gcbo, handles);
    %end %import_data_Main_Callback


    function generate_menu_Main_Callback(hObject, eventdata)
    % hObject    handle to generate_menu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        if strcmp(get(handles.generate_menu_Main,'Enable'), 'on')

            % Check to see if GUI has been created already:
            generateOutputGUI_handle = findall(0,'tag','generateOutputFig');

            if (isempty(generateOutputGUI_handle))
                 %Launch the figure
                 %generateOutputGUI = make_subgui();
                 handles = guidata(gcbo);
                 generateOutputGUI(handles);
            else    
                % Set the figure in focus:
                figure(generateOutputGUI_handle);
            end%if
        end

        % Update handles structure
        guidata(gcbo, handles);
    %end
    
    function exit_Main_Callback(hObject, eventdata)
    % hObject    handle to generate_menu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        
        % Close application:
        mainGUI_CloseRequestFcn(handles.mainGUIFig, eventdata);

    %end
    
% ==================== END MAIN GUI CALLBACK Functions ====================


%========================= STANDALONE FUNCTIONS ===========================
    function isEnabled(hObject, handles)
        if handles.isDataLoaded==1
            set(hObject, 'Enable', 'on');
        else
            set(hObject, 'Enable',  'off');
        end %if
    %end%isEnabled
    
    function displayFileInfo(EEG_Data)
        handles = guidata(gcbo);
        
        % Get file dduration:
        handles.record    = evalin('base', 'record');
        [~, fileDuration] = size(handles.record);
        fileDuration      = fileDuration/200; 
        assignin('base', 'fileDuration', fileDuration);
        
        mainFontSize  = handles.mainFontSize;
        mainFontUnits = handles.mainFontUnits;
        colour        = handles.colour;
        
        % Create labels to display data:
        %===================== Static Texts (labels) ======================
        labelXPos   = 11;
		labelWidth  = 160;
		yPos        = 252;
		
		valueXPos   = 177; % X position of value(s) displayed
		valueWidth = 223; % Width of value(s) displayed
		
        position = [labelXPos, yPos, labelWidth, 21];
        handles.labelPatientID = uicontrol('Style', 'text', 'String',...
            'Patient ID:', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelPatientID','FontSize', mainFontSize,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
            'HorizontalAlignment', 'left', 'Visible', 'off',...
            'Parent', handles.panelMain);
        
        % Update handles structure
        guidata(handles.labelPatientID, handles);  
        
        position = [valueXPos, yPos, valueWidth, 21];
        handles.patientID = uicontrol('Style', 'text', 'Units', 'pixels',...
             'Position', position, 'Tag', 'patientID', 'FontSize',...
             mainFontSize, 'FontUnits', mainFontUnits,...
             'BackgroundColor', colour, 'HorizontalAlignment', 'left',...
             'Visible', 'off', 'Parent', handles.panelMain);
         
        set(handles.patientID,'String', strtrim(EEG_Data.patientID));
        
        % Update handles structure
        guidata(handles.patientID, handles);
        
        %------------------------------------------------------------------
        yPos = yPos-40;
        position = [labelXPos, yPos, labelWidth, 21];
        handles.labelRecordID = uicontrol('Parent', handles.panelMain,...
            'Style', 'text', 'String', 'Record ID:', 'Units', 'pixels',...
            'Position', position, 'Tag', 'labelNumChannels',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour, 'HorizontalAlignment', 'left',...
            'Visible', 'off');
        
        % Update handles structure
        guidata(handles.labelRecordID, handles);  
        
        position = [valueXPos, yPos, valueWidth, 21];
        handles.recordID = uicontrol('Parent', handles.panelMain,...
             'Style', 'text', 'Units', 'pixels', 'Position', position,...
             'Tag', 'recordID', 'FontSize', mainFontSize,...
             'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
             'HorizontalAlignment', 'left', 'Visible', 'off');
         
        set(handles.recordID,'String', strtrim(EEG_Data.recordID));
        
        % Update handles structure
        guidata(handles.recordID, handles);
        
        %------------------------------------------------------------------
        yPos = yPos-40;
        position = [labelXPos, yPos, labelWidth, 21];
        handles.labelStartDate = uicontrol('Parent', handles.panelMain,...
            'Style', 'text', 'String', 'Start Date:', 'Units', 'pixels',...
            'Position', position, 'Tag', 'labelNumChannels',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour, 'HorizontalAlignment', 'left',...
            'Visible', 'off');
        
        % Update handles structure
        guidata(handles.labelStartDate, handles);  
        
        position = [valueXPos, yPos, valueWidth, 21];
        handles.startDate = uicontrol('Parent', handles.panelMain,...
             'Style', 'text', 'Units', 'pixels', 'Position', position,...
             'Tag', 'startDate', 'FontSize', mainFontSize,...
             'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
             'HorizontalAlignment', 'left', 'Visible', 'off');
         
        set(handles.startDate,'String', strrep(strtrim(EEG_Data.startdate),'.','-'));
        
        % Update handles structure
        guidata(handles.startDate, handles);
        
        %------------------------------------------------------------------
        yPos = yPos-40;
        position = [labelXPos, yPos, labelWidth, 21];
        handles.labelStartTime = uicontrol('Parent', handles.panelMain,...
            'Style', 'text', 'String', 'Start Time:', 'Units', 'pixels',...
            'Position', position, 'Tag', 'labelNumChannels',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour, 'HorizontalAlignment', 'left',...
            'Visible', 'off');
        
        % Update handles structure
        guidata(handles.labelStartTime, handles);  
        
        position = [valueXPos, yPos, valueWidth, 21];
        handles.startTime = uicontrol('Parent', handles.panelMain,...
             'Style', 'text', 'Units', 'pixels', 'Position', position,...
             'Tag', 'startTime', 'FontSize', mainFontSize,...
             'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
             'HorizontalAlignment', 'left', 'Visible', 'off');
         
        set(handles.startTime,'String', strrep(strtrim(EEG_Data.starttime),'.',':'));
        
        % Update handles structure
        guidata(handles.startTime, handles);
        
        %------------------------------------------------------------------
        yPos = yPos-40;
        position = [labelXPos, yPos, labelWidth, 21];
        handles.labelNumChannels = uicontrol('Parent', handles.panelMain,...
            'Style', 'text', 'String', 'Number of Channels:', 'Units', 'pixels',...
            'Position', position, 'Tag', 'labelNumChannels',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour, 'HorizontalAlignment', 'left',...
            'Visible', 'off');
        
        % Update handles structure
        guidata(handles.labelNumChannels, handles);  
        
        position = [valueXPos, yPos, valueWidth, 21];
        handles.NumChannels = uicontrol('Parent', handles.panelMain,...
             'Style', 'text', 'Units', 'pixels', 'Position', position,...
             'Tag', 'NumChannels', 'FontSize', mainFontSize,...
             'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
             'HorizontalAlignment', 'left', 'Visible', 'off');
         
        [~,temp] = size(EEG_Data.label);
        set(handles.NumChannels,'String', num2str(temp));
        
        % Update handles structure
        guidata(handles.NumChannels, handles);
        
        %------------------------------------------------------------------
        yPos = yPos-40;
        position = [labelXPos, yPos, labelWidth, 21];
        handles.labelNumEpochs = uicontrol('Parent', handles.panelMain,...
            'Style', 'text', 'String', 'Number of Epochs:', 'Units', 'pixels',...
            'Position', position, 'Tag', 'labelNumEpochs',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour, 'HorizontalAlignment', 'left',...
            'Visible', 'off');
        
        % Update handles structure
        guidata(handles.labelNumEpochs, handles);  
        
        position = [valueXPos, yPos, valueWidth, 21];
        handles.NumEpochs = uicontrol('Parent', handles.panelMain,...
             'Style', 'text', 'Units', 'pixels', 'Position', position,...
             'Tag', 'NumEpochs', 'FontSize', mainFontSize,...
             'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
             'HorizontalAlignment', 'left', 'Visible', 'off');
         
        temp = round(fileDuration/30);
        set(handles.NumEpochs,'String', num2str(temp));
        
        % Update handles structure
        guidata(handles.NumEpochs, handles);
        
         %------------------------------------------------------------------
        yPos = yPos-40;
        position = [labelXPos, yPos, labelWidth, 21];
        handles.labelFileDuration = uicontrol('Parent', handles.panelMain,...
            'Style', 'text', 'String', 'File Duration (sec):', 'Units', 'pixels',...
            'Position', position, 'Tag', 'labelFileDuration',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour, 'HorizontalAlignment', 'left',...
            'Visible', 'off');
        
        % Update handles structure
        guidata(handles.labelFileDuration, handles);  
        
        position = [valueXPos, yPos, valueWidth, 21];
        handles.fileDuration = uicontrol('Parent', handles.panelMain,...
             'Style', 'text', 'Units', 'pixels', 'Position', position,...
             'Tag', 'fileDuration', 'FontSize', mainFontSize,...
             'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
             'HorizontalAlignment', 'left', 'Visible', 'off');
         
        set(handles.fileDuration,'String', num2str(fileDuration));
        
        % Update handles structure
        guidata(handles.NumEpochs, handles);
        %========================= End Labels =============================
        
		% Set Visibility on:
		set(handles.labelPatientID, 'Visible', 'on');
		set(handles.patientID, 'Visible', 'on');
		
		set(handles.labelRecordID, 'Visible', 'on');
		set(handles.recordID, 'Visible', 'on');
		
		set(handles.labelStartDate, 'Visible', 'on');
		set(handles.startDate, 'Visible', 'on');
		
		set(handles.labelStartTime, 'Visible', 'on');
		set(handles.startTime, 'Visible', 'on');
		
		set(handles.labelNumChannels, 'Visible', 'on');
		set(handles.NumChannels, 'Visible', 'on');
		
		set(handles.labelNumEpochs, 'Visible', 'on');
		set(handles.NumEpochs, 'Visible', 'on');
        
        set(handles.labelFileDuration, 'Visible', 'on');
		set(handles.fileDuration, 'Visible', 'on');
		
        guidata(gcbo, handles);
    %end displayFileInfo

    function handles = deleteUIElement(handles, field)
        uiElement = cell(1,1);
        uiElement = {field};
        delete(handles.(uiElement{1}));
        handles = rmfield(handles, field);
    %end%  deleteUIElement

%end