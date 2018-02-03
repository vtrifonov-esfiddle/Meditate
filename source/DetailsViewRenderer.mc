using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class DetailsViewRenderer {
	private const InitialTextPosY = 30;
	private const TextPosYOffset = 30;
	private const TitlePosY = 20;
	private const IconX = 30;
	
	private var mDetailsModel;
	
	function initialize(detailsModel) {
		me.mDetailsModel = detailsModel;
	}
	
	function renderBackgroundColor(dc) {				        
        dc.setColor(Gfx.COLOR_TRANSPARENT, me.mDetailsModel.backgroundColor);        
        dc.clear();        
    }
    
    function renderDetailsView(dc) {
        dc.setColor(me.mDetailsModel.color, Gfx.COLOR_TRANSPARENT); 
       	me.displayTitle(dc, me.mDetailsModel.title);
		
		for (var lineNumber = 1; lineNumber <= me.mDetailsModel.detailLines.size(); lineNumber++) {
			var line = me.mDetailsModel.detailLines[lineNumber];
			if (line.icon != null) {
				me.displayIcon(dc, lineNumber, line.icon, line.iconOffset);
			}
			if (line.value instanceof  TextLine) {
       			me.displayText(dc, lineNumber, line.value.text, line.textOffset);  
       		}
   			else if	(line.value instanceof ProgressBarLine) {
   			
   			}
       	}       
    }
    
    private function displayTitle(dc, title) {
        var textX = dc.getWidth() / 2;	
        dc.drawText(textX, TitlePosY, Gfx.FONT_SYSTEM_MEDIUM, title, Gfx.TEXT_JUSTIFY_CENTER);
    }	
    
    private function getLinePosY(lineNumber) {
    	return lineNumber * TextPosYOffset + InitialTextPosY;
    }
    	
	private function displayIcon(dc, lineNumber, drawableId, iconOffset) {
        var posX = IconX + iconOffset;
        var posY = getLinePosY(lineNumber);
        
		var bitmap = new Ui.Bitmap({
	         :rezId=>drawableId,
	         :locX=>posX,
	         :locY=>posY
     	});
     	bitmap.draw(dc);
	}
    
    private function displayText(dc, lineNumber, text, textOffset) {   
        var textX = dc.getWidth() / 3.4 + textOffset;
        var posY = getLinePosY(lineNumber);		
        
        dc.drawText(textX, posY, Gfx.FONT_SYSTEM_SMALL, text, Gfx.TEXT_JUSTIFY_LEFT);
    }    
}