using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class DurationPicker extends Ui.Picker {

    function initialize(initialMinutes) {
        var title = new Ui.Text({:text=>Rez.Strings.durationPickerTitle, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER, :color=>Gfx.COLOR_WHITE});
        var hours = new HoursFactory();        
        var minutes = new MinutesFactory();
                
        Picker.initialize({:title=>title, :pattern=>[hours, minutes], :defaults=> me.getDefaults(initialMinutes)});
    }
    
    function getDefaults(initialMinutes) {
        var defaultHours = initialMinutes / 60;
        var defaultMinutes = initialMinutes % 60;
        
        return [defaultHours, defaultMinutes];
    }
    
	function getSeparator() {
		var separator = new Ui.Text({:text=>":", :color=>Gfx.COLOR_WHITE, :font => Gfx.FONT_SYSTEM_SMALL, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER });
		return separator;
	}
	
    function onUpdate(dc) {
        Picker.onUpdate(dc);
    }
}