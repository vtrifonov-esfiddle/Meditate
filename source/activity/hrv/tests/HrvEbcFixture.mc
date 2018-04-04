using Toybox.Math;

class HrvEbcFixture{
	function initialize(intervalsCount) {
		me.mHrvEbc = new HrvEbc(intervalsCount);
	}
	
	private var mHrvEbc;
	
	function add1NormalInterval() {
		mHrvEbc.addBeatToBeatInterval(1090.9);
	}
	
	function add10NormalIntervals() {
		mHrvEbc.addBeatToBeatInterval(1034.48);
		mHrvEbc.addBeatToBeatInterval(1000.0);
		mHrvEbc.addBeatToBeatInterval(1016.94);
		mHrvEbc.addBeatToBeatInterval(1034.48);
		mHrvEbc.addBeatToBeatInterval(1016.94);
		mHrvEbc.addBeatToBeatInterval(1034.48);
		mHrvEbc.addBeatToBeatInterval(1034.48);
		mHrvEbc.addBeatToBeatInterval(1016.94);
		mHrvEbc.addBeatToBeatInterval(1034.48);
		mHrvEbc.addBeatToBeatInterval(1000.0);
		mHrvEbc.addBeatToBeatInterval(1000.0);
		
	}
	
	function addNormalIntervalLow() {
		mHrvEbc.addBeatToBeatInterval(1010.4);
	}
	
	function addNormalIntervalHigh() {
		mHrvEbc.addBeatToBeatInterval(1084.3);
	}
	
	function addOutlierHigh() {
		mHrvEbc.addBeatToBeatInterval(1300.0);
	}
	
	function addOutlierLow() {
		mHrvEbc.addBeatToBeatInterval(800.0);
	}
	
	function add16NormalIntervals() {
		add10NormalIntervals();
		mHrvEbc.addBeatToBeatInterval(1000.0);
		mHrvEbc.addBeatToBeatInterval(1016.94);
		mHrvEbc.addBeatToBeatInterval(1016.94);
		mHrvEbc.addBeatToBeatInterval(1052.63);
		mHrvEbc.addBeatToBeatInterval(1034.48);
		mHrvEbc.addBeatToBeatInterval(1000.0);		
	}
			
	function calculate() {
		var result = mHrvEbc.calculate();
		return result;
	}
	
	function isResultExpected(actual, expected) {		
		System.println("HRV EBC actual: " + actual + "; expected: " + expected);
		var actualRound = Math.round(actual * 100.0);
		var expectedRound = Math.round(expected * 100.0);
		return actualRound == expectedRound;		
	}
}

class ExpectedHrvEbc {
	const ExpectedEbc10 = 34.48;	
	const ExpectedEbc10OutlierHigh = 300.0;
	const ExpectedEbc10OutlierLow = 234.48;
	const ExpectedEbc16 = 52.63;
}
