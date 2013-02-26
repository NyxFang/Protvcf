package pages.index.view{
	
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import flash.net.URLRequest;
	
	import flash.external.ExternalInterface;
	
	import com.greensock.TweenLite;
	
	import components.loader.SwfLoader;
	import pages.index.event.MenuEvent;
	import pages.index.event.BGMEvent;
	
	//import pages.home.Menu;
	
	public class Index extends MovieClip{
		
		private var swfloader;
		
		private var menu:Menu;
		
		private var menu_MC:MovieClip;
		
		private var footer:Footer;
		
		private var loaderContent:MovieClip;
		
		private var loadingMC:MovieClip;
		
		private var muteMC:MovieClip;
		
		private var soundtransform:SoundTransform;
		
		private var channel:SoundChannel ;
		
		private var sound:Sound;
		
		public function Index(){
			
			addEventListener(Event.ADDED_TO_STAGE,initStage);
			
		}// end Index()
		
		private function initStage(evt:Event):void{
			
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			init();
			
		}// end initStage()
		
		private function init():void{
			
			loaderContent =  this.getChildByName("loadcontent") as MovieClip;
			
			loadingMC = this.getChildByName("load_mc") as MovieClip;
			
			swfloader = new SwfLoader(loaderContent,loadingMC,callBack);
			
			menu_MC = this.getChildByName("menu_mc") as MovieClip
			
			menu = new Menu(menu_MC,swfloader);
			
			muteMC = this.getChildByName("mute_btn") as MovieClip;
			
			muteMC.visible = false;
			
			footer = new Footer();
			
			footer.initCell(this["footer_mc"]["footer_1"],this["menu_mc"]["menuItem_4"]);
			
			startBGM();
			
			introStart();
			
		}
		
		private function startBGM():void{
			
			this.addEventListener(BGMEvent.UN_OR_MUTE,soundVolume);
			
			sound = new Sound(new URLRequest("resources/bgm.mp3"));
			
			channel = sound.play();
			
			channel.addEventListener(Event.SOUND_COMPLETE,channelHandler);
			
			soundtransform = new SoundTransform(0.5);
			
			channel.soundTransform = soundtransform;
			
			muteMC.addEventListener(MouseEvent.CLICK,muteHandler);
			
		}
		
		private function channelHandler(evt:Event){
				
				channel.removeEventListener(Event.SOUND_COMPLETE,channelHandler);
				
				channel = sound.play();
				
				channel.soundTransform = soundtransform;
				
				channel.addEventListener(Event.SOUND_COMPLETE,channelHandler);
				
		}
		
		private function muteHandler(evt:MouseEvent):void{
			
			
			soundVolume(null);
						
		}
		
		private function soundVolume(evt:BGMEvent):void{
			
			if(channel.soundTransform.volume == 0){ 
				
				soundtransform.volume = 0.5;
				
				//TweenLite.to(soundtransform,0.5,{volume:0.5});
				
				muteMC.gotoAndStop(1);
				
			}else{
				
				//TweenLite.to(soundtransform,0.5,{volume:0.0001});
				
				soundtransform.volume = 0;
				
				muteMC.gotoAndStop(2);
				
			}
			
			channel.soundTransform = soundtransform;
			
		}
		
		private function introStart(){
			
			menu_MC.visible = false;
			
			this["footer_mc"].visible = false;
			
		}// end introStart();
		
		private function introEnd(){
			
			menu_MC.visible = true;
			
			this["footer_mc"].visible = true;
			
		}// end introStart();
		
		private function callBack(_path:String):void{
			
			if(_path == "intro.swf"){
				
				introStart();
				
			}else{
				try{
					
					introEnd();
					
				}catch(e:Error){
					
					trace("not intro")
					
				}
			}
			
			if(_path != URLPath.HOME &&_path != "intro.swf"&&_path != "about.swf"){
				
				this.gotoAndStop(2);
				
				
			}else{
				
				this.gotoAndStop(1);
				
				MovieClip(this).addFrameScript(0,resetFooter);
				
				
			}
			muteMC.visible = true;
			
			//swfloader.startLoader(_path);
			
		}// end loadSwf();
		
		private function resetFooter():void{
			
			footer.initCell(this["footer_mc"]["footer_1"],this["menu_mc"]["menuItem_4"]);
			
		}// end resetFooter()
		
	}// end class
	
}// end package