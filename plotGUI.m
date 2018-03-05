function plotGUI(varargin)
    % Check to see if GUI has been created already (Singleton behaviour):
    plotGUI_handle = findall(0,'tag','plotGUIFig');

    if (isempty(plotGUI_handle))
        %Launch the figure
        position = [680,489,369, 120];
        colour   = [0.94, 0.94, 0.94];
        plotGUIFig = figure('Name', 'Plot Epochs', 'tag',...
            'plotGUIFig', 'Visible', 'off','Position', position,...
            'Resize', 'off', 'menubar', 'none', 'numbertitle', 'off',...
            'Color', colour, 'CloseRequestFcn', {@plotGUI_CloseRequestFcn});

        mainFontSize = 11;
        mainFontUnits = 'points';
        
        handles = guihandles;
        
        
        % Create UI elements:
        % ============================== Labels ===========================
        position = [11, 45, 140, 21];
        handles.labelSelectEpochs = uicontrol('Style', 'text', 'String',...
            'Select Epochs: ', 'Units', 'pixels', 'Position', position,...
            'Tag', 'labelSelectEpochs','FontSize', mainFontSize,...
            'FontUnits', mainFontUnits, 'BackgroundColor', colour);
        
        
        guidata(handles.labelSelectEpochs, handles);
        % ============================End Labels ==========================
        
        
        %============================ Buttons =============================
        position = [176, 35, 175, 50];
        handles.btnSelectEpochs = uicontrol('Style', 'pushbutton', 'String', 'Select Epochs',...
            'Units', 'pixels', 'Position', position, 'Tag', 'btnSelectEpochs',...
            'FontSize', mainFontSize, 'FontUnits', mainFontUnits,...
            'BackgroundColor', colour, 'Enable', 'on');
        
        % Set Callback:
        set(handles.btnSelectEpochs,'Callback',{@btnSelectEpochs_Callback});
 
        % Update handles structure
        guidata(handles.btnSelectEpochs, handles);
        %========================== End Butttons ==========================
        
        
        % Move GUI to the centre of the screen:
        movegui(plotGUIFig, 'center');

        set(plotGUIFig, 'Visible', 'on');
    else
        % Set the figure in focus:
        figure(plotGUI_handle);    
    end% if
    
    
    % =============== plotGUI CALLBACK Functions ================
    %------------------------ Main GUI Functions --------------------------
    % --- Executes when user attempts to close mainGUIFig.
    function plotGUI_CloseRequestFcn(hObject, eventdata)
    % hObject    handle to mainGUIFig (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hint: delete(hObject) closes the figure
        delete(hObject);
    %end% plotGUI_CloseRequestFcn
    
    
    %========================== Button Callbacks ==========================
    function btnSelectChannel_Callback(hOject, eventdata)
    % hObject    handle to mainGUIFig (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        
%         handles.channelList = evalin('base', 'EEG_Data.label');
%         [handles.selectedChannels, handles.isChannelSelected] = listdlg(...
%             'PromptString','Select the channels:', 'SelectionMode',...
%             'multiple', 'ListString',handles.channelList);
        set(handles.btnSelectEpochs, 'Enable', 'off');
        guidata(gcbo, handles);
        
        
    function btnSelectEpochs_Callback(hOject, eventdata)
    % hObject    handle to mainGUIFig (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        handles = guidata(gcbo);
        
        handles.Frequency = evalin('base', 'Frequency');
        handles.MainData  = evalin('base', 'SpectralData');
        
        
        handles.NumEpochs = evalin('base', 'NumEpochs');
        handles.NumEpochs = 1:1:handles.NumEpochs;
        handles.NumEpochs = num2str(handles.NumEpochs.');
        [handles.selectedEpochs, handles.isEpochsSelected] = listdlg(...
            'PromptString','Select the Epochs:', 'SelectionMode',...
            'multiple', 'ListString',handles.NumEpochs);
        
        if handles.isEpochsSelected==1
            plotter(handles.Frequency, handles.MainData, handles.selectedEpochs);
        end % if
        
        guidata(gcbo, handles);
    %======================== End Button Callbacks ========================
    
    
    
    %======================= STANDALONE FUNCTIONS =========================
%end

