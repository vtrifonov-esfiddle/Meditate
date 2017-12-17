using Toybox.WatchUi as Ui;

class MediateActivity {
	private var mMeditateModel;
	private var mSession;
	private var mIsStarted;
	
	function initialize(meditateModel) {
		me.mMeditateModel = meditateModel;
	
		Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );
    	Sensor.enableSensorEvents( method( :onSensor ) );
    	
    	me.mSession = ActivityRecording.createSession(       
                {
                 :name=>"Meditation",                              
                 :sport=>ActivityRecording.SPORT_GENERIC,      
                 :subSport=>ActivityRecording.SUB_SPORT_GENERIC 
                }
           );  
        me.mIsStarted = false;     
	}
	
	function start() {
		me.mIsStarted = true;
		me.mSession.start(); 
	}
	
	function pause() {
		me.mIsStarted = false;	
		me.mSession.stop();
	}
	function onSensor(sensorInfo) {
	    me.mMeditateModel.heartRate = sensorInfo.heartRate;
	    Ui.requestUpdate();
	}
		
	function finish() {
		me.mSession.save();
		Sensor.setEnabledSensors([]);
	}
	
	function discard() {
		me.mSession.discard();
	}
	
	function isStarted() {
		return me.mIsStarted;
	}
}