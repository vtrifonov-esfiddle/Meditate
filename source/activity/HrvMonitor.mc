using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

class HrvMonitor {
	function initialize(activitySession) {
		me.mHrvRmssdDataField = HrvMonitor.createHrvRmssdDataField(activitySession);
		me.mHrvBeatToBeatIntervalsDataField = HrvMonitor.createHrvBeatToBeatIntervalsDataField(activitySession);
		me.mHrvSdrrDataField = HrvMonitor.createHrvSdrrDataField(activitySession);
		me.mHrvSdrrFirst5MinDataField = HrvMonitor.createHrvSdrrFirst5MinDataField(activitySession);
		me.mHrvSdrrLast5MinDataField = HrvMonitor.createHrvSdrrLast5MinDataField(activitySession);
		
		me.mPreviousBeatToBeatInterval = null;
		me.mSquareOfSuccessiveBtbDifferences = 0.0;
		me.mBeatToBeatIntervalsCount = 0;
	}
		
	private var mHrvRmssdDataField;
	private var mHrvBeatToBeatIntervalsDataField;
	private var mHrvSdrrDataField;
	private var mHrvSdrrFirst5MinDataField;
	private var mHrvSdrrLast5MinDataField;
	
	private var mPreviousBeatToBeatInterval;
	private var mSquareOfSuccessiveBtbDifferences;	
	private var mBeatToBeatIntervalsCount;
			
	private static const HrvBeatToBeatIntervalsFieldId = 1;	
	
	private static const HrvSdrrFieldId = 2;
	private static const HrvSdrrFirst5MinFieldId = 3;
	private static const HrvSdrrLast5MinFieldId = 4;
	
	private static const HrvRmssdFieldId = 5;
	
	
	private static function createHrvRmssdDataField(activitySession) {
		var hrvRmssdDataField = activitySession.createField(
            "hrv_rmssd",
            HrvMonitor.HrvRmssdFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvRmssdDataField;
	}
	
	private static function createHrvSdrrDataField(activitySession) {
		var hrvSdrrDataField = activitySession.createField(
            "hrv_sdrr",
            HrvMonitor.HrvSdrrFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvSdrrDataField;
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
	
	private function storeBeatToBeatInterval(index, beatToBeatInterval) {	
		return App.getApp().Storage.setValue("btb" + index, beatToBeatInterval);
	}
	
	private function getBeatToBeatInterval(index) {
		return App.getApp().Storage.getValue("btb" + index);
	}
		
	private function addBeatToBeatInterval(beatToBeatInterval) {
		if (me.mPreviousBeatToBeatInterval != null) {
			me.mBeatToBeatIntervalsCount++;		
			
			me.storeBeatToBeatInterval(me.mBeatToBeatIntervalsCount - 1, beatToBeatInterval);
			me.mSquareOfSuccessiveBtbDifferences += Math.pow(beatToBeatInterval - me.mPreviousBeatToBeatInterval, 2);
		}		
		me.mPreviousBeatToBeatInterval = beatToBeatInterval;
	}
	
	public function calculateHrvUsingSdrr() {
		var sdrr = me.calculateHrvUsingSdrrSubset(0, me.mBeatToBeatIntervalsCount);
		me.mHrvSdrrDataField.setData(sdrr);
		return sdrr;
	}
	
	public function calculateHrvFirst5MinSdrr() {
		var count;
		if (me.mBeatToBeatIntervalsCount > 300) {
			count = 300;
		}
		else {
			count = me.mBeatToBeatIntervalsCount;
		}
		var sdrr = me.calculateHrvUsingSdrrSubset(0, count);
		me.mHrvSdrrFirst5MinDataField.setData(sdrr);
		return sdrr;
	}
	
	public function calculateHrvLast5MinSdrr() {
		var startIndex = me.mBeatToBeatIntervalsCount - 300 - 1;
		if (startIndex < 0) {
			startIndex = 0;
		}
		var sdrr = me.calculateHrvUsingSdrrSubset(startIndex, me.mBeatToBeatIntervalsCount);
		me.mHrvSdrrLast5MinDataField.setData(sdrr);
		return sdrr;
	}
	
	private function calculateHrvUsingSdrrSubset(startIndex, count) {
		if (me.mBeatToBeatIntervalsCount < 1) {
			return null;
		}
		
		var sumBeatToBeat = 0;
		for (var i = startIndex; i < count; i ++) {
			sumBeatToBeat += me.getBeatToBeatInterval(i);
		}
		var meanBeatToBeat = sumBeatToBeat / me.mBeatToBeatIntervalsCount.toFloat();
		
		var sumSquaredDeviations = 0;
		for (var i = startIndex; i < count; i ++) {			
			sumSquaredDeviations += Math.pow(me.getBeatToBeatInterval(i) - meanBeatToBeat, 2);
		}
		
		var sdrr = Math.sqrt(sumSquaredDeviations / me.mBeatToBeatIntervalsCount.toFloat());
		return sdrr;
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