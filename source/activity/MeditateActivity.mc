using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.FitContributor;
using Toybox.Timer;
using Toybox.Math;

class MediateActivity {
	private var mMeditateModel;
	private var mSession;
	private var mVibeAlertsExecutor;	
	private var mHrvMonitor;
	private var mStressMonitor;
	
	private const SUB_SPORT_YOGA = 43;
		
	function initialize(meditateModel) {
		me.mMeditateModel = meditateModel;
		if (meditateModel.getActivityType() == ActivityType.Yoga) { 
			me.mSession = ActivityRecording.createSession(       
                {
                 :name => "Yoga",                              
                 :sport => ActivityRecording.SPORT_TRAINING,      
                 :subSport => SUB_SPORT_YOGA
                });    		
        }
        else {
        	me.mSession = ActivityRecording.createSession(       
                {
                 :name => "Meditating",                              
                 :sport => ActivityRecording.SPORT_GENERIC,      
                 :subSport => ActivityRecording.SUB_SPORT_GENERIC
                });
        }      	
		Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );		
		me.createMinHrDataField();		
		me.mVibeAlertsExecutor = null;
		me.mHrvMonitor = new HrvMonitor(me.mSession);
		me.mStressMonitor = new StressMonitor(me.mSession);
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
	
	private const RefreshActivityInterval = 1000;
	
	private var mRefreshActivityTimer;
		
	function start() {	
		Sensor.registerSensorDataListener(method(:onSensorData), {
			:period => 1, 				// 1 second sample time
			:heartBeatIntervals => {
		        :enabled => true
		    }
		});
		me.mSession.start(); 
		me.mVibeAlertsExecutor = new VibeAlertsExecutor(me.mMeditateModel);
		me.mRefreshActivityTimer = new Timer.Timer();		
		me.mRefreshActivityTimer.start(method(:refreshActivityStats), RefreshActivityInterval, true);	
	}	
	
	function onSensorData(sensorData) {
		if (!(sensorData has :heartRateData) || sensorData.heartRateData == null) {
			return;
		}
		
		for (var i = 0; i < sensorData.heartRateData.heartBeatIntervals.size(); i++) {
			var beatToBeatInterval = sensorData.heartRateData.heartBeatIntervals[i];				
			if (beatToBeatInterval != null) {			
	    		me.mHrvMonitor.addValidBeatToBeatInterval(beatToBeatInterval);	 
	    		var hr = Math.round((60.0 / (beatToBeatInterval / 1000.0))).toNumber();    		
	    		me.mStressMonitor.addHrSample(hr);
    		}
    		me.mHrvMonitor.addNonFilteredBeatToBeatInterval(beatToBeatInterval);	 
    	}    	
	}		
			
	function refreshActivityStats() {	
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
		if (activityInfo.currentHeartRate != null && (me.mMeditateModel.minHr == null || me.mMeditateModel.minHr > activityInfo.currentHeartRate)) {
    		me.mMeditateModel.minHr = activityInfo.currentHeartRate;
    	}
		me.mVibeAlertsExecutor.firePendingAlerts();	    
    	me.mMeditateModel.hrv = me.mHrvMonitor.calculateHrvConsecutive();
    	
	    Ui.requestUpdate();	    
	}	   	
	
	function stop() {	
		if (me.mSession.isRecording() == false) {
			return;
	    }	
	    
	    Sensor.unregisterSensorDataListener();
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
		
		var stressStats = me.mStressMonitor.calculateStressStats();
		var hrvSummary = me.mHrvMonitor.calculateHrvSummary();
		var summaryModel = new SummaryModel(activityInfo, me.mMeditateModel.minHr, stressStats, hrvSummary);
		return summaryModel;
	}
			
	function finish() {		
		Sensor.setEnabledSensors( [] );
		me.mSession.save();
		me.mSession = null;
	}
		
	function discard() {		
		Sensor.setEnabledSensors( [] );
		me.mSession.discard();
		me.mSession = null;
	}
	
	function discardDanglingActivity() {
		var isDangling = me.mSession != null && !me.mSession.isRecording();
		if (isDangling) {
			me.discard();
		}
	}
}