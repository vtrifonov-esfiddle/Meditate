using Toybox.WatchUi as Ui;

class YesDelegate extends Ui.ConfirmationDelegate {
	private var mOnYes;
	
    function initialize(onYes) {
        ConfirmationDelegate.initialize();
        me.mOnYes = onYes;
    }

    function onResponse(value) {
        if (value == Ui.CONFIRM_YES) {  
        	me.mOnYes.invoke();      	    
        }        
    }
}