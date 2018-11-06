using Toybox.System;
using HrvAlgorithms.HrvTracking;

class SummaryModel {
	function initialize(activitySummary, hrvTracking) {
		me.elapsedTime = activitySummary.hrSummary.elapsedTimeSeconds; 
		me.maxHr = me.initializeHeartRate(activitySummary.hrSummary.maxHr);
		me.avgHr = me.initializeHeartRate(activitySummary.hrSummary.averageHr);
		me.minHr = me.initializeHeartRate(activitySummary.hrSummary.minHr);
		
		me.stress = me.initializePercentageValue(activitySummary.stress);
		
		if (activitySummary.hrvSummary != null) {
			me.hrvRmssd = me.initializeHeartRateVariability(activitySummary.hrvSummary.rmssd);
			me.hrvFirst5Min = me.initializeHeartRateVariability(activitySummary.hrvSummary.first5MinSdrr);
			me.hrvLast5Min = me.initializeHeartRateVariability(activitySummary.hrvSummary.last5MinSdrr);
			me.hrvPnn50 = me.initializePercentageValue(activitySummary.hrvSummary.pnn50);
			me.hrvPnn20 = me.initializePercentageValue(activitySummary.hrvSummary.pnn20);
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