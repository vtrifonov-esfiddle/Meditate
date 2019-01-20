using Toybox.System;

class SummaryRollupModel {
	function initialize() {		
		me.mSummaryModels = {};
	}
	
	private var mSummaryModels;
	
	public function addSummary(summaryModel) {
		var newSummaryIndex = me.mSummaryModels.size();
		mSummaryModels[newSummaryIndex] = summaryModel;
	}
	
	public function getSummary(index) {
		return me.mSummaryModels[index];
	}
	
	public function getSummaries() {
		return me.mSummaryModels;
	}
}