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
	        var colors = [Gfx.COLOR_BLUE, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW];
	        
	        Ui.switchToView(new ColorPickerView(Gfx.COLOR_BLUE), new ColorPickerDelegate(colors, method(:onColorSelected)), Ui.SLIDE_LEFT);
        }
        else if (item == :selectAlert) {
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
	        
	        var alertModel2 = new DetailsModel();
	        alertModel2.color = Gfx.COLOR_PINK;
	        alertModel2.title = "Alert 2";
	        
	        alertModel2.detailLines[1].icon = Rez.Drawables.durationIcon;
	        alertModel2.detailLines[1].text = "18m 00s";
	        
	        alertModel2.detailLines[2].icon = Rez.Drawables.vibrateIcon;
	        alertModel2.detailLines[2].text = "medium constant";
	        
	        alertModel2.detailLines[3].icon = Rez.Drawables.intermediateAlertsIcon;
	        alertModel2.detailLines[3].text = "chart";
	        
	        alertModel2.detailLines[4].icon = Rez.Drawables.heartRateMinIcon;
	        alertModel2.detailLines[4].text = "57 bpm";
	        
	        alertModel2.detailLines[5].icon = Rez.Drawables.heartRateMaxIcon;
	        alertModel2.detailLines[5].text = "66 bpm";
	        Ui.switchToView(new AlertView(alertModel), new AlertViewDelegate(method(:onAlertSelected), [alertModel, alertModel2]), Ui.SLIDE_LEFT);
        }
        else if (item == :duration) {
        	var durationPickerModel = new DurationPickerModel();
	        Ui.popView(Ui.SLIDE_IMMEDIATE);
    		Ui.pushView(new DurationPickerView(durationPickerModel), new DurationPickerDelegate(durationPickerModel, me.mMeditateModel), Ui.SLIDE_LEFT);
        }
    }
    
    function onColorSelected(color) {
    }
    
    function onAlertSelected(alert) {
    }

}