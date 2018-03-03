using Toybox.Application as App;

class MeditateModel {
	function initialize(sessionModel) {
		me.mSession = sessionModel;
		me.elapsedTime = 0;
		me.minHr = null;
		me.currentHr = null;
		me.hrv = null;
	}
	
	private var mSession;

	public var currentHr;
	public var minHr;
	public var elapsedTime;
	
	public var hrv;
	
	function getSessionTime() {
		return me.mSession.time;
	}
	
	function getOneOffIntervalAlerts() {
		return me.getIntervalAlerts(IntervalAlertType.OneOff);
	}	
	
	private function getIntervalAlerts(alertType) {
		var result = {};
		for (var i = 0; i < me.mSession.intervalAlerts.count(); i++) {
			var alert = me.mSession.intervalAlerts.get(i);
			if (alert.type == alertType) {
				result.put(result.size(), alert);
			}
		}
		return result;
	}
	
	function getRepeatIntervalAlerts() {		
		return me.getIntervalAlerts(IntervalAlertType.Repeat);
	}
		
	function getColor() {
		return me.mSession.color;
	}
	
	function getVibePattern() {
		return me.mSession.vibePattern;
	}
	
	function setSession(sessionModel) {
		me.mSession = sessionModel;
	}
}