using Toybox.System;

class SummaryModel {
	function initialize(activityInfo, minHr, stressStats, hrvFirst5Min, hrvLast5Min, hrvRmssd) {
		me.elapsedTime = activityInfo.elapsedTime / 1000; 
		me.maxHr = me.initializeHeartRate(activityInfo.maxHeartRate);
		me.avgHr = me.initializeHeartRate(activityInfo.averageHeartRate);
		me.minHr = me.initializeHeartRate(minHr);
		me.hrvRmssd = me.initializeHeartRateVariability(hrvRmssd);
		
		if (stressStats != null) {
			me.noStress = me.initializeStressScore(stressStats.noStress);
			me.lowStress = me.initializeStressScore(stressStats.lowStress);
			me.highStress = me.initializeStressScore(stressStats.highStress);

			me.stressMedian = me.initializeStressMedian(stressStats.median);
		}
		me.hrvFirst5Min = me.initializeHeartRateVariability(hrvFirst5Min);
		me.hrvLast5Min = me.initializeHeartRateVariability(hrvLast5Min);
	}
	
	private function initializeHeartRate(heartRate) {
		if (heartRate == null || heartRate == 0) {
			return me.InvalidHeartRate;
		}
		else {
			return heartRate;
		}
	}
	
	private function initializeStressMedian(median) {
		if (median == null || median == 0) {
			return me.InvalidHeartRate;
		}
		else {
			return median.format("%2.1f");
		}
	}
	
	private function initializeStressScore(stressScore) {
		if (stressScore == null) {
			return me.InvalidHeartRate;
		}
		else {
			return stressScore.format("%3.2f");
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
	
	var noStress;
	var lowStress;
	var highStress;
	
	var stressMedian;
	
	var hrvRmssd;
	var hrvFirst5Min;
	var hrvLast5Min;
}