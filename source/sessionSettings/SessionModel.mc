using Toybox.Graphics as Gfx;
using Toybox.Application as App;

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
		MediumAscending = 9
	}
}

class SessionModel {
	function initialize() {	
	}
	
	function fromDictionary(loadedSessionDictionary) {	
		me.time = loadedSessionDictionary["time"];
		me.color = loadedSessionDictionary["color"];
		me.vibePattern = loadedSessionDictionary["vibePattern"];
	}
	
	function toDictionary() {
		return {
			"time" => me.time,
			"color" => me.color,
			"vibePattern" => me.vibePattern
		};
	}
		
	function reset() {
		me.time = 600;
		me.color = Gfx.COLOR_YELLOW;
		me.vibePattern = VibePattern.LongContinuous;
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
	}
		
	var time;
	var color;
	var vibePattern;
}