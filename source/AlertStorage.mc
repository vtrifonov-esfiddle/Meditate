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
	}	
	
	private var mSelectedAlertIndex;
	private var mAlertsCount;
	
	function selectAlert(index) {
		me.mSelectedAlertIndex = index;
		App.Storage.setValue("selectedAlertIndex", me.mSelectedAlertIndex);
	}
	
	function loadSelectedAlert() {
		var loadedAlertDictionary = App.Storage.getValue(me.getSelectedAlertKey());
		
		var alert = new AlertModel();
		if (loadedAlertDictionary == null) {
			alert.reset();
			me.saveSelectedAlert(alert);
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
	
	function updateAlertStats() {
		App.Storage.setValue("selectedAlertIndex", me.mSelectedAlertIndex);
		App.Storage.setValue("alertsCount", me.mAlertsCount);
	}
	
	function addAlert() {
		var alert = new AlertModel();
		alert.reset();
		me.mAlertsCount++;
		me.mSelectedAlertIndex = me.mAlertsCount -1;
		me.saveSelectedAlert(alert);
		me.updateAlertStats();
		return alert;
	}
	
	function deleteSelectedAlert() {
		App.Storage.deleteValue(me.getSelectedAlertKey());
		if (me.mSelectedAlertIndex > 0) {
			me.mSelectedAlertIndex--;
		}
		if (me.mAlertsCount > 0) {
			me.mAlertsCount--;
		}
		me.updateAlertStats();
	}		
	
	private function getSelectedAlertKey() {
		return "alert" + me.mSelectedAlertIndex.toString();
	}
	

	function testSave() {
		var alert1 = me.addAlert();
		alert1.color = Gfx.COLOR_GREEN;
		alert1.time = 300;
		me.saveSelectedAlert(alert1);
		
		var alert2 =  me.addAlert();
		alert2.color = Gfx.COLOR_BLUE;
		alert2.time = 70;
		
		me.saveSelectedAlert(alert2);
	}
	
	private function printAlert(alert) {	
		System.println("alert: " + me.getSelectedAlertKey() + " " + alert.time + " " + alert.color + " " + alert.vibrationPattern);
	}
	
	function testLoad() {
		var alert = me.loadSelectedAlert();
		me.printAlert(alert);
	}
}