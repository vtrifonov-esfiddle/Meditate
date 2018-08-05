class VibeAlertsExecutor {
	function initialize(meditateModel) {
		me.mMeditateModel = meditateModel;
		me.mOneOffIntervalAlerts = me.mMeditateModel.getOneOffIntervalAlerts();
		me.mRepeatIntervalAlerts = me.mMeditateModel.getRepeatIntervalAlerts();	
		me.mIsFinalAlertPending = true;
	}
	
	private var mIsFinalAlertPending;
	private var mMeditateModel;
	private var mOneOffIntervalAlerts;
	private var mRepeatIntervalAlerts;
	
	function firePendingAlerts() {
		if (me.mIsFinalAlertPending == true) {
			me.fireIfRequiredRepeatIntervalAlerts();
			me.fireIfRequiredOneOffIntervalAlerts();
			me.fireIfRequiredFinalAlert();
		}
	}
	
	private function fireIfRequiredFinalAlert() {
	    if (me.mMeditateModel.elapsedTime >= me.mMeditateModel.getSessionTime()) {	    	
			Vibe.vibrate(me.mMeditateModel.getVibePattern());
			me.mIsFinalAlertPending = false;
	    }
	}
	
	private function fireIfRequiredOneOffIntervalAlerts() {
	    var i = 0;
	    while (me.mOneOffIntervalAlerts.size() > 0 && i < me.mOneOffIntervalAlerts.size()) {
	    	var alertKey = me.mOneOffIntervalAlerts.keys()[i];
	    	if (me.mMeditateModel.elapsedTime >= me.mOneOffIntervalAlerts[alertKey].time) {
	    		Vibe.vibrate(me.mOneOffIntervalAlerts[alertKey].vibePattern);
	    		me.mOneOffIntervalAlerts.remove(alertKey);
	    	}	
	    	else {
	    		i++;  
	    	}  		
	    }
	}
	
	private function fireIfRequiredRepeatIntervalAlerts() {
		for (var i = 0; i < me.mRepeatIntervalAlerts.size(); i++) {
			if (me.mRepeatIntervalAlerts[i].time > 0 && me.mMeditateModel.elapsedTime % me.mRepeatIntervalAlerts[i].time == 0) {
	    		Vibe.vibrate(me.mRepeatIntervalAlerts[i].vibePattern);	    		
	    	}	
		}
	}
}