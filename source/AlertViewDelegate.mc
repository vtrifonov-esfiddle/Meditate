using Toybox.WatchUi as Ui;

class AlertViewDelegate extends ColorPickerDelegate {
	private var mAlertModel;
	
	function initialize(colors, onColorSelected, alertModel) {
		ColorPickerDelegate.initialize(colors, onColorSelected);	
		me.mAlertModel = alertModel;	
	}
	
	function createScreenPickerView() {
		me.mAlertModel.color = me.mColors[me.mSelectedColorIndex];
		return new AlertView(me.mAlertModel);
	}
}