using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class DurationPicker extends Ui.Picker {

    function initialize(initialMinutes) {
        var title = new Ui.Text({:text=>Rez.Strings.durationPickerTitle, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER, :color=>Gfx.COLOR_WHITE});
        var minutesHigh = new MinutesFactory(0, 6, Gfx.FONT_SYSTEM_MEDIUM);        
        var minutesLow = new MinutesFactory(0, 9, Gfx.FONT_SYSTEM_MEDIUM);   
                
        Picker.initialize({:title=>title, :pattern=>[minutesHigh, minutesLow], :defaults=> me.getDefaults(initialMinutes)});
    }
    
    function getDefaults(initialMinutes) {
        var minutesHigh = (initialMinutes % 60) / 10;
        var minutesLow = initialMinutes % 10;
        
        return [minutesHigh, minutesLow];
    }

    function onUpdate(dc) {
        Picker.onUpdate(dc);
    }
}