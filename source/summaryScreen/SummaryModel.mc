using Toybox.System;

class SummaryModel {
	function initialize(activityInfo, minHr, stressStats, hrvFirst5Min, hrvLast5Min) {
		me.elapsedTime = activityInfo.elapsedTime / 1000; 
		me.maxHr = me.initializeHeartRate(activityInfo.maxHeartRate);
		me.avgHr = me.initializeHeartRate(activityInfo.averageHeartRate);
		me.minHr = me.initializeHeartRate(minHr);
		
		me.noStress = me.initializeStressScore(stressStats.noStress);
		me.mediumStress = me.initializeStressScore(stressStats.mediumStress);
		me.highStress = me.initializeStressScore(stressStats.highStress);
		
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
	var mediumStress;
	var highStress;
	
	var hrvFirst5Min;
	var hrvLast5Min;
}