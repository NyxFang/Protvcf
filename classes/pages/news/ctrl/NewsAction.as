package pages.news.ctrl{
	
	public class NewsAction{
		
		import flash.events.MouseEvent;
		import flash.display.MovieClip;
		
		public var callBack:Function;

		public function NewsAction(){
			
			
			
		}// end NewsAction()
		
		public function push(_btn:MovieClip):void{
			
			_btn.addEventListener(MouseEvent.CLICK,changeContent);
			
		}
		
		private function changeContent(evt:MouseEvent):void{
						
			var s:String = evt.currentTarget.name;
			
			callBack(int(s.substr(s.indexOf("_")+1))+1);
			
			//callBack()
			
		}
		
	}// end class
	
}// end package