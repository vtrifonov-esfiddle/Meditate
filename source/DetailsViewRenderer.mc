using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang;

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
        dc.setColor(me.mDetailsModel.titleColor, Gfx.COLOR_TRANSPARENT); 
       	me.displayTitle(dc, me.mDetailsModel.title);
		
		for (var lineNumber = 1; lineNumber <= me.mDetailsModel.detailLines.size(); lineNumber++) {
        	dc.setColor(me.mDetailsModel.color, Gfx.COLOR_TRANSPARENT); 
			var line = me.mDetailsModel.detailLines[lineNumber];
			if (line.icon != null) {
				me.displayIcon(dc, lineNumber, line.icon, line.iconOffset);
			}
			if (line.value instanceof TextLine) {
       			me.displayText(dc, lineNumber, line.value.text, line.valueOffset);  
       		}
   			else if	(line.value instanceof PercentageHighlightLine) {
   				me.drawPercentageHighlightLine(dc, lineNumber, line.value.getHighlights(), line.value.backgroundColor, line.valueOffset);
   			}
       	}       
    }
    
    private const ProgressBarWidth = 150;
    private const ProgressBarHeight = 16;
    
    private function drawPercentageHighlightLine(dc, lineNumber, highlights, backgroundColor, valueOffset) {
    	var highlightKeys = highlights.keys();
    	var valuePosXOffset = dc.getWidth() / 3.4 + valueOffset;
    	var posY = me.getLinePosY(lineNumber) + 10;
		
		dc.setColor(backgroundColor, Gfx.COLOR_TRANSPARENT);
		dc.fillRectangle(valuePosXOffset, posY, ProgressBarWidth, ProgressBarHeight);   
		
		var highlightWidth = 0.015 * ProgressBarWidth;		
    	for (var i = 0; i < highlights.size(); i++) {
    		var sectionKey = highlightKeys[i];
    		var highlight = highlights[sectionKey];
    		var valuePosX = valuePosXOffset + highlight.progressPercentage * ProgressBarWidth;
    		dc.setColor(highlight.color, Gfx.COLOR_TRANSPARENT);
    		dc.fillRectangle(valuePosX, posY, highlightWidth, ProgressBarHeight);    		
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
    
    private function displayText(dc, lineNumber, text, valueOffset) {   
        var textX = dc.getWidth() / 3.4 + valueOffset;
        var posY = getLinePosY(lineNumber);		
        
        dc.drawText(textX, posY, Gfx.FONT_SYSTEM_SMALL, text, Gfx.TEXT_JUSTIFY_LEFT);
    }    
}