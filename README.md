# Meditate

A Garmin Connect IQ meditation app that tracks as an activity the heart rate, stress, HRV and provides vibration alerts.

## Features
- shows up as a Connect IQ activity allowing to view the HR graph (optional)
- stress tracking
  - analyses in overlapping 10 Sec Windows Max-Min HR (reported as **Max-Min HR 10 Sec Window** chart on Connect IQ)
  - tracks the median of the Max-Min HR windows as a summary field (**Stress Median** field on Connect IQ)
  - calculates stress into 3 cathegories - **No**, **Low** and **High**
    - No - % of Max-Min Windows that are <= **stress median**
    - Low - % of Max-Min Windows that are > **stress median** and < 3x **stress median**
    - High - % of Max-Min Windows that are >= 3x **stress median**
- tracks the overall min, avg and max HR
- ability to configure multiple meditation sessions
- each session supports interval vibration alerts
- interval alerts can trigger from a few seconds up to few hours
- summary stats at the end of the session
- [HRV](https://en.wikipedia.org/wiki/Heart_rate_variability) (Heart Rate Variability) 
  - this approximates current HR to beat-to-beat intervals to calculate [Standard Deviation](https://en.wikipedia.org/wiki/Standard_deviation) of the first and last 5 min of the session
  - the Vivoactive 3 HR sensor is too unreliable to produce usable R-R intervals data for algorithms that analyse successive beat-to-beat intervals like RMSSD (it flattens the readings)
  - working version with RMSSD in branch [hrv-rmssd-publish](https://github.com/vtrifonov-esfiddle/Meditate/tree/hrv-rmssd-publish/)

## Supported Devices
- Vivoactive 3 (from [vivoactive3-publish](https://github.com/vtrifonov-esfiddle/Meditate/tree/vivoactive3-publish) branch)
- Round Watches that support Connect IQ >= 2.4 (from [round-watches-publish](https://github.com/vtrifonov-esfiddle/Meditate/tree/round-watches-publish) branch)
  - Fenix 5 Family, Forerunner 645 Family, Forerunner 935, D2 Charlie

## Screenshots
![meditate.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/meditate.png)
![sessionPicker.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/sessionPicker.PNG)
![sessionInProgress.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/sessionInProgress.PNG)
![sessionSummaryHr.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/sessionSummaryHr.PNG)
![sessionSummaryStress.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/sessionSummaryStress.PNG)
![sessionSummaryStressMedian.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/sessionSummaryStressMedian.PNG)
![sessionSummaryHrvSdrr.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/sessionSummaryHrvSdrr.PNG)
![timePicker.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/timePicker.PNG)
![colorPicker.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/colorPicker.PNG)
