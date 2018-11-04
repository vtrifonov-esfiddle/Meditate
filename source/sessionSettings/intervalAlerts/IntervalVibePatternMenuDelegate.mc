using Toybox.WatchUi as Ui;

class IntervalVibePatternMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnVibePatternPicked;
	
    function initialize(onVibePatternPicked) {
        MenuInputDelegate.initialize();
        me.mOnVibePatternPicked = onVibePatternPicked;
    }
		
    function onMenuItem(item) {
    	if (item == :mediumContinuous) {
        	me.mOnVibePatternPicked.invoke(VibePattern.MediumContinuous);
        }    
        else if (item == :mediumPulsating) {
        	me.mOnVibePatternPicked.invoke(VibePattern.MediumPulsating);
        }
        else if (item == :mediumAscending) {
        	me.mOnVibePatternPicked.invoke(VibePattern.MediumAscending);
        }
    	else if (item == :shortContinuous) {
        	me.mOnVibePatternPicked.invoke(VibePattern.ShortContinuous);
        }    
        else if (item == :shortPulsating) {
        	me.mOnVibePatternPicked.invoke(VibePattern.ShortPulsating);
        }
        else if (item == :shortAscending) {
        	me.mOnVibePatternPicked.invoke(VibePattern.ShortAscending);
        }
        else if (item == :shorterAscending) {
        	me.mOnVibePatternPicked.invoke(VibePattern.ShorterAscending);
        }
        else if (item == :shorterContinuous) {
        	me.mOnVibePatternPicked.invoke(VibePattern.ShorterContinuous);
        }
        else if (item == :blip) {
        	me.mOnVibePatternPicked.invoke(VibePattern.Blip);
        }              
    }
}