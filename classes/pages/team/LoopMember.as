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
		
		public var SPEED:int = 2;
		
		public var CTRL:Boolean = false;		
		
		private var memberArr:Array;
		
		private var timer:Timer;
		
		private const SPLIT_START:int = 280;
		
		private const SPLIT_END:int = 280+376;
		
		private const ITEM_WIDTH:Number = 198.3;
		
		private var view_X:Number;
		
		public function LoopMember(_view:MovieClip,_location:MovieClip,_callBack:Function):void{
			
			view = _view;
			
			location = _location;
			
			callBack = _callBack;
			
			initCell();
			
		}// end LoopMember;
		
		private function initCell():void{
			
			memberArr = [];
			
			for(var i:int = 0 ; i<=10 ;i++){
				
				var member:MovieClip = view.getChildByName("member_"+i) as MovieClip;
				
				member.addEventListener(MouseEvent.CLICK,clickHandler);
				
				member.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
				member.addEventListener(MouseEvent.ROLL_OVER,overHandler);
				
				memberArr.push(member);
				
			}// end for
			
			timer = new Timer(24);
			
			timer.addEventListener(TimerEvent.TIMER,startMove);
			
			inCtrl();
			
		}// end initCell();
		
		public function inCtrl():void{
			
			if(CTRL){
				
				//if(view.x<=view.stage.stageWidth-view.width||view.x>=0){
				if(view.x<=1000-view.width||view.x>=0){
				
					stopTimer();
					
				}
				
			}else{
			
				startTimer();
				
			}
			
		}
		
		public function startMove(evt:TimerEvent):void{
			
			//if(view.x<=view.stage.stageWidth-view.width){
			if(view.x<=1000-view.width){
				
				SPEED = -2;
				
			}
			
			if(view.x>=0){
				
				SPEED = 2;
				
			}
			
			inCtrl();
			
			view.x-=SPEED;

			view_X = view.x;
						
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
			
			//var temp:MovieClip = MovieClip(evt.currentTarget);
			
			//TweenMax.to(temp,0.6,{frame:1});
			
			splitMember(int(str));
			
			callBack(int(str));
			
		}// end clickHandler();
		
		private function splitMember(_index:int):void{
			
			//var bef_current_start_x:Number = SPLIT_END + Math.abs(view.x) //- SPLIT_END -SPLIT_START - memberArr[0].width;
			
			//var aff_current_end_x:Number = SPLIT_START - memberArr[0].width -1 + Math.abs(view.x);
			
			var bef_current_start_x:Number = SPLIT_START - ITEM_WIDTH + Math.abs(view.x) -2;
			
			var aff_current_end_x:Number = SPLIT_START - 2*(ITEM_WIDTH +1) + Math.abs(view.x);

			for(var i:int = memberArr.length-1 ; i>=_index ; i--){

				if(i == _index){
				
					TweenMax.to(memberArr[i],0.5,{x:bef_current_start_x});
					
				}else{
					
					TweenMax.to(memberArr[i],0.5,{x:SPLIT_END + Math.abs((i-_index-1)) *(ITEM_WIDTH + 2)+ Math.abs(view.x)});
					
				}
				
			}
			
			for(var j:int = _index-1 ; j>=0 ; j--){

				if(j == _index-1){
					
					TweenMax.to(memberArr[j],0.5,{x:aff_current_end_x - 2});
					
				}else{
					
					TweenMax.to(memberArr[j],0.5,{x:aff_current_end_x - (_index -1 - j) * (ITEM_WIDTH)});
				}
				
			}
			
		}
		
		public function mergerMember():void{
			
			for(var i:int = 0 ; i<memberArr.length ; i++){
				
				if(i == 0){
					
					TweenMax.to(memberArr[i],0.5,{x:0});
					
				}else{
				
					TweenMax.to(memberArr[i],0.5,{x:(memberArr[i].width + 1)*i});
				
				}
				
			}
			
			startTimer();
			
			enbledMouseEvent(true);
			
		}
		
		private function outHandler(evt:MouseEvent):void{
		
			startTimer();
			
			var temp:MovieClip = MovieClip(evt.currentTarget);
			
			TweenMax.to(temp,0.6,{frame:1});
			
			location.gotoAndStop(1);
			
		}// end outHandler();

		private function overHandler(evt:MouseEvent):void{
			
			stopTimer();
			
			var str:String = evt.currentTarget.name;
			
			str = str.slice(str.indexOf("_")+1);
			
			if(int(str)>=1&&int(str)<=4){
				
				location.gotoAndStop(2);
				
			}else if(int(str)>4&&int(str)<=6){
				
				location.gotoAndStop(3);
				
			}else{
				
				if(str !="0"){
				
					location.gotoAndStop(4);
				}
			}
			
			var temp:MovieClip = MovieClip(evt.currentTarget);
			
			TweenMax.to(temp,0.6,{frame:temp.totalFrames});
			 
		}// end outHandler();
		
		public function enbledMouseEvent(_boo:Boolean = false):void{
			
			if(!_boo){
				
				for(var i:int = 0 ; i<memberArr.length ; i++){
					
					memberArr[i].removeEventListener(MouseEvent.ROLL_OUT,outHandler);
					
					//memberArr[i].mouseChildren = memberArr[i].mouseEnabled = true;
				
				}// end for()
				
			}else{
			
				for(var j:int = 0 ; j<memberArr.length ; j++){
					
					memberArr[j].addEventListener(MouseEvent.ROLL_OUT,outHandler);
					
					//memberArr[j].mouseChildren = memberArr[j].mouseEnabled = false;
				
				}// end for()
			
			}
		}
		
	}// end class;
	
}// end package