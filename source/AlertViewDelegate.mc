using Toybox.WatchUi as Ui;

class AlertViewDelegate extends ScreenPickerDelegate {
	private var mOnAlertSelected;
	private var mAlertModels;
	
	function initialize(onAlertSelected, alertModels) {
		ScreenPickerDelegate.initialize(alertModels.size());	
		me.mAlertModels = alertModels;
		me.mOnAlertSelected = onAlertSelected;
	}
	
	function onSelect() {
		me.mOnAlertSelected.invoke(me.getSelectedAlert());
		Ui.popView(Ui.SLIDE_RIGHT);
		return true;
	}	
	
	private function getSelectedAlert() {
		return me.mAlertModels[me.mSelectedPageIndex];
	}
	
	function createScreenPickerView() {
		return new AlertView(me.getSelectedAlert());
	}
}