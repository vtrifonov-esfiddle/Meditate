using Toybox.System;

class SummaryModel {
	function initialize(activityInfo) {
		me.elapsedTime = activityInfo.elapsedTime / 1000; 
		me.maxHr = me.initializeHeartRate(activityInfo.maxHeartRate);
		me.avgHr = me.initializeHeartRate(activityInfo.averageHeartRate);
	}
	
	private function initializeHeartRate(heartRate) {
		if (heartRate == null) {
			return me.InvalidHeartRate;
		}
		else {
			return heartRate;
		}
	}
	
	private const InvalidHeartRate = "--";
	
	public var elapsedTime;
	
	public var maxHr;
	public var avgHr;
}