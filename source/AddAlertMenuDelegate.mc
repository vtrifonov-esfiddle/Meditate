using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AddAlertMenuDelegate extends Ui.MenuInputDelegate {
	private var mMeditateModel;

    function initialize(meditateModel) {
        MenuInputDelegate.initialize();
        me.mMeditateModel = meditateModel;
    }
		
    function onMenuItem(item) {
        if (item == :color) {
	        Ui.popView(Ui.SLIDE_IMMEDIATE);
	        var colors = [Gfx.COLOR_BLUE, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW];
	        
	        Ui.pushView(new ScreenPickerView(Gfx.COLOR_BLUE), new ColorPickerDelegate(colors, method(:onColorSelected)), Ui.SLIDE_RIGHT);
        }
        else if (item == :selectAlert) {
	        Ui.popView(Ui.SLIDE_IMMEDIATE);
	        var colors = [Gfx.COLOR_BLUE, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW];
	        
	        Ui.pushView(new AlertView(Gfx.COLOR_BLUE), new AlertViewDelegate(colors, method(:onColorSelected)), Ui.SLIDE_RIGHT);
        }
        else if (item == :duration) {
        	var durationPickerModel = new DurationPickerModel();
	        Ui.popView(Ui.SLIDE_IMMEDIATE);
    		Ui.pushView(new DurationPickerView(durationPickerModel), new DurationPickerDelegate(durationPickerModel, me.mMeditateModel), Ui.SLIDE_RIGHT);
        }
    }
    
    function onColorSelected(color) {
    	System.println("color: " + color);
    }

}