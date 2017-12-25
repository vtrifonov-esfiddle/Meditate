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
    	me.mDigitsLayout.updateDurationText("Pick duration");
    }
	
	
    // Update the view
    function onUpdate(dc) {     
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
