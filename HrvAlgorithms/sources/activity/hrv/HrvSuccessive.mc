module HrvAlgorithms {
	class HrvSuccessive {
		function initialize() {		
			me.mPreviousBeatToBeatInterval = null;
			me.mCurrentBeatToBeatInterval = null;
		}
			
		private var mPreviousBeatToBeatInterval;
		private var mCurrentBeatToBeatInterval;
		
		function addBeatToBeatInterval(beatToBeatInterval) {
			me.mPreviousBeatToBeatInterval = me.mCurrentBeatToBeatInterval;
			me.mCurrentBeatToBeatInterval = beatToBeatInterval;	
		}
		
		function calculate() {
			if (me.mPreviousBeatToBeatInterval == null || me.mCurrentBeatToBeatInterval == null) {
				return null;
			}
			return me.mCurrentBeatToBeatInterval - me.mPreviousBeatToBeatInterval;
		}
	}

}