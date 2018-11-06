using Toybox.WatchUi as Ui;
using Toybox.Lang;

class IntervalAlertsMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnIntervalAlertsChanged;
	private var mIntervalAlerts;
	
	function initialize(intervalAlerts, onIntervalAlertsChanged) {
		MenuInputDelegate.initialize();
		me.mIntervalAlerts = intervalAlerts;
		me.mOnIntervalAlertsChanged = onIntervalAlertsChanged;
	}
	
 	function onMenuItem(item) {
        if (item == :addNew) {
			me.editIntervalAlert(me.mIntervalAlerts.addNew());		
        }
        else if (item == :edit) {
        	if (me.mIntervalAlerts.count() == 0) {
		    	return;
        	}
        	var editIntervalAlertsMenu = new Ui.Menu();
			editIntervalAlertsMenu.setTitle(Ui.loadResource(Rez.Strings.editIntervalAlertsMenu_title));
			
			for (var i = 0; i < me.mIntervalAlerts.count(); i++) {
				var intervalAlert = me.mIntervalAlerts.get(i);			
				var type;
				if (intervalAlert.type == IntervalAlertType.OneOff) {
					type = "One-off";
				}
				else {
					type = "Repeat";
				}
				editIntervalAlertsMenu.addItem(Lang.format("$1$ $2$", [type, TimeFormatter.format(intervalAlert.time)]), i);
			}
			
			var editIntervalAlertsMenuDelegate = new EditIntervalAlertsMenuDelegate(method(:editIntervalAlert));
			Ui.pushView(editIntervalAlertsMenu, editIntervalAlertsMenuDelegate, Ui.SLIDE_LEFT);	
        }
        else if (item == :deleteAll) {
        	if (me.mIntervalAlerts.count() == 0) {
		    	return;
        	}
        	var confirmDeleteAllIntervalAlertsHeader = Ui.loadResource(Rez.Strings.confirmDeleteAllIntervalAlertsHeader);
        	var confirmDeleteAllDialog = new Ui.Confirmation(confirmDeleteAllIntervalAlertsHeader);
        	Ui.pushView(confirmDeleteAllDialog, new YesDelegate(method(:onConfirmedDeleteAllIntervalAlerts)), Ui.SLIDE_IMMEDIATE);
        }
    }
    
    function onDeleteIntervalAlert(intervalAlertIndex) {
    	me.mIntervalAlerts.delete(intervalAlertIndex);
    	me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
    }
    
    function editIntervalAlert(selectedIntervalAlertIndex) {
		me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
		var selectedIntervalAlert = me.mIntervalAlerts.get(selectedIntervalAlertIndex);
		var intervalAlertMenu = new Rez.Menus.addEditIntervalAlertMenu();
		var selectedIntervalAlertNumber = selectedIntervalAlertIndex + 1;
		intervalAlertMenu.setTitle(Ui.loadResource(Rez.Strings.addEditIntervalAlertMenu_title) + " " + selectedIntervalAlertNumber);
		var intervalAlertMenuDelegate = new AddEditIntervalAlertMenuDelegate(selectedIntervalAlert, selectedIntervalAlertIndex, method(:onIntervalAlertChanged), method(:onDeleteIntervalAlert));
		Ui.pushView(intervalAlertMenu, intervalAlertMenuDelegate, Ui.SLIDE_LEFT);
    }
    
    function onConfirmedDeleteAllIntervalAlerts() {
    	Ui.popView(Ui.SLIDE_IMMEDIATE);
    	me.mIntervalAlerts.reset();
    	me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
    }
    
    function onIntervalAlertChanged(intervalAlertIndex, intervalAlert) {
    	me.mIntervalAlerts.set(intervalAlertIndex, intervalAlert);
    	me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
    }
}