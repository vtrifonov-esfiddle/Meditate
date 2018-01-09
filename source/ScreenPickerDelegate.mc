using Toybox.WatchUi as Ui;

class ScreenPickerDelegate extends Ui.BehaviorDelegate {
	function initialize() {
		BehaviorDelegate.initialize();
	}
		
	function onNextPage() {				
		Ui.switchToView(me.createScreenPickerView(), me, Ui.SLIDE_DOWN);		
		return true;
	}
	
	function createScreenPickerView() {
	}
	
	function onPreviousPage() {				
		Ui.switchToView(me.createScreenPickerView(), me, Ui.SLIDE_UP);		
		return true;
	}
}