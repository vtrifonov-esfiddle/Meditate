using Toybox.WatchUi as Ui;
using Toybox.Lang;

class IntervalAlertsMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnIntervalAlertsChanged;
	private var mIntervalAlerts;
	private var mSelectedIntervalAlertIndex;
	
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
        	var confirmDeleteAllIntervalAlertsHeader = Ui.loadResource(Rez.Strings.confirmDeleteAllIntervalAlertsHeader);
        	var confirmDeleteAllDialog = new Ui.Confirmation(confirmDeleteAllIntervalAlertsHeader);
        	Ui.pushView(confirmDeleteAllDialog, new YesDelegate(method(:onConfirmedDeleteAllIntervalAlerts)), Ui.SLIDE_IMMEDIATE);
        }
    }
    
    private function onDeleteIntervalAlert(selectedIntervalAlert) {
    	
    }
    
    private function editIntervalAlert(selectedIntervalAlertIndex) {
    	me.mSelectedIntervalAlertIndex = selectedIntervalAlertIndex;
		me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
		var selectedIntervalAlert = me.mIntervalAlerts.get(mSelectedIntervalAlertIndex);
		var intervalAlertMenu = new Rez.Menus.addEditIntervalAlertMenu();
		var selectedIntervalAlertNumber = selectedIntervalAlertIndex + 1;
		intervalAlertMenu.setTitle(Ui.loadResource(Rez.Strings.addEditIntervalAlertMenu_title) + " " + selectedIntervalAlertNumber);
		var intervalAlertMenuDelegate = new AddEditIntervalAlertMenuDelegate(selectedIntervalAlert, method(:onIntervalAlertChanged), method(:onDeleteIntervalAlert));
		Ui.pushView(intervalAlertMenu, intervalAlertMenuDelegate, Ui.SLIDE_LEFT);
    }
    
    private function onConfirmedDeleteAllIntervalAlerts() {
    	me.mIntervalAlerts.reset();
    	me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
    }
    
    function onIntervalAlertChanged(intervalAlert) {
    	me.mIntervalAlerts.set(me.mSelectedIntervalAlertIndex, intervalAlert);
    	me.mOnIntervalAlertsChanged.invoke(me.mIntervalAlerts);
    }
}