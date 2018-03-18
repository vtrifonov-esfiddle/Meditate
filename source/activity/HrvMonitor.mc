using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

class HrvMonitor {
	function initialize(activitySession) {
		me.mHrvRmssdDataField = HrvMonitor.createHrvRmssdDataField(activitySession);
		me.mHrvBeatToBeatIntervalsDataField = HrvMonitor.createHrvBeatToBeatIntervalsDataField(activitySession);
		me.mHrvSdnnDataField = HrvMonitor.createHrvSdnnDataField(activitySession);
		me.mPreviousBeatToBeatInterval = null;
		me.mSquareOfSuccessiveBtbDifferences = 0.0;
		me.mBeatToBeatIntervalsCount = 0;
	}
		
	private var mHrvRmssdDataField;
	private var mHrvBeatToBeatIntervalsDataField;
	private var mHrvSdnnDataField;
	
	private var mPreviousBeatToBeatInterval;
	private var mSquareOfSuccessiveBtbDifferences;	
	private var mBeatToBeatIntervalsCount;
		
	private static const HrvRmssdFieldId = 1;
	private static const HrvBeatToBeatIntervalsFieldId = 2;
	private static const HrvSdnnFieldId = 3;
	
	private static function createHrvRmssdDataField(activitySession) {
		var hrvRmssdDataField = activitySession.createField(
            "hrv_rmssd",
            HrvMonitor.HrvRmssdFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvRmssdDataField;
	}
	
	private static function createHrvSdnnDataField(activitySession) {
		var hrvSdnnDataField = activitySession.createField(
            "hrv_sdnn",
            HrvMonitor.HrvSdnnFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"ms"}
        );
        return hrvSdnnDataField;
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
	
	public function calculateHrvUsingSdnn() {
		if (me.mBeatToBeatIntervalsCount < 1) {
			return null;
		}
		
		var sumBeatToBeat = 0;
		for (var i = 0; i < me.mBeatToBeatIntervalsCount; i ++) {
			sumBeatToBeat += me.getBeatToBeatInterval(i);
		}
		var meanBeatToBeat = sumBeatToBeat / me.mBeatToBeatIntervalsCount.toFloat();
		
		var sumSquaredDeviations = 0;
		for (var i = 0; i < me.mBeatToBeatIntervalsCount; i ++) {			
			sumSquaredDeviations += Math.pow(me.getBeatToBeatInterval(i) - meanBeatToBeat, 2);
		}
		
		var sdnn = Math.sqrt(sumSquaredDeviations / me.mBeatToBeatIntervalsCount.toFloat());
		me.mHrvSdnnDataField.setData(sdnn);
		return sdnn;
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