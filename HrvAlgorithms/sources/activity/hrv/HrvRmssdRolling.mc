module HrvAlgorithms {
	class HrvRmssdRolling {
		function initialize(rollingIntervalSeconds) {	
			me.mRollingIntervalSeconds = rollingIntervalSeconds;		
			me.reset();
		}
			
		private var mRollingIntervalSeconds;
		private var mSecondsCount;	
		private var mSquareOfSuccessiveBtbDifferences;	
		private var mPreviousBeatToBeatInterval;
		private var mBeatToBeatIntervalsCount;
		
		private function reset() {
			me.mSecondsCount = 0;	
			me.mSquareOfSuccessiveBtbDifferences = 0.0;
			me.mBeatToBeatIntervalsCount = 0;
			me.mPreviousBeatToBeatInterval = null;
		}
		
		function addOneSecBeatToBeatIntervals(beatToBeatIntervals) {
			for (var i = 0; i < beatToBeatIntervals.size(); i++) {
				me.addBeatToBeatInterval(beatToBeatIntervals[i]);
			}
			me.mSecondsCount++;
			return me.calculate();
		}
		
		private function addBeatToBeatInterval(beatToBeatInterval) {
			if (me.mPreviousBeatToBeatInterval != null) {
				me.mBeatToBeatIntervalsCount++;					
				
				me.mSquareOfSuccessiveBtbDifferences += Math.pow(beatToBeatInterval - me.mPreviousBeatToBeatInterval, 2);	
			}		
			me.mPreviousBeatToBeatInterval = beatToBeatInterval;
		}
		
		private function calculate() {
			if (me.mSecondsCount < me.mRollingIntervalSeconds || me.mBeatToBeatIntervalsCount < 1) {
				return null;
			}
			
			var rootMeanSquareOfSuccessiveBtbDifferences = Math.sqrt(me.mSquareOfSuccessiveBtbDifferences / me.mBeatToBeatIntervalsCount);	
			me.reset();	
			return rootMeanSquareOfSuccessiveBtbDifferences;
		}
	}
}