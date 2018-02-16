using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AddEditIntervalAlertMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnIntervalAlertChanged;
	private var mIntervalAlert;

	function initialize(intervalAlert, onIntervalAlertChanged) {
		MenuInputDelegate.initialize();
		me.mOnIntervalAlertChanged = onIntervalAlertChanged;
		me.mIntervalAlert = intervalAlert;
	}
	
	function onMenuItem(item) {
        if (item == :type) {
			var intervalTypeMenuDelegate = new IntervalTypeMenuDelegate(method(:onTypeChanged));
			Ui.pushView(new Rez.Menus.intervalTypeMenu(),  intervalTypeMenuDelegate, Ui.SLIDE_LEFT);			
        }
        else if (item == :vibePattern) {
			var intervalVibePatternMenuDelegate = new IntervalVibePatternMenuDelegate(method(:onVibePatternChanged));
			Ui.pushView(new Rez.Menus.intervalVibePatternMenu(),  intervalVibePatternMenuDelegate, Ui.SLIDE_LEFT);			
        }
        else if (item == :time) {
        	var durationPickerModel = new DurationPickerModel();
    		Ui.pushView(new DurationPickerView(durationPickerModel), new DurationPickerDelegate(durationPickerModel, method(:onDurationPicked)), Ui.SLIDE_LEFT);   	
        }
        else if (item == :color) {
	        var colors = [Gfx.COLOR_BLUE, Gfx.COLOR_RED, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW, Gfx.COLOR_GREEN, Gfx.COLOR_LT_GRAY, Gfx.COLOR_PINK, Gfx.COLOR_PURPLE, Gfx.COLOR_WHITE];
	        
	        Ui.pushView(new ColorPickerView(Gfx.COLOR_BLUE), new ColorPickerDelegate(colors, method(:onColorPicked)), Ui.SLIDE_LEFT);  
        }
    }
    
    function onDurationPicked(durationInSeconds) {
    	me.mIntervalAlert.time = durationInSeconds;
    	me.mOnIntervalAlertChanged.invoke(me.mIntervalAlert);
    }
    
    function onColorPicked(color) {
    	me.mIntervalAlert.color = color;
    	me.mOnIntervalAlertChanged.invoke(me.mIntervalAlert);
    }
    
    function onVibePatternChanged(vibePattern) {
    	me.mIntervalAlert.vibePattern = vibePattern;
    	me.mOnIntervalAlertChanged.invoke(me.mIntervalAlert);
    }
    
    function onTypeChanged(type) {
    	me.mIntervalAlert.type = type;
    	me.mOnIntervalAlertChanged.invoke(me.mIntervalAlert);
    }
	
}