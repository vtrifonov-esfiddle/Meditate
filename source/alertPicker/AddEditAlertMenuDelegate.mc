using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AddEditAlertMenuDelegate extends Ui.MenuInputDelegate {
    private var mOnChangeAlert;
    
    function initialize(onChangeAlert) {
        MenuInputDelegate.initialize();
        me.mOnChangeAlert = onChangeAlert;
    }
		
    function onMenuItem(item) {
        if (item == :time) {
        	var durationPickerModel = new DurationPickerModel();
    		Ui.pushView(new DurationPickerView(durationPickerModel), new DurationPickerDelegate(durationPickerModel, method(:onDurationPicked)), Ui.SWIPE_LEFT);   	
        }
        else if (item == :color) {
	        var colors = [Gfx.COLOR_BLUE, Gfx.COLOR_RED, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW, Gfx.COLOR_GREEN, Gfx.COLOR_LT_GRAY, Gfx.COLOR_PINK, Gfx.COLOR_PURPLE, Gfx.COLOR_WHITE];
	        
	        Ui.pushView(new ColorPickerView(Gfx.COLOR_BLUE), new ColorPickerDelegate(colors, method(:onColorSelected)), Ui.SLIDE_LEFT);  
        }
        else if (item == :vibrationPattern) {
	    	var vibrationPatternMenuDelegate = new VibrationPatternMenuDelegate(method(:onVibrationPatternPicked));
        	Ui.pushView(new Rez.Menus.vibrationPatternMenu(), vibrationPatternMenuDelegate, Ui.SWIPE_LEFT);        	
        }
    }
    
    private function onVibrationPatternPicked(vibrationPattern) {
    	var alertModel = new AlertModel();
    	alertModel.vibrationPattern = vibrationPattern;
		me.mOnChangeAlert.invoke(alertModel);	
		Vibration.vibrate(vibrationPattern);
    }
	    
    function onDurationPicked(durationMins) {    
		var alertModel = new AlertModel();
    	alertModel.time = durationMins * 60;
    	me.mOnChangeAlert.invoke(alertModel);	
    }
    
    function onColorSelected(color) {
    	var alertModel = new AlertModel();
    	alertModel.color = color;
		me.mOnChangeAlert.invoke(alertModel);	
    }
}