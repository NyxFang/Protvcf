package components.loader{
	
	import flash.display.MovieClip;
	import flash.display.MovieClip;
	import flash.display.Loader;
	
	import flash.net.URLRequest;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	import flash.external.ExternalInterface;
	
	public class SwfLoader extends MovieClip{
		
		public var view:MovieClip;
		
		private var prevLoader:Loader;
		
		private var prevObj:Object;
		
		private var currLoader:Loader;
		
		private var path:String = "home.swf";
		
		private var ifFirst:Boolean = true;
		
		public function SwfLoader(_view:MovieClip){
			
			view = _view;
			
			initLoader();
			
		}// end Loader()		
		
		private function initLoader():void{
			
			currLoader = new Loader();
			
			currLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderComplete);
			
			currLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			
			view.addEventListener(EffectOutEvent.EFFECT_OUT_COMPLETE,showLoadedSwf);

			startLoader(path);
			
			
		}// end initLoader;
		
		public function startLoader(_path:String):void{
			
			path = _path;
			
			currLoader.load(new URLRequest(path));
			
			view.addChildAt(currLoader,0);
			
		}
		
		private function loaderComplete(evt:Event):void{
			
			if(!ifFirst){
				trace("out effect");
				prevObj.effectOut();
				
			}else{
				trace("frist");
				var obj:Object = currLoader.content;
			
				obj.effectIn();
				
				ifFirst = false;
				
				prevObj = currLoader.content;
			}
			
			
			
		}
		
		private function showLoadedSwf(evt:EffectOutEvent):void{
			trace("event listenered...showLoadedSwf....");
			
			var obj:Object = currLoader.content;
			
			obj.effectIn();
			
		}// end showLoadedSwf()
		
		private function ioErrorHandler(evt:IOErrorEvent):void{
			
			if(path.indexOf("/") == -1){
				
				startLoader("swf/"+path);
				
			}
			
		}
		
		
		
	}// end class
	
}//end package