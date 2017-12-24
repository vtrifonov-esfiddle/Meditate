using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class MinutesFactory extends Ui.PickerFactory {
    hidden var mStart;
    hidden var mStop;
    hidden var mIncrement;
    hidden var mFormatString;
    hidden var mFont;

    function getIndex(value) {
        var index = (value / mIncrement) - mStart;
        return index;
    }

    function initialize(start, stop, font) {
        PickerFactory.initialize();

        mStart = start;
        mStop = stop;
        mIncrement = 1;

        mFont = font;
    	mFormatString = "%d";
    }

    function getDrawable(index, selected) {
        return new Ui.Text( { :text=>getValue(index).format(mFormatString), :color=>Gfx.COLOR_WHITE, :font=> mFont, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER } );
    }

    function getValue(index) {
        return mStart + (index * mIncrement);
    }

    function getSize() {
        return ( mStop - mStart ) / mIncrement + 1;
    }

}
