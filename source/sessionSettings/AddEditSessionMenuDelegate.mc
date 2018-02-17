using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AddEditSessionMenuDelegate extends Ui.MenuInputDelegate {
    private var mOnChangeSession;
    private var mIntervalAlerts;
    
    function initialize(intervalAlerts, onChangeSession) {
        MenuInputDelegate.initialize();
        me.mIntervalAlerts = intervalAlerts;
        me.mOnChangeSession = onChangeSession;
    }
		
    function onMenuItem(item) {
        if (item == :time) {
        	var durationPickerModel = new DurationPickerModel();
    		Ui.pushView(new DurationPickerView(durationPickerModel), new DurationPickerDelegate(durationPickerModel, method(:onDurationPicked)), Ui.SLIDE_LEFT);   	
        }
        else if (item == :color) {
	        var colors = [Gfx.COLOR_BLUE, Gfx.COLOR_RED, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW, Gfx.COLOR_GREEN, Gfx.COLOR_LT_GRAY, Gfx.COLOR_PINK, Gfx.COLOR_PURPLE, Gfx.COLOR_WHITE];
	        
	        Ui.pushView(new ColorPickerView(Gfx.COLOR_BLUE), new ColorPickerDelegate(colors, method(:onColorSelected)), Ui.SLIDE_LEFT);  
        }
        else if (item == :vibePattern) {
	    	var vibePatternMenuDelegate = new VibePatternMenuDelegate(method(:onVibePatternPicked));
        	Ui.pushView(new Rez.Menus.vibePatternMenu(), vibePatternMenuDelegate, Ui.SLIDE_LEFT);        	
        }
        else if (item == :intervalAlerts) {
        	var intervalAlertsMenuDelegate = new IntervalAlertsMenuDelegate(me.mIntervalAlerts, method(:onIntervalAlertsChanged));
        	var intervalAlertSettingsMenu = new Rez.Menus.intervalAlertSettingsMenu();
        	if (me.mIntervalAlerts.count() > 0) {
	        	var editName = Ui.loadResource(Rez.Strings.menuIntervalAlertSettings_edit);
	        	intervalAlertSettingsMenu.addItem(editName, :edit);
	        	var deleteAllName = Ui.loadResource(Rez.Strings.menuIntervalAlertSettings_deleteAll);
	        	intervalAlertSettingsMenu.addItem(deleteAllName, :deleteAll);
        	}
        	Ui.pushView(intervalAlertSettingsMenu, intervalAlertsMenuDelegate, Ui.SLIDE_LEFT);
        }
    }
    
    private function onIntervalAlertsChanged(intervalAlerts) {
    	var sessionModel = new SessionModel();
    	sessionModel.intervalAlerts = intervalAlerts;
		me.mOnChangeSession.invoke(sessionModel);	
    }
    
    private function onVibePatternPicked(vibePattern) {
    	var sessionModel = new SessionModel();
    	sessionModel.vibePattern = vibePattern;
		me.mOnChangeSession.invoke(sessionModel);	
		Vibe.vibrate(vibePattern);
    }
	    
    function onDurationPicked(durationMins) {    
		var sessionModel = new SessionModel();
    	sessionModel.time = durationMins * 60;
    	me.mOnChangeSession.invoke(sessionModel);	
    }
    
    function onColorSelected(color) {
    	var sessionModel = new SessionModel();
    	sessionModel.color = color;
		me.mOnChangeSession.invoke(sessionModel);	
    }
}