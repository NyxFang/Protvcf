package pages.about{
	
	import flash.display.MovieClip;
	
	import flash.events.Event;
	
	import com.greensock.TweenMax;
	import pages.index.event.MenuEvent;
	import components.loader.EffectOutEvent;
	import components.scrollPanel.ScrollPanel;
	import components.bottomcomponents.BottomComponents;
	
	public class About extends MovieClip{
		
		private var introduce:MovieClip;
		
		private var scrollPanel:ScrollPanel;
		
		public function About(){
			
			addEventListener(Event.ADDED_TO_STAGE,initCell);
			
		}// end About()
		
		private function initCell(evt:Event):void{
			
			this.addFrameScript(68,initScroll);
			
			this.addFrameScript(105,initBottom);
			
		}// end initCell();
		
		private function initBottom():void{
			
			var bottom:BottomComponents = new BottomComponents(this.getChildByName("itemContent") as MovieClip);
			
		}
		
		private function initScroll():void{
			
			introduce = this.getChildByName("introduce_mc") as MovieClip;
			
			var sp = new ScrollPanel();
			
			introduce["bar_mc"].buttonMode = true;
			
			sp.initScrollPanel({width:221,height:248},introduce["content_mc"],introduce["scrollbar_mc"],introduce["bar_mc"],"vertical");
			
		}// end initScroll();
		
		public function effectIn():void{
			
			this.play();
			
		}// end effectIn();
		
		public function effectOut():void{
			
			TweenMax.to(this,1.7,{frame:MovieClip(this).totalFrames,onComplete:dispathOut});
			
		}// end effectOut()
		
		private function dispathOut():void{
			
			this.dispatchEvent(new EffectOutEvent(EffectOutEvent.EFFECT_OUT_COMPLETE));
			
		}// end dispatchOut()
		
	}// end class
	
}// end package
		