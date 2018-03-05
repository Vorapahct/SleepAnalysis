function [filename, filepath, hdr, record] = importdata()
    % Open EDF File:
    [filename, filepath] = uigetfile({'*.EDF;*.edf;*.REC;*.rec', 'EDF Files (*.edf,*.rec)'}, 'Choose an EDF file'); 
    if filename~=0
        [hdr, record]=edfread([filepath filename]);
        display('EEG records imported successfully.');
        %[~,N] = size(record);
        %fs = 200;
    else % Default values
        hdr      = 0;
        record   = 0;
        filepath = 0;
    end% if
    
end %importdata

