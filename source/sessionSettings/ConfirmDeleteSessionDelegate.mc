using Toybox.WatchUi as Ui;

class ConfirmDeleteSessionDelegate extends Ui.ConfirmationDelegate {
	private var mSessionStorage;
    private var mSessionPickerDelegate;
	
    function initialize(sessionStorage, sessionPickerDelegate) {
        ConfirmationDelegate.initialize();
        me.mSessionStorage = sessionStorage;
        me.mSessionPickerDelegate = sessionPickerDelegate;
    }

    function onResponse(value) {
        if (value == Ui.CONFIRM_YES) {        	
        	me.mSessionStorage.deleteSelectedSession();        	 	
        	me.mSessionPickerDelegate.setPagesCount(me.mSessionStorage.getSessionsCount());
        	me.mSessionPickerDelegate.select(me.mSessionStorage.getSelectedSessionIndex());       
        }        
    }
}