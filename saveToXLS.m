function saveToXLS(outputFileDir, TypeOfAnalysis, MainData,...
                    intervalsOfType, NumEpochs)
                
    display('Saving Output File...');                           
    %Creates a label array for the writing to
    Headings = label(TypeOfAnalysis);
    
    %Starts to create the excel file by using the label array
    FinalAssembly(1,:) = Headings;          

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%% Creates the 1-25 Hz labels to easily read the data %%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for p = 1:intervalsOfType
        TotalEmptyCells{p} = ' ';
        if(mod(p,(intervalsOfType/25)) == 0)
            TotalEmptyCells{p} = p/(intervalsOfType/25);
        end
    end

    
    TotalEmptyCells = ['DC' TotalEmptyCells];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    FinalAssembly(2,:) = TotalEmptyCells;   %Adds the new labels to the final array
   
    %Gets the number of records within the processed data
    [loopNumber, ~] = size(MainData);       

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%% Converts all the data into a writeable format %%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for p = 1:loopNumber
        FinalAssembly(p+2,:) = num2cell(MainData(p,:));
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%% Creates the epochs label %%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    EpochsNumberLabel = [1:1:NumEpochs]';
    EpochsNumLabel{1} = ' '; 
    EpochsNumLabel{2} = 'Epochs';
    for p = 1:length(EpochsNumberLabel)
        EpochsNumLabel{1,p+2} = num2str(EpochsNumberLabel(p));
    end
    FinalOutput = [EpochsNumLabel' FinalAssembly];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    xlswrite([outputFileDir '.xls'],FinalOutput);   %Writes the data to an excel file
    
    try
        winopen([outputFileDir '.xls']);
    catch
        display('Tried to open file in Excel!');
    end%try

end

