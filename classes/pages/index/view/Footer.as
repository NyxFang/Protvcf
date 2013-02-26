package pages.index.view{
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	public class Footer extends MovieClip{
		
		private var view:MovieClip;
		
		private var tempbtn:MovieClip;
		
		private var menuItem4:MovieClip;
		
		private var btnMore:MovieClip;
		
		private var btnNews:SimpleButton;
		
		public function Footer(){
			
			
			
		}// end Footer()
		
		public function initCell(_view:MovieClip,_menuItem4:MovieClip):void{
			
			view = _view;
			
			menuItem4 = _menuItem4
			
			btnMore = view.getChildByName("btn_more") as MovieClip;
			
			btnNews = view.getChildByName("newsbtn") as SimpleButton;
			
			btnMore.addEventListener(MouseEvent.CLICK,moreHandler);
				
			btnMore.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
			btnMore.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
			btnNews.addEventListener(MouseEvent.CLICK,moreHandler);
			
			for(var i:int = 0 ; i< 3 ; i++){
				
				var btn:MovieClip = view.getChildByName("btn_"+i) as MovieClip;
				
				btn.addEventListener(MouseEvent.CLICK,clickHandler);
				
				btn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
				btn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
				
				if(i == 0){
					
					tempbtn = btn;
					
					tempbtn.mouseChildren = tempbtn.mouseEnabled = false;
					
					tempbtn.gotoAndStop(2);
					
				}// end if
				
			}// end for
			
		}// end initCell()
		
		private function clickHandler(evt:MouseEvent):void{
			
			tempbtn.mouseChildren = tempbtn.mouseEnabled = true;
			
			tempbtn.gotoAndStop(1);
			
			tempbtn = MovieClip(evt.currentTarget);
			
			tempbtn.mouseChildren = tempbtn.mouseEnabled = false;
			
			var str:String = evt.currentTarget.name;

			(evt.currentTarget).parent.gotoAndStop(int(str.substr(str.indexOf("_")+1))+1);
			
			
		}// end clickHandler();
		
		private function outHandler(evt:MouseEvent):void{
			
			if(tempbtn ==  MovieClip(evt.currentTarget)){
				
				return;
				
			}
			
			MovieClip(evt.currentTarget).gotoAndStop(1);
			
			
		}// end outHandler();
		
		private function overHandler(evt:MouseEvent):void{
			
			if(tempbtn ==  MovieClip(evt.currentTarget)){
				
				return;
				
			}
			
			MovieClip(evt.currentTarget).gotoAndStop(2);
			
		}// end overHandler();
		
		private function moreHandler(evt:MouseEvent):void{
			
			//menuItem4.dispatchEvent(new MenuEvent(MenuEvent.MENU_ITEM_CLICK,URLPath.NEWS));
			menuItem4.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			menuItem4.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			
			
		}// end moreHandler();
		
		private function newsHandler(evt:MouseEvent):void{
			
			//menuItem4.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			//menuItem4.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			
		}// end newsHandler();
		
		public function clear():void{
			
			
			
		}// end clear();
		
	}// end class
		
}// end package