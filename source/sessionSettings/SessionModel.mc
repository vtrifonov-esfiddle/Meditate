using Toybox.Graphics as Gfx;

module VibePattern {
	enum {
		LongPulsating = 1,
		LongContinuous = 2,
		LongAscending = 3,		
		ShortPulsating = 4,
		ShortContinuous = 5,
		ShortAscending = 6,
		MediumPulsating = 7,
		MediumContinuous = 8,
		MediumAscending = 9,
		ShorterAscending = 10,
		ShorterContinuous = 11,
		Blip = 12
	}
}

class SessionModel {
	function initialize() {	
	}
		
	function fromDictionary(loadedSessionDictionary) {	
		me.time = loadedSessionDictionary["time"];
		me.color = loadedSessionDictionary["color"];
		me.vibePattern = loadedSessionDictionary["vibePattern"];
				
		var serializedAlerts = loadedSessionDictionary["intervalAlerts"];		
		me.intervalAlerts = new IntervalAlerts();
		me.intervalAlerts.fromDictionary(serializedAlerts);
	}
	
	function toDictionary() {	
		var serializedAlerts = me.intervalAlerts.toDictionary();
		return {
			"time" => me.time,
			"color" => me.color,
			"vibePattern" => me.vibePattern,
			"intervalAlerts" => serializedAlerts
		};
	}
		
	function reset() {
		me.time = 600;
		me.color = Gfx.COLOR_YELLOW;
		me.vibePattern = VibePattern.LongContinuous;		
		me.intervalAlerts = new IntervalAlerts();
		me.intervalAlerts.reset();
	}
	
	function copyNonNullFieldsFromSession(otherSession) {
    	if (otherSession.time != null) {
    		me.time = otherSession.time;
    	}
    	if (otherSession.color != null) {
    		me.color = otherSession.color;
    	}
    	if (otherSession.vibePattern != null) {
    		me.vibePattern = otherSession.vibePattern;
    	}
    	if (otherSession.intervalAlerts != null) {
    		me.intervalAlerts = otherSession.intervalAlerts;
    	}
	}
		
	var time;
	var color;
	var vibePattern;
	var intervalAlerts;
}