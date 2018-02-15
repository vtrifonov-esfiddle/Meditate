using Toybox.Application as App;

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