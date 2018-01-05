using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.Attention;

class MediateActivity {
	private var mMeditateModel;
	private var mSession;
	private var mIsStarted;	
	private var mSummaryModel;
	
	function initialize(meditateModel) {
		me.mMeditateModel = meditateModel;
		
		Sensor.enableSensorEvents( method( :onSensor ) );
    	
    	me.mSession = ActivityRecording.createSession(       
                {
                 :name=>"Meditation",                              
                 :sport=>ActivityRecording.SPORT_GENERIC,      
                 :subSport=>ActivityRecording.SUB_SPORT_CARDIO_TRAINING
                }
           );  
        me.mIsStarted = false;     
		me.mSummaryModel;		
		Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );
	}
		
	function start() {
		me.mIsStarted = true;		
		me.mSession.start(); 
		var elapsedTimer = new Timer.Timer();
		var durationInMilliseconds = me.mMeditateModel.getDurationMins() * 60 * 1000;
		elapsedTimer.start(method(:durationElapsed), durationInMilliseconds, false);
	}
	
	private function durationElapsed() {
		var viberationProfile = [
			new Attention.VibeProfile(50, 1000),
	        new Attention.VibeProfile(0, 1000),
	        new Attention.VibeProfile(75, 1000),
	        new Attention.VibeProfile(0, 1000), 
	        new Attention.VibeProfile(100, 2000),
	        new Attention.VibeProfile(0, 1000),
	        new Attention.VibeProfile(100, 1000)
		];
		Attention.vibrate(viberationProfile);
	}
	
	function stop() {
		me.mIsStarted = false;			
		me.mSession.stop();
		me.mSummaryModel = new SummaryModel();
	}
	function onSensor(sensorInfo) {
		if (me.mIsStarted) {
		    me.mMeditateModel.heartRate = sensorInfo.heartRate;
		    Ui.requestUpdate();
	    }
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