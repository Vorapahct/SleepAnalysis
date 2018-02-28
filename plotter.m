function x = plotter(Frequency,EpochData,Epochs)
    [n,~] = size(EpochData);    %Creates a loop number depending on how many epochs to graph

    if(length(Epochs) > n)      %Error check, cannot plot more epochs than there is
        display('More epochs chosen to plot than epochs that exist within data.');
        return;
    end

    figure;     %Creates a new figure to plot on
    hold on;    %Allows multiply plots on one figure
    grid on;    %Switches the gridlines on
    
    for i = 1:length(Epochs)    %Plots the selected epochs
        plot(Frequency,EpochData(Epochs(i),:));
    end
    
    for j = 1:length(Epochs)    %Creates labels for the legend with the epoch number
        LegendLabel{j} = num2str(Epochs(j));
    end
    
    legend(LegendLabel);                %Puts the legend on the figure
    title('Selected Epochs Plotted');   %Gives the figure a title
    xlabel('Frequency (Hz)');           %Gives the figure a x axis label
    ylabel('Power (dB)');               %Gives the figure a y axis label
end