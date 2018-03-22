using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.FitContributor;
using Toybox.Timer;

class MediateActivity {
	private var mMeditateModel;
	private var mSession;
	private var mSummaryModel;
	private var mVibeAlertsExecutor;	
	private var mHrvMonitor;
		
	function initialize(meditateModel) {
		me.mMeditateModel = meditateModel;
		    	
    	me.mSession = ActivityRecording.createSession(       
                {
                 :name=>"Meditating",                              
                 :sport=>ActivityRecording.SPORT_GENERIC,      
                 :subSport=>ActivityRecording.SUB_SPORT_GENERIC
                }
           );      
		me.mSummaryModel = null;		
		Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );		
		me.createMinHrDataField();
		me.mVibeAlertsExecutor = null;
		me.mHrvMonitor = new HrvMonitor(me.mSession);
	}
			
	private function createMinHrDataField() {
		me.mMinHrField = me.mSession.createField(
            "min_hr",
            me.MinHrFieldId,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"bpm"}
        );

        me.mMinHrField.setData(0);
	}
	
	private const MinHrFieldId = 0;
	private var mMinHrField;
	
	private var RefreshActivityInterval = 1000;
	
	private var mRefreshActivityTimer;
		
	function start() {	
		me.mSession.start(); 
		me.mVibeAlertsExecutor = new VibeAlertsExecutor(me.mMeditateModel);
		me.mRefreshActivityTimer = new Timer.Timer();		
		me.mRefreshActivityTimer.start(method(:refreshActivityStats), me.RefreshActivityInterval, true);	
	}
			
	private function refreshActivityStats() {	
		if (me.mSession.isRecording() == false) {
			return;
	    }	
	    
		var activityInfo = Activity.getActivityInfo();
		if (activityInfo == null) {
			return;
		}
		if (activityInfo.elapsedTime != null) {
			me.mMeditateModel.elapsedTime = activityInfo.elapsedTime / 1000;
		} 
		me.mMeditateModel.currentHr = activityInfo.currentHeartRate;
		if (activityInfo.currentHeartRate != null) {
	    	if (me.mMeditateModel.minHr == null || me.mMeditateModel.minHr > activityInfo.currentHeartRate) {
	    		me.mMeditateModel.minHr = activityInfo.currentHeartRate;
	    	}
	    }
	    
    	me.mHrvMonitor.addHrSample(activityInfo.currentHeartRate);	    
		me.mVibeAlertsExecutor.firePendingAlerts();
	    
	    Ui.requestUpdate();	    
	}	   	
	
	function stop() {	
		if (me.mSession.isRecording() == false) {
			return;
	    }	
	    
		me.mSession.stop();		
		me.mRefreshActivityTimer.stop();
		me.mRefreshActivityTimer = null;
		me.mVibeAlertsExecutor = null;
	}
		
	function calculateSummaryFields() {		
		var activityInfo = Activity.getActivityInfo();		
		if (me.mMeditateModel.minHr != null) {
			me.mMinHrField.setData(me.mMeditateModel.minHr);
		}
		
		var hrvFirst5Min = me.mHrvMonitor.calculateHrvFirst5MinSdrr();
		var hrvLast5Min = me.mHrvMonitor.calculateHrvLast5MinSdrr();
		var hrvRmssd = me.mHrvMonitor.calculateHrvUsingRmssd();
		me.mSummaryModel = new SummaryModel(activityInfo, me.mMeditateModel.minHr, hrvFirst5Min, hrvLast5Min, hrvRmssd);
	}
			
	function finish() {		
		Sensor.setEnabledSensors( [] );
		me.mSession.save();
		return me.mSummaryModel;
	}
	
	function discard() {		
		Sensor.setEnabledSensors( [] );
		me.mSession.discard();
		return me.mSummaryModel;
	}
}

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
			if (me.mMeditateModel.elapsedTime % me.mRepeatIntervalAlerts[i].time == 0) {
	    		Vibe.vibrate(me.mRepeatIntervalAlerts[i].vibePattern);	    		
	    	}	
		}
	}
}