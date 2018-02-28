function x = RangeSelector(interval,Data)
    tempIntervalEnd = round(interval(2),0); % Round down to nearest 1:
    if(tempIntervalEnd == 0)
        x = Data;
        return;
    end
    tempIntervalEnd = round(interval(2)*6000*2,0);
    lengthOfData   = length(Data);
    if( tempIntervalEnd > lengthOfData)
        display('The range selected exceeds the range of the data');
        x = 0;
        return;
    end
    DataStart = round(interval(1)*6000*2,0);
    DataStop  = round(interval(2)*6000*2,0);

    selectedDataByUser = Data(1,(DataStart+1):DataStop);

    x = selectedDataByUser;
end