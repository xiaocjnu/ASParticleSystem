package {
	import flash.display.*
	import flash.geom.*
	import flash.events.*
	import utils.particles.*

	public class FireEmitter extends Emitter{

		public function FireEmitter(maxParticles:Number = 150, 
			texture:BitmapData = null,
			emitterMode:int = GRAVITY_MODE,
			renderMode:int = PARTICLE_RENDER
			){
			super(maxParticles, texture, emitterMode, renderMode)

			initEmitter()
			mouseChildren = false	
		}


		public function initEmitter() : void{
			if(m_texture == null){
				m_texture = new firePng()
				m_render.texture = m_texture
			}
			//var bmd:BitmapData = new BitmapData(m_stage.stageWidth, m_stage.stageHeight, true, 0x0) 
			//var bmp:Bitmap = new Bitmap(bmd)
			//addChild(bmp)
			//m_render.setCanvas(bmd)
			
			//emitter.addChild(emitter.bmps[0])
			
			m_gravityX = 0
			m_gravityY = 9.8
			m_speed = 60
			m_speedVar = 20

			m_startSize = 32
			m_startSizeVar = 0
			m_endSize = 32
			m_endSizeVar = 0

			m_emitAngle = -90
			m_emitAngleVar = 10
			m_lifespan = 3
			m_lifespanVar = 0.25
			updateEps()

			m_startX = 400
			m_startY = 250
			m_startXVar = 40
			m_startYVar = 20

			m_startColor = new ColorARGB(1, 193.0/255, 63.0/255, 30.0/255)
			m_startColorVar = new ColorARGB(0, 0, 0, 0)
			m_endColor = new ColorARGB(1, 0, 0, 0)
			m_endColorVar = new ColorARGB(0, 0, 0, 0)

			m_duration = 3

			m_startRotation = 0
			m_startRotationVar = 0
			m_endRotation = 0
			m_endRotationVar = 0
			m_emitterMode = 0
		}


	}
}