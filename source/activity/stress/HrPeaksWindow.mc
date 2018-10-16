using Toybox.Math;

class HrPeaksWindow {
	function initialize(samplesCount) {
		me.mSamples = new [samplesCount];
		me.mStoreIndex = 0;
		me.mStoredSamplesCount = 0;
		
		me.mAverageHrPeak = 0.0;
		me.mHrPeaksCount = 0;
	}
	
	private var mSamples;
	private var mStoredSamplesCount;
	private var mStoreIndex;
	
	private var mAverageHrPeak;
	private var mHrPeaksCount;
	
	function addOneSecBeatToBeatIntervals(beatToBeatIntervals) {
		me.mSamples[me.mStoreIndex] = beatToBeatIntervals;
		me.mStoreIndex = (me.mStoreIndex + 1) % me.mSamples.size();
		me.mStoredSamplesCount++;
	}
	
	function calculateCurrentPeak() {
		var hrPeak = me.calculateHrPeak();
		if (hrPeak != null) {
			me.addHrPeak(hrPeak);
		}
		return hrPeak;
	}
	
	function calculateHrPeaksAverage() {
		if (me.mHrPeaksCount == 0) {
			return 0.0;
		}
		
		return me.mAverageHrPeak / me.mHrPeaksCount.toFloat();
	}
	
	private function addHrPeak(hrPeak) {
		me.mAverageHrPeak += hrPeak;
		me.mHrPeaksCount++;
	}
	
	private function calculateHrPeak() {
		if (me.mStoredSamplesCount < me.mSamples.size()) {
			return null;
		}
		var maxHr = null;
		for (var i = 0; i < me.mSamples.size(); i++) {
			if (me.mSamples[i].size() > 0) {
				for (var s = 0; s < me.mSamples[i].size(); s++) { 
					var beatToBeatSample = me.mSamples[i][s];
					var bpmSample =  Math.round(60000 / beatToBeatSample.toFloat()).toNumber();
					
					if (maxHr == null || bpmSample > maxHr) {
						maxHr = bpmSample;
					}
				}
			}
		}
		
		if (maxHr == null) {
			return null;
		}
		var averageHr = Activity.getActivityInfo().averageHeartRate;
		var hrPeak = maxHr - averageHr;
		if (hrPeak > 0) {
			return (hrPeak / averageHr.toFloat()) * 100.0;
		}
		else {
			return 0.0;
		}
	}
}