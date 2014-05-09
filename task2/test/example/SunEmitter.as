package {
	import flash.display.*
	import flash.geom.*
	import flash.events.*
	import utils.particles.*

	public class SunEmitter extends Emitter{

		public function SunEmitter(maxParticles:Number = 350, 
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

			m_startSize = 30
			m_startSizeVar = 10
			m_endSize = 30
			m_endSizeVar = 0

			m_emitAngle = -90
			m_emitAngleVar = 360
			m_lifespan = 1
			m_lifespanVar = 0.5
			
			m_gravityX = 0
			m_gravityY = 0
			m_radialAccel = 0
			m_radialAccelVar = 0
			m_speed = 20
			m_speedVar = 5
			m_tangentialAcceel = 0
			m_tangentialAcceelVar = 0


			updateEps()

			m_startX = 400
			m_startY = 350
			m_startXVar = 0
			m_startYVar = 0

			m_startColor = new ColorARGB(1, 193/255.0, 63/255.0, 30/255.0)
			m_startColorVar = new ColorARGB(0/255.0, 0/255.0, 0/255.0, 0/255.0)
			m_endColor = new ColorARGB(255.0/255.0, 0/255.0, 0/255.0, 0/255.0)
			m_endColorVar = new ColorARGB(0/255.0, 0/255.0, 0/255.0, 0/255.0)

			m_duration = -1

			m_startRotation = 0
			m_startRotationVar = 0
			m_endRotation = 0
			m_endRotationVar = 0
			m_emitterMode = 0
		}


	}
}