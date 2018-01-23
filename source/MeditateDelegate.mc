using Toybox.WatchUi as Ui;

class MeditateDelegate extends Ui.BehaviorDelegate {
	private var mMeditateModel;
	private var mMeditateActivity;
	private var mAlertStorage;
	
    function initialize(meditateModel, alertStorage) {
        BehaviorDelegate.initialize();
        me.mMeditateModel = meditateModel;
        me.mMeditateActivity = new MediateActivity(me.mMeditateModel);
        me.mAlertStorage = alertStorage;
        me.startActivity();
    }
		
	private function startActivity() {
		me.mMeditateModel.output = "Started";
		me.mMeditateActivity.start();
	}
	
	private function stopActivity() {
		me.mMeditateModel.output = "Stopped";
		Ui.requestUpdate();
		me.mMeditateActivity.stop();
		me.finishActivity();
	}
    
    private function finishActivity() {
    	var confirmSaveHeader = Ui.loadResource(Rez.Strings.ConfirmSaveHeader);
    	var confirmSaveDialog = new Ui.Confirmation(confirmSaveHeader);
        Ui.pushView(confirmSaveDialog, new ConfirmSaveDelegate(me.mMeditateActivity), Ui.SLIDE_IMMEDIATE);
    }
        
    function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER) {
	    	me.stopActivity();
	    	return true;
	  	}
	  	return false;
    }
}