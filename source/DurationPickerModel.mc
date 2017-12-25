class DurationPickerModel {
	function initialize() {
		me.reset();	
	}
	
	function reset() {
		me.pickerPos = :durationPicker_initialHint;	
		me.hoursHigh = "0";
		me.hoursLow = "0";
		me.minutesHigh = "0";
		me.minutesLow = "0";	
	}
		
	var hoursHigh;
	var hoursLow;
	var minutesHigh;
	var minutesLow; 	
	var pickerPos;	
}
