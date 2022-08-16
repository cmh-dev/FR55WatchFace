import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

class FR55WatchFaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        drawTime();
        drawBattery();
        drawDate();
        drawBreaks();
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    private function drawTime() {
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour.format("%02d"), clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeDisplay") as Text;
        view.setText(timeString);
    }

    private function drawBattery() {
        var battery = System.getSystemStats().battery;				
        var batteryDisplay = View.findDrawableById("BatteryDisplay"); 
        if (battery <=  25) {
            batteryDisplay.setColor(Graphics.COLOR_RED);
        }
        else if (battery <= 75) {
            batteryDisplay.setColor(Graphics.COLOR_YELLOW); 
        }
        else {
            batteryDisplay.setColor(Graphics.COLOR_GREEN); 
        }      
        batteryDisplay.setText("Battery: " + battery.format("%d") + "%"); 
    }

    private function drawDate() {      
    	var date = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$ $2$ $3$", [date.day, date.month, date.year]);
        var dateDisplay = View.findDrawableById("DateDisplay");      
        dateDisplay.setText(dateString);	    	
    }

    private function drawBreaks() {      
        View.findDrawableById("BottomBreakDisplay").setText("_______________________");    
        View.findDrawableById("TopBreakDisplay").setText("_______________________");    
    }


    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
