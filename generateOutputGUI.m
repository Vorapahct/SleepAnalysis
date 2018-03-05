function generateOutputGUI(varargin)

    % Check to see if GUI has been created already (Singleton behaviour):
    generateOutputGUI_handle = findall(0,'tag','generateOutputFig');

    if (isempty(generateOutputGUI_handle))
        %Launch the figure
        position = [680,177,375,489];
        colour    = [0.94, 0.94, 0.94];
        generateOutputFig = figure('Name', 'Generate Output', 'tag',...
            'generateOutputFig', 'Visible', 'off','Position', position,...
            'Resize', 'off', 'menubar', 'none', 'numbertitle', 'off',...
            'Color', colour, 'CloseRequestFcn',{@generateOutputGUI_CloseRequestFcn});

        mainFontSize = 11;
        mainFontUnits = 'points';
        
        % Generate the handles structure.
        handles = guihandles(generateOutputFig);
        
        % Default values:
        handles.isChannelSelected = 0;
        assignin('base', 'isChannelSelected', handles.isChannelSelected);
        
        handles.outputFilePath    = 0;
        assignin('base', 'outputFilePath', handles.outputFilePath);
        
        handles.timeInterval      = 0;
        assignin('base', 'timeInterval', handles.timeInterval);
        
        handles.timeUnit          = 0;
        assignin('base', 'timeUnit', handles.timeUnit);
        
        handles.defaultFrequencyRange = [0 25];

        
        % Update handles structure:
        guidata(generateOutputFig, handles);
        
        % Create UI Elements:
        %===================== Static Texts (labels) ======================
        position = [12, 453, 218, 20];
        handles.labelOutputDir = uicontrol('Style', 'text', 'String',...
            'Save Output File(s) in Directory: ', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelOutputDir','FontSize', mainFontSize,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour);
        
        % Update handles structure
        guidata(handles.labelOutputDir, handles);  
        
        %------------------------------------------------------------------
        position = [12, 349, 137, 21];
        handles.labelTimeInterval = uicontrol('Style', 'text', 'String',...
            'Enter Time Interval:', 'Units', 'pixels', 'Position', position,...
             'Tag', 'labelTimeInterval','FontSize', mainFontSize,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour);
        
        % Update handles structure
        guidata(handles.labelTimeInterval, handles); 
        
        %------------------------------------------------------------------
        position = [12, 250, 137, 21];
        handles.labelChannelSelection = uicontrol('Style', 'text', 'String',...
            'Channel Selection:  ', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelChannelSelection','FontSize', mainFontSize,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour);
        
        % Update handles structure
        guidata(handles.labelChannelSelection, handles); 
        
        %------------------------------------------------------------------
        position = [12, 205, 128, 21];
        handles.labelFrequencyRange = uicontrol('Style', 'text', 'String',...
            'Frequency Range:', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelFrequencyRange','FontSize', mainFontSize,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour);
        
        % Update handles structure
        guidata(handles.labelFrequencyRange, handles);
        
        %------------------------------------------------------------------
        position = [12, 21, 375, 21];
        handles.labelStatus = uicontrol('Style', 'text', 'String',...
            'Ready', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelStatus','FontSize', mainFontSize,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour, ...
            'HorizontalAlignment', 'left');
        
        % Update handles structure
        guidata(handles.labelStatus, handles);
        
        %=================== %end Static Texts (labels) ====================
        
        %========================= Edit Boxes =============================
        position = [12, 388, 339, 30];
        handles.edtBoxOutputDirec = uicontrol('Style', 'edit', 'String', '',...
            'Units', 'pixels', 'Position', position, 'Tag', 'edtBoxOutputDirec',...
            'FontSize', 7, 'FontUnits', mainFontUnits,...
            'Enable', 'inactive', 'BackgroundColor', [0.8, 0.8, 0.8],...
            'CreateFcn', {@edtBoxOutputDirec_CreateFcn});
        
        
        % Update handles structure
        guidata(handles.edtBoxOutputDirec, handles);
        
        % -----------------------------------------------------------------
        position = [150, 340, 202, 38];
        temp = evalin('base', 'fileDuration');
        temp = temp/60;
        text = strcat('0', {' '}, num2str(temp));
        handles.edtBoxTimeInterval = uicontrol('Style', 'edit', 'String', text,...
            'Units', 'pixels', 'Position', position, 'Tag', 'edtBoxTimeInterval',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'CreateFcn', {@edtBoxTimeInterval_CreateFcn});
        
        % Set Callback:
        set(handles.edtBoxTimeInterval,'Callback',...
                                   {@edtBoxTimeInterval_Callback});
        
        % Update handles structure
        guidata(handles.edtBoxTimeInterval, handles);
        
        % -----------------------------------------------------------------
        position = [150, 198, 202, 31];
        handles.edtBoxFrequencyRange = uicontrol('Style', 'edit', 'String', '0 25',...
            'Units', 'pixels', 'Position', position, 'Tag', 'edtBoxFrequencyRange',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,'Enable', 'inactive',...
            'CreateFcn', {@edtBoxFrequencyRange_CreateFcn});
        set(handles.edtBoxFrequencyRange, 'BackgroundColor', [0.8, 0.8, 0.8]);
        
        % Set Callback:
        set(handles.edtBoxFrequencyRange,'Callback',...
                                 {@edtBoxFrequencyRange_Callback});    
        
        % Update handles structure
        guidata(handles.edtBoxFrequencyRange, handles);
        
        %======================= %end Edit Boxes ===========================
        
        
        
        % ====================== RadioGroupButtons ========================
        %position = [0.56, 0.6319018404907976, 0.3733333333333333, 0.10224948875255613];
        position = [12, 288, 339, 51];
        handles.buttonGroupTimeUnit = uibuttongroup('Units', 'pixels','Position',position,...
             'Title', 'Time Unit', 'TitlePosition','lefttop',...
             'Tag', 'buttonGroupTimeUnit',...
             'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
             'BackgroundColor', colour);
        try
            % Set SelectionChanged_Fcn:
            set(handles.buttonGroupTimeUnit,'SelectionChangedFcn',...
                          {@buttonGroupTimeUnit_SelectionChangedFcn});
        catch
            % Set SelectionChanged_Fcn for older MATLAB versions:
            set(handles.buttonGroupTimeUnit,'SelectionChangeFcn',...
                          {@buttonGroupTimeUnit_SelectionChangedFcn});
        end% try
        % Update handles structure
        guidata(handles.buttonGroupTimeUnit, handles);
        
        %------------------------------------------------------------------
        position = [7, 8, 110, 23];
        handles.radiobuttonHrs = uicontrol(handles.buttonGroupTimeUnit,...
            'Style','radiobutton', 'Units', 'pixels', 'Position',position,...
            'String', 'hours', 'Tag', 'radiobuttonHrs',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour);
        
        % Update handles structure
        guidata(handles.radiobuttonHrs, handles);
        
        %------------------------------------------------------------------
        position = [188, 8, 110, 23];
        handles.radiobuttonMins = uicontrol(handles.buttonGroupTimeUnit,...
            'Style','radiobutton', 'Units', 'pixels', 'Position',position,...
            'String', 'minutes', 'Tag', 'radiobuttonMins',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour);
        
        % Update handles structure
        guidata(handles.radiobuttonMins, handles);
        
        set(handles.buttonGroupTimeUnit, 'SelectedObject', handles.radiobuttonMins);
        %>>>>>>>>>>>>>>>>>>> RadioButtonGroup File Type <<<<<<<<<<<<<<<<<<<
        position = [12, 138, 339, 52];
        handles.buttonGroupFileType = uibuttongroup('Units', 'pixels','Position',position,...
             'Title', 'File Type', 'TitlePosition','lefttop',...
             'Tag', 'buttonGroupFileType',...
             'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
             'BackgroundColor', colour);
         try
            % Set SelectionChanged_Fcn:
            set(handles.buttonGroupFileType,'SelectionChangedFcn',...
                {@buttonGroupFileType_SelectionChangedFcn});
         catch
             % Set SelectionChanged_Fcn for older MATLAB versions:
            set(handles.buttonGroupFileType,'SelectionChangeFcn',...
                {@buttonGroupFileType_SelectionChangedFcn});
         end % try
        % Update handles structure
        guidata(handles.buttonGroupFileType, handles);
        
        %------------------------------------------------------------------
        position = [7, 8, 110, 23];
        handles.radiobuttonSleep = uicontrol(handles.buttonGroupFileType,...
            'Style','radiobutton', 'Units', 'pixels', 'Position',position,  ...
            'String', 'Sleep EEG', 'Tag', 'radiobuttonSleep',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour);
        
        % Update handles structure
        guidata(handles.radiobuttonSleep, handles);
        
        %------------------------------------------------------------------
        position = [188, 8, 110, 23];
        handles.radiobuttonWake = uicontrol(handles.buttonGroupFileType,...
            'Style','radiobutton', 'Units', 'pixels', 'Position',position,...
            'String', 'Wake EEG', 'Tag', 'radiobuttonWake',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour);
        
        % Update handles structure
        guidata(handles.radiobuttonWake, handles);
        
        % ===================== %end RadioGroupButtons =====================
        
        
        %=========================== Buttons ==============================
        position = [11, 420, 99, 33];
        handles.btnBrowse = uicontrol('Style', 'pushbutton', 'String', 'Browse...',...
            'Units', 'pixels', 'Position', position, 'Tag', 'btnBrowse',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour);
        
        % Set Callback:
        set(handles.btnBrowse,'Callback',{@btnBrowse_Callback});
 
        % Update handles structure
        guidata(handles.btnBrowse, handles);
        
        %------------------------------------------------------------------
        position = [150, 245, 202, 35];
        handles.btnSelectChannels = uicontrol('Style', 'pushbutton',...
            'String', 'Select Channel','Units', 'pixels', 'Position',...
            position, 'Tag', 'btnSelectChannels','FontSize',...
            mainFontSize, 'FontUnits', mainFontUnits, 'BackgroundColor', colour);
        
        % Set Callback:
        set(handles.btnSelectChannels,'Callback',...
                                   {@btnSelectChannels_Callback});
 
        % Update handles structure
        guidata(handles.btnSelectChannels, handles);
        
        %------------------------------------------------------------------
        position = [36, 55, 302, 51];
        handles.btnGenerate = uicontrol('Style', 'pushbutton',...
            'String', 'Generate','Units', 'pixels', 'Position',...
            position, 'Tag', 'btnGenerate','FontSize',...
            mainFontSize, 'FontUnits', mainFontUnits, 'BackgroundColor', colour);
        
        % Set Callback:
        set(handles.btnGenerate,'Callback',{@btnGenerate_Callback});
 
        % Update handles structure
        guidata(handles.btnGenerate, handles);
        %========================== end Buttons ===========================
        
        
        %========================= Menu buttons ===========================
        
        %------------------------- plot_epochs_menu -------------------------
        handles.plot_epochs_menu = uimenu(generateOutputFig, 'Label', 'Plot Epochs', 'tag',...
            'plot_epochs_menu', 'Enable', 'off');

        set(handles.plot_epochs_menu, 'Callback',{@plot_epochs_menu_Callback});

        % Update handles structure
        guidata(handles.plot_epochs_menu, handles);
        %----------------------- End plot_epochs_menu -----------------------

        %--------------------- customBins_menu -----------------------
        handles.customBins_menu = uimenu(generateOutputFig, 'Label', 'Custom Bins',...
            'tag', 'customBins_menu', 'Enable', 'off');

        set(handles.customBins_menu, 'Callback',{@customBins_menu_Callback});

        % Update handles structure
        guidata(handles.customBins_menu, handles);
        %-------------------- End customBins_menu --------------------
        
        %===================== END Menu buttons ===========================
        
        
        % Move GUI to the centre of the screen:
        movegui(generateOutputFig, 'center');

        % Display GUI after all objects have been rendered:
        set(handles.buttonGroupTimeUnit, 'Visible', 'on');
        set(generateOutputFig, 'Visible', 'on');
    else
        % Set the figure in focus:
        figure(generateOutputGUI_handle);    
    end % if
    
    % =============== GenerateOutputGUI CALLBACK Functions ================
    %------------------------ Main GUI Functions --------------------------
    % --- Executes when user attempts to close mainGUIFig.
    function generateOutputGUI_CloseRequestFcn(hObject, eventdata)
    % hObject    handle to mainGUIFig (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: delete(hObject) closes the figure
        generateOutputGUI_handle = findall(0,'tag','generateOutputFig');
        mainGUI_h = findall(0,'tag','mainGUIFig');
        
        keepOpenFigures = [generateOutputGUI_handle;mainGUI_h];
        % Close other GUIs (figures) besides Main:
        delete( setdiff( findall(0, 'type', 'figure'), keepOpenFigures));
        
        delete(hObject);
    %end% generateOutputGUI_CloseRequestFcn
    
    
    % --- Executes during object creation, after setting all properties.
    function edtBoxOutputDirec_CreateFcn(hObject, eventdata)
    % hObject    handle to edtOutputDirec (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
    
    % --- Executes during object creation, after setting all properties.
    function edtBoxTimeInterval_CreateFcn(hObject, eventdata)
    % hObject    handle to edtOutputDirec (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
    
    
    function edtBoxFrequencyRange_CreateFcn(hObject, eventdata)
    % hObject    handle to edtOutputDirec (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
    
    
    % ----------------- RadioButtonGroup Selection Change -----------------
    % --- Executes when selected object is changed in uibuttongroupTimeUnit.
    function handles = buttonGroupTimeUnit_SelectionChangedFcn(hObject,...
                                                        eventdata)
    % hObject    handle to the selected object in uibuttongroupTimeUnit 
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        handles.timeUnit =get(get(handles.buttonGroupTimeUnit,...
                                               'SelectedObject'),'String');

        assignin('base','timeUnit', handles.timeUnit);

        % Update handles structure
        guidata(gcbo, handles);
    %end % buttonGroupTimeUnit_SelectionChangedFcn
    
    function handles = buttonGroupFileType_SelectionChangedFcn(hObject,...
                                                        eventdata)
    % hObject    handle to the selected object in uibuttongroupTimeUnit 
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        handles.fileType = get(get(handles.buttonGroupFileType,...
                                               'SelectedObject'),'String');
        assignin('base','fileType', handles.fileType);

        % Update handles structure
        guidata(gcbo, handles);
    %end % buttonGroupFileType_SelectionChangedFcn
    
    % --------------- %end RadioButtonGroup Selection Change ---------------
    
    
    % ------------------------ Edit Box Callbacks -------------------------
    function edtBoxTimeInterval_Callback(hObject, eventdata)
    % hObject    handle to edtBoxTimeInterval (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of edtBoxTimeInterval as text
    %        str2double(get(hObject,'String')) returns contents of edtBoxTimeInterval as a double
        handles = guidata(gcbo);
        temp = strtrim(get(hObject,'String'));
        handles.timeInterval = str2num(temp{1});

        %handles.timeInterval
        assignin('base','timeInterval',handles.timeInterval);
        
        % Update handles structure
        guidata(gcbo, handles);
    %end % edtBoxTimeInterval_Callback

    function edtBoxFrequencyRange_Callback(hObject, eventdata)
    % hObject    handle to edtBoxTimeInterval (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of edtBoxTimeInterval as text
    %        str2double(get(hObject,'String')) returns contents of edtBoxTimeInterval as a double
        handles = guidata(gcbo);
        handles.selectedFrequencyRange = str2num(get(hObject,'String'));

        assignin('base','selectedFrequencyRange',handles.selectedFrequencyRange);
        
        % Update handles structure
        guidata(gcbo, handles);
    %end % edtBoxFrequencyRange_Callback

    % ---------------------- %end Edit Box Callbacks -----------------------
     
     
    %-------------------------- Button Callbacks --------------------------
    % --- Executes on button press in btnBrowse.
    function btnBrowse_Callback(hObject, eventdata)
    % hObject    handle to btnBrowse (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        handles = exportData(handles);
        
        % Update handles structure
         guidata(gcbo, handles);
    %end% btnBrowse_Callback


    % --- Executes on button press in btnSelectChannels.
    function btnSelectChannels_Callback(hObject, eventdata)
    % hObject    handle to btnChannelSelection (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        
        handles.channelList = evalin('base', 'EEG_Data.label');
        [handles.selectedChannels, handles.isChannelSelected] = listdlg(...
            'PromptString','Select the channels:', 'SelectionMode',...
            'single', 'ListString',handles.channelList);

        % Save to global workspace:
        assignin('base','selectedChannels', handles.selectedChannels);
        assignin('base','isChannelSelected', handles.isChannelSelected);

        % Update handles structure
        guidata(gcbo, handles);
    %end % btnSelectChannels


    % --- Executes on button press in btnGenerate.
    function btnGenerate_Callback(hObject, eventdata)
    % hObject    handle to btnGenerateOutput (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        % Self call to get Time Value:
        edtBoxTimeInterval_Callback(handles.edtBoxTimeInterval,...
                                                       eventdata);

        % Self call to get Time Unit:
        buttonGroupTimeUnit_SelectionChangedFcn(handles.buttonGroupTimeUnit,...
                                                       eventdata);
        
        % Self call to get File Type:
        buttonGroupFileType_SelectionChangedFcn(handles.buttonGroupFileType,...
                                                       eventdata);
                                                   
        % Self call to get selected Frequency Range:
        edtBoxFrequencyRange_Callback(handles.edtBoxFrequencyRange,...
                                                       eventdata);
                                                   
        handles = guidata(gcbo);
        set(handles.labelStatus, 'String', ' ');
       
        % Check if all the necessary conditions to proceed have been meet:
        if ~isnumeric(handles.outputFilePath) && ~isempty(handles.timeInterval) ...
           && handles.isChannelSelected==1 && (handles.timeInterval(2))~=0
            try
                set(handles.btnGenerate, 'Enable', 'off');
                drawnow(); % Update GUI

                display('Generating output files...');

                % Calculate data and save to CSV files:
                generateOutput();

                set(handles.btnGenerate, 'Enable', 'on');
            catch
                % Enable button:
                set(handles.btnGenerate, 'Enable', 'on');
                
                % Display status:
                set(handles.labelStatus, 'String', 'Unsuccessful');
                
                %Throw error:
                error('Unable to generate output file!');
            end %try
            
            % Enable plot and Custom bins menu options:
            set(handles.plot_epochs_menu, 'Enable', 'on');
            set(handles.customBins_menu, 'Enable', 'on');
            
        else % Display errors:
            if handles.outputFilePath==0
                message = 'Please select a folder to save output file. Click the Browse button!';
                error(message); 
            end %if

            if isempty(handles.timeInterval)
                message = 'Please enter a valid Time Interval!';
                error(message); 
            end%if

            if handles.isChannelSelected==0
                message = 'Please Select the Channels you want to analyse!';
                error(message); 
            end% if
        end%if
        
        % Update handles structure
        guidata(gcbo, handles);
    %end% btnGenerate_Callback
    %----------------------- end Button Callbacks -------------------------
    
    
    
    %------------------------- uiMenu Callbacks --------------------------- 
    function plot_epochs_menu_Callback(hObject, eventdata)
    % hObject    handle to plot_epochs_menu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        if strcmp(get(handles.plot_epochs_menu,'Enable'), 'on')

            % Check to see if GUI has been created already:
            plotGUI_handle = findall(0,'tag','plotGUIFig');

            if (isempty(plotGUI_handle))
                 %Launch the figure
                 %generateOutputGUI = make_subgui();
                 handles = guidata(gcbo);
                 plotGUI(handles);
            else    
                % Set the figure in focus:
                figure(plotGUI_handle);
            end%if
        end

        % Update handles structure
        guidata(gcbo, handles);
    %end

    function customBins_menu_Callback(hObject, eventdata)
    % hObject    handle to customBins_menu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        if strcmp(get(handles.customBins_menu,'Enable'), 'on')

            % Check to see if GUI has been created already:
            customBinsGUI_handle = findall(0,'tag','customBinsGUIFig');

            if (isempty(customBinsGUI_handle))
                 %Launch the figure
                 %generateOutputGUI = make_subgui();
                 customBinsGUI(handles);
            else    
                % Set the figure in focus:
                figure(customBinsGUI_handle);
            end%if
        end

        % Update handles structure
        guidata(gcbo, handles);
    %end
    
    %----------------------- END uiMenu Callbacks ------------------------- 
    
% ========================== STANDALONE FUNCTION(S) =======================
    function [handles] = exportData(handles)
        handles.outputFilePath = 0;
        assignin('base','outputFilePath', handles.outputFilePath);
        [handles.outputFilePath] = uigetdir(matlabroot, 'Save Output File(s)');

        if ~isnumeric(handles.outputFilePath)
            assignin('base','outputFilePath',handles.outputFilePath);
            set(handles.edtBoxOutputDirec, 'String', handles.outputFilePath);
        end%if
        
        
    function generateOutput()
        handles = guidata(gcbo);
        
        % Checks whether it is minutes or hours:
        if(strcmp(handles.timeUnit,'hours'))      
            % Convert hours to minutes:
            handles.timeInterval = handles.timeInterval.*60;
        end % (strcmp(handles.timeUnit,'hours'))    
    
        % Get records:
        handles.record = evalin('base', 'record');
        
        % Channel selected is always at index 1 of
        % handles.selectedChannels:
        i=1;
        
        % Update Label to display status of file generation:
        message = strcat('Generating file(s) for channel ', {' '},...
                   handles.channelList(handles.selectedChannels(i)), '...');
        set(handles.labelStatus, 'String', message);
        drawnow();% Update GUI

        %Extracts the channel from the full dataset
        currentFullRecord = handles.record(handles.selectedChannels(i),:); 

        %Calls the function to take the selected time range:
        selectedDataByUser = RangeSelector(handles.timeInterval,...
                                        currentFullRecord);    

        %Decides on a time interval depending on type of analysis 
        if strcmpi(handles.fileType,'SLEEP EEG')      
            numberOfBins = 125;    %125 bins for sleep analysis
        else
            numberOfBins = 50;     %50 bins for wake analysis
        end

        % Runs the analysis on the data and returns the power spectrum bins,
        % the frequency and the number of epochs
        [SpectralData, NumEpochs, Frequency] = LatestAnalysis(...
            selectedDataByUser, handles.fileType);

        % Save to global workspace:
        assignin('base','SpectralData', SpectralData);
        assignin('base','NumEpochs', NumEpochs);
        assignin('base','Frequency', Frequency);

        %>>>>>>>>>>>>>>>>>> Create filename for each channel: <<<<<<<<<<<<<
        filename = evalin('base', 'filename');
        temp = '';
        for j=1:length(filename)
            if ~isspace(filename(j))
                temp = strcat(temp,filename(j));
            else
                filename = temp;
                break;      
            end%if
        end%for

        startDate = evalin('base', 'EEG_Data.startdate');
        startDate = strrep(startDate,'.','-');

        startTime = evalin('base', 'EEG_Data.starttime');
        startTime = strrep(startTime,'.','_');

        filename = strcat(filename, '_', startDate, '__', startTime, '_',...
                          handles.fileType ,'_',  handles.channelList(handles.selectedChannels(i)));

        assignin('base','outputFileName', filename{1});

        outputFileDir = strcat(handles.outputFilePath, filesep, filename);
        assignin('base','outputFileDir', outputFileDir{1});
        %>>>>>>>>>>>>>>>>>>>>>> End filename creation <<<<<<<<<<<<<<<<<<<<<
        
        % Save To XLS file:
        saveToXLS(outputFileDir{1}, handles.fileType,...
            SpectralData, numberOfBins, NumEpochs);

        display('File generation complete.');
        display(['File has been saved as ', outputFileDir{1}]);


%       % Save to CSV file:
%       % Frequency Range 0-25Hz
%       saveToFile(handles.data, [0 25], outputFileDir,...
%       handles.channelList(handles.selectedChannels(i)));

        % Update Label to display status of file generation:
        message = strcat('File generation for channel',{' '} ,...
                        handles.channelList(handles.selectedChannels(i)), ' is complete.');
        set(handles.labelStatus, 'String', message);
        pause(1);
        
        set(handles.labelStatus, 'String', 'Ready');
        
        guidata(gcbo, handles);
        %end% generateOutput

%end