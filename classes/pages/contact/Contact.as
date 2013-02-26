package pages.contact{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	
	import com.greensock.TweenMax;
	import components.loader.EffectOutEvent;
	
	public class Contact extends MovieClip{
		
		private var mapMC:MovieClip;
		
		private var mapitemCtrl:Map;
		
		public function Contact(){
			
			addFrameScript(177,initCell);
			
		}// end Contact()
		
		private function initCell():void{
			
			this.stop();
			
			for(var i:int = 0 ; i < 3 ; i++){
				
				var btnItem:MovieClip = this["btngroup_mc"].getChildByName("btnItem_"+i) as MovieClip;
				
				btnItem.addEventListener(MouseEvent.CLICK,clickHandler);
				
				btnItem.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
				btnItem.addEventListener(MouseEvent.ROLL_OVER,overHandler);
				
			}// end for
			
			mapMC = this.getChildByName("map_mc") as MovieClip;
			
		}// end initCell()
		
		private function clickHandler(evt:MouseEvent):void{
			
			var str:String = evt.currentTarget.name;
			
			var frame:int = int(str.substr(str.indexOf("_")+1));
			
			mapMC.gotoAndStop(frame+1);
			
			mapMC.addFrameScript(frame,mapShow);
			
		}// end clickHandler();
		
		private function mapShow():void{
			
			var mapitem:MovieClip = mapMC.getChildByName("map") as MovieClip;
			
			mapitem.gotoAndPlay(2);
						
		}// end mapShow()
		
		private function outHandler(evt:MouseEvent):void{
			
			TweenMax.to(MovieClip(evt.currentTarget),0.5,{frame:1});
			
		}// end outHandler();
		
		private function overHandler(evt:MouseEvent):void{
			
			TweenMax.to(MovieClip(evt.currentTarget),0.5,{frame:MovieClip(evt.currentTarget).totalFrames});
			
		}// end overHandler();
		
		public function effectIn():void{
			
			this.play();
			
		}
		
		public function effectOut():void{
			
//			mapMC.close();
			
			TweenMax.to(this,1.6,{frame:MovieClip(this).totalFrames,onComplete:dispathOut});
			
		}
		
		private function dispathOut():void{
			
			this.dispatchEvent(new EffectOutEvent(EffectOutEvent.EFFECT_OUT_COMPLETE));
			
		}
		
	}// end class;
	
}// end package