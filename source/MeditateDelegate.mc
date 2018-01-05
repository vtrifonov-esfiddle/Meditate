using Toybox.WatchUi as Ui;

class MeditateDelegate extends Ui.BehaviorDelegate {
	private var mMeditateModel;
	private var mMeditateActivity;
	
    function initialize(meditateModel) {
        BehaviorDelegate.initialize();
        me.mMeditateModel = meditateModel;
        me.mMeditateActivity = new MediateActivity(me.mMeditateModel);
    }
		
    function onMenu() {
		return me.showDurationMenu();
    }
    
    function onNextPage() {
    	return me.showDurationMenu();
    }
    
    private function showConfigureAlertsMenu() {
    	var configAlerts = new Ui.Menu();
    	configAlerts.setTitle("Configure Alerts");
    	configAlerts.addItem("Add Profile", :alerts_addProfile);
    	configAlerts.addItem("Add Alert", :alerts_addAlert);
    	configAlerts.addItem("Vibration Pattern", :alerts_vibrationPattern);
    	configAlerts.addItem("Time", :alerts_time);
    	
    	var configAlertsMenuDelegate = new Ui.BehaviorDelegate();
    	Ui.pushView(configAlerts, configAlertsMenuDelegate, Ui.SWIPE_DOWN);
    }
    
    private function showDurationMenu() {
    	var durationMenuDelegate = new DurationMenuDelegate(me.mMeditateModel);
        Ui.pushView(new Rez.Menus.DurationMenu(), durationMenuDelegate, Ui.CLICK_TYPE_TAP);
        return true;
    }
	
	private function toggleActivity() {
		if (!me.mMeditateActivity.isStarted()) {
			me.mMeditateModel.output = "Started";
			me.mMeditateModel.isStarted = true;
			me.mMeditateActivity.start();		
			Ui.requestUpdate();
		}
		else {
			me.mMeditateModel.output = "Stopped";
			me.mMeditateModel.isStarted = false;
			Ui.requestUpdate();
			me.mMeditateActivity.stop();
			me.finishActivity();
		}
	}
    
    private function finishActivity() {
    	var confirmSaveHeader = Ui.loadResource(Rez.Strings.ConfirmSaveHeader);
    	var confirmSaveDialog = new Ui.Confirmation(confirmSaveHeader);
        Ui.pushView(confirmSaveDialog, new ConfirmSaveDelegate(me.mMeditateActivity), Ui.SLIDE_IMMEDIATE);
    }
        
    function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER) {
	    	me.toggleActivity();
	    	return true;
	  	}
	  	return false;
    }
}