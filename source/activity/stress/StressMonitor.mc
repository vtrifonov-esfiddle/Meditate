using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

class StressMonitor {
	function initialize(activitySession) {	
		me.mStressTracking = GlobalSettings.loadStressTracking();
		if (me.mStressTracking == StressTracking.OnDetailed) {		
			me.mMaxMinHrWindowDataField = StressMonitor.createMaxMinHrWindowDataField(activitySession);
			me.mMaxMinHrvWindowDataField = StressMonitor.createMaxMinHrvWindowDataField(activitySession);
		}
		if (me.mStressTracking != StressTracking.Off) {
			me.mStressMedianDataField = createStressMedianDataField(activitySession);
			me.mNoStressDataField = StressMonitor.createNoStressDataField(activitySession);
			me.mLowStressDataField = StressMonitor.createLowStressDataField(activitySession);
			me.mHighStressDataField = StressMonitor.createHighStressDataField(activitySession);
		}
		me.mMaxMinHrWindow10 = new MaxMinHrWindow(10);			
		me.mMaxMinHrvWindow10 = new MaxMinHrvWindow(10);
		me.mMaxMinHrWindowStats = new MaxMinHrWindowStats();				
	}
					
	private var mStressTracking;
		
	private var mMaxMinHrWindow10;
	private var mMaxMinHrvWindow10;
	private var mMaxMinHrWindowStats;
	
	private var mMaxMinHrvWindowDataField;		
	private var mMaxMinHrWindowDataField;
	private var mStressMedianDataField;
	private var mNoStressDataField;
	private var mLowStressDataField;
	private var mHighStressDataField;
	
	private static const MaxMinHrvWindowDataFieldId = 6;			
	private static const MaxMinHrWindowDataFieldId = 5;
	private static const StressMedianDataFieldId = 1;
	private static const NoStressDataFieldId = 2;
	private static const LowStressDataFieldId = 3;
	private static const HighStressDataFieldId = 4;
	
	private static function createStressMedianDataField(activitySession) {
		return activitySession.createField(
            "stress_m",
            StressMedianDataFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"bmp"}
        );
	}
	
	private static function createNoStressDataField(activitySession) {
		return activitySession.createField(
            "stress_no",
            NoStressDataFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"%"}
        );
	}
	
	private static function createLowStressDataField(activitySession) {
		return activitySession.createField(
            "stress_low",
            LowStressDataFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"%"}
        );
	}
	
	private static function createHighStressDataField(activitySession) {
		return activitySession.createField(
            "stress_high",
            HighStressDataFieldId,
            FitContributor.DATA_TYPE_FLOAT,
            {:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"%"}
        );
	}
	
	private static function createMaxMinHrWindowDataField(activitySession) {
		return activitySession.createField(
            "hrv_mmhr",
            MaxMinHrWindowDataFieldId,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"bmp"}
        );
	}	
	
	private static function createMaxMinHrvWindowDataField(activitySession) {
		return activitySession.createField(
            "hrv_mmhrv",
            MaxMinHrvWindowDataFieldId,
            FitContributor.DATA_TYPE_UINT16,
            {:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"ms"}
        );
	}	
		
	function addHrSample(hr) {
		me.mMaxMinHrWindow10.addHrSample(hr);
		me.calculateMaxMinHrWindow10();
	}
	
	function addOneSecBeatToBeatIntervals(beatToBeatIntervals) {
		me.mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals(beatToBeatIntervals);
	}
	
	private function calculateMaxMinHrWindow10() {
		var result = me.mMaxMinHrWindow10.calculate();
		if (result != null) {
			if (me.mMaxMinHrWindowDataField != null) {
				me.mMaxMinHrWindowDataField.setData(result);
			}
			me.mMaxMinHrWindowStats.addMaxMinHrWindow(result);
		}
	}
	
	private function calculateMaxMinHrvWindow10() {
		var result = me.mMaxMinHrvWindow10.calculate();
		if (result != null) {
			if (me.mMaxMinHrvWindowDataField != null) {
				me.mMaxMinHrvWindowDataField.setData(result);
			}
		}
	}
		
	public function calculateStressStats() {
		if (me.mStressTracking == StressTracking.Off) {
			return null;
		}
		var stressStats = me.mMaxMinHrWindowStats.calculate();		
		if (stressStats.median != null) {
			if (me.mStressTracking == StressTracking.OnDetailed) {
				me.mStressMedianDataField.setData(stressStats.median);
			}
			me.mNoStressDataField.setData(stressStats.noStress);
			me.mLowStressDataField.setData(stressStats.lowStress);
			me.mHighStressDataField.setData(stressStats.highStress);
		}
		return stressStats;
	}	
}