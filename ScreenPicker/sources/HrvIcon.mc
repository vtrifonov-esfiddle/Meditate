using Toybox.Graphics as Gfx;

module ScreenPicker {
	class HrvIcon extends Icon {
		function initialize(icon) {
			icon[:font] = StatusIconFonts.fontAwesomeFreeSolid;			
			icon[:symbol] = StatusIconFonts.Rez.Strings.faHeartbeat;
			if (icon[:color] == null) {
				icon[:color] = HeartBeatPurpleColor;
			}
				
			Icon.initialize(icon);
		}
		
		const HeartBeatPurpleColor = 0xFF00FF;
		
		function setStatusDefault() {
			me.setColor(HeartBeatPurpleColor);
		}
		
		function setStatusOn() {
			me.setColor(HeartBeatPurpleColor);
		}
		
		function setStatusOnDetailed() {
			me.setColor(Gfx.COLOR_BLUE);
		}
		
		function setStatusOff() {
			me.setColor(Gfx.COLOR_LT_GRAY);
		}
		
		function setStatusWarning() {
			me.setColor(Gfx.COLOR_YELLOW);
		}
	} 
}