function x = customBin(Data,Range,Type)
    display('Creating Custom Bins...');
    if(strcmpi(Type,'sleep eeg') == true)
        TypeDataRange = 0.2;
    else
        TypeDataRange = 0.5;
    end

    [n,m] = size(Data);
    CheckRange = Range(1);
    RangeData = [TypeDataRange:TypeDataRange:25];
    
    for j = 1:n

        if(Range(1) == -1 && Range(2) == 25)
            Numbers(j) = sum(Data(j,:));
            continue;
        elseif(Range(1) == -1 && Range(2) ~= 25)
            Low = 1;
        end
        
        Range(1) = Range(1)+0.2;
        
        for i = 1:length(RangeData)
            if(Range(1) == RangeData(i))
                Low = i+1; 
            elseif(Range(2) == RangeData(i))
                High = i+1; 
            end   
        end
        
        Numbers(j,1) = sum(Data(j,Low:High));
        Range(1) = CheckRange;
    end
    
    x = Numbers;   %126
end