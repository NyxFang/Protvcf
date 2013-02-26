package pages.contact{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	
	import com.greensock.TweenMax;
	
	public class Map extends MovieClip{
		
		private var closeBtn:MovieClip;
		
		public function Map(){
			
			this.addFrameScript(21,initCell);
			
			
		}// end Map()
		
		public function initCell():void{
			
			closeBtn = this.getChildByName("closebtn") as MovieClip;
			
			closeBtn.addEventListener(MouseEvent.CLICK,closeMap);
			
			closeBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			closeBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
		}// end intCell()
		
		private function closeMap(evt:MouseEvent):void{
			
			clear();
			
			this.play();
			
		}// end closeMap();
		
		private function outHandler(evt:MouseEvent):void{
			
			TweenMax.to(closeBtn,0.3,{frame:1});
			
		}// end outHandler();
		
		private function overHandler(evt:MouseEvent):void{
			
			TweenMax.to(closeBtn,0.3,{frame:closeBtn.totalFrames});
			
		}// end overHandler();
		
		private function clear():void{
			
			closeBtn.removeEventListener(MouseEvent.CLICK,closeMap);
			
			closeBtn.removeEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			closeBtn.removeEventListener(MouseEvent.ROLL_OVER,overHandler);
			
		}// end clear();
		
	}// end class
	
}// end package