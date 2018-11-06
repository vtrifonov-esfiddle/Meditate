class DurationPickerModel {
	function initialize(count) {
		me.mDigits = new [count];
		me.reset();	
	}
		
	private const InitialHint = -2;	
	private var mDigits;
	private var mPickerPos;	
	
	function reset() {
		me.mPickerPos = InitialHint;	
		for (var i = 0; i < me.mDigits.size(); i++) {
			me.mDigits[i] = 0;
		}
	}
		
	function pickDigit(digit) {
		me.mPickerPos++;
		me.mDigits[me.mPickerPos] = digit;
	}
		
	function undo() {
		if (me.mPickerPos >= 0) {
			me.mDigits[me.mPickerPos] = 0;
		}
		me.mPickerPos--;		
	}
	
	function startPickingDigits() {
		me.mPickerPos = -1;
	}
	
	function isInitialHintPos() {
		return me.mPickerPos == InitialHint;
	}
	
	function isInProgressPos() {
		return !me.isInitialHintPos() && !me.isFinishPos();
	}
	
	function isFinishPos() {
		return me.mPickerPos == (me.mDigits.size() - 1);
	}
	
	function getPickerPos() {
		return me.mPickerPos;
	}
		
	function getDigits() {
		return me.mDigits;
	}
}
