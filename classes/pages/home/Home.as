package pages.home{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	
	import com.greensock.TweenMax;
	import pages.index.event.MenuEvent;
	import components.loader.EffectOutEvent;
	import components.bottomcomponents.BottomComponents;
	
	public class Home extends MovieClip{
		
		private var moreBtn:MovieClip;
		
		
		public function Home(){
			
			this.addFrameScript(67,initCell);
			
			this.addFrameScript(85,initBottom);
			
		}// end Home()
		
		private function initCell():void{
			
			moreBtn = this.getChildByName("morebtn") as MovieClip;
			
			configEvents();
			
		}// end initCell();
		
		private function initBottom():void{
			
			var bottom:BottomComponents = new BottomComponents(this.getChildByName("itemContent") as MovieClip);
			
		}
		
		private function configEvents():void{
			
			moreBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
			moreBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			moreBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
		}// end configEvents();
		
		private function clickHandler(evt:MouseEvent):void{
			
			this.dispatchEvent(new MenuEvent(MenuEvent.MENU_ITEM_CLICK,1));
			
		}// end clickHandler();
		
		private function outHandler(evt:MouseEvent):void{
			
			TweenMax.to(moreBtn,0.5,{frame:1});
			
		}// end outHandler();
		
		private function overHandler(evt:MouseEvent):void{
			
			TweenMax.to(moreBtn,0.5,{frame:moreBtn.totalFrames});
			
		}// end overHandler();
		
		public function effectIn():void{
			
			this.play();
			
		}
		
		public function effectOut():void{
			
			TweenMax.to(this,1.7,{frame:MovieClip(this).totalFrames,onComplete:dispathOut});
			
		}// end effectOut()
		
		private function dispathOut():void{
			
			this.dispatchEvent(new EffectOutEvent(EffectOutEvent.EFFECT_OUT_COMPLETE));
			
		}// end dispatchOut()
		
		public function clear():void{
			
			
			
		}// end clear()
		
	}// end class
	
}// end package