using Toybox.Test;
using Toybox.Math;
using Toybox.System;

class MaxMinHrvWindowStatsFixture {
	static function buildEvenWindowsCountStats() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();
		maxMinHrvWindowStats.addMaxMinHrvWindow(40);
		maxMinHrvWindowStats.addMaxMinHrvWindow(45);
		maxMinHrvWindowStats.addMaxMinHrvWindow(50);
		maxMinHrvWindowStats.addMaxMinHrvWindow(40);		
		maxMinHrvWindowStats.addMaxMinHrvWindow(130);
		maxMinHrvWindowStats.addMaxMinHrvWindow(120);
		maxMinHrvWindowStats.addMaxMinHrvWindow(66);
		maxMinHrvWindowStats.addMaxMinHrvWindow(72);		
		
		return MaxMinHrvWindowStatsFixture.calculate(maxMinHrvWindowStats);
	}
	
	static function buildOddWindowsCountStats() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();
		maxMinHrvWindowStats.addMaxMinHrvWindow(40);
		maxMinHrvWindowStats.addMaxMinHrvWindow(45);
		maxMinHrvWindowStats.addMaxMinHrvWindow(50);
		maxMinHrvWindowStats.addMaxMinHrvWindow(40);		
		maxMinHrvWindowStats.addMaxMinHrvWindow(130);
		maxMinHrvWindowStats.addMaxMinHrvWindow(120);
		maxMinHrvWindowStats.addMaxMinHrvWindow(66);
		maxMinHrvWindowStats.addMaxMinHrvWindow(72);	
		maxMinHrvWindowStats.addMaxMinHrvWindow(23);
		
		return MaxMinHrvWindowStatsFixture.calculate(maxMinHrvWindowStats);
	}
	
	static function buildMixedWindowsStats() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();
		maxMinHrvWindowStats.addMaxMinHrvWindow(43);
		maxMinHrvWindowStats.addMaxMinHrvWindow(44);
		maxMinHrvWindowStats.addMaxMinHrvWindow(55);
		maxMinHrvWindowStats.addMaxMinHrvWindow(43);
		maxMinHrvWindowStats.addMaxMinHrvWindow(137);
		maxMinHrvWindowStats.addMaxMinHrvWindow(123);
		maxMinHrvWindowStats.addMaxMinHrvWindow(62);
		maxMinHrvWindowStats.addMaxMinHrvWindow(74);
		maxMinHrvWindowStats.addMaxMinHrvWindow(26);
		maxMinHrvWindowStats.addMaxMinHrvWindow(33);
		maxMinHrvWindowStats.addMaxMinHrvWindow(92);
		maxMinHrvWindowStats.addMaxMinHrvWindow(130);
		maxMinHrvWindowStats.addMaxMinHrvWindow(124);
		maxMinHrvWindowStats.addMaxMinHrvWindow(63);
		maxMinHrvWindowStats.addMaxMinHrvWindow(72);
		maxMinHrvWindowStats.addMaxMinHrvWindow(33);
		maxMinHrvWindowStats.addMaxMinHrvWindow(74);
		maxMinHrvWindowStats.addMaxMinHrvWindow(26);
		maxMinHrvWindowStats.addMaxMinHrvWindow(39);
		maxMinHrvWindowStats.addMaxMinHrvWindow(170);
		maxMinHrvWindowStats.addMaxMinHrvWindow(202);
		maxMinHrvWindowStats.addMaxMinHrvWindow(253);
		maxMinHrvWindowStats.addMaxMinHrvWindow(87);
		maxMinHrvWindowStats.addMaxMinHrvWindow(38);
		maxMinHrvWindowStats.addMaxMinHrvWindow(44);
		
		return MaxMinHrvWindowStatsFixture.calculate(maxMinHrvWindowStats);
	}
	
	static function build9OnesAnd2to9() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();
		for (var i = 1; i <= 9; i++) {
			maxMinHrvWindowStats.addMaxMinHrvWindow(10);
		}
		for (var i = 2; i <= 9; i++) {
			maxMinHrvWindowStats.addMaxMinHrvWindow(i * 10);
		}
		return MaxMinHrvWindowStatsFixture.calculate(maxMinHrvWindowStats);
	}
	
	static function build10Zeroes() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();
		for (var i = 1; i <= 10; i++) {
			maxMinHrvWindowStats.addMaxMinHrvWindow(0);
		}
		return MaxMinHrvWindowStatsFixture.calculate(maxMinHrvWindowStats);
	}
	
	static function build0to10WindowsStats() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();
		
		for (var i=0; i <=10; i++) {
			maxMinHrvWindowStats.addMaxMinHrvWindow(i * 10);
		}
		
		return MaxMinHrvWindowStatsFixture.calculate(maxMinHrvWindowStats);
	}
			
	static function build0to9WindowsStats() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();
		
		for (var i=0; i <=9; i++) {
			maxMinHrvWindowStats.addMaxMinHrvWindow(i * 10);
		}
		
		return MaxMinHrvWindowStatsFixture.calculate(maxMinHrvWindowStats);
	}
			
	static function build10WindowStats() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();		
		maxMinHrvWindowStats.addMaxMinHrvWindow(10);
		return calculate(maxMinHrvWindowStats);
	}
		
	static function build1and10WindowsStats() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();		
		maxMinHrvWindowStats.addMaxMinHrvWindow(1);
		maxMinHrvWindowStats.addMaxMinHrvWindow(10);
		return MaxMinHrvWindowStatsFixture.calculate(maxMinHrvWindowStats);
	}
	
	static function buildNoWindowsStats() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();		
		return maxMinHrvWindowStats.calculate();
	}
	
	static function build1WindowStats() {
		var maxMinHrvWindowStats = new MaxMinHrvWindowStats();		
		maxMinHrvWindowStats.addMaxMinHrvWindow(1);
		return maxMinHrvWindowStats.calculate();
	}
	
	static function calculate(maxMinHrvWindowStats) {
		var stats = maxMinHrvWindowStats.calculate();
		var totalStress = stats.noStress + stats.lowStress + stats.highStress;
		System.println("Max-Min HRV total stress: " + totalStress + "; expected: 100%");
		var areEqual = MaxMinHrvWindowStatsFixture.isResultExpectedGeneric(totalStress, 100.0);
		Test.assert(areEqual);
		return stats;
	}	
	
	static function isResultExpectedGeneric(actual, expected) {		
		var actualRound = Math.round(actual * 100.0);
		var expectedRound = Math.round(expected * 100.0);
		return actualRound == expectedRound;		
	}
			
	static function isResultExpected(actual, expected) {		
		System.println("Max-Min HRV Window Stats: " + actual + "; expected: " + expected);
		return isResultExpectedGeneric(actual, expected);	
	}
}