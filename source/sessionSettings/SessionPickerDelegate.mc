using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
class SessionPickerDelegate extends ScreenPickerDelegate {
	private var mSessionStorage;
	private var mSelectedSessionDetails;
	
	function initialize(sessionStorage) {
		ScreenPickerDelegate.initialize(sessionStorage.getSelectedSessionIndex(), sessionStorage.getSessionsCount());	
		me.mSessionStorage = sessionStorage;
		me.mSelectedSessionDetails = new DetailsModel();
		me.globalSettingsIconsYOffset = App.getApp().getProperty("globalSettingsIconsYOffset");
		me.sessionDetailsIconsXPos = App.getApp().getProperty("sessionDetailsIconsXPos");
		me.sessionDetailsValueXPos = App.getApp().getProperty("sessionDetailsValueXPos");
		me.globalSettingsIconsXPos = App.getApp().getProperty("globalSettingsIconsXPos");
		me.sessionDetailsAlertsLineYOffset = App.getApp().getProperty("sessionDetailsAlertsLineYOffset");
	}
	
	private var globalSettingsIconsYOffset;
	private var sessionDetailsIconsXPos;
	private var sessionDetailsValueXPos;
	private var globalSettingsIconsXPos;
	private var sessionDetailsAlertsLineYOffset;
	
    function onMenu() {
		return me.showSessionSettingsMenu();
    }
    
    private function showSessionSettingsMenu() {
    	var sessionSettingsMenuDelegate = new SessionSettingsMenuDelegate(me.mSessionStorage, me);
        Ui.pushView(new Rez.Menus.sessionSettingsMenu(), sessionSettingsMenuDelegate, Ui.SLIDE_UP);
        return true;
    }
		
	private function startActivity() {
    	var selectedSession = me.mSessionStorage.loadSelectedSession();
    	var meditateModel = new MeditateModel(selectedSession);  
    	  
        var meditateView = new MeditateView(meditateModel);
        var mediateDelegate = new MeditateDelegate(meditateModel);
		Ui.switchToView(meditateView, mediateDelegate, Ui.SLIDE_LEFT);
	}
	
    function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER) {
	    	me.startActivity();
	    	return true;
	  	}
	  	return false;
    }
	
	private function setSelectedSessionDetails() {
		me.mSessionStorage.selectSession(me.mSelectedPageIndex);
		var session = me.mSessionStorage.loadSelectedSession();
		me.updateSelectedSessionDetails(session);
	}
		
	private static function getVibePatternText(vibePattern) {
		switch (vibePattern) {
			case VibePattern.LongPulsating:
				return "Long Pulsating";
			case VibePattern.LongAscending:
				return "Long Ascending";
			case VibePattern.LongContinuous:
				return "Long Continuous";
			case VibePattern.MediumAscending:
				return "Medium Ascending";
			case VibePattern.MediumContinuous:
				return "Medium Continuous";
			case VibePattern.MediumPulsating:
				return "Medium Pulsating";
			case VibePattern.ShortAscending:
				return "Short Ascending";
			case VibePattern.ShortContinuous:
				return "Short Continuous";
			case VibePattern.ShortPulsating:
				return "Short Pulsating";
		}
	}
	
	function updateSelectedSessionDetails(session) {
		var details = me.mSelectedSessionDetails;
				
        details.color = Gfx.COLOR_WHITE;
        details.backgroundColor = Gfx.COLOR_BLACK;
        var activityTypeText;
        if (session.activityType == ActivityType.Yoga) {
        	activityTypeText = "Yoga";
        }
        else {
        	activityTypeText = "Meditate";
        }
        details.title = activityTypeText + " " + (me.mSelectedPageIndex + 1);
        details.titleColor = session.color;
        
        var timeIcon = new Icon({        
        	:font => IconFonts.fontAwesomeFreeSolid,
        	:symbol => Rez.Strings.faHourglassHalf
        });
        details.detailLines[1].icon = timeIcon;
        details.detailLines[1].value.text = TimeFormatter.format(session.time);
        
        var vibePatternIcon = new Icon({        
        	:font => IconFonts.fontMeditateIcons,
        	:symbol => Rez.Strings.meditateFontVibratePattern
        });
        details.detailLines[2].icon = vibePatternIcon;
        details.detailLines[2].value.text = getVibePatternText(session.vibePattern);
        
        var alertsLineIcon = new Icon({        
        	:font => IconFonts.fontAwesomeFreeRegular,
        	:symbol => Rez.Strings.faClock
        });
        details.detailLines[3].icon = alertsLineIcon;
        var alertsToHighlightsLine = new AlertsToHighlightsLine(session);
        details.detailLines[3].value = alertsToHighlightsLine.getAlertsLine(me.sessionDetailsValueXPos, me.sessionDetailsAlertsLineYOffset);
        
        details.setAllIconsXPos(me.sessionDetailsIconsXPos);
        details.setAllValuesXPos(me.sessionDetailsValueXPos);       
        
        me.updateGlobalSettingsDetails();      
	}	
	
	function updateGlobalSettingsDetails() {
		var details = me.mSelectedSessionDetails;
		var statusIcons = new IconsLine(4);
		statusIcons.xPos = me.globalSettingsIconsXPos;
		var stressTracking = GlobalSettings.loadStressTracking();
		if (stressTracking == StressTracking.On) {
			statusIcons.addIcon({        
	        	:font => IconFonts.fontMeditateIcons,
	        	:symbol => Rez.Strings.meditateFontStress,
	        	:color => Gfx.COLOR_WHITE
	        });		
		}
		else if (stressTracking == StressTracking.OnDetailed) {			
			statusIcons.addIcon({        
	        	:font => IconFonts.fontMeditateIcons,
	        	:symbol => Rez.Strings.meditateFontStress,
	        	:color => Gfx.COLOR_WHITE
	        });	
			statusIcons.addIcon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faPieChart,
	        	:color => Gfx.COLOR_WHITE
	        });	
		}    
		if (GlobalSettings.loadHrvTracking() == HrvTracking.On) {			
			var heartBeatPurpleColor = 0xFF00FF;
			statusIcons.addIcon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faHeartbeat,
	        	:color => heartBeatPurpleColor
	        });	
		}          
				
        var saveActivityConfirmation = GlobalSettings.loadConfirmSaveActivity();
        if (saveActivityConfirmation == ConfirmSaveActivity.AutoYes) {
        	statusIcons.addIcon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faSaveSession,
	        	:color => Gfx.COLOR_GREEN
	        });	
        }
        if (saveActivityConfirmation == ConfirmSaveActivity.AutoNo) {
        	statusIcons.addIcon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faSaveSession,
	        	:color => Gfx.COLOR_RED
	        });	
        }
        var multiSession = GlobalSettings.loadMultiSession();
        if (multiSession == MultiSession.Yes) {
        	statusIcons.addIcon({        
	        	:font => IconFonts.fontAwesomeFreeSolid,
	        	:symbol => Rez.Strings.faRepeatSession
	        });	
        }
        
        statusIcons.yLineOffset = me.globalSettingsIconsYOffset;         
		details.detailLines[4] = statusIcons;
	}
	
	function createScreenPickerView() {
		me.setSelectedSessionDetails();
		return new SessionPickerView(me.mSelectedSessionDetails);
	}
	
	class AlertsToHighlightsLine {
		function initialize(session) {
			me.mSession = session;
		}
		
		private var mSession;
		
		function getAlertsLine(alertsLineXPos, alertsLineYOffset) {
	        var alertsLine = new PercentageHighlightLine(me.mSession.intervalAlerts.count());

	        alertsLine.backgroundColor = me.mSession.color;	        
	        alertsLine.startPosX = alertsLineXPos;
	        alertsLine.yOffset = alertsLineYOffset;
	        	        
	        me.AddHighlights(alertsLine, IntervalAlertType.Repeat);      
	        me.AddHighlights(alertsLine, IntervalAlertType.OneOff);
	        
	        return alertsLine;
		}
				
		private function AddHighlights(alertsLine, alertsType) {
			var intervalAlerts = me.mSession.intervalAlerts;
			
			for (var i = 0; i < intervalAlerts.count(); i++) {
	        	var alert = intervalAlerts.get(i);
	        	if (alert.type == alertsType) {
		        	var percentageTimes = alert.getAlertProgressBarPercentageTimes(me.mSession.time);
		        	for (var percentageIndex = 0; percentageIndex < percentageTimes.size(); percentageIndex++) {   		        			
	        			alertsLine.addHighlight(alert.color, percentageTimes[percentageIndex]);	
		        	}
	        	}
	        }
		}
	}
}