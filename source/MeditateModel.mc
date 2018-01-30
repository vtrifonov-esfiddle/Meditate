using Toybox.Application as App;

class MeditateModel {
	function initialize(alertModel) {
		me.heartRate = null;
		me.mAlert = alertModel;
		me.elapsedTime = 0;
	}
	
	private var mAlert;
			
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