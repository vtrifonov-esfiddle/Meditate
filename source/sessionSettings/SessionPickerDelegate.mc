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
		Ui.pushView(meditateView, mediateDelegate, Ui.SLIDE_LEFT);
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
        var mainDuration = new ProgressBarLine();
        mainDuration.addSection(session.color, 100);
        details.detailLines[3].value = mainDuration;
        
        details.detailLines[5].valueOffset = -20;        
        details.detailLines[5].value.text = "ready to start";
	}
	
	function createScreenPickerView() {
		me.setSelectedSessionDetails();
		return new SessionPickerView(me.mSelectedSessionDetails);
	}
}