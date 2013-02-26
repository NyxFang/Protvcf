package pages.work{
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.SimpleButton;
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import flash.net.URLRequest;
	
	import com.greensock.TweenMax;
	
	public class ImageItem extends MovieClip{
		
		public var imageContent:MovieClip;
		
		public var infoContent:MovieClip;
		
		private var itemBtn:SimpleButton;
		
		private var loader:Loader;
		
		private var loader1:Loader;
		
		private var startMove:Function;
		
		private var stopMove:Function
		
		public var index:int = 0;
		
		private var moveOrNotMove:Boolean = false;
		
		private var timerflag:Boolean ;
		
		public function ImageItem(_startMove:Function,_stopMove:Function,_timerflag:Boolean = true){
			
			startMove = _startMove;
			
			stopMove = _stopMove;
			
			timerflag = _timerflag;
			
			init();
			
		}// end ImageItem();
		
		private function init():void{
			
			imageContent = this.getChildByName("imagecontent") as MovieClip;
			
			infoContent = this.getChildByName("infocontent") as MovieClip;
			
			itemBtn = this.getChildByName("btn") as SimpleButton; 
			
			//loader = new Loader;
			
			//loader1 = new Loader;
			
			configEvents();
			
		}// end init()
		
		private function configEvents():void{
			
			/*loader.contentLoaderInfo.addEventListener(Event.COMPLETE,imageLoaded);
			
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioerrorHandler);
			
			loader1.contentLoaderInfo.addEventListener(Event.COMPLETE,infoLoaded);
			
			loader1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioerrorHandler);*/
			
			itemBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
			itemBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			itemBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
		}
		
		public function startLoad(_imagepath:String,_infopath:String):void{
			
			/*loader.load(new URLRequest(_imagepath));
						
			loader1.load(new URLRequest(_infopath));*/
			
		}// end startLoader();
		
		private function imageLoaded(evt:Event):void{
			
			//imageContent.addChild(loader.content);
			
		}
		
		private function infoLoaded(evt:Event):void{
			
			//infoContent.addChild(loader1.content);
			
		}
		
		private function clickHandler(evt:MouseEvent):void{
						
			//itemBtn.mouseEnabled = true;
			
			moveOrNotMove = true;
			
			this.dispatchEvent(new WorkEvent(WorkEvent.ITEM_CLICK,index));
			
		}//end clickHandler();
		
		private function overHandler(evt:MouseEvent):void{
			
			moveOrNotMove = false;
			
			stopMove();
			
			TweenMax.to(this,0.5,{frame:this.totalFrames});
			
		}// end overHndler();
		
		private function outHandler(evt:MouseEvent):void{
			
			if(!moveOrNotMove){
				
				if(timerflag){
				
					startMove();
					
				}
			}
			
			TweenMax.to(this,0.5,{frame:1});
			
		}// end outHnadler();
		
		public function itemBtnEnabeld(_enabled:Boolean):void{
			
			moveOrNotMove = false;
			
			if(timerflag){
				
					startMove();
					
			}
		}
		
		private function ioerrorHandler(evt:IOErrorEvent):void{
			trace("path.. error");
			
		}
		
		public function clear():void{
			
			itemBtn.removeEventListener(MouseEvent.CLICK,clickHandler);
			
			itemBtn.removeEventListener(MouseEvent.ROLL_OUT,outHandler);
			
			itemBtn.removeEventListener(MouseEvent.ROLL_OVER,overHandler);
			
		}
		
	}// end class;
}// end package;