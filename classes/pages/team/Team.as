package pages.team{
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	
	import com.greensock.TweenMax;
	import pages.index.event.MenuEvent;
	import components.loader.EffectOutEvent;
	
	public class Team extends MovieClip{
		
		private var memberDetail:MovieClip;
		
		private var memberDetail_backBtn:MovieClip;
		
		private var teamView:MovieClip;
		
		private var teamloop:LoopMember;
		
		private var leftBtn:MovieClip;
		
		private var rightBtn:MovieClip;
		
		private var areaBtns:MovieClip;
		
		private var shangHaiBtn:MovieClip;
		
		private var beijingBtn:MovieClip;
		
		private var taipeiBtn:MovieClip;
		
		private var tempBtn:MovieClip;
		
		private const ITEM_WIDTH:Number = 198.3;
		
		public function Team(){

			this.addFrameScript(128,initCell);
			
		}// end About()
		
		private function initCell():void{
			
			this.stop();
			
			memberDetail = this.getChildByName("detail_group") as MovieClip;
			
			memberDetail.visible = false;
			
			memberDetail_backBtn = memberDetail.getChildByName("backbtn") as MovieClip;
			
			teamView = this.getChildByName("team_mc") as MovieClip
			
			teamloop = new LoopMember(teamView,this.getChildByName("location_mc") as MovieClip,showDetail);
			
			leftBtn = this.getChildByName("leftbtn") as MovieClip;
			
			rightBtn = this.getChildByName("rightbtn") as MovieClip;
			
			areaBtns = this.getChildByName("areabtns") as MovieClip;
			
			shangHaiBtn = areaBtns.getChildByName("shanghaibtn") as MovieClip;
			
			tempBtn = shangHaiBtn;
			
			beijingBtn = areaBtns.getChildByName("beijingbtn") as MovieClip;
			
			taipeiBtn = areaBtns.getChildByName("taipeibtn") as MovieClip;
			
			configEvents();
			
		}
		
		private function configEvents():void{
			
			this.addEventListener(LoopEvent.LOOP_STOP,stopLoop);
			
			this.addEventListener(LoopEvent.LOOP_START,startLoop);
			
			leftBtn.buttonMode = true;
			
			rightBtn.buttonMode = true;
							
			leftBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
			leftBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
							
			rightBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
			rightBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
			
			shangHaiBtn.addEventListener(MouseEvent.ROLL_OVER,areaOverHandler);
			
			beijingBtn.addEventListener(MouseEvent.ROLL_OVER,areaOverHandler);
			
			taipeiBtn.addEventListener(MouseEvent.ROLL_OVER,areaOverHandler);
			
			shangHaiBtn.addEventListener(MouseEvent.ROLL_OUT,areaOutHandler);
			
			beijingBtn.addEventListener(MouseEvent.ROLL_OUT,areaOutHandler);
			
			taipeiBtn.addEventListener(MouseEvent.ROLL_OUT,areaOutHandler);
			
			shangHaiBtn.addEventListener(MouseEvent.CLICK,areaClickHandler);
			
			beijingBtn.addEventListener(MouseEvent.CLICK,areaClickHandler);
			
			taipeiBtn.addEventListener(MouseEvent.CLICK,areaClickHandler);
			
			memberDetail_backBtn.addEventListener(MouseEvent.CLICK,backHandler);
			
		}
		
		
		private function showDetail(_frame:int):void{
			
			TweenMax.to(tempBtn,0.5,{frame:1});
			
			if(_frame >= 1 && _frame<=4){
				
				tempBtn = shangHaiBtn;
				
			}else if(_frame > 4 && _frame<=6){
				
				tempBtn = beijingBtn;
				
			}else{
				
				if(_frame!=0){
					
					tempBtn = taipeiBtn;
					
				}else{
					
					TweenMax.to(tempBtn,0.5,{frame:1});
					
				}
				
			}
			
			TweenMax.to(tempBtn,0.5,{frame:tempBtn.totalFrames});
			
			memberDetail.visible = true;

			memberDetail.gotoAndStop(_frame+2);
			
			embledRightLeftbutton(true);
			
			//memberDetail.addFrameScript(_frame,init_memberDetailAction);
			
		}// end showLocation
		
		private function areaOverHandler(evt:MouseEvent):void{
			
			var temp:MovieClip = MovieClip(evt.currentTarget);
			
			TweenMax.to(temp,0.5,{frame:temp.totalFrames});
			
		}
		
		private function areaOutHandler(evt:MouseEvent):void{
			
			if(tempBtn != MovieClip(evt.currentTarget)){
				
				TweenMax.to(MovieClip(evt.currentTarget),0.5,{frame:1});
				
			}
			
		}
		
		private function areaClickHandler(evt:MouseEvent):void{
			
			if(memberDetail.visible){
			
				backHandler(null);
			
			}
			
			teamloop.stopTimer();
			
			TweenMax.to(tempBtn,0.5,{frame:1});
			
			tempBtn = MovieClip(evt.currentTarget);
						
			if(evt.currentTarget.name =="shanghaibtn"){
				
				teamView.x = -ITEM_WIDTH + ITEM_WIDTH/2;
				
			}else if((evt.currentTarget.name =="beijingbtn")){
				
				teamView.x = -ITEM_WIDTH * 4 +ITEM_WIDTH/2;
				
			}else if((evt.currentTarget.name =="taipeibtn")){
				
				teamView.x = -ITEM_WIDTH * 6 -ITEM_WIDTH/2;
				
			}
		}
		
		private function backHandler(evt:MouseEvent):void{
			
			TweenMax.to(tempBtn,0.5,{frame:1});
			
			memberDetail.visible = false;
			
			teamloop.mergerMember();
			
			embledRightLeftbutton(false);
						
		}
		
		private function embledRightLeftbutton(enbled:Boolean):void{
			
			if(enbled){
				
				leftBtn.removeEventListener(MouseEvent.ROLL_OUT,outHandler);
				
				leftBtn.removeEventListener(MouseEvent.ROLL_OVER,overHandler);
							
				rightBtn.removeEventListener(MouseEvent.ROLL_OUT,outHandler);
				
				rightBtn.removeEventListener(MouseEvent.ROLL_OVER,overHandler);
				
			}else{
				
				leftBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
				leftBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
							
				rightBtn.addEventListener(MouseEvent.ROLL_OUT,outHandler);
				
				rightBtn.addEventListener(MouseEvent.ROLL_OVER,overHandler);
				
			}
			
		}
		
		/*private function init_memberDetailAction():void{
			
			var memberDetailAction:MemberDetail = new MemberDetail(memberDetail["view"]);
			
		}*/
		
		private function startLoop(evt:LoopEvent):void{
			
			teamloop.enbledMouseEvent(false);
			
			teamloop.startTimer();
			
		}
		
		private function stopLoop(evt:LoopEvent):void{
			
			teamloop.stopTimer();
			
		}
		
		
		private function outHandler(evt:MouseEvent):void{
			
			teamloop.CTRL = false;
			
			teamloop.inCtrl();
			
			if(evt.currentTarget.name == "leftbtn"){
				
				teamloop.SPEED = -2;
				
			}else{
				
				teamloop.SPEED = 2;
				
			}
			
			MovieClip(evt.currentTarget).gotoAndPlay(1);
			
		}
		
		private function overHandler(evt:MouseEvent):void{
			
			teamloop.CTRL = true;
			
			teamloop.inCtrl();
			
			if(evt.currentTarget.name == "leftbtn"){
				
				teamloop.SPEED = -8;
				
			}else{
				
				teamloop.SPEED = 8;
				
			}
			
			MovieClip(evt.currentTarget).gotoAndPlay(2);
			
		}
		
		public function effectIn():void{
			
			this.play();
			
		}// end effectIn();
		
		public function effectOut():void{
			
			TweenMax.to(this,1.7,{frame:MovieClip(this).totalFrames,onComplete:dispathOut});
			
		}// end effectOut()
		
		private function dispathOut():void{
			
			this.dispatchEvent(new EffectOutEvent(EffectOutEvent.EFFECT_OUT_COMPLETE));
			
		}// end dispatchOut()
		
	}// end class
	
}// end package
		