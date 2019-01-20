module HrvAlgorithms {
	class HrvPnnx {
		function initialize(differenceThreshold) {		
			me.mPreviousBeatToBeatInterval = null;
			me.mTotalIntervalsCount = 0;
			me.mOverThresholdIntervalsCount = 0;
			me.mDifferenceThreshold = differenceThreshold;
		}
				
		private var mPreviousBeatToBeatInterval;
		private var mTotalIntervalsCount;
		private var mOverThresholdIntervalsCount;
		private var mDifferenceThreshold;
		
		function addBeatToBeatInterval(beatToBeatInterval) {
			me.mTotalIntervalsCount++;
			if (beatToBeatInterval == null) {
				return;
			}
			if (me.mPreviousBeatToBeatInterval == null) {
				me.mPreviousBeatToBeatInterval = beatToBeatInterval;
			}
			var intervalsDifference = (beatToBeatInterval - me.mPreviousBeatToBeatInterval).abs();		
			me.mPreviousBeatToBeatInterval = beatToBeatInterval;
			if (intervalsDifference > me.mDifferenceThreshold) {
				me.mOverThresholdIntervalsCount++;
			}		
		}
		
		function calculate() {
			if (me.mTotalIntervalsCount == 0) {
				return null;
			}
			return (me.mOverThresholdIntervalsCount.toFloat() / me.mTotalIntervalsCount.toFloat()) * 100.0;
		}
	}
}
