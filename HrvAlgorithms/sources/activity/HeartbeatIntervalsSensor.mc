using Toybox.Sensor;

module HrvAlgorithms {
	class HeartbeatIntervalsSensor {
		private const SessionSamplePeriodSeconds = 1;
		
		function initialize() {
			me.enableHrSensor();
		}
		
		private function enableHrSensor() {		
			Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
		}

		function disableHrSensor() {
			Sensor.setEnabledSensors([]);
		}
		
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
}