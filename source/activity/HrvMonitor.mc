using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

class HrvMonitor {
	function initialize(activitySession) {
		me.mHrvRmssdDataField = HrvMonitor.createHrvRmssdDataField(activitySession);
		me.mHrvBeatToBeatIntervalsDataField = HrvMonitor.createHrvBeatToBeatIntervalsDataField(activitySession);
		me.mHrvSdrrFirst5MinDataField = HrvMonitor.createHrvSdrrFirst5MinDataField(activitySession);
		me.mHrvSdrrLast5MinDataField = HrvMonitor.createHrvSdrrLast5MinDataField(activitySession);
		
		me.mPreviousBeatToBeatInterval = null;
		me.mSquareOfSuccessiveBtbDifferences = 0.0;
		me.mBeatToBeatIntervalsCount = 0;
		
		me.mIntervalsBufferFirst5Min = new [Buffer5MinLength];	
		me.mIntervalsBufferLast5Min = new [Buffer5MinLength];
		me.mBufferLast5MinCurrentIndex = 0;
		me.mBufferLast5MinIsOverwritten = false;
	}
	
	private const Buffer5MinLength = 300;
	private var mIntervalsBufferFirst5Min;
	private var mIntervalsBufferLast5Min;
	private var mBufferLast5MinCurrentIndex;
	private var mBufferLast5MinIsOverwritten;
	private var mHrvRmssdDataField;
	private var mHrvBeatToBeatIntervalsDataField;
	private var mHrvSdrrFirst5MinDataField;
	private var mHrvSdrrLast5MinDataField;
	
	private var mPreviousBeatToBeatInterval;
	private var mSquareOfSuccessiveBtbDifferences;	
	private var mBeatToBeatIntervalsCount;
			
	private static const HrvBeatToBeatIntervalsFieldId = 1;	
	
	private static const HrvSdrrFirst5MinFieldId = 2;
	private static const HrvSdrrLast5MinFieldId = 3;
	
	private static const HrvRmssdFieldId = 4;
	
	
	private static function createHrvRmssdDataField(activitySession) {
		var hrvRmssdDataField = activitySession.createField(
            "hrv_rmssd",
            HrvMonitor.HrvRmssdFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvRmssdDataField;
	}
		
	private static function createHrvSdrrFirst5MinDataField(activitySession) {
		var hrvSdrrFirst5MinDataField = activitySession.createField(
            "hrv_sdrr_f",
            HrvMonitor.HrvSdrrFirst5MinFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvSdrrFirst5MinDataField;
	}
	
	private static function createHrvSdrrLast5MinDataField(activitySession) {
		var hrvSdrrLast5MinDataField = activitySession.createField(
            "hrv_sdrr_l",
            HrvMonitor.HrvSdrrLast5MinFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvSdrrLast5MinDataField;
	}
	
	private static function createHrvBeatToBeatIntervalsDataField(activitySession) {
		var beatToBeatfield = activitySession.createField(
            "hrv_btb",
            HrvMonitor.HrvBeatToBeatIntervalsFieldId,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
        return beatToBeatfield;
	}
		
	function addHrSample(hr) {
		if (hr != null) {
			var beatToBeatInterval = 60000.toFloat() / hr.toFloat();		
			me.mHrvBeatToBeatIntervalsDataField.setData(beatToBeatInterval.toNumber());
			me.addBeatToBeatInterval(beatToBeatInterval);
		}
	}
	
	private function storeNewLast5MinBufferIndex(index) {
		var result = me.mBufferLast5MinCurrentIndex;
		if (me.mBufferLast5MinCurrentIndex >= Buffer5MinLength) {
			me.mBufferLast5MinCurrentIndex = 0;
			me.mBufferLast5MinIsOverwritten = true;
			result = 0;
		}
		else {
			me.mBufferLast5MinCurrentIndex++;
		}
		return result;
	}
	
	private function getLast5MinBufferIndex(index) {
		var startIndex;
		if (me.mBufferLast5MinIsOverwritten == true) {
			startIndex = me.mBufferLast5MinCurrentIndex + 1;
		}
		else {
			startIndex = 0;
		}
		
		var bufferIndex = me.mBeatToBeatIntervalsCount - index;
		var bufferIndexWithOffset = (startIndex + bufferIndex) % Buffer5MinLength;
		return bufferIndexWithOffset;
	}
	
	private function storeBeatToBeatInterval(index, beatToBeatInterval) {
		if (index < Buffer5MinLength) {
			me.mIntervalsBufferFirst5Min[index] = beatToBeatInterval;
		}
		else {
			me.mIntervalsBufferLast5Min[me.storeNewLast5MinBufferIndex(index)] = beatToBeatInterval;
		}	
	}
	
	private function getBeatToBeatInterval(index) {
		if (index < Buffer5MinLength) {
			return me.mIntervalsBufferFirst5Min[index];
		}
		else {
			return me.mIntervalsBufferLast5Min[getLast5MinBufferIndex(index)];
		}
	}
		
	private function addBeatToBeatInterval(beatToBeatInterval) {
		if (me.mPreviousBeatToBeatInterval != null) {
			me.mBeatToBeatIntervalsCount++;		
			
			me.storeBeatToBeatInterval(me.mBeatToBeatIntervalsCount - 1, beatToBeatInterval);
			me.mSquareOfSuccessiveBtbDifferences += Math.pow(beatToBeatInterval - me.mPreviousBeatToBeatInterval, 2);
		}		
		me.mPreviousBeatToBeatInterval = beatToBeatInterval;
	}
	
	public function calculateHrvFirst5MinSdrr() {
		var count;
		if (me.mBeatToBeatIntervalsCount > Buffer5MinLength) {
			count = Buffer5MinLength;
		}
		else {
			count = me.mBeatToBeatIntervalsCount;
		}
		var sdrr = me.calculateHrvUsingSdrrSubset(0, count);
		if (sdrr != null) {
			me.mHrvSdrrFirst5MinDataField.setData(sdrr);
		}
		return sdrr;
	}
	
	public function calculateHrvLast5MinSdrr() {
		var startIndex = me.mBeatToBeatIntervalsCount - Buffer5MinLength - 1;
		if (startIndex < 0) {
			startIndex = 0;
		}
		var sdrr = me.calculateHrvUsingSdrrSubset(startIndex, me.mBeatToBeatIntervalsCount);
		if (sdrr != null) {
			me.mHrvSdrrLast5MinDataField.setData(sdrr);
		}
		return sdrr;
	}
	
	function calculateHrvStressTest(startIndex, count) {
		if (me.mBeatToBeatIntervalsCount < 1) {
			return null;
		}
		
		var sumBeatToBeat = 0;
		var actualIndex;
		for (var i = startIndex; i < count; i ++) {
			actualIndex = i % me.mBeatToBeatIntervalsCount;
			sumBeatToBeat += me.getBeatToBeatInterval(actualIndex);
		}
		var meanBeatToBeat = sumBeatToBeat / count.toFloat();
		
		var sumSquaredDeviations = 0;
		for (var i = startIndex; i < count; i ++) {	
			actualIndex = i % me.mBeatToBeatIntervalsCount;		
			sumSquaredDeviations += Math.pow(me.getBeatToBeatInterval(actualIndex) - meanBeatToBeat, 2);
		}
		return Math.sqrt(sumSquaredDeviations / count.toFloat());
	}
	
	private function calculateHrvUsingSdrrSubset(startIndex, count) {
		if (me.mBeatToBeatIntervalsCount < 1) {
			return null;
		}
		
		var sumBeatToBeat = 0;
		for (var i = startIndex; i < count; i ++) {
			sumBeatToBeat += me.getBeatToBeatInterval(i);
		}
		var meanBeatToBeat = sumBeatToBeat / count.toFloat();
		
		var sumSquaredDeviations = 0;
		for (var i = startIndex; i < count; i ++) {			
			sumSquaredDeviations += Math.pow(me.getBeatToBeatInterval(i) - meanBeatToBeat, 2);
		}
		return Math.sqrt(sumSquaredDeviations / count.toFloat());
	}
		
	public function calculateHrvUsingRmssd() {
		if (me.mBeatToBeatIntervalsCount < 1) {
			return null;
		}
		
		var rootMeanSquareOfSuccessiveBtbDifferences = Math.sqrt(me.mSquareOfSuccessiveBtbDifferences / me.mBeatToBeatIntervalsCount);
		me.mHrvRmssdDataField.setData(rootMeanSquareOfSuccessiveBtbDifferences);
		return rootMeanSquareOfSuccessiveBtbDifferences;
	}
}