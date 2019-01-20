using Toybox.WatchUi as Ui;

class IntervalTypeMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnIntervalAlertChanged;
	private var mOnTypeChanged;

	function initialize(onTypeChanged) {
		MenuInputDelegate.initialize();
		me.mOnTypeChanged = onTypeChanged;
	}
	
	function onMenuItem(item) {
        if (item == :oneOff) {
			me.mOnTypeChanged.invoke(IntervalAlertType.OneOff);		
        }
        else if (item == :repeat) {
        	me.mOnTypeChanged.invoke(IntervalAlertType.Repeat);
        }
    }	
}