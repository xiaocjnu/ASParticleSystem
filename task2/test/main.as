import utils.particles.Emitter;
import flash.utils.Dictionary;

import utils.action.*
import utils.action.instant.*
import utils.particles.CanvasRender;
import flash.events.Event;
import utils.particles.*


addChild(new FPS())

//׼������
function onEnterFrame(e:Event) : void{
	var dt:Number = 1.0 / stage.frameRate
	EmitterManager.getInstance().update(dt) 
	ASActionManager.getInstance().update(dt)
}
//���ϣ��ʹ��canvasģʽ��ȾͼƬ����Ҫ��ʼ��ȫ��λͼ��ȫ��ֻ��Ҫִ��һ��ֻ�ɡ�
CanvasRender.initCanvas(stage.stageWidth, stage.stageHeight)
stage.addChild(CanvasRender.canvas)

this.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true)


// run
//EmitterManager.getInstance().addEmitter(emitter)
var demo:ParticlesDemo = new ParticlesDemo(stage)






