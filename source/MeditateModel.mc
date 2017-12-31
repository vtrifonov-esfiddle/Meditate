using Toybox.Application as App;

class MeditateModel {
	function initialize() {
		me.output = "Pick duration";
		me.heartRate = "";
		me.isStarted = false;
	}
		
	function getDurationMins() {
		var durationMins = App.Properties.getValue("meditationDurationMins");
		return durationMins;
	}
	
	function setDuration(durationMins) {
		App.Properties.setValue("meditationDurationMins", durationMins);
	}	
		
	public var output;
	public var heartRate;
	public var isStarted;
}