using Toybox.Test;

module HrvAlgorithms {
	class HrvSdrrLastNSecTests {
		(:test)
		static function noBeatToBeatIntervalCalculate(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrLastNSec(10));
			var result = calculatorFixture.calculate();
			return result == null;	
		}
		
		(:test)
		static function oneBeatToBeatIntervalCalculate(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrLastNSec(10));
			calculatorFixture.add1NormalInterval();
			var result = calculatorFixture.calculate();
			return result == null;	
		}
		
		(:test)
		static function oneLessThanTheIntervalsCount(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrLastNSec(7));
			calculatorFixture.add6NormalIntervals();
			var result = calculatorFixture.calculate();
			return result == null;	
		}
		
		(:test)
		static function FiveMinNormalIntervals(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrLastNSec(5 * 60));
			calculatorFixture.add5MinNormalIntervals();
			
			var result = calculatorFixture.calculate();
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected5MinNormalIntervals);	
		}
		
		(:test)
		static function FiveMinIntervalsCountOneOutlierBefore5MinIntervals(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrLastNSec(5 * 60));
			calculatorFixture.addOutlierInterval();
			calculatorFixture.add5MinNormalIntervals();
			
			var result = calculatorFixture.calculate();
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected5MinNormalIntervals);	
		}
		
		(:test)
		static function FiveMinIntervalsCount10MinNormalIntervals(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrLastNSec(5 * 60));
			calculatorFixture.add5MinNormalIntervals();
			calculatorFixture.add5MinNormalIntervals();
			
			var result = calculatorFixture.calculate();
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected5MinNormalIntervals);	
		}
		
		(:test)
		static function SixSec6NormalIntervals(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrLastNSec(6));
			calculatorFixture.add6NormalIntervals();
			var result = calculatorFixture.calculate();		
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected6NormalIntervals);	
		}
		
		(:test)
		static function SixSec6NormalIntervalsOneOutlier(logger) {
			var calculatorFixture = new HrvCalculatorFixture(new HrvSdrrLastNSec(6));
			calculatorFixture.add6NormalIntervals();
			calculatorFixture.addOutlierInterval();
			var result = calculatorFixture.calculate();		
			return calculatorFixture.isResultExpected(result, ExpectedHrvSdrr.Expected5NormalIntervals1Outlier);	
		}
	}
}