package pages.work{
	
	import flash.events.Event;
	
	public class WorkEvent extends Event{
		
		public static const ITEM_CLICK:String = "image_section_item_click";
		
		public var item:int;
		
		public function WorkEvent(type:String,_item:int){
			
			super(type,true,true);
			
			item = _item;
			
		}// end MenuEvent()
		
	}// end class
	
	
}// end package