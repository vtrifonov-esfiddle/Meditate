using Toybox.WatchUi as Ui;

class YesNoDelegate extends YesDelegate {
	private var mOnNo;

    function initialize(onYes, onNo) {
    	YesDelegate.initialize(onYes);
        me.mOnNo = onNo;
    }

    function onResponse(value) {
    	YesDelegate.onResponse(value);
    	if (value == Ui.CONFIRM_NO) {     		
        	me.mOnNo.invoke();   
    	}
    }    
}