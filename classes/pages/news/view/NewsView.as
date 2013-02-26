package pages.news.view{
	
	import flash.display.MovieClip;
	
	import flash.events.Event;
	
	import pages.news.ctrl.NewsAction;
	import com.greensock.TweenMax;
	import components.loader.EffectOutEvent;
	import components.scrollPanel.ScrollPanel;
	
	public class NewsView extends MovieClip{
		
		private var view:MovieClip;
		
		private var scrollContent:MovieClip;
		
		private var newaction:NewsAction;
		
		private var content_frame:int = 1;
		
		private var sp:ScrollPanel;
		
		public function NewsView(){
			
			view = this;
			
			addEventListener(Event.ADDED_TO_STAGE,stageHandler);
			
			
		}// end NewsView()
		
		private function stageHandler(evt:Event):void{
			
			view.addFrameScript(96,initCell);
			
		}
		
		public function effectIn():void{
			
			view.play();
			
		}
		
		public function effectOut():void{
			
			TweenMax.to(this,1.7,{frame:MovieClip(this).totalFrames,onComplete:dispathOut});
			
		}// end effectOut()
		
		private function dispathOut():void{
			
			view.dispatchEvent(new EffectOutEvent(EffectOutEvent.EFFECT_OUT_COMPLETE));
			
		}// end dispatchOut()
		
		
		private function initCell():void{
			
			newaction = new NewsAction();
			
			for(var i:int = 0 ; i< 3; i++){
								
				newaction.push(view["new_list_mc"].getChildByName("listItem_"+i));
				
			}// end for
			
			scrollContent = view.getChildByName("content_mc") as MovieClip;
			
			newaction.callBack = changeContent;
			
			sp = new ScrollPanel();
			
			initScroll();
			
		}// end initCell()
		
		public function changeContent(_frame:int = 1):void{
			
			if(content_frame == _frame){
				
				return;
				
			}
			
			content_frame = _frame;
			
			scrollContent.gotoAndStop(_frame);
			
			scrollContent.addFrameScript(_frame-1,initScroll);
			
		}
		
		private function initScroll():void{
			
			var scroll_mc:MovieClip = scrollContent["content_"+(content_frame-1)]["content_child"];
			
			//trace(scroll_mc["content_mc"],scroll_mc["scrollbarbg"],scroll_mc["scrollbarbtn"]);
			
			if(!scroll_mc["scrollbarbtn"]){
				return;
			}
			
			sp.initScrollPanel({width:358,height:330},scroll_mc["content_mc"],scroll_mc["scrollbarbg"],scroll_mc["scrollbarbtn"],"vertical");
			
		}
		
	}// end class
	
}// end package