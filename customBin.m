function x = customBin(Data,Range,Type)
    display('Creating Custom Bins...');
    if(strcmpi(Type,'sleep eeg') == true)
        TypeDataRange = 0.2;
    else
        TypeDataRange = 0.5;
    end

    [n,m] = size(Data);
    
    if(Range(1) == -1)
        Start = 1;
    else
        Start = Range(1)/TypeDataRange + 2;
    end
    Stop = Range(2)/TypeDataRange + 1;
    
    for j = 1:n
        Numbers(j,1) = sum(Data(j,Start:Stop));
    end

    x = Numbers;   
end