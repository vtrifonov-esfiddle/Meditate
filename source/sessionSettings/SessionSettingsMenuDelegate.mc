using Toybox.WatchUi as Ui;

class SessionSettingsMenuDelegate extends Ui.MenuInputDelegate {
    private var mSessionStorage;
    private var mSessionPickerDelegate;
    
    function initialize(sessionStorage, sessionPickerDelegate) {
        MenuInputDelegate.initialize();
        me.mSessionStorage = sessionStorage;
        me.mSessionPickerDelegate = sessionPickerDelegate;
    }
		
    function onMenuItem(item) {
        if (item == :addNew) {
        	var newSession = me.mSessionStorage.addSession();	
        	var addEditSessionMenuMenuDelegate = new AddEditSessionMenuDelegate(newSession.intervalAlerts ,method(:onChangeSession));        	
        	me.mSessionPickerDelegate.setPagesCount(me.mSessionStorage.getSessionsCount());
        	me.mSessionPickerDelegate.select(me.mSessionStorage.getSelectedSessionIndex());
   	        Ui.popView(Ui.SLIDE_IMMEDIATE);
        	Ui.pushView(new Rez.Menus.addEditSessionMenu(), addEditSessionMenuMenuDelegate, Ui.SLIDE_LEFT);        	
        }
        else if (item == :edit) {
        	var existingSession = me.mSessionStorage.loadSelectedSession();
   	        var addEditSessionMenuMenuDelegate = new AddEditSessionMenuDelegate(existingSession.intervalAlerts, method(:onChangeSession));
   	        Ui.popView(Ui.SLIDE_IMMEDIATE);
        	Ui.pushView(new Rez.Menus.addEditSessionMenu(), addEditSessionMenuMenuDelegate, Ui.SLIDE_LEFT);    
        }
        else if (item == :delete) {
	    	var confirmHeader = Ui.loadResource(Rez.Strings.confirmDeleteSessionHeader);
    		var confirmDeleteSessionDialog = new Ui.Confirmation(confirmHeader);    		
   	        Ui.popView(Ui.SLIDE_IMMEDIATE);
        	Ui.pushView(confirmDeleteSessionDialog, new ConfirmDeleteSessionDelegate(me.mSessionStorage, me.mSessionPickerDelegate), Ui.SLIDE_LEFT);
        }
    }
    
    private function onChangeSession(changedSessionModel) {
    	var existingSession = me.mSessionStorage.loadSelectedSession();
		existingSession.copyNonNullFieldsFromSession(changedSessionModel);
		me.mSessionStorage.saveSelectedSession(existingSession);
		me.mSessionPickerDelegate.updateSelectedSessionDetails(existingSession);
		Ui.requestUpdate();
    }
}