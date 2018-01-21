using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AddEditAlertMenuDelegate extends Ui.MenuInputDelegate {
    private var mAlertStorage;
    private var mMeditateModel;
    
    function initialize(alertStorage, meditateModel) {
        MenuInputDelegate.initialize();
        me.mAlertStorage = alertStorage;
        me.mMeditateModel = meditateModel;
    }
		
    function onMenuItem(item) {
        if (item == :time) {
        	var durationPickerModel = new DurationPickerModel();
    		Ui.pushView(new DurationPickerView(durationPickerModel), new DurationPickerDelegate(durationPickerModel, method(:onDurationPicked)), Ui.SWIPE_LEFT);   	
        }
        else if (item == :color) {
	        var colors = [Gfx.COLOR_BLUE, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW, Gfx.COLOR_GREEN, Gfx.COLOR_LT_GRAY, Gfx.COLOR_PINK, Gfx.COLOR_PURPLE, Gfx.COLOR_WHITE];
	        
	        Ui.pushView(new ColorPickerView(Gfx.COLOR_BLUE), new ColorPickerDelegate(colors, method(:onColorSelected)), Ui.SLIDE_LEFT);  
        }
        else if (item == :vibrationPattern) {
	    	var vibrationPatternMenuDelegate = new VibrationPatternMenuDelegate(method(:onVibrationPatternPicked));
        	Ui.pushView(new Rez.Menus.vibrationPatternMenu(), vibrationPatternMenuDelegate, Ui.SWIPE_LEFT);        	
        }
    }
    
    private function onVibrationPatternPicked(vibrationPattern) {
    	var alertModel = me.mAlertStorage.loadSelectedAlert();
    	alertModel.vibrationPattern = vibrationPattern;
		me.updateAlert(alertModel);
		Vibration.vibrate(vibrationPattern);
    }
    
    private function updateAlert(alertModel) {
    	me.mAlertStorage.saveSelectedAlert(alertModel); 
    	me.mMeditateModel.setAlert(alertModel);
    }
    
    function onDurationPicked(durationMins) {    
    	var alertModel = me.mAlertStorage.loadSelectedAlert();
    	alertModel.time = durationMins * 60;
		me.updateAlert(alertModel);
    }
    
    
    
    function onColorSelected(color) {
    	var alertModel = me.mAlertStorage.loadSelectedAlert();
    	alertModel.color = color;
		me.updateAlert(alertModel);
    }
}