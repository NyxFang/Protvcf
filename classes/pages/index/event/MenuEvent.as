package pages.index.event{
	
	import flash.events.Event;
	
	public class MenuEvent extends Event{
		
		public static const MENU_ITEM_CLICK:String = "menu_item_click";
		
		public var menuItem:int;
		
		public function MenuEvent(type:String,_menuItem:int){
			
			super(type,true,true);
			
			menuItem = _menuItem;
			
		}// end MenuEvent()
		
	}// end class
	
	
}// end package