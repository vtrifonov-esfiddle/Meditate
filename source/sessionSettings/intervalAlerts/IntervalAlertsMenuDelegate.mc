using Toybox.WatchUi as Ui;

class IntervalAlertsMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnIntervalAlertsChanged;
	private var mIntervalAlerts;
	private var mSelectedIntervalAlertIndex;
	
	function initialize(intervalAlerts, onIntervalAlertsChanged) {
		MenuInputDelegate.initialize();
		me.mIntervalAlerts = intervalAlerts;
		me.mOnIntervalAlertsChanged = onIntervalAlertsChanged;
	}
	
 	function onMenuItem(item) {
        if (item == :addNew) {
			me.mSelectedIntervalAlertIndex = me.mIntervalAlerts.addNew();
			me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
			var selectedIntervalAlert = me.mIntervalAlerts.get(mSelectedIntervalAlertIndex);
			var intervalAlertMenu = new Rez.Menus.addEditIntervalAlertMenu();
			intervalAlertMenu.setTitle(Ui.loadResource(Rez.Strings.addEditIntervalAlertMenu_title) + " " + me.mIntervalAlerts.count());
			var intevalAlertMenuDelegate = new AddEditIntervalAlertMenuDelegate(selectedIntervalAlert, method(:onIntervalAlertChanged));
			Ui.pushView(intervalAlertMenu, intevalAlertMenuDelegate, Ui.SLIDE_LEFT);			
        }
        else if (item == :edit) {
        
        }
        else if (item == :deleteAll) {
        	me.mIntervalAlerts.reset();
        	me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
        }
    }
    
    function onIntervalAlertChanged(intervalAlert) {
    	me.mIntervalAlerts.set(me.mSelectedIntervalAlertIndex, intervalAlert);
    	me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
    }
}