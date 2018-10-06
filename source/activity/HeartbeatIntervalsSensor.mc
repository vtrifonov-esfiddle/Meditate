using Toybox.Sensor;

class HeartbeatIntervalsSensor {
	private const SessionSamplePeriodSeconds = 1;

	function start() {
		Sensor.unregisterSensorDataListener();
		Sensor.registerSensorDataListener(method(:onSessionSensorData), {
			:period => SessionSamplePeriodSeconds, 				
			:heartBeatIntervals => {
		        :enabled => true
		    }
		});
	}
	
	function setOneSecBeatToBeatIntervalsSensorListener(listener) {
		me.mSensorListener = listener;
	}
	
	private var mSensorListener;
	
	function onSessionSensorData(sensorData) {
		if (!(sensorData has :heartRateData) || sensorData.heartRateData == null || mSensorListener == null) {
			return;			
		}		
		
		var heartBeatIntervals = sensorData.heartRateData.heartBeatIntervals;
		me.mSensorListener.invoke(heartBeatIntervals);		
	}		
	
	function stop() {
		Sensor.unregisterSensorDataListener();
	}
}