using Toybox.Math;

class MaxMinHrvWindowStats {
	function initialize() {
		me.mStatsCounts = new [MaxStatsWindow+1];
		for (var i = 0; i < me.mStatsCounts.size(); i++) {
			me.mStatsCounts[i] = 0;
		}
		me.mWindowsCount = 0;
	}
	
	private var mWindowsCount;	
	private var mStatsCounts;
	private const MaxStatsWindow = 30;
	
	function addMaxMinHrvWindow(windowCalculation) {
		me.mWindowsCount++;
		var scaledDownWindow = windowCalculation / 10;
		if (windowCalculation % 10 >= 5) {
			scaledDownWindow += 1;
		}
		if (scaledDownWindow >= MaxStatsWindow) {
			me.mStatsCounts[MaxStatsWindow] += 1;
		}
		else {
			me.mStatsCounts[scaledDownWindow] += 1;
		}
		
	}
	
	private function calculateMedian() {
		if (me.mWindowsCount == 0) {
			return null;
		}
		if (me.mWindowsCount == 1) {
			for (var i = 0; i < me.mStatsCounts.size(); i++) {
				if (me.mStatsCounts[i] > 0) {
					return i.toFloat();
				}
			}
		}
		if (me.mWindowsCount == 2) {
			var twoStatsSum = 0;
			for (var i = 0; i < me.mStatsCounts.size(); i++) {
				if (me.mStatsCounts[i] > 0) {
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
		for (var i = 0; i < me.mStatsCounts.size(); i++) {
			if (medianCount < targetMedianCount) {
				medianCount += me.mStatsCounts[i];	
				continue;			
			}
			
			var medianValue;
			var previousMedianValue = null;
			if (medianCount - targetMedianCount == 0) {			
				medianValue = i-1;
				if (isAveragingNeeded == true) {
					previousMedianValue = medianValue;
					do {
						medianValue++;					
					}
					while (me.mStatsCounts[medianValue] == 0 && medianValue < me.mStatsCounts.size());										
				}
			}
			else {				
				medianValue = i-1;
			}
			
			if (isAveragingNeeded == true) {
				if (me.mStatsCounts[medianValue] > 1 && previousMedianValue == null) {					
					previousMedianValue = medianValue;
				}
				else {
					previousMedianValue = null;
					var previousMedianIndex = medianValue - 1;
					while (previousMedianIndex >= 0 && previousMedianValue == null) {
						if (me.mStatsCounts[previousMedianIndex] > 0) {
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
		
		return MaxStatsWindow.toFloat();
	}
	
	private function getNoStress(medianIndex) {
		if (medianIndex >= me.MaxStatsWindow) {
			medianIndex = me.MaxStatsWindow - 1;
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
		if (maxStressIndex > MaxStatsWindow) {
			maxStressIndex = MaxStatsWindow;
		}
		return maxStressIndex;
	}
	
	private function getHighStress(medianIndex) {
		var startThreshold = me.getHighStressThreshold(medianIndex);
		return me.getWindowsClacification(startThreshold, MaxStatsWindow);
	}
	
	private function getWindowsClacification(startStatsCountIndex, endStatsCountIndex) {
		if (me.mWindowsCount == 0) {
			return null;
		}
		var classifiedWindowsCount = 0;
		for (var i = startStatsCountIndex; i <= endStatsCountIndex; i++) {
			classifiedWindowsCount += me.mStatsCounts[i];
		}
		var classificationPercentage = (classifiedWindowsCount.toFloat() / me.mWindowsCount.toFloat()) * 100;
		return classificationPercentage;
	}
	
	function calculate() {
		var stressStats = new StressStats();
		
		stressStats.median = me.calculateMedian();
		if (stressStats.median != null) {
			var medianIndex = Math.round(stressStats.median).toNumber();
			stressStats.noStress = getNoStress(medianIndex);
			stressStats.lowStress = getLowStress(medianIndex);
			stressStats.highStress = getHighStress(medianIndex);
		}
		return stressStats;
	}	
}

class StressStats {
	var median;
	var noStress;
	var lowStress;
	var highStress;
}