using Toybox.Test;
using Toybox.Math;
using Toybox.System;

class MaxMinHrWindowStatsTests {
	(:test)
	static function evenWindowsMedian(logger) {
		var stats = buildEvenWindowsCountStats();
		return isResultExpected(stats.median, 5.5);		
	}
	
	(:test)
	static function evenWindowsNoStress(logger) {
		var stats = buildEvenWindowsCountStats();
		return isResultExpected(stats.noStress, 50.0);		
	}
	
	(:test)
	static function evenWindowsMediumStress(logger) {
		var stats = buildEvenWindowsCountStats();
		return isResultExpected(stats.mediumStress, 25.0);		
	}
	
	(:test)
	static function evenWindowsHighStress(logger) {
		var stats = buildEvenWindowsCountStats();
		return isResultExpected(stats.highStress, 25.0);		
	}
	
	private static function buildEvenWindowsCountStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(5);
		maxMinHrWindowStats.addMaxMinHrWindow(4);		
		maxMinHrWindowStats.addMaxMinHrWindow(13);
		maxMinHrWindowStats.addMaxMinHrWindow(12);
		maxMinHrWindowStats.addMaxMinHrWindow(6);
		maxMinHrWindowStats.addMaxMinHrWindow(7);		
		
		return maxMinHrWindowStats.calculate();
	}
	
	(:test)
	static function oddWindowsMedian(logger) {
		var stats = buildOddWindowsCountStats();
		return isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function oddWindowsNoStress(logger) {
		var stats = buildOddWindowsCountStats();
		return isResultExpected(stats.noStress, 55.5555);		
	}
	
	(:test)
	static function oddWindowsMediumStress(logger) {
		var stats = buildOddWindowsCountStats();
		return isResultExpected(stats.mediumStress, 22.22);		
	}
	
	(:test)
	static function oddWindowsHighStress(logger) {
		var stats = buildOddWindowsCountStats();
		return isResultExpected(stats.highStress, 22.22);		
	}
	
	private static function buildOddWindowsCountStats() {
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
		
		return maxMinHrWindowStats.calculate();
	}
	
	private static function buildMixedWindowsStats() {
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
		
		return maxMinHrWindowStats.calculate();
	}
	
	(:test)
	static function mixedWindowsMedian(logger) {
		var stats = buildMixedWindowsStats();
		return isResultExpected(stats.median, 6.0);		
	}
	
	(:test)
	static function mixedWindowsNoStress(logger) {
		var stats = buildMixedWindowsStats();
		return isResultExpected(stats.noStress, 52.0);		
	}
	
	(:test)
	static function mixedWindowsMediumStress(logger) {
		var stats = buildMixedWindowsStats();
		return isResultExpected(stats.mediumStress, 20.0);		
	}
	
	(:test)
	static function mixedWindowsHighStress(logger) {
		var stats = buildMixedWindowsStats();
		return isResultExpected(stats.highStress, 28.0);		
	}
	
	private static function isResultExpected(actual, expected) {		
		System.println("Max-Min HR Window Stats: " + actual + "; expected: " + expected);
		var actualRound = Math.round(actual * 100.0);
		var expectedRound = Math.round(expected * 100.0);
		return actualRound == expectedRound;		
	}
}