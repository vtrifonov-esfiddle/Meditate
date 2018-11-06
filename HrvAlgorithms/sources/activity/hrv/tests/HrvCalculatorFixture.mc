using Toybox.Math;

module HrvAlgorithms {
	class HrvCalculatorFixture{
		function initialize(hrvCalculator) {
			me.mHrvCalculator = hrvCalculator;
		}
		
		private var mHrvCalculator;
		
		function add1NormalInterval() {
			mHrvCalculator.addBeatToBeatInterval(1090.9);
		}
		
		function add6NormalIntervals() {
			mHrvCalculator.addBeatToBeatInterval(1090.9);
			mHrvCalculator.addBeatToBeatInterval(1016.9);
			mHrvCalculator.addBeatToBeatInterval(1016.9);
			mHrvCalculator.addBeatToBeatInterval(1034.4);
			mHrvCalculator.addBeatToBeatInterval(1016.9);
			mHrvCalculator.addBeatToBeatInterval(1052.6);
		}
		
		function add5MinNormalIntervals() {
			for (var i=1; i <= 5 * 10; i++) {
				add6NormalIntervals();
			}
		}
			
		function addOutlierInterval() {
			mHrvCalculator.addBeatToBeatInterval(1400.0);
		}
		
		function calculate() {
			var result = mHrvCalculator.calculate();
			return result;
		}
		
		function isResultExpected(actual, expected) {		
			System.println("Hrv Calculator result: actual: " + actual + "; expected: " + expected);
			var actualRound = Math.floor(actual * 100.0);
			var expectedRound = Math.floor(expected * 100.0);
			return actualRound == expectedRound;		
		}
	}
	
	class ExpectedHrvSdrr {
		const Expected6NormalIntervals = 26.95;
		const Expected5MinNormalIntervals = 26.95;
		const Expected6NormalIntervals1Outlier = 129.07;
		const Expected5NormalIntervals1Outlier = 139.41;
	}
}
