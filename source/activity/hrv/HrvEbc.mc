class HrvEbc {
	function initialize(intervalsCount) {
		me.mIntervals = new [intervalsCount];
		me.mStoreIndex = 0;
		me.mStoredIntervalsCount = 0;
	}
	
	private var mIntervals;
	private var mStoredIntervalsCount;
	private var mStoreIndex;
	
	function addBeatToBeatInterval(beatToBeatInterval) {
		if (beatToBeatInterval != null) {
			me.mIntervals[me.mStoreIndex] = beatToBeatInterval.toFloat();
			me.mStoreIndex = (me.mStoreIndex + 1) % me.mIntervals.size();
			me.mStoredIntervalsCount++;
		}
	}
	
	function calculate() {
		if (me.mStoredIntervalsCount < me.mIntervals.size()) {
			return null;
		}
		
		var minInterval = me.mIntervals[0];
		var maxInterval = me.mIntervals[0];
		for (var i = 1; i < me.mIntervals.size(); i++) {
			if (me.mIntervals[i] < minInterval) {
				minInterval = me.mIntervals[i];
			}
			else if (me.mIntervals[i] > maxInterval) {
				maxInterval = me.mIntervals[i];
			}
		}
		
		return maxInterval - minInterval;
	}
}