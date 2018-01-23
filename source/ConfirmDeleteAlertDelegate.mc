using Toybox.WatchUi as Ui;

class ConfirmDeleteAlertDelegate extends Ui.ConfirmationDelegate {
	private var mAlertStorage;
    private var mAlertPickerDelegate;
	
    function initialize(alertStorage, alertPickerDelegate) {
        ConfirmationDelegate.initialize();
        me.mAlertStorage = alertStorage;
        me.mAlertPickerDelegate = alertPickerDelegate;
    }

    function onResponse(value) {
        if (value == Ui.CONFIRM_YES) {        	
        	me.mAlertStorage.deleteSelectedAlert();
        	me.mAlertPickerDelegate.setPagesCount(me.mAlertStorage.getAlertsCount());
        	me.mAlertPickerDelegate.select(me.mAlertStorage.getSelectedAlertIndex());
        }        
    }
}