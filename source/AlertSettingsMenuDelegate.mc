using Toybox.WatchUi as Ui;

class AlertSettingsMenuDelegate extends Ui.MenuInputDelegate {
    private var mAlertStorage;
    private var mMeditateModel;
    
    function initialize(alertStorage, meditateModel) {
        MenuInputDelegate.initialize();
        me.mAlertStorage = alertStorage;
        me.mMeditateModel = meditateModel;
    }
		
    function onMenuItem(item) {
        if (item == :addNew) {
        	var newAlert = me.mAlertStorage.addAlert();
            me.mMeditateModel.setAlert(newAlert);    	
        	var addEditAlertMenuMenuDelegate = new AddEditAlertMenuDelegate(me.mAlertStorage, me.mMeditateModel);
   	        Ui.popView(Ui.SLIDE_IMMEDIATE);
        	Ui.pushView(new Rez.Menus.addEditAlertMenu(), addEditAlertMenuMenuDelegate, Ui.SLIDE_LEFT);        	
        }
        else if (item == :edit) {
   	        var addEditAlertMenuMenuDelegate = new AddEditAlertMenuDelegate(me.mAlertStorage, me.mMeditateModel);
   	        Ui.popView(Ui.SLIDE_IMMEDIATE);
        	Ui.pushView(new Rez.Menus.addEditAlertMenu(), addEditAlertMenuMenuDelegate, Ui.SLIDE_LEFT);    
        }
        else if (item == :delete) {
	    	var confirmHeader = Ui.loadResource(Rez.Strings.confirmDeleteAlertHeader);
    		var confirmDeleteAlertDialog = new Ui.Confirmation(confirmHeader);
   	        Ui.popView(Ui.SLIDE_IMMEDIATE);
        	Ui.pushView(confirmDeleteAlertDialog, new ConfirmDeleteAlertDelegate(me.mAlertStorage, me.mMeditateModel), Ui.SLIDE_LEFT);
        }
    }
}