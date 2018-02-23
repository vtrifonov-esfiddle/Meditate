using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang;

class DurationPickerView extends Ui.View {
	private var mModel;
	private var mDone;
	private var mDigitsOutputBuilder;
	
    function initialize(model, digitsOutputBuilder) {
        View.initialize();     
        me.mModel = model;
        me.mDone = new Rez.Drawables.done();
        me.mDigitsOutputBuilder = digitsOutputBuilder;
    }
    
    var mDigitsLayout;
    var mDigitsOutput;
    
    // Load your resources here
    function onLayout(dc) {
    	var digitsOutput = me.mDigitsOutputBuilder.build(dc);
    	me.mDigitsLayout = new DigitsLayout(dc.getWidth(), dc.getHeight(), digitsOutput);
        setLayout(me.mDigitsLayout.digitsLayout);
        me.mDigitsOutput = me.mDigitsLayout.getDigitsOutput();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	me.setKeyToSelectableInteraction(true);
    	me.mModel.reset();
    	me.mDigitsOutput.setInitialHintLayout();
    }
	
	function updateDisableDigitsStatus() {
		if (me.mModel.pickerPos == :durationPicker_initialHint || me.mModel.pickerPos == :durationPicker_finish) {  
			me.mDigitsLayout.disableAllDigits();
    	}   	    	
    	    	
		var digit;
    	switch (me.mModel.pickerPos) {
			case :durationPicker_start :
				me.mDigitsLayout.enableAllDigits();
				break;
			case :durationPicker_hoursLow :
				for (digit = 0; digit < 6; digit++) {
	    			me.mDigitsLayout.enableDigitState(digit);
	    		}
				for (digit = 6; digit < 10; digit++) {
	    			me.mDigitsLayout.disableDigitState(digit);
	    		}
				break;
			case :durationPicker_minutesHigh :
			case :durationPicker_minutesLow :
				me.mDigitsLayout.enableAllDigits();
				break;		
		}
	}	
		
    // Update the view
    function onUpdate(dc) {     
    	me.updateDisableDigitsStatus();
   	    	
    	switch (me.mModel.pickerPos) {
			case :durationPicker_initialHint:
				me.mDigitsOutput.setInitialHintLayout();
				break;
			case :durationPicker_start :
				me.mDigitsOutput.setHoursSelected();
				break;
			case :durationPicker_hoursLow :
				me.mDigitsOutput.setHoursLow(me.mModel.hoursLow);				
				me.mDigitsOutput.setMinutesHighSelected();
				break;
			case :durationPicker_minutesHigh :
				me.mDigitsOutput.setMinutesHigh(me.mModel.minutesHigh);				
				me.mDigitsOutput.setMinutesLowSelected();
				break;
			case :durationPicker_minutesLow :				
				me.mDigitsOutput.setMinutesLow(me.mModel.minutesLow);				
				me.mDigitsOutput.setFinish();
				break;		
		}  	
				
    	View.onUpdate(dc);
    	     	
		if (me.mModel.pickerPos == :durationPicker_minutesLow || me.mModel.pickerPos == :durationPicker_finish) {					
			me.mModel.pickerPos = :durationPicker_finish;			
       		me.mDone.draw(dc);
		}		
		
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
