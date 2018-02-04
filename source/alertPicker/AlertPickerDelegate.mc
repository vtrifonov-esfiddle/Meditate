using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AlertPickerDelegate extends ScreenPickerDelegate {
	private var mAlertStorage;
	private var mSelectedAlertDetails;
	
	function initialize(alertStorage) {
		ScreenPickerDelegate.initialize(alertStorage.getSelectedAlertIndex(), alertStorage.getAlertsCount());	
		me.mAlertStorage = alertStorage;
		me.mSelectedAlertDetails = new DetailsModel();
	}
	
    function onMenu() {
		return me.showAlertSettingsMenu();
    }
    
    private function showAlertSettingsMenu() {
    	var alertSettingsMenuDelegate = new AlertSettingsMenuDelegate(me.mAlertStorage, me);
        Ui.pushView(new Rez.Menus.alertSettingsMenu(), alertSettingsMenuDelegate, Ui.SLIDE_UP);
        return true;
    }
		
	private function startActivity() {
    	var selectedAlert = me.mAlertStorage.loadSelectedAlert();
    	var meditateModel = new MeditateModel(selectedAlert);  
    	  
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
	
	private function setSelectedAlertDetails() {
		me.mAlertStorage.selectAlert(me.mSelectedPageIndex);
		var alert = me.mAlertStorage.loadSelectedAlert();
		me.updateSelectedAlertDetails(alert);
	}
		
	private static function getVibrationPatternText(vibrationPattern) {
		switch (vibrationPattern) {
			case VibrationPattern.LongPulsating:
				return "Long Pulsating";
			case VibrationPattern.LongAscending:
				return "Long Ascending";
			case VibrationPattern.LongContinuous:
				return "Long Continuous";
			case VibrationPattern.MediumAscending:
				return "Medium Ascending";
			case VibrationPattern.MediumContinuous:
				return "Medium Continuous";
			case VibrationPattern.MediumPulsating:
				return "Medium Pulsating";
			case VibrationPattern.ShortAscending:
				return "Short Ascending";
			case VibrationPattern.ShortContinuous:
				return "Short Continuous";
			case VibrationPattern.ShortPulsating:
				return "Short Pulsating";
		}
	}
	
	function updateSelectedAlertDetails(alert) {
		var details = me.mSelectedAlertDetails;
        details.color = Gfx.COLOR_WHITE;
        details.backgroundColor = Gfx.COLOR_BLACK;
        details.title = "Alert " + (me.mSelectedPageIndex + 1);
        details.titleColor = alert.color;
        details.setAllIconsOffset(-4);
        
        details.detailLines[1].icon = Rez.Drawables.durationIcon;
        details.detailLines[1].value.text = TimeFormatter.format(alert.time);
        
        details.detailLines[2].icon = Rez.Drawables.vibrateIcon;
        details.detailLines[2].value.text = getVibrationPatternText(alert.vibrationPattern);
        
        details.detailLines[3].icon = Rez.Drawables.alertDurationIcon;
        var mainDuration = new ProgressBarLine();
        mainDuration.addSection(alert.color, 100);
        details.detailLines[3].value = mainDuration;
        
        details.detailLines[4].icon = Rez.Drawables.alertDurationIcon;
        var repeatDuration1 = new ProgressBarLine();
        repeatDuration1.addSection(Gfx.COLOR_BLUE, 20);
        for (var i = 1; i <= 7; i++) {
	        repeatDuration1.addSection(Gfx.COLOR_RED, 2);
	        repeatDuration1.addSection(Gfx.COLOR_BLUE, 8);
        }
        repeatDuration1.addSection(Gfx.COLOR_GREEN, 10);
        details.detailLines[4].value = repeatDuration1;
        
        details.detailLines[5].icon = Rez.Drawables.heartRateIcon;
        details.detailLines[5].value.text = "ready";
	}
	
	function createScreenPickerView() {
		me.setSelectedAlertDetails();
		return new AlertPickerView(me.mSelectedAlertDetails);
	}
}