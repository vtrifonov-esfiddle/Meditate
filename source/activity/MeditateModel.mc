using Toybox.Application as App;

class MeditateModel {
	function initialize(alertModel) {
		me.mAlert = alertModel;
		me.elapsedTime = 0;
		me.minHr = null;
		me.currentHr = null;
	}
	
	private var mAlert;

	public var currentHr;
	public var minHr;
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