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
			return 0.0;
		}
		var medianCount = 0;
		var targetMedianCount = me.mWindowsCount / 2;
		
		var isAveragingNeeded = me.mWindowsCount % 2 == 0;			
		for (var i = 0; i < me.mBpmStatsCounts.size(); i++) {
			if (medianCount < targetMedianCount) {
				medianCount += me.mBpmStatsCounts[i];	
				continue;			
			}
			
			var medianValue;
			if (medianCount - targetMedianCount > 0) {
				medianValue = i-1;
			}
			else {
				medianValue = i;
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
		return me.getWindowsClacification(0, medianIndex);
	}
	
	private function getMediumStress(medianIndex) {
		return me.getWindowsClacification(medianIndex + 1, MaxBpmWindow - 1);
	}
	
	private function getHighStress(medianIndex) {
		return me.getWindowsClacification(MaxBpmWindow, MaxBpmWindow);
	}
	
	private function getWindowsClacification(startBpmStatsCountIndex, endBpmStatsCountIndex) {
		if (me.mWindowsCount == 0) {
			return 0.0;
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
		
		var medianIndex = hrStats.median.toNumber();
		hrStats.noStress = getNoStress(medianIndex);
		hrStats.mediumStress = getMediumStress(medianIndex);
		hrStats.highStress = getHighStress(medianIndex);
		return hrStats;
	}	
}

class HrStats {
	var median;
	var noStress;
	var mediumStress;
	var highStress;
}