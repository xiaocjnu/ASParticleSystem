import utils.particles.Emitter;
import flash.utils.Dictionary;

import utils.action.*
import utils.action.instant.*
import utils.particles.CanvasRender;
import flash.events.Event;
import utils.particles.*


addChild(new FPS())

//准备工作
function onEnterFrame(e:Event) : void{
	var dt:Number = 1.0 / stage.frameRate
	EmitterManager.getInstance().update(dt) 
	ASActionManager.getInstance().update(dt)
}
//如果希望使用canvas模式渲染图片，需要初始化全局位图。全局只需要执行一次只可。
CanvasRender.initCanvas(stage.stageWidth, stage.stageHeight)
stage.addChild(CanvasRender.canvas)

this.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true)


// run
//EmitterManager.getInstance().addEmitter(emitter)
var demo:ParticlesDemo = new ParticlesDemo(stage)






