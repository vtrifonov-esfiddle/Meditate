class AlertKeysStorage {
	function initialize() {
		me.loadAlertKeys();
	}
	
	private var mAlertKeys;
	
	private function loadAlertKeys() {
		me.mAlertKeys = App.Storage.getValue("alertKeys");		
		me.saveAlertKeys();
	}
	
	private function ensureInitialAlertKeyExists() {
		if (me.mAlertKeys == null || me.mAlertKeys.size() == 0) {
			me.mAlertKeys = new [1];
			me.mAlertKeys[0] = 0;
		}
	}
	
	private function saveAlertKeys() {
		me.ensureInitialAlertKeyExists();
		App.Storage.setValue("alertKeys", me.mAlertKeys);
	}	
		
	function addAfterInitialKey() {
		var lastAlertKey = me.mAlertKeys[me.mAlertKeys.size() - 1];
		me.mAlertKeys.add(lastAlertKey + 1); 
		me.saveAlertKeys();
	}
	
	function deleteKey(removeIndex) {
		var removeAlertKeyValue = me.mAlertKeys[removeIndex];
		me.mAlertKeys.remove(removeAlertKeyValue);
		me.saveAlertKeys();
	}
	
	function getKey(alertIndex) {
		return "alert" + me.mAlertKeys[alertIndex].toString();
	}
}