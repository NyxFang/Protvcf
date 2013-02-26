/**
 
 * propose : Get data or send data;
 
 * @Auth : Navy;
 
 * time : 2010-6-2;

*/

package components.utils{
	
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import flash.external.ExternalInterface;
	
	public class DataStream{
		
		private var urlLoader:URLLoader;
		
		private var success:Function;
		
		private var fail:Function
		
		private var _xml:XML;
		
		public function DataStream(_success,_fail){
			
			success = _success;
			
			fail =_fail;
			
			init();
			
		}// end DataStream;
		
		private function init():void{
			
			urlLoader = new URLLoader();
			
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			
			urlLoader.addEventListener(Event.COMPLETE,completeHandler);
			
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			
		}// end init()
		
		public function sendPostData(_url:String,_parm:URLVariables):void{
			
			//var header:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
			
			var req:URLRequest = new URLRequest(_url);
			
			req.method = URLRequestMethod.POST;
			
			req.data = _parm;
			
			urlLoader.load(req);
			
		}// end PostData()
		
		public function sendGetData(_url:String,_parm:URLVariables):void{
			
			var header:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
			
			var req:URLRequest = new URLRequest(_url);
			
			req.method = URLRequestMethod.GET;
			
			req.data = _parm;
			
			urlLoader.load(req);
		}
		
		public function sendXMLData(_url:String,_parm:XML):void{
			
			var header:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
			
			var req:URLRequest = new URLRequest(_url);
			
			req.method = URLRequestMethod.POST;
			
			req.data = _parm;
			
			urlLoader.load(req);
			
		}
		
		public function getData(_url:String):void{
			
			var req:URLRequest = new URLRequest(_url);
			
			urlLoader.load(req);
			
		}
		
		private function completeHandler(evt:Event):void{
			
			//ExternalInterface.call("alert",urlLoader.data)
			
			//trace("urlLoader:",urlLoader.data)
			
			//trace("target:",evt.target.data)
			
			//trace("curtarget:",evt.currentTarget.data);
			
			_xml = XML(evt.currentTarget.data);
			
			this.success(_xml);
			
		}// end completeHandler()
		
		private function ioErrorHandler(evt:IOErrorEvent):void{
			
			this.fail("failed..:"+evt.type);
			
		}// end ioErrorHandler();
		
	}// end class;
}// end package