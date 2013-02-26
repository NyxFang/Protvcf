package components.bottomcomponents{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	import flash.utils.Timer;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.*
	import components.utils.DataStream;
	import pages.index.event.MenuEvent;
	
	
	public class BottomComponents{
		
		private var view:MovieClip;
		
		private var item:BottomItem;
		
		private var itemArr:Array;
		
		private var timer:Timer;
		
		private const SPEED:int = 2;
		
		public function BottomComponents(_view:MovieClip):void{
			
			view = _view;
			
			view.x = 1000;
			
			initData();
			
		}// end BottomComponents();
		
		private function initData():void{
			
			var ds:DataStream = new DataStream(getDataScuess,fail);
			
			ds.getData(URLPath.BOTTOMCOMPONENTS_XML);
			
			itemArr = [];
			
		}// end initCell()
		
		private function getDataScuess(_xml:XML):void{
			
			for(var i:int = 0 ; i<_xml["items"]["item"].length() ; i++){
				
				var item:BottomItem = new BottomItem(startTimer,stopTimer);
								
				if(i == 0){
					
					item.x = 0;
					
				}else{
					
					item.x = (item.width +2)*i;
					
				}
				
				//item.y = -138;

				item.loaderImage(_xml["items"]["item"][i]["imagepath"]);
				
				item.setTitle(_xml["items"]["item"][i]["title"]);
				
				view.addChild(item);
				
				itemArr.push(item);
				
			}// end for();
			
			TweenMax.to(view,2,{x:0,ease:Expo.easeOut,onComplete:loopView});
			
		}// end getDataScress();
		
		private function loopView():void{
			
			timer = new Timer(24);
			
			timer.addEventListener(TimerEvent.TIMER,startMove);
			
			startTimer();
			
		}// end loopView()
		
		public function startMove(evt:TimerEvent):void{
			
			view.x-=SPEED;

			if(view.x%(itemArr[0].width+2) == 0 || view.x%(itemArr[0].width+2) == -1){
				
				TweenMax.to(itemArr[0],0.5,{alpha:0,onComplete:changeArr});
				
			}
			
		}// end StartMove();
		
		private function changeArr():void{
			
			itemArr[0].alpha = 1;
			
			itemArr[0].x = itemArr[itemArr.length-1].x + itemArr[itemArr.length-1].width + 2;
					
			itemArr.push(itemArr.shift());
			
		}// end changeArr()
		
		public function startTimer():void{
			
			timer.start();
			
		}
		
		public function stopTimer():void{
			
			timer.reset();
			
			timer.stop();
			
		}// end StopMove();
		
		private function fail(_info:String):void{
			
			trace(_info);
			
		}// end fail();
		
	}// end class
	
	
}//end package