using Toybox.Application as App;

class MeditateModel {
	function initialize(alertModel) {
		me.output = "Pick duration";
		me.setInvalidHeartRate();
		me.mAlert = alertModel;
		me.elapsedTime = 0;
	}
	
	private var mAlert;
	
	function setInvalidHeartRate() {
		me.heartRate = "--";
	}	
		
	public var output;
	public var heartRate;
	public var elapsedTime;
	
	function getAlertTime() {
		return me.mAlert.time;
	}
		
	function getColor() {
		return me.mAlert.color;
	}
	
	function getVibrationPattern() {
		return me.mAlert.vibrationPattern;
	}
	
	function setAlert(alertModel) {
		me.mAlert = alertModel;
	}
}