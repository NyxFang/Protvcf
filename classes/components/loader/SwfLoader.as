package components.loader{
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.DisplayObject;
	
	import flash.net.URLRequest;
	
	import flash.text.TextField;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	import flash.external.ExternalInterface;
	
	public class SwfLoader extends MovieClip{
		
		public var view:MovieClip;
		
		private var currScene:DisplayObject;
		
		private var newScene:DisplayObject;
		
		private var loader:Loader;
		
		private var loadingmc:MovieClip
		
		private var loadContent:MovieClip;
		
		private var percent_txt:TextField;
		
		private var path:String = "home.swf";
		
		private var prefix:String = "";
		
		private var ifFirst:Boolean;
		
		private var callBack:Function;
		
		public function SwfLoader(_view:MovieClip,_loadingmc:MovieClip,_callBack:Function){
			
			view = _view;
			
			callBack = _callBack;
			
			loadContent = _loadingmc;
			
			initLoader();
			
		}// end Loader()		
		
		private function initLoader():void{
			
			loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderComplete);
			
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			
			percent_txt = loadContent.getChildByName("txt") as TextField;
			
			loadingmc = loadContent.getChildByName("loading_mc") as MovieClip;
			
			view.addEventListener(EffectOutEvent.EFFECT_OUT_COMPLETE,showLoadedSwf);
			
			startLoader(path);
			
			
		}// end initLoader;
		
		public function startLoader(_path:String):void{
			
			path = _path;
			
			if(currScene){
			
				currScene["effectOut"]();
				
			}else{
				
				loader.load(new URLRequest(path));
				
			}
		}
		
		private function loaderComplete(evt:Event):void{
			
			loadContent.visible = false;

			callBack(path);
			
			newScene = loader.content;
			
			newScene["effectIn"]();
			
			currScene = newScene;
			
			view.addChild(newScene);
			
		}
		
		private function showLoadedSwf(evt:EffectOutEvent):void{

			if(newScene){

				view.removeChild(newScene);
				
			}
			
			loader.load(new URLRequest(path));
			
		}// end showLoadedSwf()
		
		private function progressHandler(evt:ProgressEvent):void{
			
			loadContent.visible = true;
			
			percent_txt.text = String(int(evt.bytesLoaded/evt.bytesTotal*100)+"%");
			
		}// end progressHandler
		
		private function ioErrorHandler(evt:IOErrorEvent):void{
			
			if(path.indexOf("/") == -1){
				
				prefix = "swf/";
				
				path = prefix+path;
				
				showLoadedSwf(null);
				
			}else{
				
				ExternalInterface.call("alert",path);
				
			}
			
		}
		
		
		
	}// end class
	
}//end package