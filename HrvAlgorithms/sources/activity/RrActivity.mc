using Toybox.Timer;
using Toybox.Sensor;
using Toybox.FitContributor;
using Toybox.ActivityMonitor;
using Toybox.ActivityRecording;

module HrvAlgorithms {
	class RrActivity {
		
		function initialize() {

			// Check if device supports respiration rate
			if (isRespirationRateSupported()) {
				me.respirationRateSupported = true;
				me.rrSummary = new RrSummary();
				me.rrSummary.maxRr = 0;
				me.rrSummary.minRr = 9999999;
				me.totalRespirationSamples = 0;
				me.totalRespirationRateSum = 0;
			} else {
				me.respirationRateSupported = false;
			}
		}

		private var respirationRateSupported;
		private var totalRespirationSamples;
		private var totalRespirationRateSum;
		private var rrSummary;
	
		// Method to be used without class instance
		function isRespirationRateSupported(){
			if (ActivityMonitor.getInfo() has :respirationRate) {
				return true;
			} else {
				return false;
			}
		}

		// Check if device supports respiration rate
		function isSupported() {
			return respirationRateSupported;
		}

		function getRespirationRate() {

			// If device supports respiration rate
			if (me.respirationRateSupported) {
				
				// Retrieves respiration rate
				var respirationRate = ActivityMonitor.getInfo().respirationRate;

				// Update summary metrics
				if (respirationRate!=null && respirationRate!=0 && respirationRate!=1) {
					updateSummary(respirationRate);
				}

				return respirationRate;
			} else {
				return -1;
			}
		}

		function updateSummary(respirationRate) {

			// Refresh respiration rate metrics including:
			// Min respiration rate
			// Average respiration rate
			// Max respiration rate
			
			totalRespirationSamples++;
			totalRespirationRateSum+=respirationRate;

			rrSummary.averageRr = Math.round(totalRespirationRateSum / totalRespirationSamples);

			if (respirationRate < rrSummary.minRr) {
				rrSummary.minRr = respirationRate;
			}
			if (respirationRate > rrSummary.maxRr) {
				rrSummary.maxRr = respirationRate;
			}
		}

		function getSummary() {
			return rrSummary;
		}
	}	
}