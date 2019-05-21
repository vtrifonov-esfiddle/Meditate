using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System;

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
    	var heartbeatIntervalsSensor = new HrvAlgorithms.HeartbeatIntervalsSensor();	
    	var sessionPickerDelegate = new SessionPickerDelegate(sessionStorage, heartbeatIntervalsSensor);
    	
        return [ sessionPickerDelegate.createScreenPickerView(), sessionPickerDelegate ];
    }
}
