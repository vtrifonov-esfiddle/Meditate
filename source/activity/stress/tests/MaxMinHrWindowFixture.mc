class MaxMinHrWindow10Fixture {
	function initialize() {
		me.mMaxMinHrWindow10 = new MaxMinHrWindow(10);
	}
	
	private var mMaxMinHrWindow10;
	
	function add10NormalSamples() {
		mMaxMinHrWindow10.addHrSample(58);
		mMaxMinHrWindow10.addHrSample(60);
		mMaxMinHrWindow10.addHrSample(59);
		mMaxMinHrWindow10.addHrSample(58);
		mMaxMinHrWindow10.addHrSample(59);
		mMaxMinHrWindow10.addHrSample(65);
		mMaxMinHrWindow10.addHrSample(58);
		mMaxMinHrWindow10.addHrSample(59);
		mMaxMinHrWindow10.addHrSample(58);
		mMaxMinHrWindow10.addHrSample(60);
		mMaxMinHrWindow10.addHrSample(60);
	}
		
	function addNormalSampleLow() {
		mMaxMinHrWindow10.addHrSample(58);
	}
	
	function addNormalSampleHigh() {
		mMaxMinHrWindow10.addHrSample(61);
	}
	
	function addOutlierHigh() {
		mMaxMinHrWindow10.addHrSample(75);
	}
	
	function addOutlierLow() {
		mMaxMinHrWindow10.addHrSample(53);
	}
	
	function calculate() {
		return mMaxMinHrWindow10.calculate();
	}
	
	function isResultExpected(actual, expected) {		
		System.println("Max-Min HR Window 10 actual: " + actual + "; expected: " + expected);
		return actual == expected;		
	}	
}

class ExpectedMaxMinHr10 {
	const NormalSamples = 7;
	const NormalSamplesAndOutlierHigh = 17;
	const NormalSamplesAndOutlierLow = 12;
}