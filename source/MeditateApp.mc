using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class MeditateApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {     	  
    	var sessionStorage = new SessionStorage();	
    	testIntervalAlerts(sessionStorage);
    	    	
    	var sessionPickerDelegate = new SessionPickerDelegate(sessionStorage);
    	
        return [ sessionPickerDelegate.createScreenPickerView(), sessionPickerDelegate ];
    }
	
	private function testIntervalAlerts(sessionStorage) {
		var session = sessionStorage.loadSelectedSession();
		
    	var interval = new Alert();
    	interval.time = 10;
    	session.intervalAlerts.add(interval);    	
    	
    	var interval2 = new Alert();
    	interval2.time = 120;
    	session.intervalAlerts.add(interval2);
    	
    	sessionStorage.saveSelectedSession(session);
	}
}
