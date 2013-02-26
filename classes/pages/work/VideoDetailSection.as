package pages.work{
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import flash.net.URLRequest;
	
	import com.greensock.TweenMax;
	import components.utils.DataStream;
	import components.flvplayer.FlvPlayer;
	import pages.index.event.BGMEvent;
	
	public class VideoDetailSection{
		
		private var view:MovieClip;
		
		private var leftBtn:MovieClip;
		
		private var rightBtn:MovieClip;
		
		private var backBtn:MovieClip;
		
		private var titleContent:MovieClip;
		
		private var flvContent0:MovieClip;
		
		private var flvContent1:MovieClip;
		
		private var tempMC:MovieClip;
		
		private var backMC:MovieClip;
		
		private var currentMC:MovieClip;
		
		private var flvPlayer:FlvPlayer;
		
		private var loader:Loader;
		
		public var data:XML;
		
		public var count:int;
		
		public var total:int;
		
		private var callBack:Function;
		
		public function VideoDetailSection(_view:MovieClip,_callBack:Function){
			
			view = _view;
						
			callBack = _callBack;
			
			initCell();
			
		}// end VideoDetailSection
		
		private function initCell():void{
			
			leftBtn = view.getChildByName("leftbtn") as MovieClip;
			
			rightBtn = view.getChildByName("rightbtn") as MovieClip;
			
			backBtn = view.getChildByName("backbtn") as MovieClip;
			
			titleContent = view.getChildByName("titlecontent") as MovieClip;
			
			flvContent0 = view.getChildByName("playerUI_0") as MovieClip;
			
			flvContent1 = view.getChildByName("playerUI_1") as MovieClip;
			
			currentMC = flvContent0;

			backMC = flvContent1;
			
			loader = new Loader();
			
			configEvents();
			
		}// end initCell();
		
		private function configEvents():void{
			
			leftBtn.addEventListener(MouseEvent.CLICK,leftHandler);
			
			rightBtn.addEventListener(MouseEvent.CLICK,rightHandler);
			
			backBtn.addEventListener(MouseEvent.CLICK,backHandler);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
			
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioerrorHandler);
			
		}// end configEvents();
		
		private function leftHandler(evt:MouseEvent):void{
			
			clear();
			
			leftBtn.mouseChildren = leftBtn.mouseEnabled = rightBtn.mouseChildren = rightBtn.mouseEnabled = false;
			
			rightBtn.visible = true;
			
			if(count>0){
				
				count -=1;
				
			}
			
			if(count == 0){
				
				leftBtn.visible = false;
				
			}
			
			backMC.x = 180;
			
			TweenMax.to(currentMC,0.5,{alpha:0,scaleX:0.8,scaleY:0.8,x: 470 ,y:265,onComplete:recoveMouse});
			
			TweenMax.to(backMC,0.5,{alpha:1,scaleX:1,scaleY:1,x:275,y:239});
			
			titleInit(data["items"]["item"][count]["videosection_title_image"]);
			
		}// end leftHandler();
		
		private function rightHandler(evt:MouseEvent):void{
			
			clear();
			
			leftBtn.mouseChildren = leftBtn.mouseEnabled = rightBtn.mouseChildren = rightBtn.mouseEnabled = false;
			
			leftBtn.visible = true;
			
			if(count<total-1){
				
				count +=1;
				
			}
			
			if(count == total-1){
				
				rightBtn.visible = false;
				
			}
			
			backMC.x = 470;
			
			TweenMax.to(currentMC,0.5,{alpha:0,scaleX:0.8,scaleY:0.8,x: 180 ,y:265,onComplete:recoveMouse});
			
			TweenMax.to(backMC,0.5,{alpha:1,scaleX:1,scaleY:1,x:275,y:239});
					
			titleInit(data["items"]["item"][count]["videosection_title_image"]);
			
		}// end rightHandler();
		
		private function recoveMouse():void{
			
			changeFlvs();
			
			leftBtn.mouseChildren = leftBtn.mouseEnabled = rightBtn.mouseChildren = rightBtn.mouseEnabled = true;
			
			flvInit(data["items"]["item"][count]["videosection_video_path"],data["items"]["item"][count]["videosection_video_thumbnail"]);
			
		}
		
		private function changeFlvs():void{
			
			tempMC = backMC;
			
            backMC = currentMC;
			
            currentMC = tempMC;
			
			//tempMC["pic_holder"].removeChildAt(0);
			try{
			currentMC["pic_holder"].removeChildAt(0);
			}catch(e:Error){};
			backMC["pic_holder"].removeChildAt(0);
			
		}
		
		
		private function backHandler(evt:MouseEvent):void{
			
			//view.dispatchEvent(new BGMEvent(BGMEvent.UN_OR_MUTE));
			
			clear();
			
			callBack();
			
		}// end backHandler();
		
		public function flvInit(_flvpath:String,_imagePath:String):void{
			
			currentMC.alpha = 1;
			
			currentMC.visible = true;
			
			flvPlayer = new FlvPlayer(currentMC);
			
			currentMC["pic_holder"].visible = false;
			
			flvPlayer.videoURL = _flvpath
			
			flvPlayer.imageURL = _imagePath;
			
			flvPlayer.playImage();
			
			
		}// end flvinit();
		
		public function titleInit(_path:String):void{
			
			loader.unload()
			
			loader.load(new URLRequest(_path));
			
		}// end startLoader();
		
		private function completeHandler(evt:Event):void{
			
			titleContent.addChild(loader);
			
		}// end completeHandler();
		
		private function ioerrorHandler(evt:IOErrorEvent):void{
			
			trace("path.. error")
			
		}
		
		public function effectOut():void{
			
			TweenMax.to(view,0.5,{autoAlpha:0});
						
		}// end effectOut();
		
		public function effectIn():void{
			
			TweenMax.to(view,0.5,{autoAlpha:1});
			
		}// end effectIn();
		
		public function clear():void{
						
			flvPlayer.clear();
			
		}// end clear();
		
	}// end class
	
}// end package