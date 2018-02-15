using Toybox.WatchUi as Ui;

class IntervalAlertsMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnIntervalAlertsChanged;

	function initialize(onIntervalAlertsChanged) {
		MenuInputDelegate.initialize();
		me.mOnIntervalAlertsChanged = onIntervalAlertsChanged;
	}
	
 	function onMenuItem(item) {
        if (item == :addNew) {
        
        }
        else if (item == :edit) {
        
        }
        else if (item == :deleteAll) {
        
        }
    }
}