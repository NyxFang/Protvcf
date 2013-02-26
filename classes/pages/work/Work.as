package pages.work{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	
	import com.greensock.TweenMax;
	import pages.index.event.MenuEvent;
	import components.loader.EffectOutEvent;
	
	public class Work extends MovieClip{
		
		private var workintro:WorkIntro
		
		public function Work(){
			
			this.addFrameScript(47,initCell);
			
		}// end About()
		
		private function initCell():void{
			
			this.stop();

			var section:MovieClip = this.getChildByName("section_mc") as MovieClip;
			
			workintro = new WorkIntro(section["section_1"]);
			
		}
		
		public function effectIn():void{
			
			this.play();
			
		}// end effectIn();
		
		public function effectOut():void{
			
			TweenMax.to(this,1.7,{frame:MovieClip(this).totalFrames,onComplete:dispathOut});
			
		}// end effectOut()
		
		private function dispathOut():void{
			
			this.dispatchEvent(new EffectOutEvent(EffectOutEvent.EFFECT_OUT_COMPLETE));
			
			workintro.clear();
			
		}// end dispatchOut()
		
	}// end class
	
}// end package
		