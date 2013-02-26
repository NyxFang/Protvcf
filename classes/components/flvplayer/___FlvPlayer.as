//Created by Action Script Viewer - http://www.buraks.com/asv
package components.flvplayer {
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.media.*;
	import pages.index.event.BGMEvent;

    public class FlvPlayer {

        private var view:MovieClip;
        private var video_Holder:MovieClip;
        private var pic_Holder:MovieClip;
        private var toggleBtn:MovieClip;
        private var muteBtn:MovieClip;
        private var playedTimeTxt:TextField;
        private var totalTimeTxt:TextField;
        private var fullScreenBtn:MovieClip;
        private var bar_Holder:MovieClip;
        private var progressBar:MovieClip;
        private var loadTxt:TextField;
        private var video:Video;
        private var st:SoundTransform;
        private var loader:Loader;
        private var connection:NetConnection;
        private var stream:NetStream;
        private var mediaInfo:Object;
        public var imageURL:String;
        public var videoURL:String;
        public var keeprate:Boolean;// = true

        public function FlvPlayer(_arg1:MovieClip):void{
            view = _arg1;
            init();
        }
        private function init():void{
            video_Holder = (view.getChildByName("video_holder") as MovieClip);
            pic_Holder = (view.getChildByName("pic_holder") as MovieClip);
            pic_Holder.alpha = 1;
            pic_Holder.visible = true;
            toggleBtn = (view.getChildByName("togglebtn") as MovieClip);
            muteBtn = (view.getChildByName("mute_btn") as MovieClip);
            fullScreenBtn = (view.getChildByName("fullscreen_btn") as MovieClip);
            fullScreenBtn.visible = false;
            bar_Holder = (view.getChildByName("bar") as MovieClip);
            progressBar = (bar_Holder.getChildByName("progressbar") as MovieClip);
            progressBar.width = 0;
            video = new Video(466, 0x0101);
            connection = new NetConnection();
            connection.connect(null);
            stream = new NetStream(connection);
            video.attachNetStream(stream);
            video_Holder.addChild(video);
            st = new SoundTransform();
            var _local1:Object = new Object();
            _local1.onMetaData = onMetaData;
            stream.client = _local1;
            loader = new Loader();
            configEvents();
        }
        private function configEvents():void{
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, picLoaded);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
            toggleBtn.addEventListener(MouseEvent.CLICK, toggleHandler);
            muteBtn.addEventListener(MouseEvent.CLICK, muteHandler);
            fullScreenBtn.addEventListener(MouseEvent.CLICK, fullScreen);
            progressBar.addEventListener(MouseEvent.CLICK, seekHandler);
        }
        public function playVideo():void{
            pic_Holder.alpha = 0;
            pic_Holder.visible = false;
            stream.play(videoURL);
        }
        public function playImage():void{
            loader.unload();
            pic_Holder.visible = false;
            loader.load(new URLRequest(imageURL));
        }
        private function picLoaded(_arg1:Event):void{
            var evt = _arg1;
            try {
                viewClear();
            } catch(e:Error) {
            };
            pic_Holder.visible = true;
            pic_Holder.addChildAt(loader, 0);
        }
        private function toggleHandler(_arg1:MouseEvent):void{
            if (toggleBtn.currentFrame == 1){
                if (progressBar.width <= 1){
                    playVideo();
                } else {
                    if ((Math.min(stream.time, mediaInfo["duration"]) / mediaInfo["duration"]) >= 0.99){
                        stream.seek(0);
                        muteBtn.gotoAndStop(1);
                    } else {
                        stream.pause();
                        toggleBtn.gotoAndStop(2);
                    };
                };
            } else {
                stream.resume();
                toggleBtn.gotoAndStop(1);
            };
        }
        private function muteHandler(_arg1:MouseEvent):void{
            if (muteBtn.currentFrame == 1){
                st.volume = 0;
                muteBtn.gotoAndStop(2);
            } else {
                st.volume = 0.5;
                muteBtn.gotoAndStop(1);
            };
            stream.soundTransform = st;
        }
        private function fullScreen(_arg1:MouseEvent):void{
            var _local2:Rectangle = view.getBounds(view);
            view.stage.fullScreenSourceRect = _local2;
            if (fullScreenBtn.currentFrame == 1){
                view.stage.displayState = StageDisplayState.FULL_SCREEN;
                fullScreenBtn.gotoAndStop(2);
            } else {
                view.stage.displayState = StageDisplayState.NORMAL;
                fullScreenBtn.gotoAndStop(1);
            };
        }
        private function seekHandler(_arg1:MouseEvent):void{
        }
        public function onMetaData(_arg1:Object):void{
            var _local4:Number;
            this.mediaInfo = _arg1;
            st.volume = 0.5;
            stream.soundTransform = st;
            var _local2:Number = (mediaInfo["width"] / video_Holder.width);
            var _local3:Number = (mediaInfo["height"] / video_Holder.height);
            _local4 = ((_local2 > _local3)) ? _local2 : _local3;
            video.width = (mediaInfo["width"] / _local4);
            video.height = (mediaInfo["height"] / _local4);
            video.x = ((video_Holder.width - video.width) / 2);
            view.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }
        private function timerFotmat(_arg1:Number):String{
            _arg1 = int(_arg1);
            var _local2:String = String((_arg1 % 60));
            _local2 = ((_local2.length < 2)) ? ("0" + _local2) : _local2;
            var _local3:String = String(int((_arg1 / 60)));
            _local3 = ((_local3.length < 2)) ? ("0" + _local3) : _local3;
            return (((_local3 + ":") + _local2));
        }
        private function enterFrameHandler(_arg1:Event):void{
            progressBar.width = ((Math.min(stream.time, mediaInfo["duration"]) / mediaInfo["duration"]) * bar_Holder.width);
        }
        private function netStatusHandler(_arg1:NetStatusEvent):void{
            switch (_arg1.info.code){
                case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    trace(("Unable to locate video: " + videoURL));
                    break;
                case "NetStream.Play.Stop":
                    view.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
					view.dispatchEvent(new BGMEvent(BGMEvent.UN_OR_MUTE));
                    break;
            };
        }
        public function clear():void{
			view.dispatchEvent(new BGMEvent(BGMEvent.UN_OR_MUTE));
            connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, picLoaded);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
            toggleBtn.removeEventListener(MouseEvent.CLICK, toggleHandler);
            muteBtn.removeEventListener(MouseEvent.CLICK, muteHandler);
            fullScreenBtn.removeEventListener(MouseEvent.CLICK, fullScreen);
            progressBar.removeEventListener(MouseEvent.CLICK, seekHandler);
            view.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            connection.close();
            stream.close();
            video.clear();
            connection = null;
            stream = null;
            video = null;
			
        }
        public function viewClear():void{
            while (pic_Holder.numChildren > 0) {
                pic_Holder.removeChildAt(0);
            };
        }
        private function connectStream():void{
            video.attachNetStream(stream);
        }
        private function securityErrorHandler(_arg1:SecurityErrorEvent):void{
            trace(("securityErrorHandler: " + _arg1));
        }
        private function asyncErrorHandler(_arg1:AsyncErrorEvent):void{
        }
        private function IOErrorHandler(_arg1:IOErrorEvent):void{
            trace(((videoURL + " ----- ioerror ------ ") + imageURL));
        }

    }
}//package components.flvplayer 
