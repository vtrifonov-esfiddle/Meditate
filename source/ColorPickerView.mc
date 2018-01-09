using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ColorPickerView extends ScreenPickerView {
	private var mColor;
	
	function initialize(color) {
		ScreenPickerView.initialize();
		me.mColor = color;
	}
	
	function onUpdate(dc) {				        
        dc.setColor(Gfx.COLOR_TRANSPARENT, me.mColor);        
        dc.clear();
        
        ScreenPickerView.onUpdate(dc);     
    }
}