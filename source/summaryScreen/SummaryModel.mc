using Toybox.System;

class SummaryModel {
	function initialize(activityInfo, minHr, stressStats, hrvSummary) {
		me.elapsedTime = activityInfo.elapsedTime / 1000; 
		me.maxHr = me.initializeHeartRate(activityInfo.maxHeartRate);
		me.avgHr = me.initializeHeartRate(activityInfo.averageHeartRate);
		me.minHr = me.initializeHeartRate(minHr);
		me.hrvRmssd = me.initializeHeartRateVariability(hrvSummary.rmssd);
		
		if (stressStats != null) {
			me.noStress = me.initializePercentageValue(stressStats.noStress);
			me.lowStress = me.initializePercentageValue(stressStats.lowStress);
			me.highStress = me.initializePercentageValue(stressStats.highStress);

			me.stressMedian = me.initializeStressMedian(stressStats.median);
		}
		me.hrvFirst5Min = me.initializeHeartRateVariability(hrvSummary.first5MinSdrr);
		me.hrvLast5Min = me.initializeHeartRateVariability(hrvSummary.last5MinSdrr);
		me.hrvPnn50 = me.initializePercentageValue(hrvSummary.pnn50);
		me.hrvPnn20 = me.initializePercentageValue(hrvSummary.pnn20);
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
	
	private function initializePercentageValue(stressScore) {
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
	var hrvPnn50;
	var hrvPnn20;
}