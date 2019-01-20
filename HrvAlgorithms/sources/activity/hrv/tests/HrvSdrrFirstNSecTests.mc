using Toybox.Test;

module HrvAlgorithms {
	class HrvSdrrFirstNSecTests {
		(:test)
		static function noBeatToBeatIntervalCalculate(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrFirstNSec(10));
			var result = calculatorFixture.calculate();
			return result == null;	
		}
		
		(:test)
		static function oneBeatToBeatIntervalCalculate(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrFirstNSec(10));
			calculatorFixture.add1NormalInterval();
			var result = calculatorFixture.calculate();
			return result == null;	
		}
		
		(:test)
		static function FiveMinNormalIntervals(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrFirstNSec(5 * 60));
			calculatorFixture.add5MinNormalIntervals();
			
			var result = calculatorFixture.calculate();
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected5MinNormalIntervals);	
		}
		
		(:test)
		static function FiveMinNormalIntervalsMaxIntervals5Min(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrFirstNSec(3 * 5 * 60));
			calculatorFixture.add5MinNormalIntervals();
			
			var result = calculatorFixture.calculate();
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected5MinNormalIntervals);	
		}
		
		(:test)
		static function FiveMinCalculator10MinNormalIntervals(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrFirstNSec(10 * 5 * 60));
			calculatorFixture.add5MinNormalIntervals();
			calculatorFixture.add5MinNormalIntervals();
			
			var result = calculatorFixture.calculate();
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected5MinNormalIntervals);	
		}
		
		(:test)
		static function SixSec6NormalIntervals(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrFirstNSec(6));
			calculatorFixture.add6NormalIntervals();
			var result = calculatorFixture.calculate();		
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected6NormalIntervals);	
		}
		
		(:test)
		static function SixSec6NormalIntervalsOneOutlier(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrFirstNSec(6));
			calculatorFixture.add6NormalIntervals();
			calculatorFixture.addOutlierInterval();
			var result = calculatorFixture.calculate();		
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected6NormalIntervals);	
		}
		
		(:test)
		static function SevenSec6NormalAndOneOutlierIntervals(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrFirstNSec(7));
			calculatorFixture.add6NormalIntervals();
			calculatorFixture.addOutlierInterval();
			var result = calculatorFixture.calculate();
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected6NormalIntervals1Outlier);	
		}
	}
}