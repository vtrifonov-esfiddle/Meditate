using Toybox.WatchUi as Ui;

class MeditateDelegate extends Ui.BehaviorDelegate {
	private var mMeditateModel;
	private var mMeditateActivity;
	
    function initialize(meditateModel) {
        BehaviorDelegate.initialize();
        me.mMeditateModel = meditateModel;
        me.mMeditateActivity = new MediateActivity(me.mMeditateModel);
    }
	
	function toggleActivity() {
		if (!me.mMeditateActivity.isStarted()) {
			me.mMeditateModel.output = "Started";
			me.mMeditateActivity.start();
		}
		else {
			me.mMeditateModel.output = "Stopped";
			me.mMeditateActivity.pause();
		}
		Ui.requestUpdate();
	}
    
    function onSelect() {
    	if (!me.mMeditateActivity.isStarted()) {
    		me.mMeditateModel.output = "Finished";
    		me.mMeditateActivity.finish();
    	}
    }
    
    function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER) {
	    	me.toggleActivity();
	    	return true;
	  	}
    }
    


}