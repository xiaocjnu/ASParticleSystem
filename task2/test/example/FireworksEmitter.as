package {
	import flash.display.*
	import flash.geom.*
	import flash.events.*
	import utils.particles.*

	public class FireworksEmitter extends Emitter{

		public function FireworksEmitter(maxParticles:Number = 150, 
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
				m_texture = new starsPng()
				m_render.texture = m_texture
			}

			m_startSize = 8
			m_startSizeVar = 2
			m_endSize = 8
			m_endSizeVar = 0

			m_emitAngle = -90
			m_emitAngleVar = 20
			m_lifespan = 3.5
			m_lifespanVar = 1
			
			m_gravityX = 0
			m_gravityY = 90
			m_radialAccel = 180
			m_radialAccelVar = 50
			m_speed = 60
			m_speedVar = 20
			m_tangentialAcceel = 0
			m_tangentialAcceelVar = 0


			updateEps()

			m_startX = 400
			m_startY = 350
			m_startXVar = 0
			m_startYVar = 0

			m_startColor = new ColorARGB(1, 127/255.0, 127/255.0, 127/255.0)
			m_startColorVar = new ColorARGB(25/255.0, 127/255.0, 127/255.0, 127/255.0)
			m_endColor = new ColorARGB(51/255.0, 25/255.0, 25/255.0, 25/255.0)
			m_endColorVar = new ColorARGB(51/255.0, 25/255.0, 25/255.0, 25/255.0)

			m_duration = -1

			m_startRotation = 0
			m_startRotationVar = 0
			m_endRotation = 0
			m_endRotationVar = 0
			m_emitterMode = 0
		}


	}
}