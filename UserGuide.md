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
    - you can hide them per alert by selecting transparent color from the [Interval Alerts settings menu](#2-configuring-a-session)
- time elapsed 
- current HR

The meditation session finishes once you press the stop button.

![Session in progress](userGuideScreenshots/sessionInProgressExplained.png)

1.3. Once you stop the session you have the option to save it.

1.3.1 You can configure to auto save or auto discard session in [Global Settings](#4-global-settings)

![Confirm save session](userGuideScreenshots/confirmSaveSession.png)

1.4. Finally you see the Summary Screen. Swipe up/down (Vivoactive 3) or press page up/down buttons to see the summary stats of HR, Stress and HRV.

  ![Summary HR](userGuideScreenshots/summaryHr.png)![Summary Stress](userGuideScreenshots/summaryStress.png) ![Summary stress median](userGuideScreenshots/summaryStressMedian.png) ![Summary HRV](userGuideScreenshots/summaryHrvSdrr.png)

1.5 Depending on the chosen option for [Confirm Save](#4.3-Confirm-Save) in [Global Settings](#4-global-settings) when you go back from this view you either exit the app (the default) or go back to the session picker screen

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
- Activity Type - ability to save the session as **Meditating** or **Yoga**. You can configure default activity type for new sessions from the Global Settings ([see section 4](#4-global-settings)).

2.3 Delete - deletes a session after asking for confirmation

2.4 Global Settings - [see section 4](#4-global-settings)

### 3. Picking a session

From the session picker screen press page up/down buttons (for Vivoactive 3 - swipe up/down).
On this screen you can see the applicable settings for the selected session
- activity type - in the title
  - Meditate
  - Yoga
- time - total duration of the session
- vibe pattern
- interval alert triggers - the graph in the middle of the screen represents the relative alert triger time compared to the total session time

![Session picker yoga explained](userGuideScreenshots/sessionPickerYogaExplained.png)

### 4. Global Settings
From the session picker screen hold the menu button (for Vivoactive 3 hold on the screen) until you see the Session settings menu. Select the Global Settings Menu. You see a view with the states of the global settings.

![Global settings](userGuideScreenshots/globalSettings.png)

To change the settings hold the menu button (for Vivoactive 3 hold on the screen) until you see the Global Settings menu. There you can select the setting you want to change.

#### 4.1 Stress Tracking

- On - tracks summary stress metrics into tree categories: No, Low and High stress
- On Detailed - tracks additionally stress median and Max-Min HR Windows Graph
- Off - no stress tracking

#### 4.2 HRV Tracking

- On 
  - tracks the standard deviation HRV of the first and last 5 min intervals of the session
  - produces beat-to-beat intervals graph in ConnectIQ when activity is saved
- Off - no HRV tracking

#### 4.3 Confirm Save

- Ask - when an activity finihes asks for confirmation whether to save the activity
- Auto Yes - when an activity finihes auto saves it
- Auto No - when an activity finihes auto discards it

#### 4.4 Multi-Session

- Yes 
  - the app continues to run after finishing session
  - this allows you to record multiple sessions
- No - the app exits after finishing session

#### 4.5 New Activity Type
You can set the default activity type for new sessions.

- Meditating
- Yoga