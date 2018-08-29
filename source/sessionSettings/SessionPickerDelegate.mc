using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
class SessionPickerDelegate extends ScreenPickerDelegate {
	private var mSessionStorage;
	private var mSelectedSessionDetails;
	private var mSummaryRollupModel;
	private var mMeditateActivity;
	private var mIsHrvReady;
	
	function initialize(sessionStorage, summaryRollupModel) {
		ScreenPickerDelegate.initialize(sessionStorage.getSelectedSessionIndex(), sessionStorage.getSessionsCount());	
		me.mSessionStorage = sessionStorage;
		me.mSummaryRollupModel = summaryRollupModel;
		me.mSelectedSessionDetails = new DetailsModel();		
        me.mMeditateActivity = new MediateActivity(method(:onHrvReady));
        me.mIsHrvReady = false;
        
		me.globalSettingsIconsYOffset = App.getApp().getProperty("globalSettingsIconsYOffset");
		me.sessionDetailsIconsXPos = App.getApp().getProperty("sessionDetailsIconsXPos");
		me.sessionDetailsValueXPos = App.getApp().getProperty("sessionDetailsValueXPos");
		me.globalSettingsIconsXPos = App.getApp().getProperty("globalSettingsIconsXPos");
		me.sessionDetailsAlertsLineYOffset = App.getApp().getProperty("sessionDetailsAlertsLineYOffset");
		me.sessionHrvStatusLineYOffset = App.getApp().getProperty("sessionHrvStatusLineYOffset");
		me.sessionHrvStatusLineIconXPos = App.getApp().getProperty("sessionHrvStatusLineIconXPos");
		me.sessionHrvStatusLineTextXPos = App.getApp().getProperty("sessionHrvStatusLineTextXPos");
	}
	
	private var globalSettingsIconsYOffset;
	private var sessionDetailsIconsXPos;
	private var sessionDetailsValueXPos;
	private var globalSettingsIconsXPos;
	private var sessionDetailsAlertsLineYOffset;
	private var sessionHrvStatusLineYOffset;
	private var sessionHrvStatusLineIconXPos;
	private var sessionHrvStatusLineTextXPos;
	
	function onHrvReady(isHrvReady) {
		if (isHrvReady != me.mIsHrvReady) {
			var hrvStatusLine = me.mSelectedSessionDetails.detailLines[4];
			if (isHrvReady == true) {
				hrvStatusLine.icon.setColor(Icon.HeartBeatPurpleColor);
		        hrvStatusLine.value.text = "Ready";
		        Vibe.vibrate(VibePattern.MediumContinuous);
	        }
	        else {
	        	hrvStatusLine.icon.setColor(Gfx.COLOR_TRANSPARENT);
	        	hrvStatusLine.value.text = "";	        	
	        }
	        Ui.requestUpdate();
			me.mIsHrvReady = isHrvReady;
		}
	}
	
    function onMenu() {
		return me.showSessionSettingsMenu();
    }
    
    private const RollupExitOption = :exitApp;
    
    function onBack() {
    	if (me.mSummaryRollupModel.getSummaries().size() > 0) {
    		var summaries = me.mSummaryRollupModel.getSummaries();
    		
    		var summaryRollupMenu = new Ui.Menu();
			summaryRollupMenu.setTitle(Ui.loadResource(Rez.Strings.summaryRollupMenu_title));
			summaryRollupMenu.addItem(Ui.loadResource(Rez.Strings.summaryRollupMenuOption_exit), RollupExitOption);
			for (var i = 0; i < summaries.size(); i++) {
    			summaryRollupMenu.addItem(TimeFormatter.format(summaries[i].elapsedTime), i);
    		}			
			var summaryRollupMenuDelegate = new MenuOptionsDelegate(method(:onSummaryRollupMenuOption));
			Ui.pushView(summaryRollupMenu, summaryRollupMenuDelegate, Ui.SLIDE_LEFT);	
			return true;
    	}
    	return false;
    }
    
    function onSummaryRollupMenuOption(option) {
    	if (option == RollupExitOption) {
    		System.exit();
    	}
    	else {
	    	var summaryIndex = option;
	    	var summaryModel = me.mSummaryRollupModel.getSummary(summaryIndex);
	    	var summaryViewDelegate = new SummaryViewDelegate(summaryModel, null);
	    	Ui.pushView(summaryViewDelegate.createScreenPickerView(), summaryViewDelegate, Ui.SLIDE_LEFT); 
    	}
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
        var mediateDelegate = new MeditateDelegate(meditateModel, me.mMeditateActivity, me.mSummaryRollupModel);
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
		var hrvStatusLine = details.detailLines[4];			
        hrvStatusLine.yLineOffset = sessionHrvStatusLineYOffset;
        hrvStatusLine.icon = new Icon({        
		        	:font => IconFonts.fontAwesomeFreeSolid,
		        	:symbol => Rez.Strings.faHeartbeat,
		        	:color => Gfx.COLOR_TRANSPARENT,
		        	:xPos => me.sessionHrvStatusLineIconXPos
		        });
		if (me.mIsHrvReady == true) {
			hrvStatusLine.icon.setColor(Icon.HeartBeatPurpleColor);
		}
       	hrvStatusLine.value.xPos = me.sessionHrvStatusLineTextXPos;
	}	
	
	
	
	function createScreenPickerView() {
		me.setSelectedSessionDetails();
		return new ScreenPickerDetailsView(me.mSelectedSessionDetails);
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