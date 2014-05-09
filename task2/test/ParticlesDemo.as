package {
	import flash.events.Event;
	import flash.utils.*
	import flash.display.*
	import utils.particles.*
	import utils.action.*
	import utils.action.instant.*
	import flash.geom.Point;

	public class ParticlesDemo extends Object{
		protected var m_emitterManager:EmitterManager
		protected var m_actionManager:ASActionManager
		protected var m_stage:Stage
		protected var m_intervalId:uint
		protected var m_bolideCount:int

		[Embed(source = "plist/PT_Current.plist", mimeType = "application/octet-stream")]
		protected var SnowXMLData:Class

		[Embed(source = "plist/PT_Hero.plist", mimeType = "application/octet-stream")]
		protected var BolideXMLData:Class

		[Embed(source = "plist/PT_Explode.plist", mimeType = "application/octet-stream")]
		protected var ExplodeXMLData:Class

		[Embed(source = "plist/PT_Smog.plist", mimeType = "application/octet-stream")]
		protected var SmogXMLData:Class

		public function ParticlesDemo(stage:Stage) {
			m_emitterManager = EmitterManager.getInstance()
			m_actionManager = ASActionManager.getInstance()
			m_stage = stage
			m_bolideCount = 0

			start()
		}

		public function start() : void{
			//初始化方法1，先将plist文件嵌入。推荐
			var snow:Emitter = new Emitter(150, new firePng(), 0, 0)
			snow.initWithXML(XML(new SnowXMLData))
			//明确指定发射完毕后自动删除
			//或者手动删除
			//否则会造成内存泄露
			snow.isAutoRemoveOnFinish = true
			m_emitterManager.addEmitterWithTarget(snow, m_stage)

			// //初始化方法2，直接读取plist。不推荐。
			// var snow:Emitter = new Emitter(150, null, 0, 1)
			// snow.initWithPlist("plist/PT_Current.plist", true)
			// snow.isAutoRemoveOnFinish = true
			// //如果用读取plist的文件初始化，要用listener等待plist加载完毕
			// snow.addEventListener(Event.COMPLETE, 
			// 		  function (e:Event) {
			//			  m_stage.addChild(snow)
			// 			  m_emitterManager.addEmitter(snow)
			// 		  },
			// 		  false, 0, true)

			m_intervalId = setInterval(addBolide, 1000)
		}

		public function addBolide() : void{
			if(m_bolideCount >= 5)
				return

			var bolide:Emitter = new Emitter(150, new firePng(), 0, 0) 
			bolide.initWithXML(XML(new BolideXMLData))
			m_emitterManager.addEmitterWithTarget(bolide, m_stage)
			bolide.x = (m_stage.stageWidth * Math.random()) * 0.8 + 50
			bolide.y = 0

			var moveby:ASMoveBy = new ASMoveBy(0.8, new Point(0, m_stage.stageHeight / 2 + m_stage.stageHeight / 2 * Math.random()))
			var callFuncN:ASCallFuncN = new ASCallFuncN(removeBolide)
			m_actionManager.addActionWithTarget(new ASSequence(moveby, callFuncN), bolide)
			m_bolideCount++
		}

		protected function removeBolide(target:DisplayObject) : void{
			var bolide:Emitter = target as Emitter
			bolide.isAutoRemoveOnFinish = true
			bolide.stop()
			m_bolideCount--
			
			
			var explode:Emitter = new Emitter(150, new firePng(), 0, 0) 
			explode.initWithXML(XML(new ExplodeXMLData()))
			explode.isAutoRemoveOnFinish = true
			m_emitterManager.addEmitterWithTarget(explode, m_stage)

			explode.x = bolide.x
			explode.y = bolide.y

			var smog:Emitter = new Emitter(150, new firePng(), 0, 0)  
			smog.initWithXML(XML(new SmogXMLData()))
			smog.isAutoRemoveOnFinish = true
			m_emitterManager.addEmitterWithTarget(smog, m_stage)
			smog.x = bolide.x
			smog.y = bolide.y
		}

		public function dispose(){
			clearInterval(m_intervalId)
		}

	}
}
