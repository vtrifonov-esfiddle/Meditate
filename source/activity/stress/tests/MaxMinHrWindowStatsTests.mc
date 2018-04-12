using Toybox.Test;
using Toybox.Math;
using Toybox.System;

class MaxMinHrWindowStatsTests {
	(:test)
	static function evenWindowsMedian(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildEvenWindowsCountStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 5.5);		
	}
	
	(:test)
	static function evenWindowsNoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildEvenWindowsCountStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 62.5);		
	}
	
	(:test)
	static function evenWindowsLowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildEvenWindowsCountStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 12.5);		
	}
	
	(:test)
	static function evenWindowsHighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildEvenWindowsCountStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 25.0);		
	}
	
	(:test)
	static function oddWindowsMedian(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildOddWindowsCountStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function oddWindowsNoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildOddWindowsCountStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 55.5555);		
	}
	
	(:test)
	static function oddWindowsLowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildOddWindowsCountStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 22.22);		
	}
	
	(:test)
	static function oddWindowsHighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildOddWindowsCountStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 22.22);		
	}
	
	(:test)
	static function windows0to10Median(logger) {
		var stats = MaxMinHrWindowStatsFixture.build0to10WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function windows0to10NoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build0to10WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 54.5454);		
	}
	
	(:test)
	static function windows0to10LowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build0to10WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 36.3636);		
	}
	
	(:test)
	static function windows0to10HighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build0to10WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 9.0909);		
	}
	
	(:test)
	static function windows0to9Median(logger) {
		var stats = MaxMinHrWindowStatsFixture.build0to9WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 4.5);		
	}
	
	(:test)
	static function windows0to9NoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build0to9WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 60.0);		
	}
	
	(:test)
	static function windows0to9LowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build0to9WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 40.0);		
	}
	
	(:test)
	static function windows0to9HighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build0to9WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 0.0);		
	}
	
	(:test)
	static function mixedWindowsMedian(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildMixedWindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 6.0);		
	}
	
	(:test)
	static function mixedWindowsNoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildMixedWindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 52.0);		
	}
	
	(:test)
	static function mixedWindowsLowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildMixedWindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 20.0);		
	}
	
	(:test)
	static function mixedWindowsHighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildMixedWindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 28.0);		
	}
	
	(:test)
	static function window1Median(logger) {
		var stats = MaxMinHrWindowStatsFixture.build1WindowStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 1.0);		
	}
	
	(:test)
	static function window1NoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build1WindowStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 100.0);		
	}
	
	(:test)
	static function window1LowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build1WindowStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 0.0);		
	}
	
	(:test)
	static function window1HighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build1WindowStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 0.0);		
	}
	
	(:test)
	static function window10Median(logger) {
		var stats = MaxMinHrWindowStatsFixture.build10WindowStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 10.0);		
	}
	
	(:test)
	static function window10NoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build10WindowStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 0.0);		
	}
	
	(:test)
	static function window10LowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build10WindowStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 0.0);		
	}
	
	(:test)
	static function window10HighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build10WindowStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 100.0);		
	}
	
	(:test)
	static function windows1and10Median(logger) {
		var stats = MaxMinHrWindowStatsFixture.build1and10WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 5.5);		
	}
	
	(:test)
	static function windows1and10NoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build1and10WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 50.0);		
	}
	
	(:test)
	static function windows1and10LowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build1and10WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 0.0);		
	}
	
	(:test)
	static function windows1and10HighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build1and10WindowsStats();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 50.0);		
	}
		
	(:test)
	static function noWindowMedian(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildNoWindowsStats();
		return stats.median == null;		
	}
	
	(:test)
	static function noWindowNoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildNoWindowsStats();
		return stats.noStress == null;		
	}
	
	(:test)
	static function noWindowLowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildNoWindowsStats();
		return stats.lowStress == null;		
	}
	
	(:test)
	static function noWindowHighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.buildNoWindowsStats();
		return stats.highStress == null;		
	}
	
	(:test)
	static function windows9OnesAnd2to9Median(logger) {
		var stats = MaxMinHrWindowStatsFixture.build9OnesAnd2to9();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 1.0);		
	}
	
	(:test)
	static function windows9OnesAnd2to9NoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build9OnesAnd2to9();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 52.94);			
	}
	
	(:test)
	static function windows9OnesAnd2to9LowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build9OnesAnd2to9();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 5.88);	
	}
	
	(:test)
	static function windows9OnesAnd2to9HighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build9OnesAnd2to9();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 41.176);			
	}
	
	(:test)
	static function windows10ZeroesMedian(logger) {
		var stats = MaxMinHrWindowStatsFixture.build10Zeroes();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 0.0);		
	}
	
	(:test)
	static function windows10ZeroesNoStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build10Zeroes();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.noStress, 100.0);			
	}
	
	(:test)
	static function windows10ZeroesLowStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build10Zeroes();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.lowStress, 0.0);	
	}
	
	(:test)
	static function windows10ZeroesHighStress(logger) {
		var stats = MaxMinHrWindowStatsFixture.build10Zeroes();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.highStress, 0.0);			
	}
	
	(:test)
	static function windows1two10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(1);
		maxMinHrWindowStats.addMaxMinHrWindow(5);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function windows0two10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(5);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 5.0);		
	}
	
	(:test)
	static function windows1double4and10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(1);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 4.0);		
	}
	
	(:test)
	static function windows0double4and10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(4);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 4.0);		
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
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 4.0);		
	}
	
	(:test)
	static function windows0double10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 10.0);		
	}
	
	(:test)
	static function windowsDouble0And10Median(logger) {
		var maxMinHrWindowStats = new MaxMinHrWindowStats();		
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(0);
		maxMinHrWindowStats.addMaxMinHrWindow(10);
		var stats = maxMinHrWindowStats.calculate();
		return MaxMinHrWindowStatsFixture.isResultExpected(stats.median, 0.0);		
	}
}