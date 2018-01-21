using Toybox.WatchUi as Ui;

class ConfirmDeleteAlertDelegate extends Ui.ConfirmationDelegate {
	private var mAlertStorage;
	private var mMeditateModel;
	
    function initialize(alertStorage, meditateModel) {
        ConfirmationDelegate.initialize();
        me.mAlertStorage = alertStorage;
        me.mMeditateModel = meditateModel;
    }

    function onResponse(value) {
        if (value == Ui.CONFIRM_YES) {        	
        	me.mAlertStorage.deleteSelectedAlert();
        	me.mMeditateModel.setAlert(me.mAlertStorage.loadSelectedAlert());
        }        
    }
}