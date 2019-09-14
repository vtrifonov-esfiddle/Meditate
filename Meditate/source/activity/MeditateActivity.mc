using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.FitContributor;
using Toybox.Timer;
using Toybox.Math;
using Toybox.Sensor;
using HrvAlgorithms.HrvTracking;

class MediteActivity extends HrvAlgorithms.HrvAndStressActivity {
	private var mMeditateModel;
	private var mVibeAlertsExecutor;	
		
	function initialize(meditateModel, heartbeatIntervalsSensor) {
		var fitSessionSpec;
		if (meditateModel.getActivityType() == ActivityType.Yoga) {
			fitSessionSpec = HrvAlgorithms.FitSessionSpec.createYoga();
		}
		else {
			fitSessionSpec = HrvAlgorithms.FitSessionSpec.createCardio("Meditating");
		}
		me.mMeditateModel = meditateModel;	
		HrvAlgorithms.HrvAndStressActivity.initialize(fitSessionSpec, meditateModel.getHrvTracking(), heartbeatIntervalsSensor);			
	}
								
	protected function onBeforeStart(fitSession) {
		HrvAlgorithms.HrvAndStressActivity.onBeforeStart(fitSession);
		me.mVibeAlertsExecutor = new VibeAlertsExecutor(me.mMeditateModel);	
	}	
				
	protected function onRefreshHrvActivityStats(activityInfo, minHr, hrvSuccessive) {	
		if (activityInfo.elapsedTime != null) {
			me.mMeditateModel.elapsedTime = activityInfo.elapsedTime / 1000;
		}
		me.mMeditateModel.currentHr = activityInfo.currentHeartRate;
		me.mMeditateModel.minHr = minHr;
		me.mVibeAlertsExecutor.firePendingAlerts();	 
		me.mMeditateModel.hrvSuccessive = hrvSuccessive;
    	
	    Ui.requestUpdate();	    
	}	   	
	
	protected function onBeforeStop() {	
		HrvAlgorithms.HrvAndStressActivity.onBeforeStop();
		me.mVibeAlertsExecutor = null;
	}
		
	function calculateSummaryFields() {	
		var activitySummary = HrvAlgorithms.HrvAndStressActivity.calculateSummaryFields();	
		var summaryModel = new SummaryModel(activitySummary, me.mMeditateModel.getHrvTracking());
		return summaryModel;
	}
}