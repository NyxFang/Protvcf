package pages.team{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	import flash.utils.Timer;
	
	import com.greensock.TweenMax;
	
	public class LoopMember{
		
		private var view:MovieClip;
		
		private var location:MovieClip;
		
		private var callBack:Function;
		
		private const SPEED:int = 2;
		
		private var memberArr:Array;
		
		private var timer:Timer;
				
		public function LoopMember(_view:MovieClip,_location:MovieClip,_callBack:Function):void{
			
			view = _view;
			
			location = _location;
			
			callBack = _callBack;
			
			initCell();
			
		}// end LoopMember;
		
		private function initCell():void{
			
			memberArr = [];
			
			for(var i:int = 0 ; i<9 ;i++){
				
				var member:MovieClip = view.getChildByName("member_"+i) as MovieClip;
				
				member.addEventListener(MouseEvent.CLICK,clickHandler);
				
				member.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
				member.addEventListener(MouseEvent.ROLL_OVER,overHandler);
				
				memberArr.push(member);
				
			}// end for
			
			timer = new Timer(24);
			
			timer.addEventListener(TimerEvent.TIMER,startMove);
			
			startTimer();
			
		}// end initCell();
		
		public function startMove(evt:TimerEvent):void{
			
			view.x-=SPEED;
			
			if(view.x%memberArr[0].width == 0){
				
				memberArr[0].x = memberArr[memberArr.length-1].x + memberArr[memberArr.length-1].width + 1;
					
				memberArr.push(memberArr.shift());
				
			}
			
		}// end StartMove();
		
		public function startTimer():void{
			
			timer.start();
			
		}
		
		public function stopTimer():void{
			
			timer.reset();
			
			timer.stop();
			
		}// end StopMove();
		
		private function clickHandler(evt:MouseEvent):void{
			
			enbledMouseEvent(false);
			
			stopTimer();
			
			var str:String = evt.currentTarget.name;
			
			str = str.slice(str.indexOf("_")+1);
			
			var temp:MovieClip = MovieClip(evt.currentTarget);
			
			TweenMax.to(temp,0.6,{frame:1});
			
			callBack(int(str));
			
		}// end clickHandler();
		
		private function outHandler(evt:MouseEvent):void{
		
			startTimer();
			
			var temp:MovieClip = MovieClip(evt.currentTarget);
			
			TweenMax.to(temp,0.6,{frame:1});
			
		}// end outHandler();

		private function overHandler(evt:MouseEvent):void{
			
			stopTimer();
			
			var str:String = evt.currentTarget.name;
			
			str = str.slice(str.indexOf("_")+1);
			
			if(int(str)>=0&&int(str)<4){
				
				location.gotoAndStop(2);
				
			}else if(int(str)>=4&&int(str)<6){
				
				location.gotoAndStop(3);
				
			}else{
				
				location.gotoAndStop(4);
				
			}
			
			var temp:MovieClip = MovieClip(evt.currentTarget);
			
			TweenMax.to(temp,0.6,{frame:temp.totalFrames});
			 
		}// end outHandler();
		
		public function enbledMouseEvent(_boo:Boolean = false):void{
			
			if(!_boo){
				
				for(var i:int = 0 ; i<memberArr.length ; i++){
					
					memberArr[i].removeEventListener(MouseEvent.ROLL_OUT,outHandler);
					
					//memberArr[i].mouseChildren = memberArr[i].mouseEnabled = _boo;
				
				}// end for()
				
			}else{
			
				for(var j:int = 0 ; j<memberArr.length ; j++){
					
					memberArr[j].addEventListener(MouseEvent.ROLL_OUT,outHandler);
					
					//memberArr[i].mouseChildren = memberArr[i].mouseEnabled = _boo;
				
				}// end for()
			
			}
		}
		
	}// end class;
	
}// end package