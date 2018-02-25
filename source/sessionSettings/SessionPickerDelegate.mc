using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class SessionPickerDelegate extends ScreenPickerDelegate {
	private var mSessionStorage;
	private var mSelectedSessionDetails;
	
	function initialize(sessionStorage) {
		ScreenPickerDelegate.initialize(sessionStorage.getSelectedSessionIndex(), sessionStorage.getSessionsCount());	
		me.mSessionStorage = sessionStorage;
		me.mSelectedSessionDetails = new DetailsModel();
	}
	
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
        details.title = "Session " + (me.mSelectedPageIndex + 1);
        details.titleColor = session.color;
        details.setAllIconsOffset(-4);
        
        details.detailLines[1].icon = Rez.Drawables.durationIcon;
        details.detailLines[1].value.text = TimeFormatter.format(session.time);
        
        details.detailLines[2].icon = Rez.Drawables.vibrateIcon;
        details.detailLines[2].value.text = getVibePatternText(session.vibePattern);
        
        details.detailLines[3].icon = Rez.Drawables.sessionDurationIcon;
        var alertsToHighlightsLine = new AlertsToHighlightsLine(session);
        details.detailLines[3].value = alertsToHighlightsLine.getAlertsLine();
        
        details.detailLines[4].valueOffset = -10;        
        details.detailLines[4].value.text = "ready to start";
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
		
		function getAlertsLine() {
	        var alertsLine = new PercentageHighlightLine();
	        alertsLine.backgroundColor = me.mSession.color;
	        me.AddHighlights(alertsLine, IntervalAlertType.Repeat);
	        me.AddHighlights(alertsLine, IntervalAlertType.OneOff);
	        
	        return alertsLine;
		}
		
		private const MinPercentageOffset = 0.05;
		
		private function AddHighlights(alertsLine, alertsType) {
			var intervalAlerts = me.mSession.intervalAlerts;
			
			for (var i = 0; i < intervalAlerts.count(); i++) {
	        	var alert = intervalAlerts.get(i);
	        	if (alert.type == alertsType) {
		        	var percentageTimes = alert.getAlertPercentageTimes(me.mSession.time);
		        	var lastPercentageTime = -1;
		        	for (var percentageIndex = 0; percentageIndex < percentageTimes.size(); percentageIndex++) {     	
		        		if (isHighglightFiltered(percentageTimes[percentageIndex], lastPercentageTime) == false) {	
		        			alertsLine.addHighlight(alert.color, percentageTimes[percentageIndex]);	        			
		        			lastPercentageTime = percentageTimes[percentageIndex];
		        		}
		        	}
	        	}
	        }
		}
		
		private function isHighglightFiltered(currentPercentageTime, lastPercentageTime) {
			return (currentPercentageTime - lastPercentageTime) < MinPercentageOffset;
		}
	}
}