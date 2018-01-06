using Toybox.WatchUi as Ui;

class AlertViewDelegate extends ScreenPickerDelegate {

	function initialize(colors, onColorSelected) {
		ScreenPickerDelegate.initialize(colors, onColorSelected);		
	}
	
	function createScreenPickerView() {
		return new AlertView(me.mColors[me.mSelectedColorIndex]);
	}
	
	function onMenu() {
		System.println("Alert View onMenu");
		return true;
	}
	
	function onSwipe(swipeEvent) {
		if (swipeEvent.getDirection() == Ui.SWIPE_LEFT) {
			System.println("Alert SWIPE_LEFT");
			onMenu();
			return true;
		}
	}
}