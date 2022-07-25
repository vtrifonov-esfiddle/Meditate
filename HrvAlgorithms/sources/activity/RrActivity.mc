using Toybox.Timer;
using Toybox.FitContributor;
using Toybox.ActivityRecording;
using Toybox.Sensor;

module HrvAlgorithms {
	class RrActivity {
		
		function initialize() {
			if(isSupported()) {
				me.supported = true;
				me.rrSummary = new RrSummary();
				me.rrSummary.maxRr = 0;
				me.rrSummary.minRr = 9999999;
				me.totalSamples = 0;
				me.totalRespirationRates = 0;
			} else {
				me.supported = false;
			}
		}

		private var supported;
		private var totalSamples;
		private var totalRespirationRates;
		private var rrSummary;
	
		function isSupported() {

			// Check if device supports respiration rate
			if (ActivityMonitor.getInfo() has :respirationRate) {
				return true;
			} else {
				return false;
			}
		}

		function getRespirationRate() {

			// If device supports respiration rate
			if (me.supported) {
				
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
			
			totalSamples++;
			totalRespirationRates+=respirationRate;

			rrSummary.averageRr = Math.round(totalRespirationRates / totalSamples);

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