function saveToFile(data, frequencyRange, selectedFrequencyRange, outputFileDir,...
    channelLabel, fileType)
    if nargin==6
        %listsep = ',';
        outputFile = [outputFileDir '_' channelLabel '.csv'];
        
        if strcmpi(fileType,'SLEEP EEG')
            hertzInterval = 0.2;
            titleInterval = 5;
        else
            hertzInterval = 0.5;
            titleInterval = 2;
        end% if
        
        frequencies = frequencyRange(1):hertzInterval:frequencyRange(2);
        
        % Check that file is available for writing:
        while 1
            fid = fopen(outputFile,'w');
            if fid~=-1
                % Add empty cells for headings that will appear on 2nd row
                % in the final output:
                for i=1:2
                    fprintf(fid, ['%s' listsep], ' ');
                end%for
                fclose(fid);
                break;
            else
                fprintf(1,'\nThe file %s \nis open in another program! Please close it to continue.',outputFile);
                pause(2);
            end%if
        end % while
        
        % Create column headings
        frequencyBinHeadings = cell(length(frequencies),2);
        k = 1;
        hertz = 1;

        for i=1:length(frequencies)-1
            % 
            if (i>=3)
                if (mod(k,titleInterval)==0)
                   k = 1;
                   frequencyBinHeadings(i,2) = {num2str(hertz)};
                   hertz = hertz+1;
                else
                   frequencyBinHeadings(i,2) = {' '};
                   k = k+1;
                end%if
            end%if
            
            % Format numbers to have 1 decimal place:
            binEdges = num2str(frequencies(i), '%10.1f\n');
            binEdges = strcat(binEdges, '-',num2str(frequencies(i+1),'%10.1f\n'), 'Hz');
            frequencyBinHeadings(i,1) = {binEdges};      
        end%for
        
        % Add last entry:
        frequencyBinHeadings(end,2) = {num2str(hertz)};
        
        % Add Epoch Number column heading:
        frequencyBinHeadings(1,2) = {'Epoch Number'};
        
        %Add DC at 0Hz column heading:
        frequencyBinHeadings(2,2) = {'DC at 0Hz'};
         
        % Transpose to make the rows columns:
        frequencyBinHeadings = frequencyBinHeadings';
         
        % Write column headings to CSV file:
        fid = fopen(outputFile,'at'); % 'at' - append
        fprintf(fid, ['%s' listsep], frequencyBinHeadings{1,1:end});
        fprintf(fid, '%s \n', '');
        fprintf(fid, ['%s' listsep], frequencyBinHeadings{2,1:end-1});
        fprintf(fid, ['%s' listsep], ' ');
        fprintf(fid, ['%s' listsep], frequencyBinHeadings{2,end});
        fclose(fid);
         
         %dlmwrite(outputFile, data, '-append', 'delimiter', listsep);
    end%if
     
end%saveToFile

