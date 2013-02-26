package pages.work{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	import flash.utils.Timer;
	
	import flash.text.TextField;
	
	import com.greensock.TweenMax;
	import components.utils.DataStream;
	import com.greensock.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.*;
	
	public class ImageDetailSection{
		
		private var view:MovieClip;
		
		private var image_Group:MovieClip;
		
		private var backBtn:MovieClip;
		
		private const SPACE:int = 5; 
		
		private const SPEED:int = 2;
		
		private var timer:Timer;
		
		private var itemArr:Array;
		
		private var queue:LoaderMax;
		
		private var loadingmc:MovieClip;
		
		private var loadingContent:MovieClip;
		
		private var loadingTxt:TextField;
		
		public function ImageDetailSection(_view:MovieClip,_loadingmc:MovieClip){
			
			view = _view;
			
			loadingmc = _loadingmc;
			
			loadingmc.visible = false;
			
			view.visible = true;
			
			image_Group = view.getChildByName("image_group") as MovieClip;
			
			loadingContent = loadingmc.getChildByName("loading_mc") as MovieClip;
			
			loadingTxt = loadingmc.getChildByName("txt") as TextField;
			
			image_Group.alpha = 0;
			
			itemArr = [];
			
			timer = new Timer(24);
			
			timer.addEventListener(TimerEvent.TIMER,loop);
			
			backBtn = view.getChildByName("backbtn") as MovieClip;
			
			backBtn.addEventListener(MouseEvent.CLICK,backHandler);
			
			effectIn();
			
		}// end VideoDetailSection
		
		public function setData(_xml:XML):void{
			
			queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			
			for(var i:int = 0 ; i<_xml["items"]["item"].length(); i++){
				
				var item:ImageItem = new ImageItem(startTimer,stopTimer);
				
				//item.startLoad(_xml["items"]["item"][i]["imagesection_thumbnail"],_xml["items"]["item"][i]["imagesection_txt"]);
				
				queue.append(new ImageLoader(_xml["items"]["item"][i]["imagesection_thumbnail"],{name:i+"thumbnail", container:item.imageContent, x:0, y:0, width:item.imageContent.width, height:item.imageContent.height}));
																																																					
				queue.append(new ImageLoader(_xml["items"]["item"][i]["imagesection_txt"],{name:i+"title", container:item.infoContent, x:0, y:0, width:item.infoContent.width, height:item.infoContent.height}));	
				
				if(i == 0){
					
					item.x = 0;
					
				}
				
				item.x = (item.width + SPACE)*i;
				
				image_Group.addChild(item);
				
				item.index = i;
				
				itemArr.push(item);
				
			}// end for()
			
			queue.load();
			
			//startTimer();
			
		}// end setData();
				
		public function loop(evt:TimerEvent):void{
			
			image_Group.x-=SPEED;
			
			if(image_Group.x%(itemArr[0].width+SPACE) == 0 || image_Group.x%(itemArr[0].width+SPACE) == -1){
				
				changeArr()
			}
			
		}// end StartMove();
		
		private function changeArr():void{
			
			itemArr[0].alpha = 1;
			
			itemArr[0].x = itemArr[itemArr.length-1].x + itemArr[itemArr.length-1].width + SPACE;
					
			itemArr.push(itemArr.shift());
			
		}// end changeArr()
		
		public function startTimer():void{
			
			timer.start();
			
		}
		
		public function stopTimer():void{
			
			timer.reset();
			
			timer.stop();
			
		}// end StopMove();
		
		
		private function backHandler(evt:MouseEvent):void{
			
			stopTimer();
			
			timer.removeEventListener(TimerEvent.TIMER,loop);
			
			timer = null;
			
			TweenMax.to(view,0.5,{alpha:0,onComplete:function(){
			
				view["parent"].gotoAndPlay(1);
				
				view.visible = false;
				
			}});
			
		}// end backHandler();
		
		public function effectOut():void{
									
			TweenMax.to(view,0.5,{autoAlpha:0});
						
		}// end effectOut();
		
		public function effectIn():void{
			
			TweenMax.to(view,0.5,{autoAlpha:1});
			
		}// end effectIn();
		
		public function enabledMouse(_i:int,_enabled:Boolean):void{
			
			itemArr[_i].itemBtnEnabeld(_enabled);
			
		}
		
		private function progressHandler(event:LoaderEvent):void {
			
			loadingmc.visible = true;
			
			loadingmc.alpha = 1;
			
     		loadingTxt.text = String(int(queue.progress*100)+"%");
 		}
 
		private function completeHandler(event:LoaderEvent):void {
   			
			startTimer();
			
			loadingmc.visible = false;
			
			TweenLite.to(image_Group, 1, {alpha:1});
			
		}
 
		private function errorHandler(event:LoaderEvent):void {
    		trace("error occured with " + event.target + ": " + event.text);
		}
		
		public function clear():void{
			
			
		}
		
	}// end class
	
}// end package