using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang;
using Toybox.Application as App;

module ScreenPicker {
	class DetailsViewRenderer {
		private const TitlePosY = 20;
		
		private var mDetailsModel;
		
		function initialize(detailsModel) {
			me.mDetailsModel = detailsModel;
			me.progressBarWidth = App.getApp().getProperty("progressBarWidth");
		}
		
		function renderBackgroundColor(dc) {				        
	        dc.setColor(Gfx.COLOR_TRANSPARENT, me.mDetailsModel.backgroundColor);        
	        dc.clear();        
	    }
	    
	    function renderDetailsView(dc) {
	        dc.setColor(me.mDetailsModel.titleColor, Gfx.COLOR_TRANSPARENT); 
	       	me.displayTitle(dc, me.mDetailsModel.title, me.mDetailsModel.titleFont);
			
			for (var lineNumber = 1; lineNumber <= me.mDetailsModel.detailLines.size(); lineNumber++) {
	        	dc.setColor(me.mDetailsModel.color, Gfx.COLOR_TRANSPARENT); 
				var line = me.mDetailsModel.detailLines[lineNumber];	
				if (line.icon != null) {
					me.displayFontIcon(dc, line.icon, line.getIconYPos());
				}
				if (line.value instanceof TextValue) {
					me.displayText(dc, line.value, line.getYPos());  
	   			}
	   			else if	(line.value instanceof PercentageHighlightLine) {
	   				var alertsLineYPos = line.getYPos() + line.value.yOffset;
	   				me.drawPercentageHighlightLine(dc, line.value.getHighlights(), line.value.backgroundColor, line.value.startPosX, alertsLineYPos);
	   			}
	   		}   
	    }
	    
	    private var progressBarWidth;
	    private const ProgressBarHeight = 16;
	    
	    private function drawPercentageHighlightLine(dc, highlights, backgroundColor, startPosX, posY) {		
			dc.setColor(backgroundColor, Gfx.COLOR_TRANSPARENT);
			dc.fillRectangle(startPosX, posY, progressBarWidth, ProgressBarHeight);   
			
			var highlightWidth = 0.03 * progressBarWidth;		
	    	for (var i = 0; i < highlights.size(); i++) {
	    		var highlight = highlights[i];
	    		var valuePosX = startPosX + highlight.progressPercentage * progressBarWidth;
	    		dc.setColor(highlight.color, Gfx.COLOR_TRANSPARENT);
	    		dc.fillRectangle(valuePosX, posY, highlightWidth, ProgressBarHeight);    		
	    	}
	    }
	    
	    private function displayTitle(dc, title, titleFont) {
	        var textX = dc.getWidth() / 2;	
	        dc.drawText(textX, TitlePosY, titleFont, title, Gfx.TEXT_JUSTIFY_CENTER);
	    }	      
	        	
		private function displayFontIcon(dc, icon, yPos) {
			icon.setYPos(yPos);
			icon.draw(dc);
		}
		    
	    private function displayText(dc, value, yPos) {   
	        dc.setColor(value.color, Gfx.COLOR_TRANSPARENT);
	        dc.drawText(value.xPos, yPos, value.font, value.text, Gfx.TEXT_JUSTIFY_LEFT);
	    }    
	}
}