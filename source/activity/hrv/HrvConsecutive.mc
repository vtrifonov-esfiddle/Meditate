class HrvConsecutive {
	function initialize() {		
		me.mPreviousBeatToBeatInterval = null;
		me.mCurrentBeatToBeatInterval = null;
	}
		
	private var mPreviousBeatToBeatInterval;
	private var mCurrentBeatToBeatInterval;
	
	function addBeatToBeatInterval(beatToBeatInterval) {
		me.mCurrentBeatToBeatInterval = beatToBeatInterval;	
		me.mPreviousBeatToBeatInterval = me.mCurrentBeatToBeatInterval;
	}
	
	function calculate() {
		if (me.mPreviousBeatToBeatInterval == null || me.mCurrentBeatToBeatInterval == null) {
			return null;
		}
		return me.mCurrentBeatToBeatInterval - me.mPreviousBeatToBeatInterval;
	}
}