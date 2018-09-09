class MaxMinHrvWindow10Fixture {
	function initialize() {
		me.mMaxMinHrvWindow10 = new MaxMinHrvWindow(10);
	}
	
	private var mMaxMinHrvWindow10;
	
	function add10NormalSamples() {
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([1100]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([1000]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([1100]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([1083]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([967]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([983]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([966]);
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([1000]);
	}
		
	function addNormalSampleLow() {
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([1100]);
	}
	
	function addNormalSampleHigh() {
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([600]);
	}
	
	function addOutlierHigh() {
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([800]);
	}
	
	function addOutlierLow() {
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([1500]);
	}
	
	function calculate() {
		return mMaxMinHrvWindow10.calculate();
	}
	
	function isResultExpected(actual, expected) {		
		System.println("Max-Min HRV Window 10 actual: " + actual + "; expected: " + expected);
		return actual == expected;		
	}	
}

class ExpectedMaxMinHrv10 {
	const NormalSamples = 134;
	const NormalSamplesAndOutlierHigh = 300;
	const NormalSamplesAndOutlierLow = 534;
}