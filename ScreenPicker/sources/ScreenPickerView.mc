using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

module ScreenPicker {
	class ScreenPickerView extends Ui.View {	
		function initialize(upDownArrowsColor) {
			View.initialize();
			me.mUpArrow = new Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faSortUp,
	        	:color=>upDownArrowsColor,
	        	:justify => Gfx.TEXT_JUSTIFY_CENTER
	        });
			me.mDownArrow = new Icon({        
	        	:font => StatusIconFonts.fontAwesomeFreeSolid,
	        	:symbol => StatusIconFonts.Rez.Strings.faSortDown,
	        	:color=>upDownArrowsColor,
	        	:justify => Gfx.TEXT_JUSTIFY_CENTER
	        });
		}
		
		private var mUpArrow;
		private var mDownArrow;
		
		protected function setArrowsColor(color) {
			me.mUpArrow.setColor(color);
			me.mDownArrow.setColor(color);
		}
		
		function onUpdate(dc) {	
			var centerXPos = dc.getWidth() / 2;
			me.mUpArrow.setXPos(centerXPos);
			me.mUpArrow.setYPos(0);
			me.mUpArrow.draw(dc);
			me.mDownArrow.setXPos(centerXPos);
			me.mDownArrow.setYPos(dc.getHeight() - dc.getFontHeight(StatusIconFonts.fontAwesomeFreeSolid));
			me.mDownArrow.draw(dc);          
	    }
	}
}