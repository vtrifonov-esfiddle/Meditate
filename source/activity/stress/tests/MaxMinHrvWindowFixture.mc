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
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals([1000]);
	}
		
	function addNormalSampleLow() {
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals(58);
	}
	
	function addNormalSampleHigh() {
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals(61);
	}
	
	function addOutlierHigh() {
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals(75);
	}
	
	function addOutlierLow() {
		mMaxMinHrvWindow10.addOneSecBeatToBeatIntervals(53);
	}
	
	function calculate() {
		return mMaxMinHrvWindow10.calculate();
	}
	
	function isResultExpected(actual, expected) {		
		System.println("Max-Min HRV Window 10 actual: " + actual + "; expected: " + expected);
		return actual == expected;		
	}	
}

class ExpectedMaxMinHr10 {
	const NormalSamples = 7;
	const NormalSamplesAndOutlierHigh = 17;
	const NormalSamplesAndOutlierLow = 12;
}