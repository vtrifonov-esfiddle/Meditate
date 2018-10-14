using Toybox.Math;

class HrPeaksWindow {
	function initialize(samplesCount) {
		me.mSamples = new [samplesCount];
		me.mStoreIndex = 0;
		me.mStoredSamplesCount = 0;
		me.mRunningMinHr = null;
	}
	
	private var mSamples;
	private var mStoredSamplesCount;
	private var mStoreIndex;
	private var mRunningMinHr;
	
	function addOneSecBeatToBeatIntervals(beatToBeatIntervals) {
		me.mSamples[me.mStoreIndex] = beatToBeatIntervals;
		me.mStoreIndex = (me.mStoreIndex + 1) % me.mSamples.size();
		me.mStoredSamplesCount++;
	}
	
	function calculate() {
		if (me.mStoredSamplesCount < me.mSamples.size()) {
			return null;
		}
		var maxHr = null;
		for (var i = 0; i < me.mSamples.size(); i++) {
			if (me.mSamples[i].size() > 0) {
				for (var s = 0; s < me.mSamples[i].size(); s++) { 
					var beatToBeatSample = me.mSamples[i][s];
					var bpmSample =  Math.round(60000 / beatToBeatSample.toFloat()).toNumber();
					
					if (me.mRunningMinHr == null || bpmSample < me.mRunningMinHr) {
						me.mRunningMinHr = bpmSample;
					}					
					
					if (maxHr == null || bpmSample > maxHr) {
						maxHr = bpmSample;
					}
				}
			}
		}
		
		if (maxHr == null) {
			return null;
		}
		return maxHr - me.mRunningMinHr;
	}
}