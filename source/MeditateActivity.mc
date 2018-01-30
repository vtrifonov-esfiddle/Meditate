using Toybox.WatchUi as Ui;
using Toybox.Timer;

class MediateActivity {
	private var mMeditateModel;
	private var mSession;
	private var mIsStarted;	
	private var mSummaryModel;
	
	function initialize(meditateModel) {
		me.mMeditateModel = meditateModel;
		    	
    	me.mSession = ActivityRecording.createSession(       
                {
                 :name=>"Meditating",                              
                 :sport=>ActivityRecording.SPORT_GENERIC,      
                 :subSport=>ActivityRecording.SUB_SPORT_GENERIC
                }
           );  
        me.mIsStarted = false;     
		me.mSummaryModel = null;		
		Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );
	}
	
	private var RefreshActivityInterval = 1000;
		
	function start() {
		me.mIsStarted = true;		
		me.mSession.start(); 
		
		var refreshActivityTimer = new Timer.Timer();		
		refreshActivityTimer.start(method(:refreshActivityStats), me.RefreshActivityInterval, true);
			
		var elapsedTimer = new Timer.Timer();
		var timeInMilliseconds = me.mMeditateModel.getAlertTime() * 1000;
		elapsedTimer.start(method(:timeElapsed), timeInMilliseconds, false);
	}
	
	private function refreshActivityStats() {	
		if (me.mIsStarted == false) {
			return;
	    }	
	    
		var activityInfo = Activity.getActivityInfo();
		if (activityInfo == null) {
			return;
		}
		if (activityInfo.elapsedTime != null) {
			me.mMeditateModel.elapsedTime = activityInfo.elapsedTime / 1000;
		} 
		me.mMeditateModel.heartRate = activityInfo.currentHeartRate;

	    Ui.requestUpdate();	    
	}
	
	private function timeElapsed() {
		Vibration.vibrate(me.mMeditateModel.getVibrationPattern());
	}
	
	function stop() {
		me.mIsStarted = false;			
		me.mSession.stop();		
		
		var activityInfo = Activity.getActivityInfo();
		me.mSummaryModel = new SummaryModel(activityInfo);
	}
		
	function finish() {		
		Sensor.setEnabledSensors( [] );
		me.mSession.save();
		return me.mSummaryModel;
	}
	
	function discard() {		
		Sensor.setEnabledSensors( [] );
		me.mSession.discard();
	}
	
	function isStarted() {
		return me.mIsStarted;
	}
}