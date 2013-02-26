package pages.index.event{
	
	import flash.events.Event;
	
	public class BGMEvent extends Event{
		
		public static const UN_OR_MUTE:String = "mute";
		
		public function BGMEvent(type:String){
			
			super(type,true,true);
						
		}// end MenuEvent()
		
	}// end class
	
	
}// end package