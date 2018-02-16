using Toybox.WatchUi as Ui;

class IntervalVibePatternMenuDelegate extends Ui.MenuInputDelegate {
	private var mOnVibePatternPicked;
	
    function initialize(onVibePatternPicked) {
        MenuInputDelegate.initialize();
        me.mOnVibePatternPicked = onVibePatternPicked;
    }
		
    function onMenuItem(item) {
    	if (item == :shortContinuous) {
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