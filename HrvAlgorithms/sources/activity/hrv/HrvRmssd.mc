module HrvAlgorithms {
	class HrvRmssd {
		function initialize() {		
			me.mSquareOfSuccessiveBtbDifferences = 0.0;
			me.mPreviousBeatToBeatInterval = null;
			me.mBeatToBeatIntervalsCount = 0;
		}
			
		private var mSquareOfSuccessiveBtbDifferences;	
		private var mPreviousBeatToBeatInterval;
		private var mBeatToBeatIntervalsCount;
		
		function addBeatToBeatInterval(beatToBeatInterval) {
			if (me.mPreviousBeatToBeatInterval != null) {
				me.mBeatToBeatIntervalsCount++;					
				
				me.mSquareOfSuccessiveBtbDifferences += Math.pow(beatToBeatInterval - me.mPreviousBeatToBeatInterval, 2);	
			}		
			me.mPreviousBeatToBeatInterval = beatToBeatInterval;
		}
		
		function calculate() {
			if (me.mBeatToBeatIntervalsCount < 1) {
				return null;
			}
			
			var rootMeanSquareOfSuccessiveBtbDifferences = Math.sqrt(me.mSquareOfSuccessiveBtbDifferences / me.mBeatToBeatIntervalsCount);		
			return rootMeanSquareOfSuccessiveBtbDifferences;
		}
	}
}