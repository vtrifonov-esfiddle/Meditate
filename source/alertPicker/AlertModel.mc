using Toybox.Graphics as Gfx;
using Toybox.Application as App;

module VibrationPattern {
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

class AlertModel {
	function initialize() {	
	}
	
	function fromDictionary(loadedAlertDictionary) {	
		me.time = loadedAlertDictionary["time"];
		me.color = loadedAlertDictionary["color"];
		me.vibrationPattern = loadedAlertDictionary["vibrationPattern"];
	}
	
	function toDictionary() {
		return {
			"time" => me.time,
			"color" => me.color,
			"vibrationPattern" => me.vibrationPattern
		};
	}
		
	function reset() {
		me.time = 600;
		me.color = Gfx.COLOR_YELLOW;
		me.vibrationPattern = VibrationPattern.LongContinuous;
	}
	
	function copyNonNullFieldsFromAlert(otherAlert) {
    	if (otherAlert.time != null) {
    		me.time = otherAlert.time;
    	}
    	if (otherAlert.color != null) {
    		me.color = otherAlert.color;
    	}
    	if (otherAlert.vibrationPattern != null) {
    		me.vibrationPattern = otherAlert.vibrationPattern;
    	}
	}
		
	var time;
	var color;
	var vibrationPattern;
}