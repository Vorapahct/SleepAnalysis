function x = xAxisSpacing(Type, intervalsOfType)

    if(strcmp(Type,'wake EEG') == true)
        xSpacing = 0.5;
        xStep = 0.5;
    else
        xSpacing = 0.2;
        xStep = 0.2;
    end
        
    xAxis = [0];               
    for i = 1:intervalsOfType                  
        xAxis = [xAxis xSpacing];   
        xSpacing = xSpacing + xStep;  
    end

    x = xAxis;
end