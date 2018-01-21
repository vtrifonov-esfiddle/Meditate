using Toybox.Attention;

class Vibration {
	static function vibrate(pattern) {
		var vibrationProfile;
		switch (pattern) {
			case VibrationPattern.LongContinuous:
				vibrationProfile = getLongContinuous();
				break;
			case VibrationPattern.LongPulsating:
				vibrationProfile = getLongPulsating();
				break;
			case VibrationPattern.LongAscending:
				vibrationProfile = getLongAscending();
				break;
			case VibrationPattern.MediumContinuous:
				vibrationProfile = getMediumContinuous();
				break;
			case VibrationPattern.MediumPulsating:
				vibrationProfile = getMediumPulsating();
				break;
			case VibrationPattern.MediumAscending:
				vibrationProfile = getMediumAscending();
				break;
			case VibrationPattern.ShortContinuous:
				vibrationProfile = getShortContinuous();
				break;
			case VibrationPattern.ShortPulsating:
				vibrationProfile = getShortPulsating();
				break;
			case VibrationPattern.ShortAscending:
				vibrationProfile = getShortAscending();
				break;
			default:
				vibrationProfile = getLongPulsating();
				break;
		}
		Attention.vibrate(vibrationProfile);
	}
	
	static function getLongPulsating() {
		return [
			new Attention.VibeProfile(100, 1000),
	        new Attention.VibeProfile(0, 1000),
	        new Attention.VibeProfile(100, 1000),
	        new Attention.VibeProfile(0, 1000), 
	        new Attention.VibeProfile(100, 1000),
	        new Attention.VibeProfile(0, 1000),
	        new Attention.VibeProfile(100, 1000)
		];
	}
	
	static function getLongAscending() {
		return [
	        new Attention.VibeProfile(20, 1000),
	        new Attention.VibeProfile(30, 1000),
	        new Attention.VibeProfile(60, 1000), 
	        new Attention.VibeProfile(80, 1000),
	        new Attention.VibeProfile(90, 1000),
	        new Attention.VibeProfile(100, 1000)
		];
	}
	
	static function getLongContinuous() {
		return [
			new Attention.VibeProfile(100, 4000)
		];
	}
	
	static function getMediumPulsating() {
		return [
			new Attention.VibeProfile(100, 1000),
	        new Attention.VibeProfile(0, 1000),
	        new Attention.VibeProfile(100, 1000)
		];
	}
	
	static function getMediumAscending() {
		return [
	        new Attention.VibeProfile(33, 1000),
	        new Attention.VibeProfile(66, 1000),
	        new Attention.VibeProfile(100, 1000)
		];
	}
	
	static function getMediumContinuous() {
		return [
			new Attention.VibeProfile(100, 2000)
		];
	}
	
	static function getShortPulsating() {
		return [
			new Attention.VibeProfile(100, 333),
	        new Attention.VibeProfile(0, 333),
	        new Attention.VibeProfile(100, 333)
		];
	}
	
	static function getShortAscending() {
		return [
	        new Attention.VibeProfile(33, 333),
	        new Attention.VibeProfile(66, 333),
	        new Attention.VibeProfile(100, 333)
		];
	}
	
	static function getShortContinuous() {
		return [
			new Attention.VibeProfile(100, 500)
		];
	}
}