using Toybox.Test;
using Toybox.Math;
using Toybox.System;

class MaxMinHrWindowStatsFixture {
	static function buildEvenWindowsCountStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(5);
		maxMinHrWindowStats.addMaxMinHrWindow(4);		
		maxMinHrWindowStats.addMaxMinHrWindow(13);
		maxMinHrWindowStats.addMaxMinHrWindow(12);
		maxMinHrWindowStats.addMaxMinHrWindow(6);
		maxMinHrWindowStats.addMaxMinHrWindow(7);		
		
		return MaxMinHrWindowStatsFixture.calculate(maxMinHrWindowStats);
	}
	
	static function buildOddWindowsCountStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(5);
		maxMinHrWindowStats.addMaxMinHrWindow(4);		
		maxMinHrWindowStats.addMaxMinHrWindow(13);
		maxMinHrWindowStats.addMaxMinHrWindow(12);
		maxMinHrWindowStats.addMaxMinHrWindow(6);
		maxMinHrWindowStats.addMaxMinHrWindow(7);		
		maxMinHrWindowStats.addMaxMinHrWindow(2);
		
		return MaxMinHrWindowStatsFixture.calculate(maxMinHrWindowStats);
	}
	
	static function buildMixedWindowsStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(5);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(13);
		maxMinHrWindowStats.addMaxMinHrWindow(12);
		maxMinHrWindowStats.addMaxMinHrWindow(6);
		maxMinHrWindowStats.addMaxMinHrWindow(7);
		maxMinHrWindowStats.addMaxMinHrWindow(2);
		maxMinHrWindowStats.addMaxMinHrWindow(3);
		maxMinHrWindowStats.addMaxMinHrWindow(9);
		maxMinHrWindowStats.addMaxMinHrWindow(13);
		maxMinHrWindowStats.addMaxMinHrWindow(12);
		maxMinHrWindowStats.addMaxMinHrWindow(6);
		maxMinHrWindowStats.addMaxMinHrWindow(7);
		maxMinHrWindowStats.addMaxMinHrWindow(3);
		maxMinHrWindowStats.addMaxMinHrWindow(7);
		maxMinHrWindowStats.addMaxMinHrWindow(2);
		maxMinHrWindowStats.addMaxMinHrWindow(3);
		maxMinHrWindowStats.addMaxMinHrWindow(17);
		maxMinHrWindowStats.addMaxMinHrWindow(20);
		maxMinHrWindowStats.addMaxMinHrWindow(25);
		maxMinHrWindowStats.addMaxMinHrWindow(8);
		maxMinHrWindowStats.addMaxMinHrWindow(3);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		
		return MaxMinHrWindowStatsFixture.calculate(maxMinHrWindowStats);
	}
	
	static function build9OnesAnd2to9() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		for (var i = 1; i <= 9; i++) {
			maxMinHrWindowStats.addMaxMinHrWindow(1);
		}
		for (var i = 2; i <= 9; i++) {
			maxMinHrWindowStats.addMaxMinHrWindow(i);
		}
		return MaxMinHrWindowStatsFixture.calculate(maxMinHrWindowStats);
	}
	
	static function build10Zeroes() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		for (var i = 1; i <= 10; i++) {
			maxMinHrWindowStats.addMaxMinHrWindow(0);
		}
		return MaxMinHrWindowStatsFixture.calculate(maxMinHrWindowStats);
	}
	
	static function build0to10WindowsStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		
		for (var i=0; i <=10; i++) {
			maxMinHrWindowStats.addMaxMinHrWindow(i);
		}
		
		return MaxMinHrWindowStatsFixture.calculate(maxMinHrWindowStats);
	}
			
	static function build0to9WindowsStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		
		for (var i=0; i <=9; i++) {
			maxMinHrWindowStats.addMaxMinHrWindow(i);
		}
		
		return MaxMinHrWindowStatsFixture.calculate(maxMinHrWindowStats);
	}
			
	static function build10WindowStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		return calculate(maxMinHrWindowStats);
	}
		
	static function build1and10WindowsStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(1);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		return MaxMinHrWindowStatsFixture.calculate(maxMinHrWindowStats);
	}
	
	static function buildNoWindowsStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		return maxMinHrWindowStats.calculate();
	}
	
	static function build1WindowStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(1);
		return maxMinHrWindowStats.calculate();
	}
	
	static function calculate(maxMinHrWindowStats) {
		var stats = maxMinHrWindowStats.calculate();
		var totalStress = stats.noStress + stats.lowStress + stats.highStress;
		System.println("Max-Min HR total stress: " + totalStress + "; expected: 100%");
		var areEqual = MaxMinHrWindowStatsFixture.isResultExpectedGeneric(totalStress, 100.0);
		Test.assert(areEqual);
		return stats;
	}	
	
	static function isResultExpectedGeneric(actual, expected) {		
		var actualRound = Math.round(actual * 100.0);
		var expectedRound = Math.round(expected * 100.0);
		return actualRound == expectedRound;		
	}
			
	static function isResultExpected(actual, expected) {		
		System.println("Max-Min HR Window Stats: " + actual + "; expected: " + expected);
		return isResultExpectedGeneric(actual, expected);	
	}
}