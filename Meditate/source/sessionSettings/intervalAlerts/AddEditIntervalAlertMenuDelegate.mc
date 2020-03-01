using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer;
using Toybox.Application as App;

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
        if (item == :vibePattern) {
			var intervalVibePatternMenuDelegate = new IntervalVibePatternMenuDelegate(method(:onVibePatternChanged));
			Ui.pushView(new Rez.Menus.intervalVibePatternMenu(),  intervalVibePatternMenuDelegate, Ui.SLIDE_LEFT);			
        }
        else if (item == :time) {
        	var intervalTypeMenuDelegate = new IntervalTypeMenuDelegate(method(:onTypeChanged));
			Ui.pushView(new Rez.Menus.intervalTypeMenu(),  intervalTypeMenuDelegate, Ui.SLIDE_LEFT);        	
        }
        else if (item == :color) {
	        var colors = [Gfx.COLOR_RED, Gfx.COLOR_YELLOW, Gfx.COLOR_GREEN, Gfx.COLOR_ORANGE, Gfx.COLOR_BLUE, Gfx.COLOR_LT_GRAY,  Gfx.COLOR_PINK, Gfx.COLOR_PURPLE, Gfx.COLOR_WHITE, Gfx.COLOR_DK_BLUE, Gfx.COLOR_DK_RED, Gfx.COLOR_DK_GREEN, Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT];
	        
	        Ui.pushView(new ColorPickerView(colors[0]), new ColorPickerDelegate(colors, method(:onColorPicked)), Ui.SLIDE_LEFT);  
        }
        else if (item == :delete) {
        	var confirmDeleteIntervalAlertHeader = Ui.loadResource(Rez.Strings.confirmDeleteIntervalAlertHeader);
        	var confirmDeleteDialog = new Ui.Confirmation(confirmDeleteIntervalAlertHeader);
        	Ui.pushView(confirmDeleteDialog, new YesDelegate(method(:onConfirmedDelete)), Ui.SLIDE_IMMEDIATE);
        }
    }
    
    function onConfirmedDelete() {
    	Ui.popView(Ui.SLIDE_IMMEDIATE);
    	me.mOnIntervalAlertDeleted.invoke(me.mIntervalAlertIndex);
    }
    
    private function notifyIntervalAlertChanged() {   
    	var notifyChangeTimer = new Timer.Timer();
		notifyChangeTimer.start(method(:onNotifyIntervalAlertChanged), 500, false); 
    }
    
    function onNotifyIntervalAlertChanged() {    	
    	me.mOnIntervalAlertChanged.invoke(me.mIntervalAlertIndex, me.mIntervalAlert);
    }    
    
    function onOneOffDurationPicked(digits) {
    	var durationInMins = digits[0] * 60 + digits[1] * 10 + digits[2];
    	var durationInSeconds = durationInMins * 60;
    	me.mIntervalAlert.time = durationInSeconds;
    	me.notifyIntervalAlertChanged();
    }
    
    function onRepeatDurationPicked(digits) {
    	var durationInSeconds = digits[0] * 600 + digits[1] * 60 + digits[2] * 10 + digits[3];
    	me.mIntervalAlert.time = durationInSeconds;
    	me.notifyIntervalAlertChanged();
    }
    
    function onColorPicked(color) {
    	me.mIntervalAlert.color = color;
    	me.notifyIntervalAlertChanged();
    }
    
    function onVibePatternChanged(vibePattern) {
    	me.mIntervalAlert.vibePattern = vibePattern;
    	me.notifyIntervalAlertChanged();
    	Vibe.vibrate(vibePattern);
    }
    
    function onTypeChanged(type) {
    	me.mIntervalAlert.type = type;
    	me.notifyIntervalAlertChanged();
    	
    	var durationPickerModel;
    	var durationPickerDelgate;
    	var timeLayoutBuilder;
    	if (type == IntervalAlertType.OneOff) {
	    	durationPickerModel = new DurationPickerModel(3);
    		timeLayoutBuilder = me.createTimeLayoutHmmBuilder();    	
    		durationPickerDelgate = new DurationPickerDelegate(durationPickerModel, method(:onOneOffDurationPicked));
    	}
    	else {
	    	durationPickerModel = new DurationPickerModel(4);
    		timeLayoutBuilder = me.createTimeLayoutMmSsBuilder();    	
    		durationPickerDelgate = new DurationPickerDelegate(durationPickerModel, method(:onRepeatDurationPicked));
    	}
    	var view = new DurationPickerView(durationPickerModel, timeLayoutBuilder);
    	Ui.popView(Ui.SLIDE_IMMEDIATE);
		Ui.pushView(view, durationPickerDelgate, Ui.SLIDE_IMMEDIATE);   	
    }
        
    private function createTimeLayoutMmSsBuilder() {
		var digitsLayout = new DigitsLayoutBuilder(Gfx.FONT_SYSTEM_TINY);
		var outputXOffset = App.getApp().getProperty("mmssTimePickerOutputXOffset");
		digitsLayout.setOutputXOffset(outputXOffset);
		digitsLayout.addInitialHint("Pick MM:SS");
		digitsLayout.addDigit({:minValue=>0, :maxValue=>5});
		digitsLayout.addDigit({:minValue=>0, :maxValue=>9});
		digitsLayout.addSeparator("m");
		digitsLayout.addDigit({:minValue=>0, :maxValue=>5});
		digitsLayout.addDigit({:minValue=>0, :maxValue=>9});
		digitsLayout.addSeparator("s");
		return digitsLayout;
    }
    
    private function createTimeLayoutHmmBuilder() {
		var digitsLayout = new DigitsLayoutBuilder(Gfx.FONT_SYSTEM_TINY);
		var outputXOffset = App.getApp().getProperty("hmmTimePickerOutputXOffset");
		digitsLayout.setOutputXOffset(outputXOffset);
		digitsLayout.addInitialHint("Pick H:MM");
		digitsLayout.addDigit({:minValue=>0, :maxValue=>9});
		digitsLayout.addSeparator("h");
		digitsLayout.addDigit({:minValue=>0, :maxValue=>5});
		digitsLayout.addDigit({:minValue=>0, :maxValue=>9});
		digitsLayout.addSeparator("m");
		return digitsLayout;
    }
	
}