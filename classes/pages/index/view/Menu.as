package pages.index.view{
	
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	
	import flash.display.MovieClip;
	
	import pages.index.event.MenuEvent;
	
	public class Menu extends EventDispatcher{
		
		private var view:MovieClip;
		
		private var tempItem:MovieClip;
		
		private var menuItemArr:Array;
		
		private var swfLoader:MovieClip;
		
		private var path:String ;
		
		public function Menu(_view:MovieClip,_swfloader:MovieClip){
			
			swfLoader = _swfloader;
						
			view = _view;
						
			init();
			
		}// end Menu()
		
		private function init():void{
			
			menuItemArr = [];
			
			for(var i:int = 0 ; i<6 ; i++){
				
				var menuItem:MovieClip = view.getChildByName("menuItem_"+i) as MovieClip;
				
				menuItem.addEventListener(MouseEvent.CLICK,clickHandler);
				
				menuItem.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
				menuItem.addEventListener(MouseEvent.ROLL_OVER,overHandler);
				
				if(i == 0){
					
					tempItem = menuItem;
					
					//tempItem.mouseChildren = tempItem.mouseEnabled = false;
					
				}
				
				menuItemArr.push(menuItem);
				
			}// end for()
			
			swfLoader.view.addEventListener(MenuEvent.MENU_ITEM_CLICK,menuItemClick);

		}// end init()
		
		private function clickHandler(evt:MouseEvent):void{
			
			tempItem.mouseChildren = tempItem.mouseEnabled = true;
			
			tempItem.gotoAndStop(1);
			
			var str:String = evt.currentTarget.name;
			
			switch(int(str.substr(str.indexOf("_")+1))){
				
				case 0 :{
					
					path = URLPath.HOME;
					
					break;
					
				}
				case 1 :{
					
					path = URLPath.ABOUT;
					
					break;
					
				}
				case 2 :{
					
					path = URLPath.WORK;
					
					break;
					
				}
				case 3 :{
					
					path = URLPath.TEAM;
					
					break;
					
				}
				case 4 :{
					
					path = URLPath.NEWS;
					
					break;
					
				}
				case 5 :{
					
					path = URLPath.CONTACT;
					
					break;
					
				}
				
			}// end switch()
			
			tempItem = MovieClip(evt.currentTarget);
			
			tempItem.gotoAndPlay(2);
			
			tempItem.mouseChildren = tempItem.mouseEnabled = false;
			
			swfLoader.startLoader(path);
			
			
		}// end clickHandler();
		
		private function menuItemClick(evt:MenuEvent):void{
			
			menuItemArr[evt.menuItem].dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			
			menuItemArr[evt.menuItem].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			
		}
		
		private function outHandler(evt:MouseEvent):void{
			
			if(tempItem ==  MovieClip(evt.currentTarget)){
				
				return;
				
			}
			
			MovieClip(evt.currentTarget).gotoAndStop(1);
			
			
		}// end outHandler();
		
		private function overHandler(evt:MouseEvent):void{
			
			if(tempItem ==  MovieClip(evt.currentTarget)){
				
				return;
				
			}
			
			MovieClip(evt.currentTarget).gotoAndPlay(2);
			
		}// end overHandler();
		
	}// end class
	
}// end package