using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AddEditIntervalAlertMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnIntervalAlertChanged;
	private var mIntervalAlert;
	private var mIntervalAlertIndex;
	private var mOnIntervalAlertDeleted;

	function initialize(intervalAlert, intervalAlertIndex, onIntervalAlertChanged, onIntervalAlertDeleted) {
		MenuInputDelegate.initialize();
		me.mOnIntervalAlertChanged = onIntervalAlertChanged;
		me.mIntervalAlert = intervalAlert;
		me.mIntervalAlertIndex = intervalAlertIndex;
		me.mOnIntervalAlertDeleted = onIntervalAlertDeleted;
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
        else if (item == :delete) {
        	var confirmDeleteIntervalAlertHeader = Ui.loadResource(Rez.Strings.confirmDeleteIntervalAlertHeader);
        	var confirmDeleteDialog = new Ui.Confirmation(confirmDeleteIntervalAlertHeader);
        	Ui.pushView(confirmDeleteDialog, new YesDelegate(method(:onConfirmedDelete)), Ui.SLIDE_IMMEDIATE);
        }
    }
    
    private function onConfirmedDelete() {
    	Ui.popView(Ui.SLIDE_IMMEDIATE);
    	me.mOnIntervalAlertDeleted.invoke(me.mIntervalAlertIndex);
    }
    
    private function notifyIntervalAlertChanged() {    
    	me.mOnIntervalAlertChanged.invoke(me.mIntervalAlertIndex, me.mIntervalAlert);
    }
    
    private function onDurationPicked(durationInSeconds) {
    	me.mIntervalAlert.time = durationInSeconds;
    	me.notifyIntervalAlertChanged();
    }
    
    private function onColorPicked(color) {
    	me.mIntervalAlert.color = color;
    	me.notifyIntervalAlertChanged();
    }
    
    private function onVibePatternChanged(vibePattern) {
    	me.mIntervalAlert.vibePattern = vibePattern;
    	me.notifyIntervalAlertChanged();
    	Vibe.vibrate(vibePattern);
    }
    
    private function onTypeChanged(type) {
    	me.mIntervalAlert.type = type;
    	me.notifyIntervalAlertChanged();
    }
	
}