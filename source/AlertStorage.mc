using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class AlertStorage {
	function initialize() {		
		me.mSelectedAlertIndex = App.Storage.getValue("selectedAlertIndex");
		if (me.mSelectedAlertIndex == null) {
			me.mSelectedAlertIndex = 0;
		}
		
		me.mAlertsCount = App.Storage.getValue("alertsCount");
		if (me.mAlertsCount == null) {
			me.mAlertsCount = 0;
		}
		me.loadAlertKeys();
	}	
	
	private var mSelectedAlertIndex;
	private var mAlertsCount;
	private var mAlertKeys;
	
	private function loadAlertKeys() {
		me.mAlertKeys = App.Storage.getValue("alertKeys");		
		if (me.mAlertKeys == null) {
			me.saveAlertKeys();
		}
	}
	
	private function saveAlertKeys() {
		if (me.mAlertKeys == null || me.mAlertKeys.size() == 0) {
			me.mAlertKeys = new [1];
			me.mAlertKeys[0] = 0;
		}
		App.Storage.setValue("alertKeys", me.mAlertKeys);
	}
	
	function selectAlert(index) {
		me.mSelectedAlertIndex = index;
		App.Storage.setValue("selectedAlertIndex", me.mSelectedAlertIndex);
	}
	
	function loadSelectedAlert() {
		var loadedAlertDictionary = App.Storage.getValue(me.getSelectedAlertKey());
		
		var alert = new AlertModel();
		if (loadedAlertDictionary == null) {
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
	
	function updateAlertStats() {
		App.Storage.setValue("selectedAlertIndex", me.mSelectedAlertIndex);
		App.Storage.setValue("alertsCount", me.mAlertsCount);
	}
	
	private function addAlertKey() {
		var lastAlertKey = me.mAlertKeys[me.mAlertKeys.size() - 1];
		me.mAlertKeys.add(lastAlertKey + 1); 
		me.saveAlertKeys();
	}
	
	private function deleteAlertKey(removeIndex) {
		var removeAlertKeyValue = me.mAlertKeys[removeIndex];
		me.mAlertKeys.remove(removeAlertKeyValue);
		me.saveAlertKeys();
	}
	
	function addAlert() {
		var alert = new AlertModel();
		alert.reset();
		if (me.mAlertKeys.size() <= me.mAlertsCount) {
			me.addAlertKey();
		}
		me.mAlertsCount++;
		me.mSelectedAlertIndex = me.mAlertsCount - 1;
		me.saveSelectedAlert(alert);
		me.updateAlertStats();
		
		return alert;
	}
	
	function deleteSelectedAlert() {
		App.Storage.deleteValue(me.getSelectedAlertKey());
		me.deleteAlertKey(me.mSelectedAlertIndex);
		if (me.mSelectedAlertIndex > 0) {
			me.mSelectedAlertIndex--;
		}
		if (me.mAlertsCount > 0) {
			me.mAlertsCount--;
		}
		me.updateAlertStats();
	}		
	
	private function getSelectedAlertKey() {
		return "alert" + me.mAlertKeys[me.mSelectedAlertIndex].toString();
	}	
}