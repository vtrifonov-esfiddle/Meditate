using Toybox.System;

class SummaryModel {
	function initialize(activityInfo, minHr, hrv) {
		me.elapsedTime = activityInfo.elapsedTime / 1000; 
		me.maxHr = me.initializeHeartRate(activityInfo.maxHeartRate);
		me.avgHr = me.initializeHeartRate(activityInfo.averageHeartRate);
		me.minHr = me.initializeHeartRate(minHr);
		me.hrv = me.initializeHeartRateVariability(hrv);
	}
	
	private function initializeHeartRate(heartRate) {
		if (heartRate == null || heartRate == 0) {
			return me.InvalidHeartRate;
		}
		else {
			return heartRate;
		}
	}
	
	private function initializeHeartRateVariability(hrv) {
		if (hrv == null) {
			return me.InvalidHeartRate;
		}
		else {
			return hrv.format("%3.2f");
		}
	}
	
	private const InvalidHeartRate = "--";
	
	var elapsedTime;
	
	var maxHr;
	var avgHr;
	var minHr;	
	
	var hrv;
}