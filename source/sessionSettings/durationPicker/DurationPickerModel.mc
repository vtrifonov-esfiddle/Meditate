module DurationPickerPos {
	enum {
		InitialHint = -1,
		Finish = -2,
	} 
}

class DurationPickerModel {
	function initialize(count, onHintPos, onDigitPicked, onFinishPos, onUndo) {
		me.mDigits = new [count];
		me.mOnHintPos = onHintPos;
		me.mOnDigitPicked = onDigitPicked;
		me.mOnFinishPos = onFinishPos;
		me.mOnUndo = onUndo;
		me.reset();	
	}
		
	private const InitialHint = -1;	
	private var mDigits;
	private var mPickerPos;	
	private var mOnHintPos;
	private var mOnDigitPicked;
	private var mOnFinishPos;
	private var mOnUndo;
	
	function reset() {
		me.mPickerPos = InitialHint;	
		for (var i = 0; i < me.mDigits.size(); i++) {
			me.mDigits[i] = 0;
		}
		me.mOnHintPos.invoke();
	}
		
	function pickDigit(digit) {
		me.mPickerPos++;
		me.mDigits[me.mPickerPos] = digit;
		if (me.isFinishPos()) {
			me.mOnFinishPos.invoke();
		}
		else {
			me.mOnDigitPicked.invoke(me.mPickerPos, digit);
		}
	}
	
	function undo() {
		me.mDigits[me.mPickerPos] = 0;
		me.mPickerPos--;
		if (me.isInitialHintPos()) {
			me.mOnHintPos.invoke();
		}
		else {
			me.mOnUndo(me.mPickerPos);
		}
	}
	
	function startPickingDigits() {
		me.mPickerPos = 0;
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
