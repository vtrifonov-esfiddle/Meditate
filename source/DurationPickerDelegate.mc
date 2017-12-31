using Toybox.WatchUi as Ui;
using Toybox.Lang;

class DurationPickerDelegate extends Ui.BehaviorDelegate {
	private var mModel;
	private var mMeditateModel;
	
    function initialize(durationPickerModel, meditateModel) {
        Ui.BehaviorDelegate.initialize();
        me.mModel = durationPickerModel;
        me.mMeditateModel = meditateModel;
    }
	
	function onSelect() {
		if (me.mModel.pickerPos == :durationPicker_finish) {
			me.pickFinalDuration();
		}
		else if (me.mModel.pickerPos == :durationPicker_initialHint) {			
			me.mModel.pickerPos = :durationPicker_start;
			me.mModel.hoursHigh = "#";
			Ui.requestUpdate();
		}
	}
	
	function pickFinalDuration() {
		var durationMins = me.mModel.hoursHigh * 600 + me.mModel.hoursLow * 60 + me.mModel.minutesHigh * 10 + me.mModel.minutesLow;
		System.println(durationMins);
		me.mMeditateModel.setDuration(durationMins);
		Ui.popView(Ui.SLIDE_RIGHT);
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
					me.mModel.pickerPos = :durationPicker_hoursHigh;					
					me.mModel.hoursHigh = instance.getDigitValue();
					me.mModel.hoursLow = "#";
					break;
				case :durationPicker_hoursHigh :
					me.mModel.pickerPos = :durationPicker_hoursLow;					
					me.mModel.hoursLow = instance.getDigitValue();
					me.mModel.minutesHigh = "#";
					break;
				case :durationPicker_hoursLow :
					me.mModel.pickerPos = :durationPicker_minutesHigh;					
					me.mModel.minutesHigh = instance.getDigitValue();
					me.mModel.minutesLow = "#";
					break;
				case :durationPicker_minutesHigh :
					me.mModel.pickerPos = :durationPicker_minutesLow;					
					me.mModel.minutesLow = instance.getDigitValue();
					break;		
			}
			Ui.requestUpdate();
		}
		
        return true;
    }
    
    function onBack() {
    	System.println("onBack: " + me.mModel.pickerPos);
    	switch (me.mModel.pickerPos) {
				case :durationPicker_start :			
					Ui.popView(Ui.SLIDE_RIGHT);
					break;
				case :durationPicker_hoursHigh :
					me.mModel.pickerPos = :durationPicker_start;	
					me.mModel.hoursHigh = "#";
					me.mModel.hoursLow = "0";
					break;
				case :durationPicker_hoursLow :
					me.mModel.pickerPos = :durationPicker_hoursHigh;
					me.mModel.hoursLow = "#";
					me.mModel.minutesHigh = "0";
					break;
				case :durationPicker_minutesHigh :
					me.mModel.pickerPos = :durationPicker_hoursLow;		
					me.mModel.minutesHigh = "#";
					me.mModel.minutesLow = "0";
					break;		
				case :durationPicker_minutesLow :
					me.mModel.pickerPos = :durationPicker_minutesHigh;	
					me.mModel.minutesLow = "#";
					break;
			}
		Ui.requestUpdate();
    	return true;
    }
    
    function onSwipe(evt) {
    	return true;
	}
}