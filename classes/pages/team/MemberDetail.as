package pages.team{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	
	import com.greensock.TweenMax;
	
	public class MemberDetail{
		
		private var closeBtn:MovieClip;
		
		private var view:MovieClip;
		
		public function MemberDetail(_view:MovieClip){
			
			view = _view;
			
			view.gotoAndPlay(2);
			
			view.addFrameScript(29,initCell);
			
			
		}// end Map()
		
		private function initCell():void{
						
			closeBtn = view.getChildByName("closebtn") as MovieClip;
			
			closeBtn.addEventListener(MouseEvent.CLICK,closePopup);
			
			//closeBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			//closeBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
		}// end intCell()
		
		private function closePopup(evt:MouseEvent):void{
			
			clear();
			
			view.dispatchEvent(new LoopEvent(LoopEvent.LOOP_START));
			
			view.gotoAndPlay(view.currentFrame+1);
			
		}// end closeMap();
		
		private function outHandler(evt:MouseEvent):void{
			
			TweenMax.to(closeBtn,0.3,{frame:1});
			
		}// end outHandler();
		
		private function overHandler(evt:MouseEvent):void{
			
			TweenMax.to(closeBtn,0.3,{frame:closeBtn.totalFrames});
			
		}// end overHandler();
		
		private function clear():void{
			
			closeBtn.removeEventListener(MouseEvent.CLICK,closePopup);
			
			//closeBtn.removeEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			//closeBtn.removeEventListener(MouseEvent.ROLL_OVER,overHandler);
			
		}// end clear();
		
	}// end class
	
}// end package