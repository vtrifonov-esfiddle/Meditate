using Toybox.Test;
using Toybox.Math;
using Toybox.System;

class MaxMinHrvWindowStatsTests {
	(:test)
	static function evenWindowsMedian(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildEvenWindowsCountStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 6.0);		
	}
		
	(:test)
	static function evenWindowsNoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildEvenWindowsCountStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 50.0);		
	}
	
	(:test)
	static function evenWindowsLowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildEvenWindowsCountStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 37.5);		
	}
	
	(:test)
	static function evenWindowsHighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildEvenWindowsCountStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 12.5);		
	}
	
	(:test)
	static function evenWindowsMedian2(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildEvenWindowsCount2Stats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 5.5);		
	}
	
	(:test)
	static function oddWindowsMedian(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildOddWindowsCountStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function oddWindowsNoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildOddWindowsCountStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 55.5555);		
	}
	
	(:test)
	static function oddWindowsLowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildOddWindowsCountStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 33.3333);		
	}
	
	(:test)
	static function oddWindowsHighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildOddWindowsCountStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 11.1111);		
	}
	
	(:test)
	static function windows0to10Median(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build0to10WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function windows0to10NoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build0to10WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 54.5454);		
	}
	
	(:test)
	static function windows0to10LowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build0to10WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 45.45454);		
	}
	
	(:test)
	static function windows0to10HighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build0to10WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 0.0);		
	}
	
	(:test)
	static function windows0to9Median(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build0to9WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 4.5);		
	}
	
	(:test)
	static function windows0to9NoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build0to9WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 60.0);		
	}
	
	(:test)
	static function windows0to9LowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build0to9WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 40.0);		
	}
	
	(:test)
	static function windows0to9HighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build0to9WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 0.0);		
	}
	
	(:test)
	static function mixedWindowsMedian(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildMixedWindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 7.0);		
	}
	
	(:test)
	static function mixedWindowsNoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildMixedWindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 60.0);		
	}
	
	(:test)
	static function mixedWindowsLowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildMixedWindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 24.0);		
	}
	
	(:test)
	static function mixedWindowsHighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildMixedWindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 16.0);		
	}
	
	(:test)
	static function window1Median(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build1WindowStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 10.0);		
	}
	
	(:test)
	static function window1NoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build1WindowStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 100.0);		
	}
	
	(:test)
	static function window1LowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build1WindowStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 0.0);		
	}
	
	(:test)
	static function window1HighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build1WindowStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 0.0);		
	}
	
	(:test)
	static function window30Median(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build30WindowStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 30.0);		
	}
	
	(:test)
	static function window30NoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build30WindowStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 0.0);		
	}
	
	(:test)
	static function window30LowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build30WindowStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 0.0);		
	}
	
	(:test)
	static function window30HighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build30WindowStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 100.0);		
	}
	
	(:test)
	static function windows1and10Median(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build1and10WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 5.5);		
	}
	
	(:test)
	static function windows1and10NoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build1and10WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 50.0);		
	}
	
	(:test)
	static function windows1and10LowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build1and10WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 50.0);		
	}
	
	(:test)
	static function windows1and10HighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build1and10WindowsStats();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 0.0);		
	}
		
	(:test)
	static function noWindowMedian(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildNoWindowsStats();
		return stats.median == null;		
	}
	
	(:test)
	static function noWindowNoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildNoWindowsStats();
		return stats.noStress == null;		
	}
	
	(:test)
	static function noWindowLowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildNoWindowsStats();
		return stats.lowStress == null;		
	}
	
	(:test)
	static function noWindowHighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.buildNoWindowsStats();
		return stats.highStress == null;		
	}
	
	(:test)
	static function windows9OnesAnd2to9Median(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build9OnesAnd2to9();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 1.0);		
	}
	
	(:test)
	static function windows9OnesAnd2to9NoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build9OnesAnd2to9();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 52.94);			
	}
	
	(:test)
	static function windows9OnesAnd2to9LowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build9OnesAnd2to9();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 5.88);	
	}
	
	(:test)
	static function windows9OnesAnd2to9HighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build9OnesAnd2to9();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 41.176);			
	}
	
	(:test)
	static function windows10ZeroesMedian(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build10Zeroes();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.median, 0.0);		
	}
	
	(:test)
	static function windows10ZeroesNoStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build10Zeroes();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.noStress, 100.0);			
	}
	
	(:test)
	static function windows10ZeroesLowStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build10Zeroes();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.lowStress, 0.0);	
	}
	
	(:test)
	static function windows10ZeroesHighStress(logger) {
		var stats = MaxMinHrvWindowStatsFixture.build10Zeroes();
		return MaxMinHrvWindowStatsFixture.isResultExpected(stats.highStress, 0.0);			
	}
	
	(:test)
	static function windows1two10Median(logger) {
		var stats = new MaxMinHrvWindowStats();		
		stats.addMaxMinHrvWindow(10);
		stats.addMaxMinHrvWindow(50);
		stats.addMaxMinHrvWindow(100);
		var statsResult = stats.calculate();
		return MaxMinHrvWindowStatsFixture.isResultExpected(statsResult.median, 5.0);		
	}
	
	(:test)
	static function windows0two10Median(logger) {
		var stats = new MaxMinHrvWindowStats();		
		stats.addMaxMinHrvWindow(0);
		stats.addMaxMinHrvWindow(50);
		stats.addMaxMinHrvWindow(100);
		var statsResult = stats.calculate();
		return MaxMinHrvWindowStatsFixture.isResultExpected(statsResult.median, 5.0);		
	}
	
	(:test)
	static function windows1double4and10Median(logger) {
		var stats = new MaxMinHrvWindowStats();		
		stats.addMaxMinHrvWindow(10);
		stats.addMaxMinHrvWindow(40);
		stats.addMaxMinHrvWindow(40);
		stats.addMaxMinHrvWindow(100);
		var statsResult = stats.calculate();
		return MaxMinHrvWindowStatsFixture.isResultExpected(statsResult.median, 4.0);		
	}
	
	(:test)
	static function windows0double4and10Median(logger) {
		var stats = new MaxMinHrvWindowStats();		
		stats.addMaxMinHrvWindow(0);
		stats.addMaxMinHrvWindow(40);
		stats.addMaxMinHrvWindow(40);
		stats.addMaxMinHrvWindow(100);
		var statsResult = stats.calculate();
		return MaxMinHrvWindowStatsFixture.isResultExpected(statsResult.median, 4.0);		
	}
	
	(:test)
	static function windows0triple4and10Median(logger) {
		var stats = new MaxMinHrvWindowStats();		
		stats.addMaxMinHrvWindow(0);
		stats.addMaxMinHrvWindow(40);
		stats.addMaxMinHrvWindow(40);
		stats.addMaxMinHrvWindow(40);
		stats.addMaxMinHrvWindow(100);
		var statsResult = stats.calculate();
		return MaxMinHrvWindowStatsFixture.isResultExpected(statsResult.median, 4.0);		
	}
	
	(:test)
	static function windows0double10Median(logger) {
		var stats = new MaxMinHrvWindowStats();		
		stats.addMaxMinHrvWindow(0);
		stats.addMaxMinHrvWindow(100);
		stats.addMaxMinHrvWindow(100);
		var statsResult = stats.calculate();
		return MaxMinHrvWindowStatsFixture.isResultExpected(statsResult.median, 10.0);		
	}
	
	(:test)
	static function windowsDouble0And10Median(logger) {
		var stats = new MaxMinHrvWindowStats();		
		stats.addMaxMinHrvWindow(0);
		stats.addMaxMinHrvWindow(0);
		stats.addMaxMinHrvWindow(100);
		var statsResult = stats.calculate();
		return MaxMinHrvWindowStatsFixture.isResultExpected(statsResult.median, 0.0);		
	}
}