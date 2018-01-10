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
    	return me.showAddAlertMenu();
    }
    
    private function showAddAlertMenu() {
    	var addAlert = new Rez.Menus.addAlertMenu();   	

    	var addAlertMenuDelegate = new AddAlertMenuDelegate(me.mMeditateModel);
    	Ui.pushView(addAlert, addAlertMenuDelegate, Ui.SWIPE_UP);
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