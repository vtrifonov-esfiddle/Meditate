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
    	return test();     	  
    	/*var sessionStorage = new SessionStorage();	    	    	
    	var sessionPickerDelegate = new SessionPickerDelegate(sessionStorage);
    	
        return [ sessionPickerDelegate.createScreenPickerView(), sessionPickerDelegate ];*/
    }
    
    private function test() {    
    	var durationPickerModel = new DurationPickerModel(4);
    	var timeLayoutBuilder = me.testCreateTimeLayoutBuilder();
    	var view = new DurationPickerView(durationPickerModel, timeLayoutBuilder);
    	var delgate = new DurationPickerDelegate(durationPickerModel, method(:testOnDigitsPicked));
		return [ view, delgate];   	
    }
    
    private function testCreateTimeLayoutBuilder() {
		var digitsLayout = new DigitsLayoutBuilder(Gfx.FONT_SYSTEM_TINY);
		digitsLayout.setOutputXOffset(75);
		digitsLayout.addInitialHint("Pick MM:SS");
		digitsLayout.addDigit({:minValue=>0, :maxValue=>9});
		digitsLayout.addDigit({:minValue=>0, :maxValue=>5});
		digitsLayout.addSeparator("m");
		digitsLayout.addDigit({:minValue=>0, :maxValue=>5});
		digitsLayout.addDigit({:minValue=>0, :maxValue=>5});
		digitsLayout.addSeparator("s");
		return digitsLayout;
    }
    
    private function testOnDigitsPicked(digits) {
    	System.println("Digits picked");
    	for (var i = 0; i < digits.size(); i++) {
    		System.print(digits[i] + " ");
    	}
    }
}
