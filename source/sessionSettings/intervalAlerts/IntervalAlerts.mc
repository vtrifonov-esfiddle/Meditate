using Toybox.Graphics as Gfx;

module IntervalAlertType {
	enum {
		OneOff = 1,
		Repeat = 2
	}
}

class IntervalAlerts {
	private var mAlerts;
	
	function initialize() {
		me.reset();
	}
			
	function addNew() {
		var newAlertIndex = me.mAlerts.size();
		var newIntervalAlert = new Alert();
		me.mAlerts.put(newAlertIndex, newIntervalAlert);
		return newAlertIndex;
	}
	
	function delete(index) {
		me.mAlerts.remove(index);
	}
	
	function reset() {
		me.mAlerts = {};
	}
	
	function fromDictionary(serializedAlerts) {		
		me.mAlerts = {};
		for (var i = 0; i < serializedAlerts.size(); i++) {
			me.mAlerts.put(i, Alert.fromDictionary(serializedAlerts[i]));
		}
	}
	
	function toDictionary() {
		var serializedAlerts = new [me.mAlerts.size()];
		for (var i = 0; i < me.mAlerts.size(); i++) {
			serializedAlerts[i] = me.mAlerts[i].toDictionary();
		}
		return serializedAlerts;
	}
	
	function get(index) {
		return me.mAlerts[index];
	}
	
	function set(index, alert) {
		me.mAlerts[index] = alert;
	}
	
	function count() {
		return me.mAlerts.size();
	}
}

class Alert {
	function initialize() {
		me.reset();
	}
	static function fromDictionary(loadedSessionDictionary) {	
		var alert = new Alert();
		alert.type = loadedSessionDictionary["type"];
		alert.time = loadedSessionDictionary["time"];
		alert.color = loadedSessionDictionary["color"];
		alert.vibePattern = loadedSessionDictionary["vibePattern"];
		return alert;
	}
	
	function toDictionary() {
		return {
			"type" => me.type,
			"time" => me.time,
			"color" => me.color,
			"vibePattern" => me.vibePattern
		};
	}
	
	function reset() {
		me.type = IntervalAlertType.Repeat;
		me.time = 60;
		me.color = Gfx.COLOR_PINK;
		me.vibePattern = VibePattern.ShortPulsating;
	}		
		
	var type;
	var time;//in seconds
	var color;
	var vibePattern;
}