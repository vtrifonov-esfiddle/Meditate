using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Lang;

class DurationPickerView extends Ui.View {
	private var mModel;
	private var mDone;
	private var mDigitsLayoutBuilder;
	
    function initialize(model, digitsLayoutBuilder) {
        View.initialize();     
        me.mModel = model;
        me.mDone = new Rez.Drawables.done();
        me.mDigitsLayoutBuilder = digitsLayoutBuilder;
    }
        
    var mDigitsLayout;
    var mDigitsOutput;
    
    // Load your resources here
    function onLayout(dc) {
    	me.mDigitsLayout = me.mDigitsLayoutBuilder.build(dc);
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
	
	function updateEnabledDigitsStatus() {
		me.mDigitsLayout.setEnabledDigits(me.mModel.getPickerPos()+1);
	}	
		
    // Update the view
    function onUpdate(dc) {     
    	me.updateEnabledDigitsStatus();
    	if (me.mModel.isInitialHintPos()) {    		
    		me.mDigitsOutput.setInitialHintLayout();
    	}
    	else {
   	    	me.mDigitsOutput.setSelectedDigit(me.mModel.getPickerPos(), me.mModel.getDigits());	
   	    }
				
    	View.onUpdate(dc);
    	     	
		if (me.mModel.isFinishPos()) {							
       		me.mDone.draw(dc);
		}				
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
