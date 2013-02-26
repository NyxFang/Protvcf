/**************************************************
 *  propose : ScrollPanel
 *  @Auth : Navy;
 **************************************************
----------------------------------------------------------------------------------------------------

* 构造函数
ScrollPanel(
 Object: 显示区域，{width, height}
 MovieClip: 需要进行滚动的对象
 MovieClip: 滚动条轨道
 MovieClip: 滚动条滑块
 String: 滚动条类型，默认为"vertical"垂直(水平:"horizontal", 垂直:"vertical")
 Boolean: 需要进行滚动的对象是否已经有一个以上的滚动条(默认为false，没有)
 Boolean: 当被滚动对象小于显示区域时，是否隐藏滚动条，默认为true隐藏
 *: [滚动条向上滚动按钮，类型为所有显示对象(可选)]
 *: [滚动条向下滚动按钮，类型为所有显示对象(可选)]
 ) 
 
----------------------------------------------------------------------------------------------------

* 方法 set px(i:int):void
  设置滑轮滚动一次以及按钮点击一次，被滚动对象移动的像素，参数为要滚动的像素值
  
* 方法 set setHide(b:Boolean):void
  设置当被滚动对象小于显示区域时，是否隐藏滚动条,true为隐藏

* 方法 update():void 
  当被滚动对象更新时，而需要改变滚动条状态，请调用此方法

* 方法 reset():void
  当重新绘制scroll时调用此方法.
  
* 方法 get ed():EventDispatcher
  返回事件侦听对象

----------------------------------------------------------------------------------------------------

* 事件
  RogitureScrollBar.GREATERTHAN:String = "greaterThan"
  被滚动对象面积大于显示对象事件
  RogitureScrollBar.LESSTHAN:String = "lessThan"
  被滚动对象面积小于显示对象事件
  
*/
package components.scrollPanel{

	import flash.display.MovieClip;
	import flash.display.Sprite;

	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;

	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	import flash.utils.Timer;
	
	import com.greensock.TweenMax;

	public class ScrollPanel {

		private var _showArea:Object;//显示区域{width, height}
		
		private var _mcMaskee:MovieClip;//需要进行滚动的对象
		
		private var _mcScrollBg:MovieClip;//滚动条轨道
		
		private var _mcScroll:MovieClip;//滚动条滑块
		
		private var _type:Object;//滚动条类型{type, attribute}
		
		private var _howMany:Boolean;//需要进行滚动的对象是否已经有一个以上的滚动条
		
		private var _btnUp:*;//滚动条向上滚动按钮
		
		private var _btnDown:*;//滚动条向下滚动按钮
		
		private var _mcMask:Sprite;//用于遮罩显示区域
		
		private var _px:Number;//滑轮滚动一次以及按钮点击一次，被滚动对象移动的像素，默认为10像素
		
		private var _bHide:Boolean;//当被滚动对象小于显示区域时，是否隐藏滚动条

		private var maskee_a:int;//Maskee初始属性
		
		private var xOfy:int;//算百分点时需要
		
		private var mouse:String;//鼠标的属性，该取mouseX还是MouseY
		
		private var oRectangle:Rectangle;//拖动范围
		
		private var scrollMoveTimer:Timer;//用于移动Maskee
		
		private var btnMouseDownTimer:Timer;//鼠标在上或下按钮上按下而未释放未移开，500毫秒后不断进行滚动
		
		private var btnMoveTimer:Timer;//鼠标在上或下按钮上按下而未释放未移开，移动滑块
		
		private var nowMoveType:String;//当前需要向上还是向下滚动

		private var pScroll:*;//滚动条容器

		private var _ed:EventDispatcher;//事件侦听对象

		public static  var GREATERTHAN:String = "greaterThan";//被滚动对象面积大于显示对象
		
		public static  var LESSTHAN:String = "lessThan";//被滚动对象面积小于显示对象
		
		private var cellPOS:Object; // 记录元件初始位置；

		public function ScrollPanel(){
			
		}
		
		public function initScrollPanel(showArea:Object, 
		 							mcMaskee:MovieClip, 
		  							mcScrollBg:MovieClip, 
		 							mcScroll:MovieClip, 
		  							type:String = "vertical", 
		  							howMany:Boolean = false,
		  							bHide:Boolean = true,
		  							btnUp:* = null, 
		  							btnDown:* = null) {
			
			if(!showArea){
				
				return;
				
			}
			
			_showArea= showArea;
			
			_mcMaskee= mcMaskee;
			
			_mcScrollBg = mcScrollBg;
			
			_mcScroll= mcScroll;
			
			_howMany= howMany;
			
			_btnUp= btnUp;
			
			_btnDown= btnDown;
			
			_bHide= bHide;
			
			//pScroll= _mcScroll.parent;

			_type = new Object();
			
			_type = (type == "vertical") ? {type:"height", attribute:"y"} : {type:"width", attribute:"x"};

			oRectangle = new Rectangle(Math.floor(_mcScroll.x), Math.floor(_mcScroll.y));
			
			oRectangle.width = (type == "vertical") ? 0 : _mcScrollBg[_type.type]-_mcScroll[_type.type];
			
			oRectangle.height = (type == "vertical") ? _mcScrollBg[_type.type]-_mcScroll[_type.type] : 0;

			maskee_a = (type == "vertical") ? Math.floor(_mcMaskee.y) : Math.floor(_mcMaskee.x);

			xOfy = (type == "vertical") ? oRectangle.y : oRectangle.x;

			mouse = (type == "vertical") ? "mouseY" : "mouseX";

			_mcMask = new Sprite();
			
			_mcMask.graphics.beginFill(0xFFFFFF);
			
			_mcMask.graphics.drawRect(_mcMaskee.x, _mcMaskee.y, _showArea.width, _showArea.height);

			_mcMask.graphics.endFill();
			
			_mcMaskee.parent.addChild(_mcMask);
			
			_mcMaskee.mask = _mcMask;

			scrollMoveTimer = new Timer(30);
			
			scrollMoveTimer.addEventListener(TimerEvent.TIMER, scrollMoveTimerEvent);

			btnMouseDownTimer = new Timer(500);
			
			btnMouseDownTimer.addEventListener(TimerEvent.TIMER, btnMouseDownTimerEvent);

			btnMoveTimer = new Timer(100);
			
			btnMoveTimer.addEventListener(TimerEvent.TIMER, btnMoveTimerEvent);

			_ed = new EventDispatcher();

			px = 10;
			
			update();
			
			savePos();
			
		}
		
		private function savePos():void{
			
			var contentPOS:Point = new Point(_mcMaskee.x,_mcMaskee.y);
			
			var scrollPOS:Point = new Point(_mcScroll.x,_mcScroll.y);
			
			cellPOS = {contentPOS:contentPOS,scrollPOS:scrollPOS};
			
		}//end savePos()
		
		private function configureListeners():void {
			
			_mcScroll.addEventListener(MouseEvent.MOUSE_DOWN, scrollMouseDown);
			
			_mcScroll.stage.addEventListener(MouseEvent.MOUSE_UP, scrollMouseUp);
			
			_mcScrollBg.addEventListener(MouseEvent.MOUSE_DOWN, scrollBgMouseDown);
			
			_mcScrollBg.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			
			_mcMaskee.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			
			if (!_howMany) {
				//_mcMaskee.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			}
			if (_btnUp != null) {
				
				_btnUp.addEventListener(MouseEvent.ROLL_OVER, btnUpMouseDown);
				
				_btnUp.addEventListener(MouseEvent.MOUSE_OUT, btnMouseOutAndUp);
				
				//_btnUp.addEventListener(MouseEvent.MOUSE_UP, btnMouseOutAndUp);
				
				//_btnUp.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			}
			if (_btnDown != null) {
				
				_btnDown.addEventListener(MouseEvent.ROLL_OVER, btnDownMouseDown);
				
				_btnDown.addEventListener(MouseEvent.MOUSE_OUT, btnMouseOutAndUp);
				
				//_btnDown.addEventListener(MouseEvent.MOUSE_UP, btnMouseOutAndUp);
				
				//_btnDown.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			}
		}
		
		private function removeListeners():void {
			
			_mcScroll.removeEventListener(MouseEvent.MOUSE_DOWN, scrollMouseDown);
			
			_mcScroll.stage.removeEventListener(MouseEvent.MOUSE_UP, scrollMouseUp);
			
			_mcScrollBg.removeEventListener(MouseEvent.MOUSE_DOWN, scrollBgMouseDown);
			
			_mcScrollBg.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			
			_mcMaskee.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			
			if (!_howMany) {
				
				//_mcMaskee.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			}
			if (_btnUp != null) {
				
				_btnUp.removeEventListener(MouseEvent.ROLL_OVER, btnUpMouseDown);
				
				_btnUp.removeEventListener(MouseEvent.MOUSE_OUT, btnMouseOutAndUp);
				
				//_btnUp.removeEventListener(MouseEvent.MOUSE_UP, btnMouseOutAndUp);
				
				//_btnUp.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			}
			if (_btnDown != null) {
				
				_btnDown.removeEventListener(MouseEvent.ROLL_OVER, btnDownMouseDown);
				
				_btnDown.removeEventListener(MouseEvent.MOUSE_OUT, btnMouseOutAndUp);
				
				//_btnDown.removeEventListener(MouseEvent.MOUSE_UP, btnMouseOutAndUp);
				
				//_btnDown.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			}
		}
		
		private function scrollMouseDown(event:MouseEvent):void {
			
			_mcScroll.startDrag(false, oRectangle);
			
			scrollMoveTimer.start();
		}
		
		private function scrollMouseUp(event:MouseEvent):void {
			
			_mcScroll[_type.attribute] = Math.floor(_mcScroll[_type.attribute]);
			
			_mcScroll.stopDrag();
			
			scrollMoveTimer.stop();
		}
		
		private function scrollMoveTimerEvent(event:TimerEvent):void {
			
			moveMaskee();
			
			event.updateAfterEvent();
		
		}
	
		private function scrollBgMouseDown(event:MouseEvent):void {
			
			moveScroll(_mcScroll.parent[mouse]);
			
			event.updateAfterEvent();
		
		}
		
		private function btnUpMouseDown(event:MouseEvent):void {
			
			moveScroll(_mcScroll[_type.attribute] - _px);
			
			nowMoveType = "up";
			
			btnMouseDownTimer.start();
			
			//event.updateAfterEvent();
		}
		
		private function btnDownMouseDown(event:MouseEvent):void {
			
			moveScroll(_mcScroll[_type.attribute] + _mcScroll[_type.type] + _px);
			
			nowMoveType = "down";
			
			btnMouseDownTimer.start();
			
			//event.updateAfterEvent();
		
		}
		
		private function btnMouseOutAndUp(event:MouseEvent):void {
			
			btnMouseDownTimer.stop();
			
			btnMoveTimer.stop();
			
			event.updateAfterEvent();
		
		}
		
		private function btnMouseDownTimerEvent(event:TimerEvent):void {
			
			btnMouseDownTimer.stop();
			
			btnMoveTimer.start();
			
			event.updateAfterEvent();
		}
		
		private function btnMoveTimerEvent(event:TimerEvent):void {
			
			if (nowMoveType == "up") {
				
				moveScroll(_mcScroll[_type.attribute] - _px);
				
			} else {
				
				moveScroll(_mcScroll[_type.attribute] + _mcScroll[_type.type] + _px);
			}
			
			event.updateAfterEvent();
		}
		
		private function mouseWheel(event:MouseEvent):void {
			
			if (event.delta < 0) {
				
				moveScroll(_mcScroll[_type.attribute] + _mcScroll[_type.type] + _px);

			} else {

				moveScroll(_mcScroll[_type.attribute] - _px);
			
			}
			
			event.updateAfterEvent();
		}
		
		public function moveScroll(iY:int):void {
						
			if (iY > _mcScroll[_type.attribute]) {
				
				iY = Math.floor(iY-_mcScroll[_type.type]);
				
				_mcScroll[_type.attribute] = ((iY+_mcScroll[_type.type]+5) > (_mcScrollBg[_type.attribute]+_mcScrollBg[_type.type])) ? Math.floor(_mcScrollBg[_type.attribute]+_mcScrollBg[_type.type]-_mcScroll[_type.type]) : iY;

			} else {

				_mcScroll[_type.attribute] = (iY < (_mcScrollBg[_type.attribute]+5)) ? _mcScrollBg[_type.attribute] : iY;

			}
			
			moveMaskee();
		}

		private function moveMaskee():void {

			var percent:Number = (_mcMaskee[_type.type] - _showArea[_type.type])/100;

			var remove:Number = (_mcScroll[_type.attribute] - xOfy)/(_mcScrollBg[_type.type]-_mcScroll[_type.type]) * 100;

			TweenMax.to(_mcMaskee,.5, {y: -(Math.floor(remove * percent - maskee_a))});
			//_mcMaskee[_type.attribute] = -(Math.floor(remove * percent - maskee_a));
		}

		public function update():void {
			
			if (_mcMaskee[_type.type] < _showArea[_type.type]) {

				_ed.dispatchEvent(new Event(ScrollPanel.LESSTHAN));

				removeListeners();

				_mcMaskee[_type.attribute] = maskee_a;

				_mcScroll[_type.attribute] = xOfy;

				hideScroll();

			} else {
			
				_ed.dispatchEvent(new Event(ScrollPanel.GREATERTHAN));
				
				configureListeners();

				showScroll();
			}
		}
		
		private function hideScroll():void {
			
			if (_bHide) {

				//TweenMax.to(pScroll,0.5,{alpha:0});
				
				TweenMax.to(_mcScroll,0.5,{alpha:0});
				
				TweenMax.to(_mcScrollBg,0.5,{alpha:0});
				
				try{
					
					TweenMax.to(_btnUp,0.5,{alpha:0});
					
					TweenMax.to(_btnDown,0.5,{alpha:0});
					
				}catch(E:Error){
					
					trace("no up&down btn")
					
				}// end try..catch...
				
			}
		}
		
		private function showScroll():void {

			/*TweenMax.to(_mcScroll,0.5,{alpha:1});
				
			TweenMax.to(_mcScrollBg,0.5,{alpha:1});
				
			try{
					
				TweenMax.to(_btnUp,0.5,{alpha:1});
					
				TweenMax.to(_btnDown,0.5,{alpha:1});
					
			}catch(E:Error){
					
				trace("no up&down btn")
					
			}// end try..catch...
*/
		}
		
		public function set px(i:int):void {
		
			var percent:Number = (i/(_mcMaskee[_type.type] - _showArea[_type.type] - i))*100;
			
			_px = (_mcScrollBg[_type.type] - _mcScroll[_type.type]) * percent / 100;
		
		}
		
		public function set setHide(b:Boolean):void {
			
			_bHide = b;
		
		}
		
		public function get ed():EventDispatcher {
			
			return _ed;
		
		}
		
		public function reset():void{
						
			TweenMax.to(_mcScroll,0.5,{x:cellPOS.scrollPOS.x,y:cellPOS.scrollPOS.y});
			
			TweenMax.to(_mcMaskee,0.5,{x:cellPOS.contentPOS.x,y:cellPOS.contentPOS.y})
			
		}// end reset()
		
	}// end class
}// end package