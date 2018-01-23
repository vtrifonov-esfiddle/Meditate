using Toybox.System;

class SummaryModel {
	function initialize(activityInfo) {
		me.elapsedTime = TimeFormatter.format(activityInfo.elapsedTime / 1000); 
		me.maxHr = activityInfo.maxHeartRate;
		me.avgHr = activityInfo.averageHeartRate;
	}

	public var elapsedTime;
	
	public var maxHr;
	public var avgHr;
}