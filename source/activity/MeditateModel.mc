using Toybox.Application as App;

class MeditateModel {
	function initialize(sessionModel) {
		me.mSession = sessionModel;
		me.elapsedTime = 0;
		me.minHr = null;
		me.currentHr = null;
	}
	
	private var mSession;

	public var currentHr;
	public var minHr;
	public var elapsedTime;
	
	function getSessionTime() {
		return me.mSession.time;
	}
		
	function getColor() {
		return me.mSession.color;
	}
	
	function getVibePattern() {
		return me.mSession.vibePattern;
	}
	
	function setSession(sessionModel) {
		me.mSession = sessionModel;
	}
}