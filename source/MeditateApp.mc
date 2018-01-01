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
    	var meditateModel = new MeditateModel();    	
        //return [ new MeditateView(meditateModel), new MeditateDelegate(meditateModel) ];
        var durationPickerModel = new DurationPickerModel();
    	return [ new DurationPickerView(durationPickerModel), new DurationPickerDelegate(durationPickerModel, meditateModel)];
    }

}
