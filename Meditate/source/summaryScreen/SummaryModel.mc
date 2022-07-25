using Toybox.Time;
using Toybox.System;
using HrvAlgorithms.HrvTracking;
using Toybox.ActivityMonitor;

class SummaryModel {
	function initialize(activitySummary, rrActivity, hrvTracking) {
		me.elapsedTime = activitySummary.hrSummary.elapsedTimeSeconds; 
		me.maxHr = me.initializeHeartRate(activitySummary.hrSummary.maxHr);
		me.avgHr = me.initializeHeartRate(activitySummary.hrSummary.averageHr);
		me.minHr = me.initializeHeartRate(activitySummary.hrSummary.minHr);
		
		var rrSummary = rrActivity.getSummary();
		if (rrSummary!=null) {
			me.maxRr = me.initializeHeartRate(rrSummary.maxRr);
			me.avgRr = me.initializeHeartRate(rrSummary.averageRr);
			me.minRr = me.initializeHeartRate(rrSummary.minRr);
		}

		me.stress = me.initializePercentageValue(activitySummary.stress);
		
		initializeStressHistory(me.elapsedTime);

		if (activitySummary.hrvSummary != null) {
			me.hrvRmssd = me.initializeHeartRateVariability(activitySummary.hrvSummary.rmssd);
			me.hrvFirst5Min = me.initializeHeartRateVariability(activitySummary.hrvSummary.first5MinSdrr);
			me.hrvLast5Min = me.initializeHeartRateVariability(activitySummary.hrvSummary.last5MinSdrr);
			me.hrvPnn50 = me.initializePercentageValue(activitySummary.hrvSummary.pnn50);
			me.hrvPnn20 = me.initializePercentageValue(activitySummary.hrvSummary.pnn20);
		}
		
		me.hrvTracking = hrvTracking;
	}

	function initializeStressHistory (elapsedTimeSeconds) {

		stressEnd = null;
		stressStart = null;

		// Get stress history iterator object
		var stressIterator = getStressHistoryIterator(elapsedTimeSeconds);
		if (stressIterator!=null) {
		
			// Loop through all data
			var sample = stressIterator.next();

			// Get the stress data for the end of the session
			if (sample != null) {
				me.stressEnd = sample.data;
			}

			// Go until the end of the iterator
			while (sample != null) {

				sample = stressIterator.next();

				// Get the stress score for the start of the session
				if (sample!=null) {
					me.stressStart = sample.data;
				}
			}
		}
	}

	function getStressHistoryIterator(elapsedTimeSeconds) {

		// We need at least 5min duration in order to call getStressHistory
		// otherwise it will fail with invalid value for duration
		if (elapsedTimeSeconds < (60 * 5)) {
			return null;
		}

		// Check device for SensorHistory compatibility
		if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getStressHistory)) {

			// Convert seconds into Duration
			var duration = new Time.Duration(elapsedTimeSeconds);

			// Retrieve the stress history for the meditation session period
			var stressHistory = Toybox.SensorHistory.getStressHistory({:period => duration,:order => SensorHistory.ORDER_NEWEST_FIRST});

			return stressHistory;
		}

		return null;
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
		
	private const InvalidHeartRate = "   --";
	
	var elapsedTime;
	
	var maxHr;
	var avgHr;
	var minHr;	
	
	var maxRr;
	var avgRr;
	var minRr;	

	var stress;
	var stressStart;
	var stressEnd;

	var hrvRmssd;
	var hrvFirst5Min;
	var hrvLast5Min;
	var hrvPnn50;
	var hrvPnn20;
	
	var hrvTracking;
}