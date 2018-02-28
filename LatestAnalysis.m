function [x,y,z] = LatestAnalysis(CurrentChannel,Type)

    display('Analyzing Channel Data...');
    EpochDivision = 6000;   %6000 data points (sampled at 5 mili seconds) make 30 seconds
    EpochStart = 1;         %First Epoch starts at 1
    EpochEnd = 6000;        %First Epoch ends at 6000

    for i = 1:length(CurrentChannel)/EpochDivision          %Breaks down data into the Epochs by reading from EpochStart till EpochEnd
        Epochs(i,:) = CurrentChannel(EpochStart:EpochEnd);  %Master Epoch file which all broken up data is put into
        EpochStart = EpochStart + EpochDivision;            %Adds the division to get the next start of the next epoch
        EpochEnd = EpochEnd + EpochDivision;                %Adds the division to get the next end of the next epoch
    end

    NumEpochs = i;          %Saves the loop number which is the number of Epochs
    display(strcat(num2str(NumEpochs), ' Epochs in selected time inteval.'));

    overlap = 0;                %Dont want data to overlap
    fs = 200;                   %Sampling rate
    winlength = 200;            %Window length
    fftlength = winlength*100;  %What the resulting FFT length/2 must be, for accuracy

    for i = 1:NumEpochs         %Runs the loop for every Epoch
        [CurrentEpochSpectrum,frequencyAxis] = pwelch(Epochs(i,:),winlength,overlap,fftlength,fs);  %Computes Pwelch (like FFT) for current data using parameters
        LengthWithoutDC = length(frequencyAxis)-1;  %Removes the DC component from the length
        UsefulLength = 0.25*LengthWithoutDC +1;     %Gets the number of frequencies for 25Hz plus 1 for the DC component 
        AllEpochSpectrums(i,:) = CurrentEpochSpectrum(1:UsefulLength);                          %Saves all the epoch spectrums
    end

    if(strcmpi(Type,'SLEEP EEG'))   %Decides on a time interval depending on type of analysis 
        intervalsOfType = 125; %125 bins for sleep analysis
    else
        intervalsOfType = 50;  %50 bins for wake analysis
    end

    xAxis = xAxisSpacing(Type,intervalsOfType);

    for j = 1:NumEpochs
        FreqBinDivision = (UsefulLength-1)/intervalsOfType; %Calculates the number of points per frequency bin
        FreqBinStart = 1;                                   %Sets the first bin to begin at the first point
        FreqBinEnd = (UsefulLength-1)/intervalsOfType;      %Sets the first bin to end at the last point by the frequency division formula
        ValidFreqData = AllEpochSpectrums(j,2:UsefulLength); %Just sets the current data in a easy to use manner

        for i = 1:intervalsOfType
           FreqBins(j,i) = sum(ValidFreqData(FreqBinStart:FreqBinEnd))/FreqBinDivision;   %Sums the points into the bin, if you divide by /FreqBinDivision it will match the later created graph
           FreqBinStart = FreqBinStart + FreqBinDivision;               %Adds the frequency division onto the beginning index
           FreqBinEnd = FreqBinEnd + FreqBinDivision;                   %Adds the frequency division onto the end index
        end

        newAmplitude = [AllEpochSpectrums(j,1) FreqBins(j,:)];  %Reintroduces the removed DC value at 0Hz
        ImportantData(j,:) = 10*log10(newAmplitude);
    end

    x = ImportantData;
    y = NumEpochs;
    z = xAxis;
end