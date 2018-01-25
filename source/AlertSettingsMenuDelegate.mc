using Toybox.WatchUi as Ui;

class AlertSettingsMenuDelegate extends Ui.MenuInputDelegate {
    private var mAlertStorage;
    private var mAlertPickerDelegate;
    
    function initialize(alertStorage, alertPickerDelegate) {
        MenuInputDelegate.initialize();
        me.mAlertStorage = alertStorage;
        me.mAlertPickerDelegate = alertPickerDelegate;
    }
		
    function onMenuItem(item) {
        if (item == :addNew) {
        	var newAlert = me.mAlertStorage.addAlert();	
        	var addEditAlertMenuMenuDelegate = new AddEditAlertMenuDelegate(me.mAlertStorage);        	
        	me.mAlertPickerDelegate.setPagesCount(me.mAlertStorage.getAlertsCount());
        	me.mAlertPickerDelegate.select(me.mAlertStorage.getSelectedAlertIndex());
   	        Ui.popView(Ui.SLIDE_IMMEDIATE);
        	Ui.pushView(new Rez.Menus.addEditAlertMenu(), addEditAlertMenuMenuDelegate, Ui.SLIDE_LEFT);        	
        }
        else if (item == :edit) {
   	        var addEditAlertMenuMenuDelegate = new AddEditAlertMenuDelegate(me.mAlertStorage);
   	        Ui.popView(Ui.SLIDE_IMMEDIATE);
        	Ui.pushView(new Rez.Menus.addEditAlertMenu(), addEditAlertMenuMenuDelegate, Ui.SLIDE_LEFT);    
        }
        else if (item == :delete) {
	    	var confirmHeader = Ui.loadResource(Rez.Strings.confirmDeleteAlertHeader);
    		var confirmDeleteAlertDialog = new Ui.Confirmation(confirmHeader);    		
   	        Ui.popView(Ui.SLIDE_IMMEDIATE);
        	Ui.pushView(confirmDeleteAlertDialog, new ConfirmDeleteAlertDelegate(me.mAlertStorage, me.mAlertPickerDelegate), Ui.SLIDE_LEFT);
        }
    }
}