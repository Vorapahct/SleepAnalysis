function customBinsGUI(varargin)
    % Check to see if GUI has been created already (Singleton behaviour):
    customBinsGUI_handle = findall(0,'tag','customBinsGUIFig');

    if (isempty(customBinsGUI_handle))
        %Launch the figure
        position = [680,416,350,270];
        colour   = [0.94, 0.94, 0.94]; % Windows form colour
        customBinsGUIFig = figure('Name', 'Plot', 'tag',...
            'customBinsGUIFig', 'Visible', 'off','Position', position,...
            'Resize', 'off', 'menubar', 'none', 'numbertitle', 'off',...
            'Color', colour, 'CloseRequestFcn', {@customBinsGUI_CloseRequestFcn});

        mainFontSize = 11;
        mainFontUnits = 'points';
        
        handles = guihandles;
        
        % Create UI elements:
        % ============================== Labels ===========================
        position = [11, 10, 330, 30];
        handles.labelStatus = uicontrol('Style', 'text', 'String',...
            'Ready', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelStatus','FontSize', 8,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
            'HorizontalAlignment', 'left');
        
        guidata(handles.labelStatus, handles);
        
        %------------------------------------------------------------------

        position = [11, 207, 165, 23];
        handles.labelSelectRange = uicontrol('Style', 'text', 'String',...
            'Enter Frequency Range:', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelSelectRange','FontSize', mainFontSize,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
            'HorizontalAlignment', 'left');
        
        
        guidata(handles.labelSelectRange, handles);
        
        %------------------------------------------------------------------
        position = [11, 110, 125, 23];
        handles.labelRangeName = uicontrol('Style', 'text', 'String',...
            'Enter Range Title: ', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelRangeName','FontSize', mainFontSize,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
            'HorizontalAlignment', 'left');
        
        
        guidata(handles.labelRangeName, handles);
        
        %------------------------------------------------------------------
        position = [11, 161, 287, 21];
        handles.labelInfo = uicontrol('Style', 'text', 'String',...
            'To include DC values enter -1 above as first value. ', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelInfo','FontSize', 8,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour,...
            'HorizontalAlignment', 'left');
        
        
        guidata(handles.labelInfo, handles);
        % ============================End Labels ==========================
        
        
        %=========================== Edit Boxes ===========================
        position = [180, 199, 131, 40];
        handles.edtBoxFrequencyRange = uicontrol('Style', 'edit', 'String', '-1 2',...
            'Units', 'pixels', 'Position', position, 'Tag', 'edtBoxFrequencyRange',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'CreateFcn', {@edtBoxFrequencyRange_CreateFcn});
        
        % Set Callback:
        set(handles.edtBoxFrequencyRange,'Callback',...
                                   {@edtBoxFrequencyRange_Callback});
        
        % Update handles structure
        guidata(handles.edtBoxFrequencyRange, handles);
        
        %------------------------------------------------------------------
        position = [180, 103, 131, 40];
        handles.edtBoxRangeName = uicontrol('Style', 'edit', 'String', 'Alpha',...
            'Units', 'pixels', 'Position', position, 'Tag', 'edtBoxRangeName',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'CreateFcn', {@edtBoxRangeName_CreateFcn});
        
        % Set Callback:
        set(handles.edtBoxRangeName,'Callback',...
                                   {@edtBoxRangeName_Callback});
        
        % Update handles structure
        guidata(handles.edtBoxRangeName, handles);
        %========================= END Edit Boxes =========================
        
        
        %============================= Buttons ============================
        position = [11, 40, 300, 50];
        handles.btnGenerateBins = uicontrol('Style', 'pushbutton', 'String', 'Generate',...
            'Units', 'pixels', 'Position', position, 'Tag', 'btnGenerateBins',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour);
        
        % Set Callback:
        set(handles.btnGenerateBins,'Callback',{@btnGenerateBins_Callback});
 
        % Update handles structure
        guidata(handles.btnGenerateBins, handles);
        %=========================== END Buttons ==========================
        
        
        % Move GUI to the centre of the screen:
        movegui(customBinsGUIFig, 'center');

        set(customBinsGUIFig, 'Visible', 'on');
    else
        
        % Set the figure in focus:
        figure(customBinsGUI_handle);  
    end% if
        
    %------------------------ Main GUI Functions --------------------------
    % --- Executes when user attempts to close mainGUIFig.
    function customBinsGUI_CloseRequestFcn(hObject, eventdata)
    % hObject    handle to mainGUIFig (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: delete(hObject) closes the figure
        delete(hObject);
    %end% generateOutputGUI_CloseRequestFcn
    
    % ======================= Edit Box func ===============================
    % --- Executes during object creation, after setting all properties.
    function edtBoxRangeName_CreateFcn(hObject, eventdata)
    % hObject    handle to edtOutputDirec (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
        
    function edtBoxRangeName_Callback(hObject, eventdata)
    % hObject    handle to edtBoxFrequencyRange (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of edtBoxRangeName as text
    %        str2double(get(hObject,'String')) returns contents of edtBoxRangeName as a double
        handles = guidata(gcbo);
        handles.BinFreqRangeTitle = get(hObject,'String');

        assignin('base','BinFreqRangeTitle', handles.BinFreqRangeTitle);
        
        % Update handles structure
        guidata(gcbo, handles);
    %end % edtBoxRangeName_Callback
        
    % --- Executes during object creation, after setting all properties.
    function edtBoxFrequencyRange_CreateFcn(hObject, eventdata)
    % hObject    handle to edtOutputDirec (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
        
        
    function edtBoxFrequencyRange_Callback(hObject, eventdata)
    % hObject    handle to edtBoxFrequencyRange (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of edtBoxFrequencyRange as text
    %        str2double(get(hObject,'String')) returns contents of edtBoxFrequencyRange as a double
        handles = guidata(gcbo);
        handles.BinFreqRange = str2num(get(hObject,'String'));
        
        assignin('base','BinFreqRange', handles.BinFreqRange);
        
        % Update handles structure
        guidata(gcbo, handles);
    %end % edtBoxFrequencyRange_Callback
    % ========================== END Edit Box Func ========================
    
    
    
    % ======================== Button Callbacks ===========================
    function btnGenerateBins_Callback(hOject, eventdata)
    % hObject    handle to mainGUIFig (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        
        % Self call to ensure values from GUI are saved:
        edtBoxFrequencyRange_Callback(handles.edtBoxFrequencyRange, eventdata);
        edtBoxRangeName_Callback(handles.edtBoxRangeName, eventdata);
        
        handles = guidata(gcbo);
        try
            % Get data from global workspace:
            SpectralData   = evalin('base', 'SpectralData');
            fileType       = evalin('base', 'fileType');
            outputFileName = evalin('base', 'outputFileName');
            outputFilePath = evalin('base', 'outputFilePath'); 
    
            if ~isempty(SpectralData) && ~isempty(handles.BinFreqRange)...
                    && ~isempty(handles.BinFreqRangeTitle)

               % Generate filename:
                filename = strcat(outputFilePath, filesep, handles.BinFreqRangeTitle,'_',...
                                  outputFileName);

                % Disable button:
                set(handles.btnGenerateBins, 'Enable', 'off');

                % Display status:
                message = strcat('Generating file', {' '},handles.BinFreqRangeTitle,'_',...
                                  outputFileName);
                set(handles.labelStatus, 'String', message);
                drawnow();

                % Create custom bin: %Uses -1 to add the DC point, 
                % otherwise takes in the frequency
                data = customBin(SpectralData, handles.BinFreqRange, fileType);

                % Writes the custom bins to an excel file:
                display(['Saving ' handles.BinFreqRangeTitle ' File...']);           
                xlswrite(filename, data);  
                display('File generated successfully.');
                
                 try
                    winopen([filename '.xls']);
                 catch
                    display('Tried to open file in Excel!');
                 end%try
                
                % Display status:
                message = ['Ready'];
                set(handles.labelStatus, 'String', message);
                set(handles.btnGenerateBins, 'Enable', 'on');
                drawnow();
            end% if
        catch ME
          
          % Enable button:
          set(handles.btnGenerateBins, 'Enable', 'on');
          
          % Display status:
          set(handles.labelStatus, 'String', 'Unsuccessful');
          
          % Throw error:
          rethrow(ME);
        end%try
        
        
        guidata(gcbo, handles);
%end

