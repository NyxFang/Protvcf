package pages.intro{
	
	import flash.display.MovieClip;
	
	import components.loader.EffectOutEvent;
	import pages.index.event.MenuEvent;
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;
	
	public class Intro extends MovieClip{
		
		public function Intro(){
			
			this["skipbtn"].addEventListener(MouseEvent.CLICK,clickHandler);
			
		}// end Intro
		
		private function clickHandler(evt:MouseEvent):void{
			
			TweenMax.to(this["video_mc"],0.5,{alpha:0,onComplete:skipHandler});
			
			this["skipbtn"].removeEventListener(MouseEvent.CLICK,clickHandler);
			
		}
		
		private function skipHandler():void{
			
			this["video_mc"].gotoAndStop(this["video_mc"].totalFrames);
			
		}
		
		public function effectIn():void{
			
			
			
		}// end effectIn();
		
		public function effectOut():void{

			this.gotoAndStop(2);
			
			this.dispatchEvent(new EffectOutEvent(EffectOutEvent.EFFECT_OUT_COMPLETE));
			
		}
		
	}// end clas
	
}// end package