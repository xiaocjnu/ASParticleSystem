package utils.particles
{
	import flash.utils.Dictionary
	import flash.display.*

	public class Emitter3D extends Emitter
	{
		public static const SPEED_MODE:int = 2
		
		
			//3D粒子的旋转度数
		protected var m_startRotationX:Number
		protected var m_startRotationXVar:Number
		protected var m_endRotationX:Number
		protected var m_endRotationXVar:Number

		protected var m_startRotationY:Number
		protected var m_startRotationYVar:Number
		protected var m_endRotationY:Number
		protected var m_endRotationYVar:Number

		protected var m_startRotationZ:Number
		protected var m_startRotationZVar:Number
		protected var m_endRotationZ:Number
		protected var m_endRotationZVar:Number

		// 3D粒子旋转完成时间
		protected var m_rotationXTime:Number
		protected var m_rotationYTime:Number
		protected var m_rotationZTime:Number

			//3D粒子的发射位置
		protected var m_startZ:Number
		protected var m_startZVar:Number


		public function Emitter3D(maxParticles:Number = 150, 
			texture:BitmapData = null,
			emitterMode:int = GRAVITY_MODE,
			renderMode:int = PARTICLE_RENDER,
			delayTime:Number = 0)
		{
			super(maxParticles, texture, emitterMode, renderMode, delayTime)
			m_startZ = m_startZVar = 0
			m_startRotationX = m_startRotationXVar = 0
			m_endRotationX = m_endRotationXVar = 0

			m_startRotationY = m_startRotationYVar = 0
			m_endRotationY = m_endRotationYVar = 0

			m_startRotationZ = m_startRotationZVar = 0
			m_endRotationZ = m_endRotationZVar = 0

			m_rotationXTime = m_rotationYTime = m_rotationZTime = 1
		}

		override public function initWithDictionary(dict:Dictionary, loadTexture:Boolean = false, flipY:int = -1) : void
		{
			super.initWithDictionary(dict, loadTexture, flipY)
		}

		//申请一个粒子，并将其初始化
		override public function addParticle() : Boolean{
			if(m_counter >= m_maxParticles){
				return false
			}
			if(m_counter >= m_particles.length || m_particles[m_counter] == null){
				m_particles[m_counter] = Particle3DPool.acquire()
			}

			initParticle(m_particles[m_counter])
			m_counter++
			return true
		}

		override public function initParticle(p:Particle) : void
		{
			super.initParticle(p)
			var tempP:Particle3D = p as Particle3D
			if(tempP == null)
			{
				return
			}
			//position
			tempP.startZ = m_startZ + m_startZVar * random_minus1_1()
			tempP.z = tempP.startZ

			//rotation，转换为弧度
			//trace("initParticle", m_rotationXTime, m_rotationYTime, m_rotationZTime)
			tempP.rotationX = (m_startRotationX + 
				m_startRotationXVar * random_minus1_1())
			tempP.deltaRotationX = ((m_endRotationX + m_endRotationXVar 
				* random_minus1_1()) - tempP.rotationX)  / m_rotationXTime

			tempP.rotationY = (m_startRotationY + 
				m_startRotationYVar * random_minus1_1())
			tempP.deltaRotationY = ((m_endRotationY + m_endRotationYVar 
				* random_minus1_1()) - tempP.rotationY)  / m_rotationYTime

			tempP.rotationZ = (m_startRotationZ + 
				m_startRotationZVar * random_minus1_1())
			tempP.deltaRotationZ = ((m_endRotationZ + m_endRotationZVar 
				* random_minus1_1()) - tempP.rotationZ)  / m_rotationZTime
			//trace("initParticle", tempP.deltaRotationX, tempP.deltaRotationY, tempP.deltaRotationZ)

			if(m_emitterMode == SPEED_MODE){
				var angle:Number = (m_emitAngle + m_emitAngleVar * random_minus1_1()) * PI_RAD
				var speed:Number = m_speed + m_speedVar * random_minus1_1()
				tempP.vx = Math.cos(angle) * speed
				tempP.vy = Math.sin(angle) * speed
			}
		}

		override public function update(dt:Number) : void{
			//加入粒子
			if(m_isActive){
				m_elpased += dt
				if(m_elpased <= m_delayTime)
					return

				if(m_counter < m_maxParticles)
					m_epf += dt * m_eps

				while(m_epf >= 1 && m_counter < m_maxParticles){
					addParticle()
					m_epf --
				}
			}

			//更新粒子状态
			for(var i:int = 0; i < m_counter; ){
				var p:Particle3D = m_particles[i] as Particle3D

				p.life -= dt
				//die
				if(p.life <= 0){
					if(i != m_counter - 1){
						//与最后一个粒子交换
						var tmp:Particle3D = m_particles[i] as Particle3D
						m_particles[i] = m_particles[m_counter - 1]
						m_particles[m_counter - 1] = tmp
						tmp = null
					}
					Particle3DPool.release(m_particles[m_counter - 1] as Particle3D)
					m_particles[m_counter - 1] = null
					--m_counter
					if(m_counter == 0 && m_isAutoRemoveOnFinish){
						//此处应释放内存
						//to do...
						//由manager来进行dispose()
						//this.dispose()
						//remove listener
						//return;
					}
					continue
				}

				//update particle
				p.color.r += p.deltaColor.r * dt
				p.color.g += p.deltaColor.g * dt
				p.color.b += p.deltaColor.b * dt
				p.color.a += p.deltaColor.a * dt

				p.scale = Math.max(0, p.scale + p.deltaScale * dt)
				p.rotation += p.deltaRotation * dt
				p.rotationX += p.deltaRotationX * dt
				p.rotationY += p.deltaRotationY * dt
				p.rotationZ += p.deltaRotationZ * dt

				if(m_emitterMode == GRAVITY_MODE){
					//normalize the position of p
					var u:Number = p.x - p.startX
					var v:Number = p.y - p.startY
					var d:Number = Math.sqrt(u*u + v*v)


					if(d > 0.001){
						u /= d
						v /= d
					}
					else{
						u = v = 0
					}
					// 计算径向加速度和切线加速度
					// 更新速度
					p.vx += (m_gravityX + u * p.radialAccel - 
						v * p.tangentialAcceel) * dt
					p.vy += (m_gravityY + v * p.radialAccel + 
						u * p.tangentialAcceel) * dt				

					p.x += p.vx * dt
					p.y += p.vy * dt
				}
				else if(m_emitterMode == RADIUS_MODE){
					p.angle += p.degreesPerSec * dt
					p.radius += p.deltaRadius * dt

					p.x = -Math.cos(p.angle) * p.radius + m_startX
					p.y = -Math.sin(p.angle) * p.radius + m_startY
				}else if(m_emitterMode == SPEED_MODE){
					p.x += p.vx * dt
					p.y += p.vy * dt
				}
				i++
			}

			m_render.renderParticles(m_particles, m_counter)

			
			if(m_duration != -1 &&  m_duration + m_delayTime <= m_elpased){
				this.stop()
			}
		}

		override public function dispose() : void{
			this.stop()
			//release the particles ...
			var len:int = m_particles.length
			for(var i:int = 0; i < len; i++){
				if(m_particles[i] != null){
					Particle3DPool.release(m_particles[i] as Particle3D)
					m_particles[i] = null
				}
			}
			m_particles = null
			if(m_texture != null)
				m_texture.dispose()
			m_texture = null
			if(m_render != null){
				m_render.dispose()
			}
			m_render = null
			m_counter = 0
		}

		override public function set renderMode(mode:int) : void{
			if(mode != m_renderMode || m_render == null){
				m_renderMode = mode
				if(m_render != null)
					m_render.dispose()

				if(mode == PARTICLE_RENDER){
					m_render = new Particle3DRender(
						this, m_maxParticles, m_texture, m_blendMode)
				}
				else if(mode == CANVAS_RENDER){
					m_render = new CanvasRender(this, m_texture, m_blendMode)
				}
			}
		}

		public function get startRotationX() : Number {return m_startRotationX }
		public function set startRotationX(value : Number) : void { m_startRotationX = value }

		public function get startRotationXVar() : Number {return m_startRotationXVar}
		public function set startRotationXVar(value : Number) : void{m_startRotationXVar = value}

		public function get startRotationY() : Number {return m_startRotationY }
		public function set startRotationY(value : Number) : void { m_startRotationY = value }

		public function get startRotationYVar() : Number {return m_startRotationYVar}
		public function set startRotationYVar(value : Number) : void{m_startRotationYVar = value}

		public function get startRotationZ() : Number {return m_startRotationZ }
		public function set startRotationZ(value : Number) : void { m_startRotationZ = value }

		public function get startRotationZVar() : Number {return m_startRotationZVar}
		public function set startRotationZVar(value : Number) : void{m_startRotationZVar = value}

		public function get endRotationX() : Number {return m_endRotationX }
		public function set endRotationX(value : Number) : void { m_endRotationX = value }

		public function get endRotationXVar() : Number {return m_endRotationXVar}
		public function set endRotationXVar(value : Number) : void{m_endRotationXVar = value}

		public function get endRotationY() : Number {return m_endRotationY }
		public function set endRotationY(value : Number) : void { m_endRotationY = value }

		public function get endRotationYVar() : Number {return m_endRotationYVar}
		public function set endRotationYVar(value : Number) : void{m_endRotationYVar = value}

		public function get endRotationZ() : Number {return m_endRotationZ }
		public function set endRotationZ(value : Number) : void { m_endRotationZ = value }

		public function get endRotationZVar() : Number {return m_endRotationZVar}
		public function set endRotationZVar(value : Number) : void{m_endRotationZVar = value}

		public function get startZ() : Number {return m_startZ}
		public function set startZ(value : Number) : void {m_startZ = value}

		public function get rotationXTime() : Number {return m_rotationXTime}
		public function set rotationXTime(value : Number) : void {m_rotationXTime = value}

		public function get rotationYTime() : Number {return m_rotationYTime}
		public function set rotationYTime(value : Number) : void {m_rotationYTime = value}

		public function get rotationZTime() : Number {return m_rotationZTime}
		public function set rotationZTime(value : Number) : void {m_rotationZTime = value}
	}
}