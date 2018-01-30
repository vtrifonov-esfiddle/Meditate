using Toybox.WatchUi as Ui;

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
        details.color = alert.color;
        details.title = "Alert " + (me.mSelectedPageIndex + 1);
        
        details.detailLines[1].icon = Rez.Drawables.durationIcon;
        details.detailLines[1].text = TimeFormatter.format(alert.time);
        
        details.detailLines[2].icon = Rez.Drawables.vibrateIcon;
        details.detailLines[2].text = getVibrationPatternText(alert.vibrationPattern);
        
        details.detailLines[3].icon = Rez.Drawables.intermediateAlertsIcon;
        details.detailLines[3].text = "Inter bar chart";
        
        details.detailLines[4].icon = Rez.Drawables.heartRateIcon;
        details.detailLines[4].text = "ready to start";
	}
	
	function createScreenPickerView() {
		me.setSelectedAlertDetails();
		return new AlertPickerView(me.mSelectedAlertDetails);
	}
}