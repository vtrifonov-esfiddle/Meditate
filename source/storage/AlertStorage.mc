using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class AlertStorage {
	function initialize() {		
		me.mSelectedAlertIndex = App.Storage.getValue("selectedAlertIndex");
		if (me.mSelectedAlertIndex == null) {
			me.mSelectedAlertIndex = 0;
		}
				
		me.mAlertKeysStorage = new AlertKeysStorage();
		
		me.mAlertsCount = App.Storage.getValue("alertsCount");
		if (me.mAlertsCount == null) {
			me.loadSelectedAlert();
		}
	}	
	
	private var mSelectedAlertIndex;
	private var mAlertsCount;
	private var mAlertKeysStorage;
		
	function selectAlert(index) {
		me.mSelectedAlertIndex = index;
		App.Storage.setValue("selectedAlertIndex", me.mSelectedAlertIndex);
	}
	
	private function getSelectedAlertKey() {
		return me.mAlertKeysStorage.getKey(me.mSelectedAlertIndex);
	}
	
	function loadSelectedAlert() {
		var loadedAlertDictionary = App.Storage.getValue(me.getSelectedAlertKey());
		
		var alert = new AlertModel();
		if (loadedAlertDictionary == null) {
			me.mAlertsCount = 0;
			alert = me.addAlert();
		}
		else {
			alert.fromDictionary(loadedAlertDictionary);
		}
		return alert;
	}
	
	function saveSelectedAlert(alert) {
		var storageValue = alert.toDictionary();
		App.Storage.setValue(me.getSelectedAlertKey(), storageValue);
	}
	
	function getAlertsCount() {
		return me.mAlertsCount;
	}
	
	function getSelectedAlertIndex() {
		return me.mSelectedAlertIndex;
	}
	
	private function updateAlertStats() {
		App.Storage.setValue("selectedAlertIndex", me.mSelectedAlertIndex);
		App.Storage.setValue("alertsCount", me.mAlertsCount);
	}
			
	function addAlert() {
		var alert = new AlertModel();
		alert.reset();
		me.mAlertsCount++;
		me.mSelectedAlertIndex = me.mAlertsCount - 1;
		if (me.mSelectedAlertIndex > 0) {
			me.mAlertKeysStorage.addAfterInitialKey();
		}
		me.saveSelectedAlert(alert);
		me.updateAlertStats();
		
		return alert;
	}
	
	function deleteSelectedAlert() {
		App.Storage.deleteValue(me.getSelectedAlertKey());
		me.mAlertKeysStorage.deleteKey(me.mSelectedAlertIndex);
		if (me.mSelectedAlertIndex > 0) {
			me.mSelectedAlertIndex--;
		}
		if (me.mAlertsCount > 1) {
			me.mAlertsCount--;
		}
		
		me.updateAlertStats();
	}	
	
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
}

