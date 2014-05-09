package {
	import flash.display.*
	import flash.geom.*
	import flash.events.*
	import utils.particles.*

	public class RadiusOneEmitter extends Emitter{

		public function RadiusOneEmitter(maxParticles:Number = 250, 
			texture:BitmapData = null,
			emitterMode:int = RADIUS_MODE,
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

			m_startSize = 32
			m_startSizeVar = 0
			m_endSize = 32
			m_endSizeVar = 0

			m_emitAngle = -90
			m_emitAngleVar = 0
			m_lifespan = 5
			m_lifespanVar = 0
			
			
			m_startRadius = 0
			m_startRadiusVar = 0
			m_endRadius = 160
			m_endRadiusVar = 0
			m_rotatePerSec = 180
			m_rotatePerSecVar = 0

			updateEps()

			m_startX = 400
			m_startY = 350
			m_startXVar = 0
			m_startYVar = 0

			m_startColor = new ColorARGB(127/255.0, 127/255.0, 127/255.0, 127/255.0)
			m_startColorVar = new ColorARGB(0/255.0, 127/255.0, 127/255.0, 127/255.0)
			m_endColor = new ColorARGB(51/255.0, 25/255.0, 25/255.0, 25/255.0)
			m_endColorVar = new ColorARGB(51/255.0, 25/255.0, 25/255.0, 25/255.0)

			m_duration = -1

			m_startRotation = 0
			m_startRotationVar = 0
			m_endRotation = 0
			m_endRotationVar = 0
		}


	}
}