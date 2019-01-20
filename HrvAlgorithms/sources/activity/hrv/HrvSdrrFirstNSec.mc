module HrvAlgorithms {
	class HrvSdrrFirstNSec {
		function initialize(maxIntervalsCount) {
			me.mMaxIntervalsCount = maxIntervalsCount;
			me.mBeatToBeatIntervalsCount = 0;
			me.mIntervals = new [maxIntervalsCount];
		}
		
		private var mMaxIntervalsCount;
		private var mBeatToBeatIntervalsCount;
		private var mIntervals;
		
		function addBeatToBeatInterval(beatToBeatInterval) {
			if (me.mBeatToBeatIntervalsCount >= me.mMaxIntervalsCount) {
				return;
			}
			
			if (beatToBeatInterval != null) {
				me.mBeatToBeatIntervalsCount++;		
				
				var intervalsIndex = me.mBeatToBeatIntervalsCount - 1;
				me.mIntervals[intervalsIndex] = beatToBeatInterval.toFloat();
			}		
		}
		
		function calculate() {
			if (me.mBeatToBeatIntervalsCount < 2) {
				return null;
			}
			
			var sumBeatToBeat = 0.0;
			for (var i = 0; i < me.mBeatToBeatIntervalsCount; i++) {
				sumBeatToBeat += me.mIntervals[i];
			}
			var meanBeatToBeat = sumBeatToBeat / me.mBeatToBeatIntervalsCount.toFloat();		
			var sumSquaredDeviations = 0.0;
			for (var i = 0; i < me.mBeatToBeatIntervalsCount; i++) {
				sumSquaredDeviations += Math.pow(me.mIntervals[i] - meanBeatToBeat, 2);	
			}
			return Math.sqrt(sumSquaredDeviations / me.mBeatToBeatIntervalsCount.toFloat());
		}
	}
}