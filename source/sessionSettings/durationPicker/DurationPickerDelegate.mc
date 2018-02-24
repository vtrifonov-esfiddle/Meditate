using Toybox.WatchUi as Ui;
using Toybox.Lang;

class DurationPickerDelegate extends Ui.BehaviorDelegate {
	private var mModel;
	private var mOnDigitsPicked;
	
    function initialize(durationPickerModel, onDigitsPicked) {
        Ui.BehaviorDelegate.initialize();
        me.mModel = durationPickerModel;
        me.mOnDigitsPicked = onDigitsPicked;
    }
	
	function onSelect() {
		if (me.mModel.isFinishPos()) {
			me.finishPickingDigits();
		}
		else if (me.mModel.isInitialHintPos()) {	
			me.mModel.startPickingDigits();
			Ui.requestUpdate();
		}
	}
	
	function finishPickingDigits() {
		Ui.popView(Ui.SLIDE_RIGHT);
		me.mOnDigitsPicked.invoke(me.mModel.getDigits());
	}
	
	function onSelectable(event) {	
		me.onSelect();
		
        var instance = event.getInstance();       
        if (event.getPreviousState() == :stateDisabled) {
        	instance.setState(:stateDisabled);
        }
		if (instance instanceof DigitButton && instance.getState() == :stateSelected) {		
			me.mModel.pickDigit(instance.getDigitValue());				
			Ui.requestUpdate();
		}
		
        return true;
    }
    
    function onBack() {
    	if (me.mModel.isInitialHintPos()) {
    		return false;
    	}
    	me.mModel.undo();
		Ui.requestUpdate();
    	return true;
    }
}