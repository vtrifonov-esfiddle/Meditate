using Toybox.Graphics as Gfx;

module ScreenPicker {
	class BreathIcon extends Icon {
		function initialize(icon) {
			icon[:font] = StatusIconFonts.fontMeditateIcons;
			icon[:symbol] = StatusIconFonts.Rez.Strings.meditateFontBreath;
			icon[:color] = BreathIconLightBlueColor;
			Icon.initialize(icon);
		}

		const BreathIconLightBlueColor = 0x6060FF;
	}
}