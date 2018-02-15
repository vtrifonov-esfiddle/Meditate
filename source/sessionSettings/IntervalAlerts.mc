using Toybox.Graphics as Gfx;

class IntervalAlerts {
	private var mAlerts;
	
	function initialize() {
		me.reset();
	}
			
	function add(intervalAlert) {
		var newAlertIndex = me.mAlerts.size();
		me.mAlerts.put(newAlertIndex, intervalAlert);
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
		alert.time = loadedSessionDictionary["time"];
		alert.color = loadedSessionDictionary["color"];
		alert.vibePattern = loadedSessionDictionary["vibePattern"];
		return alert;
	}
	
	function toDictionary() {
		return {
			"time" => me.time,
			"color" => me.color,
			"vibePattern" => me.vibePattern
		};
	}
	
	function reset() {
		me.time = 10;
		me.color = Gfx.COLOR_PINK;
		me.vibePattern = VibePattern.ShortPulsating;
	}		

	var time;
	var color;
	var vibePattern;
}