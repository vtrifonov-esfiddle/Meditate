using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang;

class DurationPickerView extends Ui.View {
	private var mModel;
	private var mDone;
	
    function initialize(model) {
        View.initialize();        
        me.mModel = model;
        me.mDone = new Rez.Drawables.done();
    }
    
    var mDigitsLayout;
    
    // Load your resources here
    function onLayout(dc) {
    	me.mDigitsLayout = new DigitsLayout(dc);
        setLayout(me.mDigitsLayout.digitsLayout);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	me.mModel.reset();
    	me.mDigitsLayout.updateDurationText("Pick HH:MM");
    }
	
	function updateDisableDigitsStatus() {
		if (me.mModel.pickerPos == :durationPicker_initialHint || me.mModel.pickerPos == :durationPicker_finish) {  
			me.mDigitsLayout.disableAllDigits();
    	}   	    	
    	    	
		var digit;
    	switch (me.mModel.pickerPos) {
			case :durationPicker_start :
				for (digit = 3; digit < 10; digit++) {
	    			me.mDigitsLayout.disableDigitState(digit);
	    		}
	    		for (digit = 0; digit < 3; digit++) {
	    			me.mDigitsLayout.enableDigitState(digit);
	    		}
				break;
			case :durationPicker_hoursHigh :
				if (me.mModel.hoursHigh > 1) {
					for (digit = 0; digit < 5; digit++) {
		    			me.mDigitsLayout.enableDigitState(digit);
		    		}
					for (digit = 5; digit < 10; digit++) {
		    			me.mDigitsLayout.disableDigitState(digit);
		    		}			    		
	    		}
	    		else {
	    			me.mDigitsLayout.enableAllDigits();
	    		}
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
    	    	
    	if (me.mModel.pickerPos != :durationPicker_initialHint && me.mModel.pickerPos != :durationPicker_finish) {  
   			me.mDigitsLayout.updateDurationText(Lang.format("$1$$2$:$3$$4$", [me.mModel.hoursHigh, me.mModel.hoursLow, 
   				me.mModel.minutesHigh, me.mModel.minutesLow]));
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
