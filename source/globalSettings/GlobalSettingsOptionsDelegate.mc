using Toybox.WatchUi as Ui;

class GlobalSettingsOptionsDelegate extends Ui.MenuInputDelegate {
	function initialize(onMenuItem) {
		MenuInputDelegate.initialize();
		mOnMenuItem = onMenuItem;
	}
	
	private var mOnMenuItem;
	
	function onMenuItem(item) {
		mOnMenuItem.invoke(item);
	}
}