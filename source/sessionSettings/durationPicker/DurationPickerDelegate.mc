using Toybox.WatchUi as Ui;
using Toybox.Lang;

class DurationPickerDelegate extends Ui.BehaviorDelegate {
	private var mModel;
	private var mOnDurationPicked;
	
    function initialize(durationPickerModel, onDurationPicked) {
        Ui.BehaviorDelegate.initialize();
        me.mModel = durationPickerModel;
        me.mOnDurationPicked = onDurationPicked;
    }
	
	function onSelect() {
		if (me.mModel.pickerPos == :durationPicker_finish) {
			me.pickFinalDuration();
		}
		else if (me.mModel.pickerPos == :durationPicker_initialHint) {			
			me.mModel.pickerPos = :durationPicker_start;
			Ui.requestUpdate();
		}
	}
	
	function pickFinalDuration() {
		var durationMins = me.mModel.hoursLow * 60 + me.mModel.minutesHigh * 10 + me.mModel.minutesLow;
		Ui.popView(Ui.SLIDE_RIGHT);
		me.mOnDurationPicked.invoke(durationMins);
	}
	
	function onSelectable(event) {	
		me.onSelect();
		
        var instance = event.getInstance();       
        if (event.getPreviousState() == :stateDisabled) {
        	instance.setState(:stateDisabled);
        }
		if (instance instanceof DigitButton && instance.getState() == :stateSelected) {						
			switch (me.mModel.pickerPos) {
				case :durationPicker_start :							
					me.mModel.hoursLow = instance.getDigitValue();
					me.mModel.pickerPos = :durationPicker_hoursLow;		
					break;
				case :durationPicker_hoursLow :								
					me.mModel.minutesHigh = instance.getDigitValue();
					me.mModel.pickerPos = :durationPicker_minutesHigh;	
					break;
				case :durationPicker_minutesHigh :								
					me.mModel.minutesLow = instance.getDigitValue();
					me.mModel.pickerPos = :durationPicker_minutesLow;	
					break;							
			}
			Ui.requestUpdate();
		}
		
        return true;
    }
    
    function onBack() {
    	switch (me.mModel.pickerPos) {
				case :durationPicker_start :	
					me.mModel.hoursLow = "0";
					Ui.popView(Ui.SLIDE_RIGHT);
					break;
				case :durationPicker_hoursLow :
					me.mModel.pickerPos = :durationPicker_start;
					me.mModel.minutesHigh = "0";
					break;
				case :durationPicker_minutesHigh :
					me.mModel.pickerPos = :durationPicker_hoursLow;		
					me.mModel.minutesLow = "0";
					break;		
				case :durationPicker_minutesLow :
					me.mModel.pickerPos = :durationPicker_minutesHigh;	
					break;
			}
		Ui.requestUpdate();
    	return true;
    }
    
    function onSwipe(evt) {
    	return true;
	}
}