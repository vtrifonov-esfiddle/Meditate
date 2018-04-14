using Toybox.FitContributor;
using Toybox.Math;
using Toybox.Application as App;

class StressMonitor {
	function initialize(activitySession) {	
		me.mStressTracking = GlobalSettings.loadStressTracking();
		if (me.mStressTracking == StressTracking.OnDetailed) {		
			me.mMaxMinHrWindowDataField = StressMonitor.createMaxMinHrWindowDataField(activitySession);
		}
		else {
			me.mMaxMinHrWindowDataField = null;
		}
		if (me.mStressTracking != StressTracking.Off) {
			me.mStressMedianDataField = createStressMedianDataField(activitySession);
			me.mNoStressDataField = StressMonitor.createNoStressDataField(activitySession);
			me.mLowStressDataField = StressMonitor.createLowStressDataField(activitySession);
			me.mHighStressDataField = StressMonitor.createHighStressDataField(activitySession);
		}
		else {
			me.mStressMedianDataField = null;
			me.mNoStressDataField = null;
			me.mLowStressDataField = null;
			me.mHighStressDataField = null;
		}
		me.mMaxMinHrWindow10 = new MaxMinHrWindow(10);	
		me.mMaxMinHrWindowStats = new MaxMinHrWindowStats();
				
	}
					
	private var mStressTracking;
		
	private var mMaxMinHrWindow10;
	private var mMaxMinHrWindowStats;
			
	private var mMaxMinHrWindowDataField;
	private var mStressMedianDataField;
	private var mNoStressDataField;
	private var mLowStressDataField;
	private var mHighStressDataField;
				
	private static const MaxMinHrWindowDataFieldId = 4;
	private static const StressMedianDataFieldId = 5;
	private static const NoStressDataFieldId = 6;
	private static const LowStressDataFieldId = 7;
	private static const HighStressDataFieldId = 8;
	
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
		
	function addHrSample(hr) {
		if (hr != null) {
			me.mMaxMinHrWindow10.addHrSample(hr);
			me.calculateMaxMinHrWindow10();
		}
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