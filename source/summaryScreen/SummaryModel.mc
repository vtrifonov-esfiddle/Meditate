using Toybox.System;

class SummaryModel {
	function initialize(activityInfo, minHr, stress, hrvSummary, hrvTracking) {
		me.elapsedTime = activityInfo.elapsedTime / 1000; 
		me.maxHr = me.initializeHeartRate(activityInfo.maxHeartRate);
		me.avgHr = me.initializeHeartRate(activityInfo.averageHeartRate);
		me.minHr = me.initializeHeartRate(minHr);
		
		me.stress = me.initializePercentageValue(stress);
		
		if (hrvSummary != null) {
			me.hrvRmssd = me.initializeHeartRateVariability(hrvSummary.rmssd);
			me.hrvFirst5Min = me.initializeHeartRateVariability(hrvSummary.first5MinSdrr);
			me.hrvLast5Min = me.initializeHeartRateVariability(hrvSummary.last5MinSdrr);
			me.hrvPnn50 = me.initializePercentageValue(hrvSummary.pnn50);
			me.hrvPnn20 = me.initializePercentageValue(hrvSummary.pnn20);
		}
		
		me.hrvTracking = hrvTracking;
	}
	
	private function initializeHeartRate(heartRate) {
		if (heartRate == null || heartRate == 0) {
			return me.InvalidHeartRate;
		}
		else {
			return heartRate;
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
	
	var stress;
		
	var hrvRmssd;
	var hrvFirst5Min;
	var hrvLast5Min;
	var hrvPnn50;
	var hrvPnn20;
	
	var hrvTracking;
}