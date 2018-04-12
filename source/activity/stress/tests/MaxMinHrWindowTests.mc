class MaxMinHrWindowTests {
	(:test)
	static function noSampleCalculate(logger) {
		var fixture = new MaxMinHrWindow10Fixture();
		var actual = fixture.calculate();
		return actual == null;
	}
	
	(:test)
	static function caclulateLessThan10Samples(logger) {
		var fixture = new MaxMinHrWindow10Fixture();
		for (var i = 1; i < 10; i++) {
			fixture.addNormalSampleLow();
			var intermediateResult = fixture.calculate();
			if (intermediateResult != null) {
				logger.error("Max-Min HR Window 10 intermediate calculations must be null.");
			}
			
		}
		var actual = fixture.calculate();
		return actual == null;
	}
	
	(:test)
	static function calculate10NormalSamples(logger) {
		var fixture = new MaxMinHrWindow10Fixture();
		fixture.add10NormalSamples();
		var actual = fixture.calculate();
		return actual == ExpectedMaxMinHr10.NormalSamples;
	}
	
	(:test)
	static function calculate10NormalAndOutlierHigh(logger) {
		var fixture = new MaxMinHrWindow10Fixture();
		fixture.add10NormalSamples();
		fixture.addOutlierHigh();
		var actual = fixture.calculate();
		return actual == ExpectedMaxMinHr10.NormalSamplesAndOutlierHigh;
	}
	
	(:test)
	static function calculate10OutlierHighAndNormal(logger) {
		var fixture = new MaxMinHrWindow10Fixture();
		fixture.addOutlierHigh();
		fixture.add10NormalSamples();
		var actual = fixture.calculate();
		return actual == ExpectedMaxMinHr10.NormalSamples;
	}
	
	(:test)
	static function calculate10NormalAndOutlierLow(logger) {
		var fixture = new MaxMinHrWindow10Fixture();
		fixture.add10NormalSamples();
		fixture.addOutlierLow();
		var actual = fixture.calculate();
		return actual == ExpectedMaxMinHr10.NormalSamplesAndOutlierLow;
	}
	
	(:test)
	static function calculate10SameSamples(logger) {
		var fixture = new MaxMinHrWindow10Fixture();
		for (var i = 1; i <= 10; i++) {
			fixture.addNormalSampleLow();
		}
		var actual = fixture.calculate();
		return actual == 0;
	}
}