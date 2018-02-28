# SleepAnalysis
This software is written for the purpose of getting the power spectrum of an input EEG signal in .rec format. The program applies the *pwelch* function of MATLAB and then bins the power spectrum in frequency bins of width 0.2 Hz or 0.5 Hz depending on the type of analysis (sleep or wake). Results of the program are stored in an Excel spreadsheet.

### edfread Function
The .rec file is read through the use of [*edfread*](https://www.mathworks.com/matlabcentral/fileexchange/31900-edfread) which was created by Brett Shoelson. 

### Future Work
This program is open to expansion in the future if there are people who would use it and want more features. Contact either of the developers for more information.
