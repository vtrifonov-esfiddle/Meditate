using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AlertView extends ScreenPickerView {
	private var mLineNumber;
	private const InitialTextPosY = 30;
	private const TextPosYOffset = 30;
	
	function initialize(color) {
		ScreenPickerView.initialize(color);
		me.mLineNumber = 1;
	}
	
	function onUpdate(dc) {		
		ScreenPickerView.onUpdate(dc);
			                
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT); 
       	me.displayIconText(dc, "TM", "15m 40s");
        me.displayIconText(dc, "VB", "Long");
        me.displayIconText(dc, "TP", "one-off");
        me.displayIconText(dc, "I1", "");
        me.displayIconText(dc, "I2", "");
        me.displayIconText(dc, "I3", "");
    }
    
    private function displayIconText(dc, icon, text) {   
        var centerX = dc.getWidth() / 2;
        var posY = me.mLineNumber * TextPosYOffset;
        
        var iconLineOffset;
        switch (me.mLineNumber) {
        	case 1:
        		iconLineOffset = 48;
        		break;
        	case 2:
        		iconLineOffset = 28;
        		break;
        	case 3:
        		iconLineOffset = 20;
        		break;
        	case 4:
        		iconLineOffset = 20;
        		break;
        	case 5:
        		iconLineOffset = 30;
        		break;
        	case 6:
        		iconLineOffset = 55;
        		break;
		}
		        
        var iconX = iconLineOffset;
        dc.drawText(iconX, posY, Gfx.FONT_SYSTEM_SMALL, icon, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(centerX, posY, Gfx.FONT_SYSTEM_SMALL, text, Gfx.TEXT_JUSTIFY_CENTER);
        me.mLineNumber += 1;
    }
    
    private function displayText(dc, text) {   
        var centerX = dc.getWidth() / 2;
        var posY = me.mLineNumber * TextPosYOffset;
        dc.drawText(centerX, posY, Gfx.FONT_SYSTEM_TINY, text, Gfx.TEXT_JUSTIFY_CENTER);
        me.mLineNumber += 1;
    }
}