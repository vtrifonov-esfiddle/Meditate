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
	        
	        Ui.pushView(new ColorPickerView(Gfx.COLOR_BLUE), new ColorPickerDelegate(colors, method(:onColorSelected)), Ui.SLIDE_LEFT);
        }
        else if (item == :selectAlert) {
	        Ui.popView(Ui.SLIDE_IMMEDIATE);
	        var colors = [Gfx.COLOR_BLUE, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW];
	        
	        var alertModel = new DetailsModel();
	        alertModel.color = Gfx.COLOR_BLUE;
	        alertModel.title = "Alert";
	        
	        alertModel.detailLines[1].icon = Rez.Drawables.durationIcon;
	        alertModel.detailLines[1].text = "1h 15m 40s";
	        
	        alertModel.detailLines[2].icon = Rez.Drawables.vibrateIcon;
	        alertModel.detailLines[2].text = "long pulsating";
	        
	        alertModel.detailLines[3].icon = Rez.Drawables.intermediateAlertsIcon;
	        alertModel.detailLines[3].text = "Inter bar chart";
	        
	        alertModel.detailLines[4].icon = Rez.Drawables.heartRateMinIcon;
	        alertModel.detailLines[4].text = "48 bpm";
	        
	        alertModel.detailLines[5].icon = Rez.Drawables.heartRateMaxIcon;
	        alertModel.detailLines[5].text = "85 bpm";
	        
	        Ui.pushView(new AlertView(alertModel), new AlertViewDelegate(colors, method(:onColorSelected), alertModel), Ui.SLIDE_LEFT);
        }
        else if (item == :duration) {
        	var durationPickerModel = new DurationPickerModel();
	        Ui.popView(Ui.SLIDE_IMMEDIATE);
    		Ui.pushView(new DurationPickerView(durationPickerModel), new DurationPickerDelegate(durationPickerModel, me.mMeditateModel), Ui.SLIDE_LEFT);
        }
    }
    
    function onColorSelected(color) {
    }

}