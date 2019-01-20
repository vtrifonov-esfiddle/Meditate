using Toybox.WatchUi as Ui;

class EditIntervalAlertsMenuDelegate extends Ui.MenuInputDelegate {
	private var mEditIntervalAlert;
	
    function initialize(editIntervalAlert) {
        MenuInputDelegate.initialize();
        me.mEditIntervalAlert = editIntervalAlert;
    }
		
    function onMenuItem(item) {
    	Ui.popView(Ui.SLIDE_IMMEDIATE);   
    	me.mEditIntervalAlert.invoke(item.toNumber());        
    }
}