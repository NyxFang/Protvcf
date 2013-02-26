package pages.work{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	
	import com.greensock.TweenMax;
	import components.utils.DataStream;
	
	public class WorkIntro{
		
		private var view:MovieClip;
		
		private var btnGroup:MovieClip;
		
		private var tvcBtn:MovieClip;
		
		private var videoBtn:MovieClip;
		
		private var viralBtn:MovieClip;
		
		private var tvc_moreBtn:MovieClip;
		
		private var making_offBtn:MovieClip;
				
		private var tempbtn:MovieClip;		
				
		private var imageSection_view:MovieClip;
		
		private var videoSection_view:MovieClip;
		
		private var imageSection:ImageDetailSection;
		
		private var videoSection:VideoDetailSection;
		
		private var path:String = URLPath.TVC_XML;
		
		private var data:XML;
		
		private var item_count:int = 0;
		
		private var loading:MovieClip;
		
		private var timerflag:Boolean = true;
		
		public function WorkIntro(_view:MovieClip){
			
			view = _view;
			
			view.addFrameScript(25,initBtn);
						
		}// end WorkIntro
		
		private function initBtn():void{
			
			view.stop();
			
			loading = view.getChildByName("load_mc") as MovieClip
			
			loading.visible = false;
			
			btnGroup = view.getChildByName("btngroup") as MovieClip;
			
			tvcBtn = btnGroup.getChildByName("tvc") as MovieClip;
			
			tvcBtn.play();
			
			videoBtn = btnGroup.getChildByName("video") as MovieClip;
			
			viralBtn = btnGroup.getChildByName("viral") as MovieClip;
			
			tvc_moreBtn = btnGroup.getChildByName("tvcmore") as MovieClip;
			
			making_offBtn = btnGroup.getChildByName("makingoff") as MovieClip;
			
			tempbtn = tvcBtn;
			
			initSectionView();
			
			configEvents();
			
		}// end initCell()
		
		private function initSectionView():void{
			
			imageSection_view = view.getChildByName("imagesection") as MovieClip;
			
			imageSection_view.visible = false;
			
			videoSection_view = view.getChildByName("videosection") as MovieClip;
			
			videoSection_view.visible = false;
			
			videoSection = new VideoDetailSection(videoSection_view,videoSectionBack);
			
			imageSection = new ImageDetailSection(imageSection_view,loading);
			
			imageSection.effectOut();
			
		}
		
		private function configEvents():void{
			
			tvcBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
			tvcBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			tvcBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
			videoBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
			videoBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			videoBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
			viralBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
			viralBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			viralBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
						
			tvc_moreBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
			tvc_moreBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			tvc_moreBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
			making_offBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
			making_offBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			making_offBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
			view.addEventListener(WorkEvent.ITEM_CLICK,itemClickHandler);
			
			setPath();
			
		}// end configEvents()
		
		private function clickHandler(evt:MouseEvent):void{
			
			loading["txt"].text = "0%";
			
			TweenMax.to(tempbtn,0.5,{frame:1});
			
			if(tempbtn == MovieClip(evt.currentTarget)){
				
				return;
				
			}
			
			tempbtn = evt.currentTarget as MovieClip;
			
			imageSection.effectOut();
			
			imageSection.clear();
			
			imageSection.stopTimer();
			
			imageSection_view.x = 0;
			
			imageSection_view.visible = false;
			
			switch(evt.currentTarget.name){
				
				case "tvc" :{
					
					path = URLPath.TVC_XML;
					
					timerflag = true;
					
					break;
				}
				case "video" :{
					
					path = URLPath.VIDEO_XML;
					
					timerflag = true;
					
					break;
				}
				case "viral" :{
					
					path = URLPath.VIRAL_XML;
					
					timerflag = true;
					
					break;
				}
				case "tvcmore" :{
					
					path = URLPath.TVC_MORE_XML;
					
					timerflag = true;
					
					break;
				}
				case "makingoff":{
					
					path = URLPath.MAKING_OFF_XML;
					
					timerflag = false;
					
					break;
					
				}
				
			}// end swicth()
			
			setPath();
			
		}
		
		private function setPath():void{
			
			var ds:DataStream = new DataStream(success,fail);
			
			ds.getData(path);
			
		}
		
		private function success(_xml:XML):void{
			
			imageSection.effectIn();
			
			data = _xml;
			
			imageSection.setData(_xml,timerflag);
			
		}// end tvcSuccess();
		
		private function itemClickHandler(evt:WorkEvent):void{
			
			item_count = evt.item;
			
			TweenMax.to(btnGroup,0.5,{autoAlpha:0});
			
			imageSection.effectOut();
			
			imageSection.stopTimer();
			
			videoSection.effectIn();
			
			videoSection.flvInit(data["items"]["item"][evt.item]["videosection_video_path"],data["items"]["item"][evt.item]["videosection_video_thumbnail"]);
			
			videoSection.titleInit(data["items"]["item"][evt.item]["videosection_title_image"]);
			
			//trace(data["items"]["item"][evt.item]["videosection_video_path"],data["items"]["item"][evt.item]["videosection_video_thumbnail"])
			
			videoSection.data = data;
			
			videoSection.count = evt.item;
			
			videoSection.total = data["items"]["item"].length();
			
		}// end workEvent();
		
		private function videoSectionBack():void{
			
			imageSection.effectIn();
			
			videoSection.effectOut();
			
			if(!timerflag){
				
				imageSection.stopTimer();
				
			}
			
			TweenMax.to(btnGroup,0.5,{autoAlpha:1});
			
			imageSection.enabledMouse(item_count,true);
			
		}
		
		private function outHandler(evt:MouseEvent):void{
			
			if(tempbtn == MovieClip(evt.currentTarget)){
				
				return;
				
			}
			
			var temp:MovieClip  = MovieClip(evt.currentTarget);
			
			TweenMax.to(temp,0.5,{frame:1});
			
		}// end outHandler();
		
		private function overHandler(evt:MouseEvent):void{
									
			var temp:MovieClip  = MovieClip(evt.currentTarget);
			
			TweenMax.to(temp,0.5,{frame:temp.totalFrames});
			
		}// end overHandler();
		
				
		private function fail(_info:String):void{
			
			trace(_info);
			
		}// end fail()
		
		public function clear():void{
			
			imageSection.clear();
			
			videoSection.clear();
			
		}// end clear();
		
	}// end class
	
}// end package;

