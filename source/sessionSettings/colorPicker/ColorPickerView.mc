using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class ColorPickerView extends ScreenPickerView {
	private var mColor;
	
	function initialize(color) {
		ScreenPickerView.initialize();
		me.mColor = color;
	}
	
	function onUpdate(dc) {		
		if(me.mColor != Gfx.COLOR_TRANSPARENT) {		        
        	dc.setColor(Gfx.COLOR_TRANSPARENT, me.mColor);
        }
        else {
        	dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        }        
        dc.clear();
        
        ScreenPickerView.onUpdate(dc);
        if (me.mColor == Gfx.COLOR_TRANSPARENT) {
        	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        	var transparentText = Ui.loadResource(Rez.Strings.intervalAlertTransparentColorText);
        	dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_SYSTEM_MEDIUM, transparentText, Gfx.TEXT_JUSTIFY_CENTER);
        }     
    }
}