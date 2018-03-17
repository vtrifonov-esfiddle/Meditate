# Meditate

A Garmin Connect IQ meditation app that tracks as an activity the heart rate and provides vibration alerts.

## Features
- shows up as a Connect IQ activity allowing to view the HR graph (optional)
- tracks the overall min, avg and max HR
- ability to configure multiple meditation sessions
- each session supports interval vibration alerts
- interval alerts can trigger from a few seconds up to few hours
- summary stats at the end of the session
- Heart Rate Variability ([HRV](https://en.wikipedia.org/wiki/Heart_rate_variability)) - experimental
  - available at [hrv](https://github.com/vtrifonov-esfiddle/Meditate/tree/hrv) branch
  - this approximates current HR to R-R intervals to calculate RMSSD (root mean square of successive differences)
  - the Vivoactive 3 HR sensor is too unreliable to produce usable R-R intervals data (it flattens the readings)

## Supported Devices
- Vivoactive 3 (from [master](https://github.com/vtrifonov-esfiddle/Meditate/tree/master) branch)
- Round Watches that support Connect IQ >= 2.4 (from [support-round-watches](https://github.com/vtrifonov-esfiddle/Meditate/tree/support-round-watches) branch )
  - Fenix 5 Line, Forerunner 645 Line, Forerunner 935, D2 Charlie

## Screenshots
![meditate.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/meditate.png)

![sessionPicker.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/sessionPicker.PNG)

![sessionInProgress.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/sessionInProgress.PNG)

![sessionSummary.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/sessionSummary.PNG)

![timePicker.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/timePicker.PNG)

![colorPicker.png](https://github.com/vtrifonov-esfiddle/Meditate/blob/master/screenshots/colorPicker.PNG)
