package components.loader{
	
	import flash.events.Event;
	
	public class EffectOutEvent extends Event{
		
		public static const EFFECT_OUT_COMPLETE:String = "effect_out_complete";
		
		/*public var complete:String = "complete";
		
		public function EffectOutEvent(type:String,_complete:String):void{
			
			
		}*/
		
		public function EffectOutEvent(type:String){

			super(type,true,true);
			
		}
		
	}// end class
	
}// end package