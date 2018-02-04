using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class SessionStorage {
	function initialize() {		
		me.mSelectedSessionIndex = App.Storage.getValue("selectedSessionIndex");
		if (me.mSelectedSessionIndex == null) {
			me.mSelectedSessionIndex = 0;
		}
				
		me.mSessionKeysStorage = new SessionKeysStorage();
		
		me.mSessionsCount = App.Storage.getValue("sessionsCount");
		if (me.mSessionsCount == null) {
			me.loadSelectedSession();
		}
	}	
	
	private var mSelectedSessionIndex;
	private var mSessionsCount;
	private var mSessionKeysStorage;
		
	function selectSession(index) {
		me.mSelectedSessionIndex = index;
		App.Storage.setValue("selectedSessionIndex", me.mSelectedSessionIndex);
	}
	
	private function getSelectedSessionKey() {
		return me.mSessionKeysStorage.getKey(me.mSelectedSessionIndex);
	}
	
	function loadSelectedSession() {
		var loadedSessionDictionary = App.Storage.getValue(me.getSelectedSessionKey());
		
		var session = new SessionModel();
		if (loadedSessionDictionary == null) {
			me.mSessionsCount = 0;
			session = me.addSession();
		}
		else {
			session.fromDictionary(loadedSessionDictionary);
		}
		return session;
	}
	
	function saveSelectedSession(session) {
		var storageValue = session.toDictionary();
		App.Storage.setValue(me.getSelectedSessionKey(), storageValue);
	}
	
	function getSessionsCount() {
		return me.mSessionsCount;
	}
	
	function getSelectedSessionIndex() {
		return me.mSelectedSessionIndex;
	}
	
	private function updateSessionStats() {
		App.Storage.setValue("selectedSessionIndex", me.mSelectedSessionIndex);
		App.Storage.setValue("sessionsCount", me.mSessionsCount);
	}
			
	function addSession() {
		var session = new SessionModel();
		session.reset();
		me.mSessionsCount++;
		me.mSelectedSessionIndex = me.mSessionsCount - 1;
		if (me.mSelectedSessionIndex > 0) {
			me.mSessionKeysStorage.addAfterInitialKey();
		}
		me.saveSelectedSession(session);
		me.updateSessionStats();
		
		return session;
	}
	
	function deleteSelectedSession() {
		App.Storage.deleteValue(me.getSelectedSessionKey());
		me.mSessionKeysStorage.deleteKey(me.mSelectedSessionIndex);
		if (me.mSelectedSessionIndex > 0) {
			me.mSelectedSessionIndex--;
		}
		if (me.mSessionsCount > 1) {
			me.mSessionsCount--;
		}
		
		me.updateSessionStats();
	}	
	
	class SessionKeysStorage {
		function initialize() {
			me.loadSessionKeys();
		}
		
		private var mSessionKeys;
		
		private function loadSessionKeys() {
			me.mSessionKeys = App.Storage.getValue("sessionKeys");		
			me.saveSessionKeys();
		}
		
		private function ensureInitialSessionKeyExists() {
			if (me.mSessionKeys == null || me.mSessionKeys.size() == 0) {
				me.mSessionKeys = new [1];
				me.mSessionKeys[0] = 0;
			}
		}
		
		private function saveSessionKeys() {
			me.ensureInitialSessionKeyExists();
			App.Storage.setValue("sessionKeys", me.mSessionKeys);
		}	
			
		function addAfterInitialKey() {
			var lastSessionKey = me.mSessionKeys[me.mSessionKeys.size() - 1];
			me.mSessionKeys.add(lastSessionKey + 1); 
			me.saveSessionKeys();
		}
		
		function deleteKey(removeIndex) {
			var removeSessionKeyValue = me.mSessionKeys[removeIndex];
			me.mSessionKeys.remove(removeSessionKeyValue);
			me.saveSessionKeys();
		}
		
		function getKey(sessionIndex) {
			return "session" + me.mSessionKeys[sessionIndex].toString();
		}
	}
}

