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
	
	static function build0to10WindowsStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		
		for (var i=0; i <=10; i++) {
			maxMinHrWindowStats.addMaxMinHrWindow(i);
		}
		
		return maxMinHrWindowStats.calculate();
	}
	
	(:test)
	static function windows0to10Median(logger) {
		var stats = build0to10WindowsStats();
		return isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function windows0to10NoStress(logger) {
		var stats = build0to10WindowsStats();
		return isResultExpected(stats.noStress, 54.5454);		
	}
	
	(:test)
	static function windows0to10MediumStress(logger) {
		var stats = build0to10WindowsStats();
		return isResultExpected(stats.mediumStress, 36.3636);		
	}
	
	(:test)
	static function windows0to10HighStress(logger) {
		var stats = build0to10WindowsStats();
		return isResultExpected(stats.highStress, 9.0909);		
	}
	
	static function build0to9WindowsStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();
		
		for (var i=0; i <=9; i++) {
			maxMinHrWindowStats.addMaxMinHrWindow(i);
		}
		
		return maxMinHrWindowStats.calculate();
	}
	
	(:test)
	static function windows0to9Median(logger) {
		var stats = build0to9WindowsStats();
		return isResultExpected(stats.median, 4.5);		
	}
	
	(:test)
	static function windows0to9NoStress(logger) {
		var stats = build0to9WindowsStats();
		return isResultExpected(stats.noStress, 50.0);		
	}
	
	(:test)
	static function windows0to9MediumStress(logger) {
		var stats = build0to9WindowsStats();
		return isResultExpected(stats.mediumStress, 50.0);		
	}
	
	(:test)
	static function windows0to9HighStress(logger) {
		var stats = build0to9WindowsStats();
		return isResultExpected(stats.highStress, 0.0);		
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
	
	static function build1WindowStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(1);
		return maxMinHrWindowStats.calculate();
	}
	
	(:test)
	static function window1Median(logger) {
		var stats = build1WindowStats();
		return isResultExpected(stats.median, 1.0);		
	}
	
	(:test)
	static function window1NoStress(logger) {
		var stats = build1WindowStats();
		return isResultExpected(stats.noStress, 100.0);		
	}
	
	(:test)
	static function window1MediumStress(logger) {
		var stats = build1WindowStats();
		return isResultExpected(stats.mediumStress, 0.0);		
	}
	
	(:test)
	static function window1HighStress(logger) {
		var stats = build1WindowStats();
		return isResultExpected(stats.highStress, 0.0);		
	}
	
	static function build10WindowStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		return maxMinHrWindowStats.calculate();
	}
	
	(:test)
	static function window10Median(logger) {
		var stats = build10WindowStats();
		return isResultExpected(stats.median, 10.0);		
	}
	
	(:test)
	static function window10NoStress(logger) {
		var stats = build10WindowStats();
		return isResultExpected(stats.noStress, 0.0);		
	}
	
	(:test)
	static function window10MediumStress(logger) {
		var stats = build10WindowStats();
		return isResultExpected(stats.mediumStress, 0.0);		
	}
	
	(:test)
	static function window10HighStress(logger) {
		var stats = build10WindowStats();
		return isResultExpected(stats.highStress, 100.0);		
	}
	
	static function build1and10WindowsStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(1);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		return maxMinHrWindowStats.calculate();
	}
	
	(:test)
	static function windows1and10Median(logger) {
		var stats = build1and10WindowsStats();
		return isResultExpected(stats.median, 5.5);		
	}
	
	(:test)
	static function windows1and10NoStress(logger) {
		var stats = build1and10WindowsStats();
		return isResultExpected(stats.noStress, 50.0);		
	}
	
	(:test)
	static function windows1and10MediumStress(logger) {
		var stats = build1and10WindowsStats();
		return isResultExpected(stats.mediumStress, 0.0);		
	}
	
	(:test)
	static function windows1and10HighStress(logger) {
		var stats = build1and10WindowsStats();
		return isResultExpected(stats.highStress, 50.0);		
	}
	
	static function buildNoWindowsStats() {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		return maxMinHrWindowStats.calculate();
	}
	
	(:test)
	static function noWindowMedian(logger) {
		var stats = buildNoWindowsStats();
		return stats.median == null;		
	}
	
	(:test)
	static function noWindowNoStress(logger) {
		var stats = buildNoWindowsStats();
		return stats.noStress == null;		
	}
	
	(:test)
	static function noWindowMediumStress(logger) {
		var stats = buildNoWindowsStats();
		return stats.mediumStress == null;		
	}
	
	(:test)
	static function noWindowHighStress(logger) {
		var stats = buildNoWindowsStats();
		return stats.highStress == null;		
	}
	
	(:test)
	static function windows1two10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(1);
		maxMinHrWindowStats.addMaxMinHrWindow(5);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function windows0two10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(5);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function windows1double4and10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(1);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return isResultExpected(stats.median, 4.0);		
	}
	
	(:test)
	static function windows0double4and10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return isResultExpected(stats.median, 4.0);		
	}
	
	(:test)
	static function windows0triple4and10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return isResultExpected(stats.median, 4.0);		
	}
	
	(:test)
	static function windows0double10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return isResultExpected(stats.median, 10.0);		
	}
	
	(:test)
	static function windowsDouble0And10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return isResultExpected(stats.median, 0.0);		
	}
	
	private static function isResultExpected(actual, expected) {		
		System.println("Max-Min HR Window Stats: " + actual + "; expected: " + expected);
		var actualRound = Math.round(actual * 100.0);
		var expectedRound = Math.round(expected * 100.0);
		return actualRound == expectedRound;		
	}
}