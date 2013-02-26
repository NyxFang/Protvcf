package components.flvplayer{
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import pages.index.event.BGMEvent;
	
	public class FlvPlayer{
		
		private var view:MovieClip;
		
		private var video_Holder:MovieClip;
		
		private var pic_Holder:MovieClip;//thumbnail
		
		private var toggleBtn:MovieClip;
		
		private var muteBtn:MovieClip;
		
		private var playedTimeTxt:TextField;
		
		private var totalTimeTxt:TextField; 
		
		private var fullScreenBtn:MovieClip;
		
		private var bar_Holder:MovieClip;
				
		private var progressBar:MovieClip;
		
		private var loadTxt:TextField;
		
		private var video:Video;
		
		private var st:SoundTransform;
		
		private var loader:Loader;
		
		private var connection:NetConnection;
		
        private var stream:NetStream;
		
		private var mediaInfo:Object;
		
		public var imageURL:String;
		
		public var videoURL:String;
		
		public var keeprate:Boolean = true;
		
		public function FlvPlayer(_view:MovieClip):void{
			
			view = _view;
			
			init();
			
		}// end FlvPlayer
		
		private function init():void{
			
			video_Holder = view.getChildByName("video_holder") as MovieClip;
						
			pic_Holder = view.getChildByName("pic_holder") as MovieClip;
			
			pic_Holder.alpha = 1;
			
			pic_Holder.visible = true;
			
			toggleBtn = view.getChildByName("togglebtn") as MovieClip;
			
			muteBtn = view.getChildByName("mute_btn") as MovieClip;
			
			fullScreenBtn = view.getChildByName("fullscreen_btn") as MovieClip;
			
			fullScreenBtn.visible = false;
			
			bar_Holder = view.getChildByName("bar") as MovieClip;
			
			progressBar = bar_Holder.getChildByName("progressbar") as MovieClip;
			
			progressBar.width = 0;
			
			//playedTimeTxt = view.getChildByName("playedtime_txt") as TextField;
			
			//totalTimeTxt = view.getChildByName("totaltime_txt") as TextField;
			
			//loadTxt = view.getChildByName("loadingtxt") as TextField;
			
			//loadTxt.visible = false;
			
//			trace(video_Holder,pic_Holder,toggleBtn,muteBtn,fullScreenBtn,bar_Holder,progressBar,loadTxt);
			
			video = new Video(466,257);
			
			connection = new NetConnection();
			
			connection.connect(null);
			
			stream = new NetStream(connection);
			
			video.attachNetStream(stream);
			
			video_Holder.addChild(video);
			
			st = new SoundTransform;
			
			var client:Object =new Object(); 
			
			client.onMetaData = onMetaData; 

			stream.client = client; 
			
			loader = new Loader();
			
			configEvents();
			
		}// end init()
		
		private function configEvents():void{
            
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,picLoaded);
			
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,IOErrorHandler);
			
			toggleBtn.addEventListener(MouseEvent.CLICK,toggleHandler);
			
			muteBtn.addEventListener(MouseEvent.CLICK,muteHandler);
			
			fullScreenBtn.addEventListener(MouseEvent.CLICK,fullScreen);
			
			progressBar.addEventListener(MouseEvent.CLICK,seekHandler);
			
		}// end configEvents();
		
		public function playVideo():void{
			
			pic_Holder.alpha = 0;
			
			pic_Holder.visible = false;
			
			stream.play(videoURL);
			
			view.dispatchEvent(new BGMEvent(BGMEvent.UN_OR_MUTE));
			
		}
		
		public function playImage():void{
			
			loader.unload();
			
			pic_Holder.visible = false;
			
			loader.load(new URLRequest(imageURL));
			
		}
		
		private function picLoaded(evt:Event):void{
			
			/*var bit:Bitmap = evt.target.content;
			
			bit.width = pic_Holder.width;
			
			bit.height = pic_Holder.height;*/
			try{
			viewClear()
			}catch(e:Error){};
			pic_Holder.visible = true;
			
			pic_Holder.addChildAt(loader,0);
			
		}
		
		private function toggleHandler(evt:MouseEvent):void{
			
			if(toggleBtn.currentFrame==1){
				
				if(progressBar.width<=1){
					
					playVideo();
					
				}else if(Math.min(stream.time,mediaInfo["duration"]) / mediaInfo["duration"]>=0.99){
					
					stream.seek(0);
					
					muteBtn.gotoAndStop(1);
					
				}else{
				
					stream.pause();
				
					toggleBtn.gotoAndStop(2)
				
				}
				
			}else{
				
				stream.resume();
				
				toggleBtn.gotoAndStop(1)
				
			}
			
		}		
		
		private function muteHandler(evt:MouseEvent):void{
			
			if(muteBtn.currentFrame == 1){
				
				st.volume = 0;
				
				muteBtn.gotoAndStop(2);
				
			}else{
				
				st.volume = 0.5;
				
				muteBtn.gotoAndStop(1);
			}
			
			stream.soundTransform = st;
			
		}
		
		private function fullScreen(evt:MouseEvent):void{
			
			var r:Rectangle = view.getBounds(view);
			
			view.stage.fullScreenSourceRect = r
			
			if(fullScreenBtn.currentFrame == 1){
			
				view.stage.displayState = StageDisplayState.FULL_SCREEN;
				
				fullScreenBtn.gotoAndStop(2);
				
			}else{
				
				view.stage.displayState = StageDisplayState.NORMAL;
				
				fullScreenBtn.gotoAndStop(1);
				
			}
			
		}
		
		private function seekHandler(evt:MouseEvent):void{
			
			
			
		}
		
		public function onMetaData(info:Object):void{
			
			this.mediaInfo = info;
			
			st.volume = 0.5;
			
			stream.soundTransform = st;
			
			var rateWidth:Number = mediaInfo["width"] / video_Holder.width ;
			
			var rateHeight:Number = mediaInfo["height"] / video_Holder.height;
			
			var rate:Number;
			
			rate = rateWidth > rateHeight ? rateWidth : rateHeight;
			
			video.width = mediaInfo["width"] / rate;
			
			video.height = mediaInfo["height"] / rate;
			
			video.x = (video_Holder.width - video.width)/2; 
			
			view.addEventListener(Event.ENTER_FRAME,enterFrameHandler);		
			
			//totalTimeTxt.text = timerFotmat(mediaInfo["duration"]);
			
		}
		
		private function timerFotmat(_sec:Number):String{
			
			_sec = int(_sec);
			
			var sec:String = String(_sec%60);
			
			sec = sec.length < 2 ? "0"+sec:sec;
			
			var min:String = String(int(_sec/60)); 
			
			min = min.length < 2 ? "0"+min:min;
			
			return min+":"+sec;
			
		}
		
		private function enterFrameHandler(evt:Event):void{
			
			progressBar.width = Math.min(stream.time,mediaInfo["duration"]) / mediaInfo["duration"] * bar_Holder.width;
			
		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			
            switch (event.info.code) {
				
                case "NetConnection.Connect.Success":
				
                    connectStream();
					
                    break;
					
                case "NetStream.Play.StreamNotFound":
				
                    trace("Unable to locate video: " + videoURL);
					
                    break;
				
				case "NetStream.Play.Stop":
					
					view.dispatchEvent(new BGMEvent(BGMEvent.UN_OR_MUTE));
					
					view.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
					
					break;
				
            }
        }
		
		public function clear():void{
			
			view.dispatchEvent(new BGMEvent(BGMEvent.UN_OR_MUTE));
			
			connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			
			stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
            stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,picLoaded);
			
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,IOErrorHandler);
			
			toggleBtn.removeEventListener(MouseEvent.CLICK,toggleHandler);
			
			muteBtn.removeEventListener(MouseEvent.CLICK,muteHandler);
			
			fullScreenBtn.removeEventListener(MouseEvent.CLICK,fullScreen);
			
			progressBar.removeEventListener(MouseEvent.CLICK,seekHandler);
			
			view.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			
			connection.close();
			
			stream.close();
			
			video.clear();
			
			connection = null;
			
			stream = null;
			
			video = null;
			
		}// end clear();
		
		public function viewClear():void{
			
			while(pic_Holder.numChildren>0){
			
				pic_Holder.removeChildAt(0);
				
			}
		}
		
		private function connectStream():void {
			
            video.attachNetStream(stream);
			
						
        }
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			
            trace("securityErrorHandler: " + event);
			
        }
        
        private function asyncErrorHandler(event:AsyncErrorEvent):void {
            // ignore AsyncErrorEvent events.
        }
		
		private function IOErrorHandler(evt:IOErrorEvent):void {
			
			trace(videoURL+" ----- ioerror ------ "+imageURL);
			
		}
	}// end class
	
}// end package