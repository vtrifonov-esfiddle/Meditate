module HrvAlgorithms {
	class HrvSdrrLastNSec {
		function initialize(intervalsCount) {
			me.mIntervalsCount = intervalsCount;
			me.mBeatToBeatIntervalsCount = 0;
			me.mIntervals = new [intervalsCount];
			me.mBufferCurrentIndex = 0;
		}
		
		private var mIntervalsCount;
		private var mBeatToBeatIntervalsCount;
		private var mIntervals;
		
		private var mBufferCurrentIndex;
		
		function addBeatToBeatInterval(beatToBeatInterval) {		
			if (beatToBeatInterval != null) {
				me.mBeatToBeatIntervalsCount++;		
				
				me.storeBeatToBeatInterval(beatToBeatInterval);
			}		
		}
		
		private function storeBeatToBeatInterval(beatToBeatInterval) {
			me.mIntervals[me.mBufferCurrentIndex] = beatToBeatInterval.toFloat();
			var bufferIndexRewinded = (me.mBufferCurrentIndex + 1) % me.mIntervalsCount;
			me.mBufferCurrentIndex = bufferIndexRewinded;
		}
			
		function calculate() {
			if (me.mBeatToBeatIntervalsCount < me.mIntervalsCount) {
				return null;
			}
			
			var sumBeatToBeat = 0.0;
			for (var i = 0; i < me.mIntervalsCount; i++) {
				sumBeatToBeat += me.mIntervals[i];
			}
			var meanBeatToBeat = sumBeatToBeat / me.mIntervalsCount.toFloat();
			
			var sumSquaredDeviations = 0.0;
			for (var i = 0; i < me.mIntervalsCount; i++) {			
				sumSquaredDeviations += Math.pow(me.mIntervals[i] - meanBeatToBeat, 2);
			}
			return Math.sqrt(sumSquaredDeviations / me.mIntervalsCount.toFloat());
		}
	}
}