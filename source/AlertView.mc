using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class AlertView extends ScreenPickerView {
	private var mLineNumber;
	private const InitialTextPosY = 30;
	private const TextPosYOffset = 30;
	private const TitlePosY = 20;
	private const IconX = 30;
	
	function initialize(color) {
		ScreenPickerView.initialize(color);
		me.mLineNumber = 1;
	}
	
	function onUpdate(dc) {		
		ScreenPickerView.onUpdate(dc);			              

        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT); 
       	me.displayTitle(dc, "Alert");
		
		me.displayIcon(dc, 1, Rez.Drawables.durationIcon);
       	me.displayText(dc, 1, "1h 15m 40s");
       	
   		me.displayIcon(dc, 2, Rez.Drawables.vibrateIcon);
       	me.displayText(dc, 2, "long pulsating");
		
   		me.displayIcon(dc, 3, Rez.Drawables.intermediateAlertsIcon);
        me.displayText(dc, 3, "inter bar chart");
        
   		me.displayIcon(dc, 4, Rez.Drawables.heartRateMinIcon);
        me.displayText(dc, 4, "48 bpm");
        
   		me.displayIcon(dc, 5, Rez.Drawables.heartRateMaxIcon);
        me.displayText(dc, 5, "85 bpm");
    }  
    	
    function displayTitle(dc, title) {
        var textX = dc.getWidth() / 2;	
        dc.drawText(textX, TitlePosY, Gfx.FONT_SYSTEM_MEDIUM, title, Gfx.TEXT_JUSTIFY_CENTER);
    }	
    
    function getLinePosY(lineNumber) {
    	return lineNumber * TextPosYOffset + InitialTextPosY;
    }
    	
	function displayIcon(dc, lineNumber, drawableId) {
        var posY = getLinePosY(lineNumber);
        
		var bitmap = new Ui.Bitmap({
	         :rezId=>drawableId,
	         :locX=>IconX,
	         :locY=>posY
     	});
     	bitmap.draw(dc);
	}
    
    private function displayText(dc, lineNumber, text) {   
        var textX = dc.getWidth() / 3.4;
        var posY = getLinePosY(lineNumber);		
        
        dc.drawText(textX, posY, Gfx.FONT_SYSTEM_SMALL, text, Gfx.TEXT_JUSTIFY_LEFT);
        me.mLineNumber += 1;
    }    
}