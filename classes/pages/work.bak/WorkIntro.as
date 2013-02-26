//Created by Action Script Viewer - http://www.buraks.com/asv
package pages.work {
    import flash.display.*;
    import flash.events.*;
    import com.greensock.*;
    import components.utils.*;

    public class WorkIntro {

        private var view:MovieClip;
        private var btnGroup:MovieClip;
        private var tvcBtn:MovieClip;
        private var videoBtn:MovieClip;
        private var viralBtn:MovieClip;
        private var tvc_moreBtn:MovieClip;
        private var making_offBtn:MovieClip;
        private var tempbtn:MovieClip;
        private var imageSection_view:MovieClip;
        private var videoSection_view:MovieClip;
        private var imageSection:ImageDetailSection;
        private var videoSection:VideoDetailSection;
        private var path:String;
        private var data:XML;
        private var item_count:int;// = 0
        private var loading:MovieClip;
        private var timerflag:Boolean;// = true

        public function WorkIntro(_arg1:MovieClip){
            path = URLPath.TVC_XML;
            super();
            view = _arg1;
            view.addFrameScript(25, initBtn);
        }
        private function initBtn():void{
            view.stop();
            loading = (view.getChildByName("load_mc") as MovieClip);
            loading.visible = false;
            btnGroup = (view.getChildByName("btngroup") as MovieClip);
            tvcBtn = (btnGroup.getChildByName("tvc") as MovieClip);
            tvcBtn.play();
            videoBtn = (btnGroup.getChildByName("video") as MovieClip);
            viralBtn = (btnGroup.getChildByName("viral") as MovieClip);
            tvc_moreBtn = (btnGroup.getChildByName("tvcmore") as MovieClip);
            making_offBtn = (btnGroup.getChildByName("makingoff") as MovieClip);
            tempbtn = tvcBtn;
            initSectionView();
            configEvents();
        }
        private function initSectionView():void{
            imageSection_view = (view.getChildByName("imagesection") as MovieClip);
            imageSection_view.visible = false;
            videoSection_view = (view.getChildByName("videosection") as MovieClip);
            videoSection_view.visible = false;
            videoSection = new VideoDetailSection(videoSection_view, videoSectionBack);
            imageSection = new ImageDetailSection(imageSection_view, loading);
            imageSection.effectOut();
        }
        private function configEvents():void{
            tvcBtn.addEventListener(MouseEvent.CLICK, clickHandler);
            tvcBtn.addEventListener(MouseEvent.ROLL_OUT, outHandler);
            tvcBtn.addEventListener(MouseEvent.ROLL_OVER, overHandler);
            videoBtn.addEventListener(MouseEvent.CLICK, clickHandler);
            videoBtn.addEventListener(MouseEvent.ROLL_OUT, outHandler);
            videoBtn.addEventListener(MouseEvent.ROLL_OVER, overHandler);
            viralBtn.addEventListener(MouseEvent.CLICK, clickHandler);
            viralBtn.addEventListener(MouseEvent.ROLL_OUT, outHandler);
            viralBtn.addEventListener(MouseEvent.ROLL_OVER, overHandler);
            tvc_moreBtn.addEventListener(MouseEvent.CLICK, clickHandler);
            tvc_moreBtn.addEventListener(MouseEvent.ROLL_OUT, outHandler);
            tvc_moreBtn.addEventListener(MouseEvent.ROLL_OVER, overHandler);
            making_offBtn.addEventListener(MouseEvent.CLICK, clickHandler);
            making_offBtn.addEventListener(MouseEvent.ROLL_OUT, outHandler);
            making_offBtn.addEventListener(MouseEvent.ROLL_OVER, overHandler);
            view.addEventListener(WorkEvent.ITEM_CLICK, itemClickHandler);
            setPath();
        }
        private function clickHandler(_arg1:MouseEvent):void{
            loading["txt"].text = "0%";
            TweenMax.to(tempbtn, 0.5, {frame:1});
            if (tempbtn == MovieClip(_arg1.currentTarget)){
                return;
            };
            tempbtn = (_arg1.currentTarget as MovieClip);
            imageSection.effectOut();
            imageSection.clear();
            imageSection.stopTimer();
            imageSection_view.x = 0;
            imageSection_view.visible = false;
            switch (_arg1.currentTarget.name){
                case "tvc":
                    path = URLPath.TVC_XML;
                    break;
                case "video":
                    path = URLPath.VIDEO_XML;
                    break;
                case "viral":
                    path = URLPath.VIRAL_XML;
                    break;
                case "tvcmore":
                    path = URLPath.TVC_MORE_XML;
                    break;
                case "makingoff":
                    path = URLPath.MAKING_OFF_XML;
                    break;
            };
            setPath();
        }
        private function setPath():void{
            var _local1:DataStream = new DataStream(success, fail);
            _local1.getData(path);
        }
        private function success(_arg1:XML):void{
            imageSection.effectIn();
            data = _arg1;
            if (_arg1["items"]["item"].length() <= 4){
                timerflag = false;
            };
            imageSection.setData(_arg1, timerflag);
        }
        private function itemClickHandler(_arg1:WorkEvent):void{
            item_count = _arg1.item;
            TweenMax.to(btnGroup, 0.5, {autoAlpha:0});
            imageSection.effectOut();
            imageSection.stopTimer();
            videoSection.effectIn();
            videoSection.flvInit(data["items"]["item"][_arg1.item]["videosection_video_path"], data["items"]["item"][_arg1.item]["videosection_video_thumbnail"]);
            videoSection.titleInit(data["items"]["item"][_arg1.item]["videosection_title_image"]);
            videoSection.data = data;
            videoSection.count = _arg1.item;
            videoSection.total = data["items"]["item"].length();
        }
        private function videoSectionBack():void{
            imageSection.effectIn();
            videoSection.effectOut();
            if (!timerflag){
                imageSection.stopTimer();
            };
            TweenMax.to(btnGroup, 0.5, {autoAlpha:1});
            imageSection.enabledMouse(item_count, true);
        }
        private function outHandler(_arg1:MouseEvent):void{
            if (tempbtn == MovieClip(_arg1.currentTarget)){
                return;
            };
            var _local2:MovieClip = MovieClip(_arg1.currentTarget);
            TweenMax.to(_local2, 0.5, {frame:1});
        }
        private function overHandler(_arg1:MouseEvent):void{
            var _local2:MovieClip = MovieClip(_arg1.currentTarget);
            TweenMax.to(_local2, 0.5, {frame:_local2.totalFrames});
        }
        private function fail(_arg1:String):void{
            trace(_arg1);
        }
        public function clear():void{
            imageSection.clear();
            videoSection.clear();
        }

    }
}//package pages.work 
