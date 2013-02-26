package components.bottomcomponents{
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.Bitmap;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	
	import flash.text.TextField;
	
	import flash.net.URLRequest;
	
	import com.greensock.TweenMax;
	import pages.index.event.MenuEvent;
	
	public class BottomItem extends MovieClip{
		
		private var loader:Loader;
		
		private var playBtn:MovieClip;
		
		private var moreBtn:MovieClip;
		
		private var imageHolder:MovieClip;
		
		private var title_Txt:TextField;
		
		private var startMove:Function;
		
		private var stopMove:Function;
		
		public function BottomItem(_start:Function,_stop:Function):void{
			
			startMove = _start;
			
			stopMove = _stop;
			
			this.buttonMode = true;
			
			init();
			
		}// end BottomItem()
		
		private function init():void{
			
			loader = new Loader();
			
			//playBtn = this.getChildByName("playbtn") as MovieClip;
			
			//playBtn.mouseChildren = playBtn.mouseEnabled = false;
			
			//this["iteminfo"].mouseChildren = this["iteminfo"].mouseEnabled = false;
			
			//moreBtn = this["iteminfo"].getChildByName("morebtn") as MovieClip;
			
			imageHolder = this.getChildByName("piccontent") as MovieClip;
			
			//title_Txt = this["iteminfo"].getChildByName("title_txt") as TextField;
			
			configEvents();
			
		}// end init();
		
		private function configEvents():void{
			
			this.addEventListener(MouseEvent.MOUSE_OUT,outHandler);
			
			this.addEventListener(MouseEvent.MOUSE_OVER,overHandler);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,showLoader);
			
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,IOErrorHandler);
			
			this.addEventListener(MouseEvent.CLICK,clickHandler);
			
			//moreBtn.addEventListener(MouseEvent.CLICK,clickHandler);
			
		}// end configEvents();
		
		public function loaderImage(_path:String):void{
			
			loader.load(new URLRequest(_path));
			
		}// end LoaderImage();
		
		public function setTitle(_title:String):void{
			
			//title_Txt.text = _title;
			
		}// end setTitle();
		
		private function showLoader(evt:Event):void{
			
			var bit:Bitmap = loader.content as Bitmap;
			
			bit.smoothing = true;
						
			imageHolder.addChild(bit);
			
		}// end showLoader();
		
		private function clickHandler(evt:MouseEvent):void{
			
			this.dispatchEvent(new MenuEvent(MenuEvent.MENU_ITEM_CLICK,2));
			
		}
		
		private function outHandler(evt:MouseEvent):void{
			
			startMove();
			
			//this["pic_msk"].gotoAndStop(1);
			
			//this["kuang_mc"].gotoAndStop(1);
			
			//TweenMax.to(this,.3,{x:170,alpha:0});
			
			TweenMax.to(this,.3,{frame:1,alpha:1});
			
		}// end outHandler()
		
		private function overHandler(evt:MouseEvent):void{
			
			stopMove();
			
			//this["pic_msk"].gotoAndPlay(3);
			
			//this["kuang_mc"].gotoAndPlay(3);
			
			TweenMax.to(this,.8,{frame:this.totalFrames,alpha:1});
			
			//TweenMax.to(this,.8,{x:0,alpha:1});
			
		}// end overHandler()		
		
		private function IOErrorHandler(evt:Event):void{
			
			trace(evt);
			
		}// end IOErrorHandler()
		
		
	}// end class
}// end package