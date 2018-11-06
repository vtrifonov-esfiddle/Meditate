using Toybox.WatchUi as Ui;

class MenuOptionsDelegate extends Ui.MenuInputDelegate {
	function initialize(onMenuItem) {
		MenuInputDelegate.initialize();
		mOnMenuItem = onMenuItem;
	}
	
	private var mOnMenuItem;
	
	function onMenuItem(item) {
		mOnMenuItem.invoke(item);
	}
}