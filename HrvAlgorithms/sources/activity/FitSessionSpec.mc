using Toybox.ActivityRecording;

module HrvAlgorithms {
	class FitSessionSpec {
		private static const SUB_SPORT_YOGA = 43;
		private static const SUB_SPORT_BREATHWORKS = 62;
		
		static function createYoga() {
			return {
                 :name => "Yoga",                              
                 :sport => ActivityRecording.SPORT_TRAINING,      
                 :subSport => SUB_SPORT_YOGA
                };
		}
		
		static function createBreathworks(sessionName) {
			return {
                 :name => sessionName,                              
                 :sport => ActivityRecording.SPORT_TRAINING,      
                 :subSport => SUB_SPORT_BREATHWORKS
                };
		}
	}
}