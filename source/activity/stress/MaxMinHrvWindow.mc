class MaxMinHrvWindow {
	function initialize(samplesCount) {
		me.mSamples = new [samplesCount];
		me.mStoreIndex = 0;
		me.mStoredSamplesCount = 0;
	}
	
	private var mSamples;
	private var mStoredSamplesCount;
	private var mStoreIndex;
	
	function addOneSecBeatToBeatIntervals(beatToBeatIntervals) {
		me.mSamples[me.mStoreIndex] = beatToBeatIntervals;
		me.mStoreIndex = (me.mStoreIndex + 1) % me.mSamples.size();
		me.mStoredSamplesCount++;
	}
	
	function calculate() {
		if (me.mStoredSamplesCount < me.mSamples.size()) {
			return null;
		}
		var minInterval = null;
		var maxInterval = null;
		for (var i = 0; i < me.mSamples.size(); i++) {
			if (me.mSamples[i].size() > 0) {
				for (var s = 0; s < me.mSamples[i].size(); s++) { 
					var sample = me.mSamples[i][s];
					if (minInterval == null) {
						minInterval = sample;
					}
					if (maxInterval == null) {
						maxInterval = sample;
					}
					if (sample < minInterval) {
						minInterval = sample;
					}
					if (sample > maxInterval) {
						maxInterval = sample;
					}
				}
			}
		}
		
		if (minInterval == null || maxInterval == null) {
			return null;
		}
		return maxInterval.abs() - minInterval.abs();
	}
}