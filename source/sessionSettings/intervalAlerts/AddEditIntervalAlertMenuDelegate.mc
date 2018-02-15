using Toybox.WatchUi as Ui;

class AddEditIntervalAlertMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnIntervalAlertChanged;

	function initialize(onIntervalAlertChanged) {
		MenuInputDelegate.initialize();
		me.mOnIntervalAlertChanged = onIntervalAlertChanged;
	}
	
}