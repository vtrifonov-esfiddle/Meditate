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
       	me.displayIconText(dc, "VI", "long");
        me.displayIconText(dc, "TP", "One-off");
        me.displayIconText(dc, "IN", "1m, 5m, 12m");
        me.displayIconText(dc, "IN", "1m, 5h 30m");
        me.displayIconText(dc, "IN", "1m, 5h 30m");
        me.displayIconText(dc, "IN", "5h 30m");
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