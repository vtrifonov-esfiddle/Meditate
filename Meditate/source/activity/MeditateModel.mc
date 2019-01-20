using Toybox.Application as App;
using HrvAlgorithms.HrvTracking;

class MeditateModel {
	function initialize(sessionModel) {
		me.mSession = sessionModel;
		me.elapsedTime = 0;
		me.minHr = null;
		me.currentHr = null;
		me.hrvSuccessive = null;
	}
	
	private var mSession;

	var currentHr;
	var minHr;
	var elapsedTime;
	var hrvSuccessive;
	
	function isHrvOn() {
		return me.mSession.hrvTracking != HrvTracking.Off;
	}
	
	function getHrvTracking() {
		return me.mSession.hrvTracking;
	}
		
	function getSessionTime() {
		return me.mSession.time;
	}
	
	function getOneOffIntervalAlerts() {
		return me.getIntervalAlerts(IntervalAlertType.OneOff);
	}	
	
	function hasIntervalAlerts() {
		return me.mSession.intervalAlerts.count() > 0;
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
	
	function getActivityType() {
		return me.mSession.activityType;
	}
}