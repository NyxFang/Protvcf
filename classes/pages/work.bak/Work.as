//Created by Action Script Viewer - http://www.buraks.com/asv
package pages.work {
    import flash.display.*;
    import com.greensock.*;
    import components.loader.*;

    public class Work extends MovieClip {

        public var section_mc:MovieClip;
        private var workintro:WorkIntro;

        public function Work(){
            addFrameScript(0, frame1, 47, frame48);
            this.addFrameScript(47, initCell);
        }
        private function initCell():void{
            this.stop();
            var _local1:MovieClip = (this.getChildByName("section_mc") as MovieClip);
            workintro = new WorkIntro(_local1["section_1"]);
        }
        public function effectIn():void{
            this.play();
        }
        public function effectOut():void{
            TweenMax.to(this, 1.7, {frame:MovieClip(this).totalFrames, onComplete:dispathOut});
        }
        private function dispathOut():void{
            this.dispatchEvent(new EffectOutEvent(EffectOutEvent.EFFECT_OUT_COMPLETE));
            workintro.clear();
        }
        

    }
}//package pages.work 
