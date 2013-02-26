//Created by Action Script Viewer - http://www.buraks.com/asv
package pages.work {
    import flash.events.*;

    public class WorkEvent extends Event {

        public var item:int;

        public static const ITEM_CLICK:String = "image_section_item_click";

        public function WorkEvent(_arg1:String, _arg2:int){
            super(_arg1, true, true);
            item = _arg2;
        }
    }
}//package pages.work 
