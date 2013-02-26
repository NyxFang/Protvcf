package pages.team{
	
	import flash.events.Event;
	
	public class LoopEvent extends Event{
		
		public static const LOOP_STOP:String = "loop_stop";
		
		public static const LOOP_START:String = "loop_start";
		
		public function LoopEvent(type:String){
			
			super(type,true,true);
			
		}// end MenuEvent()
		
	}// end class
	
	
}// end package