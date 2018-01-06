using Toybox.WatchUi as Ui;

class AlertViewDelegate extends ScreenPickerDelegate {

	function initialize(colors, onColorSelected) {
		ScreenPickerDelegate.initialize(colors, onColorSelected);		
	}
	
	function createScreenPickerView() {
		return new AlertView(me.mColors[me.mSelectedColorIndex]);
	}
}