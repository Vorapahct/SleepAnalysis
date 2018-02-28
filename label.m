function x = label(Type)

    if(strcmpi(Type,'SLEEP EEG') == true)
        step = 0.2;
        startRange = 0;
        stopRange = 0.2;
        loopRange = 125;
    else
        step = 0.5;
        startRange = 0;
        stopRange = 0.5;
        loopRange = 50;
    end
    
    for k = 1:loopRange
        lowRange = num2str(startRange);
        highRange = num2str(stopRange);
        Labels{k} = [lowRange '-' highRange ' Hz'];
        startRange = startRange + step;
        stopRange = stopRange + step;
    end

    x = [' ' Labels];
end