using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

class HrvMonitor {
	function initialize(activitySession) {
		me.mHrvBeatToBeatIntervalsDataField = HrvMonitor.createHrvBeatToBeatIntervalsDataField(activitySession);
		me.mHrvSdrrFirst5MinDataField = HrvMonitor.createHrvSdrrFirst5MinDataField(activitySession);
		me.mHrvSdrrLast5MinDataField = HrvMonitor.createHrvSdrrLast5MinDataField(activitySession);
		me.mHrvEbc10DataField = HrvMonitor.createHrvEbc10DataField(activitySession);
		me.mHrvEbc16DataField = HrvMonitor.createHrvEbc16DataField(activitySession);
		me.mMaxMinHrWindowDataField = HrvMonitor.createMaxMinHrWindowDataField(activitySession);
		me.mStressMedianDataField = HrvMonitor.createStressMedianDataField(activitySession);
		me.mNoStressDataField = HrvMonitor.createNoStressDataField(activitySession);
		me.mMediumStressDataField = HrvMonitor.createMediumStressDataField(activitySession);
		me.mHighStressDataField = HrvMonitor.createHighStressDataField(activitySession);
		
		me.mHrvSdrrFirst5Min = new HrvSdrrFirstNSec(Buffer5MinLength);
		me.mHrvSdrrLast5Min = new HrvSdrrLastNSec(Buffer5MinLength);
		me.mHrvEbc10 = new HrvEbc(10);
		me.mHrvEbc16 = new HrvEbc(16);	
		me.mMaxMinHrWindow10 = new MaxMinHrWindow(10);	
		me.mMaxMinHrWindowStats = new MaxMinHrWindowStats();
	}
	
	private const Buffer5MinLength = 300;
	
	private var mHrvSdrrFirst5Min;
	private var mHrvSdrrLast5Min;	
	private var mHrvEbc10;
	private var mHrvEbc16;
	private var mMaxMinHrWindow10;
	private var mMaxMinHrWindowStats;
	
	private var mHrvBeatToBeatIntervalsDataField;
	private var mHrvSdrrFirst5MinDataField;
	private var mHrvSdrrLast5MinDataField;			
	private var mHrvEbc10DataField;
	private var mHrvEbc16DataField;		
	private var mMaxMinHrWindowDataField;
	private var mStressMedianDataField;
	private var mNoStressDataField;
	private var mMediumStressDataField;
	private var mHighStressDataField;
			
	private static const HrvBeatToBeatIntervalsFieldId = 1;		
	private static const HrvSdrrFirst5MinFieldId = 2;
	private static const HrvSdrrLast5MinFieldId = 3;	
	private static const HrvEbc10FieldId = 4;
	private static const HrvEbc16FieldId = 5;
	private static const MaxMinHrWindowDataFieldId = 6;
	private static const StressMedianDataFieldId = 7;
	private static const NoStressDataFieldId = 8;
	private static const MediumStressDataFieldId = 9;
	private static const HighStressDataFieldId = 10;
	
	private static function createStressMedianDataField(activitySession) {
		return activitySession.createField(
            "stress_m",
            HrvMonitor.StressMedianDataFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"bmp"}
        );
	}
	
	private static function createNoStressDataField(activitySession) {
		return activitySession.createField(
            "stress_no",
            HrvMonitor.NoStressDataFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"%"}
        );
	}
	
	private static function createMediumStressDataField(activitySession) {
		return activitySession.createField(
            "stress_med",
            HrvMonitor.MediumStressDataFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"%"}
        );
	}
	
	private static function createHighStressDataField(activitySession) {
		return activitySession.createField(
            "stress_high",
            HrvMonitor.HighStressDataFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"%"}
        );
	}
	
	private static function createMaxMinHrWindowDataField(activitySession) {
		return activitySession.createField(
            "hrv_mmhr",
            HrvMonitor.MaxMinHrWindowDataFieldId,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"bmp"}
        );
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
	
	private static function createHrvEbc10DataField(activitySession) {
		var hrvEbc10DataField = activitySession.createField(
            "hrv_ebc10",
            HrvMonitor.HrvEbc10FieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
        return hrvEbc10DataField;
	}
	
	private static function createHrvEbc16DataField(activitySession) {
		var hrvEbc16DataField = activitySession.createField(
            "hrv_ebc16",
            HrvMonitor.HrvEbc16FieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
        return hrvEbc16DataField;
	}
		
	function addHrSample(hr) {
		if (hr != null) {
			var beatToBeatInterval = 60000.toFloat() / hr.toFloat();		
			me.mHrvBeatToBeatIntervalsDataField.setData(beatToBeatInterval.toNumber());
			
			me.mHrvSdrrFirst5Min.addBeatToBeatInterval(beatToBeatInterval);
			me.mHrvSdrrLast5Min.addBeatToBeatInterval(beatToBeatInterval);
			me.mHrvEbc10.addBeatToBeatInterval(beatToBeatInterval);
			me.mHrvEbc16.addBeatToBeatInterval(beatToBeatInterval);
			me.mMaxMinHrWindow10.addHrSample(hr);
			me.calculateMaxMinHrWindow10();
			me.calculateHrvEbc10();
			me.calculateHrvEbc16();
		}
	}
	
	private function calculateMaxMinHrWindow10() {
		var result = me.mMaxMinHrWindow10.calculate();
		if (result != null) {
			me.mMaxMinHrWindowDataField.setData(result);
			me.mMaxMinHrWindowStats.addMaxMinHrWindow(result);
		}
	}
	
	private function calculateHrvEbc10() {		
		var ebc10 = me.mHrvEbc10.calculate();
		if (ebc10 != null) {
			me.mHrvEbc10DataField.setData(ebc10);			
		}
	}
	
	private function calculateHrvEbc16() {		
		var ebc16 = me.mHrvEbc16.calculate();
		if (ebc16 != null) {
			me.mHrvEbc16DataField.setData(ebc16);
		}
	}
	
	public function calculateStressStats() {
		var stressStats = me.mMaxMinHrWindowStats.calculate();		
		if (stressStats.median != null) {
			me.mStressMedianDataField.setData(stressStats.median);
			me.mNoStressDataField.setData(stressStats.noStress);
			me.mMediumStressDataField.setData(stressStats.mediumStress);
			me.mHighStressDataField.setData(stressStats.highStress);
		}
		return stressStats;
	}
	
	public function calculateHrvFirst5MinSdrr() {		
		var sdrr = me.mHrvSdrrFirst5Min.calculate();
		if (sdrr != null) {
			me.mHrvSdrrFirst5MinDataField.setData(sdrr);
		}
		return sdrr;
	}
	
	public function calculateHrvLast5MinSdrr() {
		var sdrr = me.mHrvSdrrLast5Min.calculate();
		if (sdrr != null) {
			me.mHrvSdrrLast5MinDataField.setData(sdrr);
		}
		return sdrr;
	}
}