# User Guide

## Features
- ability to save the session as a Connect IQ activity (optional)
    - save as **Meditating** or **Yoga**
- ability to configure multiple meditation/yoga sessions
    - e.g. a 20 min session with 1 min recurring alerts, triggering a different alert on the 10th minute
    - each session supports interval vibration alerts
    - interval alerts can trigger from a few seconds up to few hours
- stress tracking
    - analyses in overlapping 10 Sec Windows Max-Min HR (reported as Max-Min HR 10 Sec Window chart on Connect IQ)
    - tracks the median of the Max-Min HR windows as a summary field (Stress Median field on Connect IQ)
    - calculates stress into 3 cathegories - **No**, **Low** and **High**
        - No - % of Max-Min Windows that are <= **stress median**
        - Low - % of Max-Min Windows that are > **stress median** and < 3x **stress median**
        - High - % of Max-Min Windows that are >= 3x **stress median**
- summary stats at the end of the session
    - tracks the overall min, avg and max HR
    - Stress
    - HRV
- [HRV](https://en.wikipedia.org/wiki/Heart_rate_variability) (Heart Rate Variability) - optional
    - this approximates current HR to beat-to-beat intervals to calculate [Standard Deviation](https://en.wikipedia.org/wiki/Standard_deviation) of the first and last 5 min of the session

## How to Use
### 1. Starting a session

1.1. From the session picker screen press the start button. 

![Session Picker](userGuideScreenshots/sessionPicker.png)

1.2. The session in-progress screen contains the following elements
- time elapsed arc 
    - shows the percentage of elapsed session time
    - full circle means session time has elapsed
- interval alert triggers 
    - the small colored marks represent the time of trigerring an interval alert
    - each marked position corresponts to an alert trigger time
    - you can hide them per alert by selecting transparent color from the [Interval Alerts settings menu](#-2.-Configuring-a-session)
- time elapsed 
- current HR

The meditation session finishes once you press the stop button.

![Session in progress](userGuideScreenshots/sessionInProgressExplained.png)

1.3. Once you stop the session you have the option to save it.

![Confirm save session](userGuideScreenshots/confirmSaveSession.png)

1.4. Finally you see the Summary Screen. Swipe up/down (Vivoactive 3) or press page up/down buttons to see the summary stats of HR, Stress and HRV.

  ![Summary HR](userGuideScreenshots/summaryHr.png)![Summary Stress](userGuideScreenshots/summaryStress.png) ![Summary stress median](userGuideScreenshots/summaryStressMedian.png) ![Summary HRV](userGuideScreenshots/summaryHrvSdrr.png)
### 2. Configuring a session

2.1 From the session picker screen hold the menu button (for Vivoactive 3 hold on the screen) until you see the Session settings menu.

![Session Picker](userGuideScreenshots/sessionPicker.png) ![Session settings menu](userGuideScreenshots/sessionSettingsMenu.png)

2.2 In Add New/Edit you can configure:
- Time - total duration of the session in H:MM
- Color - the color of the session used in graphical controls; select by using page up/down behaviour on the watch (Vivoactive 3 - swipe up/down)
- Vibe Pattern - shorter or longer patterns ranging from pulsating or continuous
- Interval Alerts - ability to configure multiple intermediate alerts
    - once you are on a specific interval alert you see in the menu title the Alert ID (e.g. Alert 1) relative to the current session interval alerts
    - Time 
        - select one-off or repetitive alert
        - repetitive alerts allow shorter durations than a minute
        - only a single alert will execute at any given time
        - priority of alerts with the same time
          1. final session alert
          2. last one-off alert
          3. last repetative alert
    - Color - the color of the current interval alert used in the graphical controls. Select different colors for each alert to differentiate them during meditation. Select transparent color if you don't want to see visual marks for the alert during meditation
    - Vibe Pattern - shorter or longer patterns ranging from pulsating or continuous
- Activity Type - ability to save the session as **Meditating** or **Yoga**. You can configure default activity type for new sessions from the Global Settings (see section 5).
- Global Settings - see bellow section 4

### 3. Picking a session

From the session picker screen press page up/down buttons (for Vivoactive 3 - swipe up/down).
On this screen you can see the applicable settings for the selected session
- activity type - in the title
  - Meditate
  - Yoga
- time - total duration of the session
- vibe pattern
- interval alert triggers - the graph in the middle of the screen represents the relative alert triger time compared to the total session time
- Global settings - see section 4

![Session picker yoga explained](userGuideScreenshots/sessionPickerYogaExplained.png)

### 4. Turning on/off Stress and HRV

From the session picker screen hold the menu button (for Vivoactive 3 hold on the screen) until you see the Session settings menu. Select the Global Settings Menu. Select the setting you wish to change. Once you are done you can see which features are turned by looking at the session picker screen's bottom icons row.
- ![](userGuideScreenshots/globalSettingsStress.png) Stress tracking is On (tracking summary metrics of No, Low and High Stress)
- ![](userGuideScreenshots/globalSettingsStressDetailed.png) Detailed Stress tracking is On (tracks additionally stress median and Max-Min HR Windows Graph)
- ![](userGuideScreenshots/globalSettingsHrv.png) HRV tracking is On (tracks the standard deviation HRV of the first and last 5 min intervals of the session)

![Global settings](userGuideScreenshots/globalSettings.png)
### 5. Connect IQ New Activity Type

You can set the default activity type for new session as **Meditating** or as **Yoga**. To do this go to the session picker screen, hold the menu button (for Vivoactive 3 hold on the screen) until you see the Session settings menu. Select the Global Settings Menu -> New Activity Type 