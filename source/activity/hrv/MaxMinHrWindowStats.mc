using Toybox.Math;

class MaxMinHrWindowStats {
	function initialize() {
		me.mBpmStatsCounts = new [MaxBpmWindow+1];
		for (var i = 0; i < me.mBpmStatsCounts.size(); i++) {
			me.mBpmStatsCounts[i] = 0;
		}
		me.mWindowsCount = 0;
	}
	
	private var mWindowsCount;	
	private var mBpmStatsCounts;
	private const MaxBpmWindow = 10;
	
	function addMaxMinHrWindow(windowCalculation) {
		me.mWindowsCount++;
		if (windowCalculation >= MaxBpmWindow) {
			me.mBpmStatsCounts[MaxBpmWindow] += 1;
		}
		else {
			me.mBpmStatsCounts[windowCalculation] += 1;
		}
		
	}
	
	private function calculateMedian() {
		if (me.mWindowsCount == 0) {
			return null;
		}
		if (me.mWindowsCount == 1) {
			for (var i = 0; i < me.mBpmStatsCounts.size(); i++) {
				if (me.mBpmStatsCounts[i] > 0) {
					return i;
				}
			}
		}
		if (me.mWindowsCount == 2) {
			var twoStatsSum = 0;
			for (var i = 0; i < me.mBpmStatsCounts.size(); i++) {
				if (me.mBpmStatsCounts[i] > 0) {
					twoStatsSum += i;
				}
			}
			return twoStatsSum.toFloat() / 2.0;
		}
		var medianCount = 0;
		var targetMedianCount = me.mWindowsCount / 2;		
		var isAveragingNeeded = me.mWindowsCount % 2 == 0;	
		if (isAveragingNeeded == false) {
			targetMedianCount++;
		}
		for (var i = 0; i < me.mBpmStatsCounts.size(); i++) {
			if (medianCount < targetMedianCount) {
				medianCount += me.mBpmStatsCounts[i];	
				continue;			
			}
			
			var medianValue;
			if (medianCount - targetMedianCount == 0) {			
				medianValue = i-1;
				if (isAveragingNeeded == true) {
					medianValue++;
				}
			}
			else {				
				medianValue = i-1;
			}
			
			if (isAveragingNeeded == true) {
				var previousMedianValue;
				if (me.mBpmStatsCounts[medianValue] > 1) {
					previousMedianValue = medianValue;
				}
				else {
					previousMedianValue = null;
					var previousMedianIndex = medianValue - 1;
					while (previousMedianIndex >= 0 && previousMedianValue == null) {
						if (me.mBpmStatsCounts[previousMedianIndex] > 0) {
							previousMedianValue = previousMedianIndex;
						}
						previousMedianIndex--;
					}
				}				
				return (medianValue + previousMedianValue).toFloat() / 2.0;
			}
			else {
				return (medianValue).toFloat();
			} 
		}
		
		return MaxBpmWindow.toFloat();
	}
	
	private function getNoStress(medianIndex) {
		if (medianIndex == 10) {
			medianIndex = 9;
		}
		return me.getWindowsClacification(0, medianIndex);
	}
	
	private function getLowStress(medianIndex) {
		var maxLowStressIndex = me.getHighStressThreshold(medianIndex) - 1;
		return me.getWindowsClacification(medianIndex + 1, maxLowStressIndex);
	}
	
	private function getHighStressThreshold(medianIndex) {
		if (medianIndex == 0) {
			return 1;
		}
		var maxStressIndex = medianIndex * 3;
		if (maxStressIndex > MaxBpmWindow) {
			maxStressIndex = MaxBpmWindow;
		}
		return maxStressIndex;
	}
	
	private function getHighStress(medianIndex) {
		var startThreshold = me.getHighStressThreshold(medianIndex);
		return me.getWindowsClacification(startThreshold, MaxBpmWindow);
	}
	
	private function getWindowsClacification(startBpmStatsCountIndex, endBpmStatsCountIndex) {
		if (me.mWindowsCount == 0) {
			return null;
		}
		var clacifiedWindowsCount = 0;
		for (var i = startBpmStatsCountIndex; i <= endBpmStatsCountIndex; i++) {
			clacifiedWindowsCount += me.mBpmStatsCounts[i];
		}
		var clacificationPercentage = (clacifiedWindowsCount.toFloat() / me.mWindowsCount.toFloat()) * 100;
		return clacificationPercentage;
	}
	
	function calculate() {
		var hrStats = new HrStats();
		
		hrStats.median = me.calculateMedian();
		if (hrStats.median != null) {
			var medianIndex = Math.round(hrStats.median).toNumber();
			hrStats.noStress = getNoStress(medianIndex);
			hrStats.lowStress = getLowStress(medianIndex);
			hrStats.highStress = getHighStress(medianIndex);
		}
		return hrStats;
	}	
}

class HrStats {
	var median;
	var noStress;
	var lowStress;
	var highStress;
}