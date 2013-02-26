//Created by Action Script Viewer - http://www.buraks.com/asv
package pages.work {
    import flash.display.*;
    import flash.events.*;
    import com.greensock.*;

    public class ImageItem extends MovieClip {

        public var imagecontent:MovieClip;
        public var infocontent:MovieClip;
        public var btn:SimpleButton;
        public var imageContent:MovieClip;
        public var infoContent:MovieClip;
        private var itemBtn:SimpleButton;
        private var loader:Loader;
        private var loader1:Loader;
        private var startMove:Function;
        private var stopMove:Function;
        public var index:int;// = 0
        private var moveOrNotMove:Boolean;// = false
        private var timerflag:Boolean;

        public function ImageItem(_arg1:Function, _arg2:Function, _arg3:Boolean=true){
            addFrameScript(0, frame1, 9, frame10);
            startMove = _arg1;
            stopMove = _arg2;
            timerflag = _arg3;
            init();
        }
        private function init():void{
            imageContent = (this.getChildByName("imagecontent") as MovieClip);
            infoContent = (this.getChildByName("infocontent") as MovieClip);
            itemBtn = (this.getChildByName("btn") as SimpleButton);
            configEvents();
        }
        private function configEvents():void{
            itemBtn.addEventListener(MouseEvent.CLICK, clickHandler);
            itemBtn.addEventListener(MouseEvent.ROLL_OUT, outHandler);
            itemBtn.addEventListener(MouseEvent.ROLL_OVER, overHandler);
        }
        public function startLoad(_arg1:String, _arg2:String):void{
        }
        private function imageLoaded(_arg1:Event):void{
        }
        private function infoLoaded(_arg1:Event):void{
        }
        private function clickHandler(_arg1:MouseEvent):void{
            moveOrNotMove = true;
            this.dispatchEvent(new WorkEvent(WorkEvent.ITEM_CLICK, index));
        }
        private function overHandler(_arg1:MouseEvent):void{
            moveOrNotMove = false;
            stopMove();
            TweenMax.to(this, 0.5, {frame:this.totalFrames});
        }
        private function outHandler(_arg1:MouseEvent):void{
            if (!moveOrNotMove){
                if (timerflag){
                    startMove();
                };
            };
            TweenMax.to(this, 0.5, {frame:1});
        }
        public function itemBtnEnabeld(_arg1:Boolean):void{
            moveOrNotMove = false;
            if (timerflag){
                startMove();
            };
        }
        private function ioerrorHandler(_arg1:IOErrorEvent):void{
            trace("path.. error");
        }
        public function clear():void{
            itemBtn.removeEventListener(MouseEvent.CLICK, clickHandler);
            itemBtn.removeEventListener(MouseEvent.ROLL_OUT, outHandler);
            itemBtn.removeEventListener(MouseEvent.ROLL_OVER, overHandler);
        }
        function frame1(){
            stop();
        }
        function frame10(){
            stop();
        }

    }
}//package pages.work 
