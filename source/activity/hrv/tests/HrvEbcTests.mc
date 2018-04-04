class HrvEbcTests {
	(:test)
	static function noBeatToBeatIntervalCalculate(logger) {
		var hrvEbcFixture = new HrvEbcFixture(10);
		var result = hrvEbcFixture.calculate();
		return result == null;	
	}
	
	(:test)
	static function hrvEbc10CalculateLessThan10Intervals(logger) {
		var hrvEbcFixture = new HrvEbcFixture(10);
		for (var i = 1; i < 5; i++) {
			hrvEbcFixture.addNormalIntervalLow();
			hrvEbcFixture.addNormalIntervalHigh();			
			var intermediateResult = hrvEbcFixture.calculate();
			if (intermediateResult != null) {
				logger.error("EBC Intermediate calculations bellow 10 must be null.");
			}
		}
		var result = hrvEbcFixture.calculate();
		return result == null;	
	}
	
	(:test)
	static function calculateHrvEbv10(logger) {
		var hrvEbcFixture = new HrvEbcFixture(10);
		hrvEbcFixture.add10NormalIntervals();
		var result = hrvEbcFixture.calculate();
		return hrvEbcFixture.isResultExpected(result, ExpectedHrvEbc.ExpectedEbc10);
	}
	
	(:test)
	static function calculateHrvEbv10NormalAndOutlierHigh(logger) {
		var hrvEbcFixture = new HrvEbcFixture(10);
		hrvEbcFixture.add10NormalIntervals();
		hrvEbcFixture.addOutlierHigh();
		
		var result = hrvEbcFixture.calculate();
		return hrvEbcFixture.isResultExpected(result, ExpectedHrvEbc.ExpectedEbc10OutlierHigh);
	}
	
	(:test)
	static function calculateHrvEbv10OutlierHighAndNormal(logger) {
		var hrvEbcFixture = new HrvEbcFixture(10);
		hrvEbcFixture.addOutlierHigh();
		hrvEbcFixture.add10NormalIntervals();
		
		var result = hrvEbcFixture.calculate();
		return hrvEbcFixture.isResultExpected(result, ExpectedHrvEbc.ExpectedEbc10);
	}
	
	(:test)
	static function calculateHrvEbv10NormalAndOutlierLow(logger) {
		var hrvEbcFixture = new HrvEbcFixture(10);
		hrvEbcFixture.add10NormalIntervals();
		hrvEbcFixture.addOutlierLow();
		
		var result = hrvEbcFixture.calculate();
		return hrvEbcFixture.isResultExpected(result, ExpectedHrvEbc.ExpectedEbc10OutlierLow);
	}
	
	(:test)
	static function calculateHrvEbv16(logger) {
		var hrvEbcFixture = new HrvEbcFixture(16);
		hrvEbcFixture.add16NormalIntervals();
		var result = hrvEbcFixture.calculate();
		return  hrvEbcFixture.isResultExpected(result, ExpectedHrvEbc.ExpectedEbc16);
	}
}