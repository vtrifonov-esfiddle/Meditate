using Toybox.WatchUi as Ui;

class VibrationPatternMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnVibrationPatternPicked;
	
    function initialize(onVibrationPatternPicked) {
        MenuInputDelegate.initialize();
        me.mOnVibrationPatternPicked = onVibrationPatternPicked;
    }
		
    function onMenuItem(item) {
    	if (item == :longContinuous) {
        	me.mOnVibrationPatternPicked.invoke(VibrationPattern.LongContinuous);
        }    
        else if (item == :longPulsating) {
        	me.mOnVibrationPatternPicked.invoke(VibrationPattern.LongPulsating);
        }
        else if (item == :longAscending) {
        	me.mOnVibrationPatternPicked.invoke(VibrationPattern.LongAscending);
        } 
        else if (item == :mediumContinuous) {
        	me.mOnVibrationPatternPicked.invoke(VibrationPattern.MediumContinuous);
        }    
        else if (item == :mediumPulsating) {
        	me.mOnVibrationPatternPicked.invoke(VibrationPattern.MediumPulsating);
        }
        else if (item == :mediumAscending) {
        	me.mOnVibrationPatternPicked.invoke(VibrationPattern.MediumAscending);
        }
        else if (item == :shortContinuous) {
        	me.mOnVibrationPatternPicked.invoke(VibrationPattern.ShortContinuous);
        }    
        else if (item == :shortPulsating) {
        	me.mOnVibrationPatternPicked.invoke(VibrationPattern.ShortPulsating);
        }
        else if (item == :shortAscending) {
        	me.mOnVibrationPatternPicked.invoke(VibrationPattern.ShortAscending);
        }                  
    }

}