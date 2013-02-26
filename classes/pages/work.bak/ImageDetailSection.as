//Created by Action Script Viewer - http://www.buraks.com/asv
package pages.work {
    import flash.display.*;
    import flash.events.*;
    import com.greensock.events.*;
    import com.greensock.*;
    import com.greensock.loading.*;
    import flash.utils.*;
    import flash.text.*;

    public class ImageDetailSection {

        private const SPACE:int = 5;

        private var view:MovieClip;
        private var image_Group:MovieClip;
        private var SPEED:int;// = 2
        private var timer:Timer;
        private var itemArr:Array;
        private var queue:LoaderMax;
        private var loadingmc:MovieClip;
        private var loadingContent:MovieClip;
        private var loadingTxt:TextField;
        private var leftBtn:MovieClip;
        private var rightBtn:MovieClip;
        private var flag:Boolean;// = false
        private var xmlLength:int;// = 0

        public function ImageDetailSection(_arg1:MovieClip, _arg2:MovieClip){
            view = _arg1;
            loadingmc = _arg2;
            loadingmc.visible = false;
            view.visible = true;
            image_Group = (view.getChildByName("image_group") as MovieClip);
            loadingContent = (loadingmc.getChildByName("loading_mc") as MovieClip);
            loadingTxt = (loadingmc.getChildByName("txt") as TextField);
            image_Group.alpha = 0;
            itemArr = [];
            timer = new Timer(24);
            timer.addEventListener(TimerEvent.TIMER, loop);
            leftBtn = (view.getChildByName("leftbtn") as MovieClip);
            rightBtn = (view.getChildByName("rightbtn") as MovieClip);
            leftBtn.buttonMode = true;
            rightBtn.buttonMode = true;
        }
        public function setData(_arg1:XML, _arg2:Boolean=true):void{
            var _local4:ImageItem;
            TweenLite.to(image_Group, 1, {alpha:0});
            loadingTxt.text = "0%";
            queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
            xmlLength = _arg1["items"]["item"].length();
            var _local3:int;
            while (_local3 < xmlLength) {
                _local4 = new ImageItem(startTimer, stopTimer, _arg2);
                queue.append(new ImageLoader(_arg1["items"]["item"][_local3]["imagesection_thumbnail"], {name:(_local3 + "thumbnail"), container:_local4.imageContent, x:0, y:0, width:_local4.imageContent.width, height:_local4.imageContent.height}));
                queue.append(new SWFLoader(_arg1["items"]["item"][_local3]["imagesection_txt"], {name:(_local3 + "title"), container:_local4.infoContent, x:0, y:0, width:_local4.infoContent.width, height:_local4.infoContent.height}));
                if (_local3 == 0){
                    _local4.x = 0;
                };
                _local4.x = ((_local4.width + SPACE) * _local3);
                image_Group.addChildAt(_local4, 0);
                _local4.index = _local3;
                itemArr.push(_local4);
                _local3++;
            };
            queue.load();
            if (_arg2){
                configEvens();
            } else {
                removeConfigEvens();
            };
        }
        private function configEvens():void{
            leftBtn.addEventListener(MouseEvent.ROLL_OUT, outHandler);
            leftBtn.addEventListener(MouseEvent.ROLL_OVER, overHandler);
            rightBtn.addEventListener(MouseEvent.ROLL_OUT, outHandler);
            rightBtn.addEventListener(MouseEvent.ROLL_OVER, overHandler);
        }
        private function removeConfigEvens():void{
            leftBtn.removeEventListener(MouseEvent.ROLL_OUT, outHandler);
            leftBtn.removeEventListener(MouseEvent.ROLL_OVER, overHandler);
            rightBtn.removeEventListener(MouseEvent.ROLL_OUT, outHandler);
            rightBtn.removeEventListener(MouseEvent.ROLL_OVER, overHandler);
        }
        public function loop(_arg1:TimerEvent):void{
            if (image_Group.x <= (1000 - image_Group.width)){
                if (flag){
                    stopTimer();
                };
                SPEED = -2;
            };
            if (image_Group.x >= 0){
                if (flag){
                    stopTimer();
                };
                SPEED = 2;
            };
            image_Group.x = (image_Group.x - SPEED);
        }
        public function startTimer():void{
            timer.start();
        }
        public function stopTimer():void{
            timer.reset();
            timer.stop();
        }
        private function backHandler(_arg1:MouseEvent):void{
            var evt = _arg1;
            stopTimer();
            timer.removeEventListener(TimerEvent.TIMER, loop);
            timer = null;
            TweenMax.to(view, 0.5, {alpha:0, onComplete:function (){
                view["parent"].gotoAndPlay(1);
                view.visible = false;
            }});
        }
        private function outHandler(_arg1:MouseEvent):void{
            flag = false;
            if (!timer.running){
                startTimer();
            };
            if (_arg1.currentTarget.name == "leftbtn"){
                SPEED = -2;
            } else {
                SPEED = 2;
            };
            MovieClip(_arg1.currentTarget).gotoAndPlay(1);
        }
        private function overHandler(_arg1:MouseEvent):void{
            flag = true;
            if (_arg1.currentTarget.name == "leftbtn"){
                SPEED = -8;
            } else {
                SPEED = 8;
            };
            MovieClip(_arg1.currentTarget).gotoAndPlay(2);
        }
        public function effectOut():void{
            TweenMax.to(view, 0.5, {autoAlpha:0});
        }
        public function effectIn():void{
            TweenMax.to(view, 0.5, {autoAlpha:1});
        }
        public function enabledMouse(_arg1:int, _arg2:Boolean):void{
            itemArr[_arg1].itemBtnEnabeld(_arg2);
        }
        private function progressHandler(_arg1:LoaderEvent):void{
            loadingmc.visible = true;
            loadingmc.alpha = 1;
            loadingTxt.text = String((int((queue.progress * 100)) + "%"));
        }
        private function completeHandler(_arg1:LoaderEvent):void{
            loadingmc.visible = false;
            if (xmlLength <= 4){
                image_Group.x = 7;
                stopTimer();
            } else {
                startTimer();
            };
            TweenLite.to(image_Group, 1, {alpha:1});
        }
        private function errorHandler(_arg1:LoaderEvent):void{
            trace(((("error occured with " + _arg1.target) + ": ") + _arg1.text));
        }
        public function clear():void{
            stopTimer();
            var _local1:int;
            while (_local1 < itemArr.length) {
                itemArr[_local1].clear();
                _local1++;
            };
            while (image_Group.numChildren > 0) {
                image_Group.removeChildAt(0);
            };
            itemArr = [];
            if (queue){
                queue.empty(true, true);
            };
            image_Group.x = 0;
        }

    }
}//package pages.work 
