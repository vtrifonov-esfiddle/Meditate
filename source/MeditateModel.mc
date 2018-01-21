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
	
	function formatTime(time) {		
		var timeCalc = time;
		var seconds = timeCalc % 60;
		timeCalc /= 60;
		var minutes = timeCalc % 60;
		timeCalc /= 60;
		var hours = timeCalc % 24;
		
		var formattedTime = Lang.format("$1$:$2$:$3$", [hours.format("%02d"), minutes.format("%02d"), seconds.format("%02d")]);
		return formattedTime;
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