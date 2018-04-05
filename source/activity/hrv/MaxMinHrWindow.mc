class MaxMinHrWindow {
	function initialize(samplesCount) {
		me.mSamples = new [samplesCount];
		me.mStoreIndex = 0;
		me.mStoredSamplesCount = 0;
	}
	
	private var mSamples;
	private var mStoredSamplesCount;
	private var mStoreIndex;
	
	function addHrSample(hr) {
		if (hr != null) {
			me.mSamples[me.mStoreIndex] = hr;
			me.mStoreIndex = (me.mStoreIndex + 1) % me.mSamples.size();
			me.mStoredSamplesCount++;
		}
	}
	
	function calculate() {
		if (me.mStoredSamplesCount < me.mSamples.size()) {
			return null;
		}
		
		var minHr = me.mSamples[0];
		var maxHr = me.mSamples[0];
		for (var i = 1; i < me.mSamples.size(); i++) {
			if (me.mSamples[i] < minHr) {
				minHr = me.mSamples[i];
			}
			else if (me.mSamples[i] > maxHr) {
				maxHr = me.mSamples[i];
			}
		}
		
		return maxHr - minHr;
	}
}