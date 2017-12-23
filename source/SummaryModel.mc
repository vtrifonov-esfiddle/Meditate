using Toybox.Activity;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Lang;
class SummaryModel {
	function initialize() {
		var activityInfo = Activity.getActivityInfo();

		me.duration = me.getDuration(activityInfo.elapsedTime); 
		me.maxHr = activityInfo.maxHeartRate;
		me.avgHr = activityInfo.averageHeartRate;
	}
	
	private function getDuration(elapsedTime) {
		elapsedTime = elapsedTime / 1000;
		var seconds = elapsedTime % 60;
		elapsedTime /= 60;
		var minutes = elapsedTime % 60;
		elapsedTime /= 60;
		var hours = elapsedTime % 24;
		
		var duration = Lang.format("$1$:$2$:$3$", [hours.format("%02d"), minutes.format("%02d"), seconds.format("%02d")]);
		return duration;
	}
	
	public var duration;
	
	public var maxHr;
	public var avgHr;
}