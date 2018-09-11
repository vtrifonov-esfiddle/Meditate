# Meditate

A Garmin Connect IQ meditation app that tracks as an activity the heart rate, HRV, stress and provides vibration alerts.

## Features
- ability to save the session as a Connect IQ activity (optional)
    - save as **Meditating** or **Yoga**
- ability to configure multiple meditation/yoga sessions
    - e.g. a 20 min session with 1 min recurring alerts, triggering a different alert on the 10th minute
    - each session supports interval vibration alerts
    - interval alerts can trigger from a few seconds up to few hours
- [HRV](https://en.wikipedia.org/wiki/Heart_rate_variability) (Heart Rate Variability)
    - RMSSD - Root Mean Square of Successive Differences (beat-to-beat intervals)
    - pNN20 - % of successive beat-to-beat intervals that differ by more than 20 ms
    - pNN50 - % of successive beat-to-beat intervals that differ by more than 50 ms
    - HRV Successive Beats - difference between current and previous beat-to-beat intervals
    - SDRR - this approximates current HR to beat-to-beat intervals to calculate [Standard Deviation](https://en.wikipedia.org/wiki/Standard_deviation) of the first and last 5 min of the session
- stress tracking
    - analyses in overlapping 10 Sec Windows Max-Min beat-to-beat intervals (reported as Max-Min HRV 10 Sec Window chart on Connect IQ)
    - tracks the median of the Max-Min HRV windows as a summary field (Stress Median field on Connect IQ)
    - calculates stress into 3 cathegories - **No**, **Low** and **High**
        - No - % of Max-Min Windows that are <= **stress median**
        - Low - % of Max-Min Windows that are > **stress median** and < 3x **stress median**
        - High - % of Max-Min Windows that are >= 3x **stress median**
- summary stats at the end of the session
    - tracks the overall min, avg and max HR
    - Stress
    - HRV

![Session picker yoga explained](userGuideScreenshots/sessionPicker.png)
![Session in-progress explained](userGuideScreenshots/sessionInProgressExplained.png)
![Summary stress](userGuideScreenshots/summaryStress.png)
![Summary HRV](userGuideScreenshots/summaryHrvSdrr.png)

## Supported Devices
- Vivoactive 3, Vivoactive 3 Music 
  - [app store link](https://apps.garmin.com/en-US/apps/bed7ed4d-07ea-4600-b477-b8911670b64a)
  - from [vivoactive3-publish](https://github.com/vtrifonov-esfiddle/Meditate/tree/vivoactive3-publish) branch
- Round Watches that support Connect IQ >= 3.0 
  - [app store link](https://apps.garmin.com/en-US/apps/1cc98099-c08b-4fc7-91e6-0f3615a3ab2c)
  - from [round-watches-publish](https://github.com/vtrifonov-esfiddle/Meditate/tree/round-watches-publish) branch
  - Fenix 5/5+ Family, Forerunner 645 Family, Forerunner 935, D2 Charlie, D2 Delta Family

## [User Guide](UserGuide.md)

## Dependencies
- Font for duration picker [Google Roboto](https://fonts.google.com/specimen/Roboto) ([Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0))
- Status Icons - [Font Awesome free](https://fontawesome.com/license) (SIL OFL 1.1 License) 


