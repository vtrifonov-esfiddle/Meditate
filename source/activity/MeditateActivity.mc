using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.FitContributor;

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
		me.createMinHrDataField();
	}
	
	private function createMinHrDataField() {
		me.mMinHrField = me.mSession.createField(
            "min_hr",
            me.MinHrFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_LAP, :units=>"bpm"}
        );

        me.mMinHrField.setData(0.0);
	}
	
	private const MinHrFieldId = 0;
	private var mMinHrField;
	
	private var RefreshActivityInterval = 1000;
	
	private var mRefreshActivityTimer;
	private var mElapsedTimer;
		
	function start() {
		me.mIsStarted = true;		
		me.mSession.start(); 
		
		me.mRefreshActivityTimer = new Timer.Timer();		
		me.mRefreshActivityTimer.start(method(:refreshActivityStats), me.RefreshActivityInterval, true);
			
		me.mElapsedTimer = new Timer.Timer();
		var timeInMilliseconds = me.mMeditateModel.getSessionTime() * 1000;
		me.mElapsedTimer.start(method(:timeElapsed), timeInMilliseconds, false);
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
		me.mMeditateModel.currentHr = activityInfo.currentHeartRate;
		if (activityInfo.currentHeartRate != null) {
	    	if (me.mMeditateModel.minHr == null || me.mMeditateModel.minHr > activityInfo.currentHeartRate) {
	    		me.mMeditateModel.minHr = activityInfo.currentHeartRate;
	    		me.mMinHrField.setData(activityInfo.currentHeartRate.toFloat());
	    	}
	    }
	    Ui.requestUpdate();	    
	}
	    
	private function timeElapsed() {
		Vibe.vibrate(me.mMeditateModel.getVibePattern());
	}
	
	function stop() {
		me.mIsStarted = false;		
		me.mSession.stop();		
		me.mRefreshActivityTimer.stop();
		me.mElapsedTimer.stop();
		
		var activityInfo = Activity.getActivityInfo();
		me.mSummaryModel = new SummaryModel(activityInfo, me.mMeditateModel.minHr);
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