package utils.particles{
	import flash.geom.*
	import flash.display.*
	import flash.events.Event
	import flash.events.IOErrorEvent
	import flash.events.ErrorEvent
	import flash.net.URLRequest
	import flash.net.URLLoader
	import flash.utils.Dictionary
	import utils.particles.helper.*

	public class Emitter extends Sprite{
		//发射器模式
		public static const GRAVITY_MODE:int = 0
		public static const RADIUS_MODE:int = 1

		//渲染模式
		public static const PARTICLE_RENDER:int = 0
		public static const CANVAS_RENDER:int = 1

		// PI的弧度值。避免每次进行度数与弧度的换算时计算
		public static const PI_RAD:Number = Math.PI / 180.0
		protected var m_isAutoRemoveOnFinish:Boolean
		// emitter attribute
			//粒子发射器的已存活时间
		protected var m_elpased:Number
			//粒子发射器的生命(s)，-1为无限长
		protected var m_duration:Number
			//每秒发射粒子的个数，根据最大粒子数量以及粒子生命周期计算得到
		protected var m_eps:Number 
			//每帧发射粒子的个数，累积计算，大于等于1时才发射
		protected var m_epf:Number
			//渲染器
		protected var m_render:Render
			//粒子的纹理
		protected var m_texture:BitmapData
		protected var m_blendMode:String

		protected var m_isActive:Boolean
		protected var m_particles:Vector.<Particle>
			//已使用的粒子数量
		protected var m_counter:int 
			//发射器类型
		protected var m_emitterMode:int 
			//渲染模式
		protected var m_renderMode:int
			//延时发射时间
		protected var m_delayTime:Number

		//particle attribute
			//可使用的粒子最大数量
		protected var m_maxParticles:int 

			//粒子的生命周期(s)
		protected var m_lifespan:Number
		protected var m_lifespanVar:Number

			// size，这里使用size是为了与标准的粒子编辑器兼容
			// 计算时会转换为scale
		protected var m_startSize:Number
		protected var m_startSizeVar:Number
		protected var m_endSize:Number
		protected var m_endSizeVar:Number
		//protected var m_scale:Number

			//发射器发射粒子的角度
		protected var m_emitAngle:Number
		protected var m_emitAngleVar:Number

			//粒子的旋转度数
		protected var m_startRotation:Number
		protected var m_startRotationVar:Number
		protected var m_endRotation:Number
		protected var m_endRotationVar:Number

			//粒子的发射位置
		protected var m_startX:Number
		protected var m_startXVar:Number
		protected var m_startY:Number
		protected var m_startYVar:Number

			//粒子的颜色
		protected var m_startColor:ColorARGB
		protected var m_startColorVar:ColorARGB
		protected var m_endColor:ColorARGB
		protected var m_endColorVar:ColorARGB

		//gravity mode attribute
			//重力加速度
		protected var m_gravityX:Number
		protected var m_gravityY:Number
			//速度
		protected var m_speed:Number
		protected var m_speedVar:Number
			//切线加速度
		protected var m_tangentialAcceel:Number
		protected var m_tangentialAcceelVar:Number
			//径向加速度
		protected var m_radialAccel:Number
		protected var m_radialAccelVar:Number
		//protected var rotationIsDir:Boolean

		//radius mode attribute
			//起始半径
		protected var m_startRadius:Number
		protected var m_startRadiusVar:Number
			//结束半径
		protected var m_endRadius:Number
		protected var m_endRadiusVar:Number
			//每秒旋转度数
		protected var m_rotatePerSec:Number
		protected var m_rotatePerSecVar:Number

		public function Emitter(maxParticles:Number = 150, 
			texture:BitmapData = null,
			emitterMode:int = GRAVITY_MODE,
			renderMode:int = PARTICLE_RENDER,
			delayTime:Number = 0){
	
			m_isAutoRemoveOnFinish = false
			m_delayTime = delayTime
			// emitter attribute
			m_epf = 0
			m_elpased = 0
			m_duration = -1
			m_texture = texture
			m_isActive = true
			m_emitterMode = emitterMode
			m_blendMode = BlendMode.ADD
			this.renderMode = renderMode

			//particle attribute
			m_maxParticles = maxParticles
			m_lifespan = 1
			m_lifespanVar = 0
			m_particles = new Vector.<Particle>(m_maxParticles, false)

			m_counter = 0
			m_eps = m_maxParticles / m_lifespan

			m_startSize = 16
			m_startSizeVar = 0
			m_endSize = 16
			m_endSizeVar = 0

			m_emitAngle = m_emitAngleVar = 0
			m_startRotation = m_startRotationVar = 0
			m_endRotation = m_endRotationVar = 0

			m_startX = m_startXVar = 0
			m_startY = m_startYVar = 0

			m_startColor = new ColorARGB(0,0,0,0)
			m_startColorVar = new ColorARGB()
			m_endColor = new ColorARGB()
			m_endColorVar = new ColorARGB()

			//gravity mode attribute
			m_gravityX = m_gravityY = 0
			m_speed = m_speedVar = 0
			m_tangentialAcceel = m_tangentialAcceelVar = 0
			m_radialAccel = m_radialAccelVar = 0

			//radius mode attribute
			m_startRadius = m_startRadiusVar = 0
			m_endRadius = m_endRadiusVar = 0
			m_rotatePerSec = m_rotatePerSecVar = 0

			mouseChildren = false
		}

		//根据字典初始化发射器
		public function initWithDictionary(dict:Dictionary, loadTexture:Boolean = false, flipY:int = -1) : void{
			this.maxParticles = dict["maxParticles"]
			this.duration = dict["duration"]
			this.emitAngle = flipY * dict["angle"]
			this.emitAngleVar = dict["angleVariance"]
			this.startColorR = dict["startColorRed"]
			this.startColorG = dict["startColorGreen"]
			this.startColorB = dict["startColorBlue"]
			this.startColorA =  dict["startColorAlpha"]
			this.startColorVarR = dict["startColorVarianceRed"]
			this.startColorVarG = dict["startColorVarianceGreen"]
			this.startColorVarB = dict["startColorVarianceBlue"]
			this.startColorVarA = dict["startColorVarianceAlpha"]
			this.endColorR = dict["finishColorRed"]
			this.endColorG = dict["finishColorGreen"]
			this.endColorB = dict["finishColorBlue"]
			this.endColorA = dict["finishColorAlpha"]
			this.endColorVarR = dict["finishColorVarianceRed"]
			this.endColorVarG = dict["finishColorVarianceGreen"]
			this.endColorVarB = dict["finishColorVarianceBlue"]
			this.endColorVarA = dict["finishColorVarianceAlpha"]
			this.startSize = dict["startParticleSize"]
			this.startSizeVar = dict["startParticleSizeVariance"]
			if(dict["finishParticleSize"] == null){
				this.endSize = -1
				this.endSizeVar = 0
			}
			else{
				this.endSize = dict["finishParticleSize"]
				this.endSizeVar = dict["finishParticleSizeVariance"]
			}
			this.startX = dict["sourcePositionx"]
			this.startY = dict["sourcePositiony"]
			this.startXVar = dict["sourcePositionVariancex"]
			this.startYVar = dict["sourcePositionVariancey"]
			this.startRotation = flipY * dict["rotationStart"]
			this.startRotationVar = dict["rotationStartVariance"]
			this.endRotation = dict["rotationEnd"]
			this.endRotationVar = dict["rotationEndVariance"]
			this.emitterMode = dict["emitterType"]
			this.gravityX = dict["gravityx"]
			this.gravityY = flipY * dict["gravityy"]
			this.speed = dict["speed"]
			this.speedVar = dict["speedVariance"]
			this.radialAccel = dict["radialAcceleration"]
			this.radialAccelVar = dict["radialAccelVariance"]
			this.tangentialAcceel = flipY * dict["tangentialAcceleration"]
			this.tangentialAcceelVar = dict["tangentialAccelVariance"]
			this.startRadius = dict["maxRadius"]
			this.startRadiusVar = dict["maxRadiusVariance"]
			this.endRadius = dict["minRadius"]
			this.endRadiusVar = dict["minRadiusVariance"]
			this.rotatePerSec = flipY * dict["rotatePerSecond"]
			this.rotatePerSecVar = dict["rotatePerSecondVariance"]
			this.lifespan = dict["particleLifespan"]
			this.lifespanVar = dict["particleLifespanVariance"]
			if(dict["emissionRate"])
				this.eps = dict["emissionRate"]

			m_isActive = true
			//this.texture/
			if(loadTexture && dict["textureFileName"]){
				var textureFileName:String = dict["textureFileName"]
				var pictLoader:Loader = new Loader()
				pictLoader.load(new URLRequest(textureFileName))
				pictLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
					function onLoadTexture(e:Event){
						texture = (e.currentTarget.content as Bitmap).bitmapData 
						//图片加载完成后再dispath完成事件
						dispatchEvent(new Event(Event.COMPLETE))
					}, false, 0, true)
				pictLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,
					function onLoadError(e : Event){
						dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR))
						throw new Error("IO_ERROR " + e)
					}, false, 0, true)
			}
			else{
				dispatchEvent(new Event(Event.COMPLETE))
			}
			
		}

		public function initWithXML(xml:XML, loadTexture:Boolean = false, flipY:int = -1) : void{
			var dict:Dictionary = PlistParser.parse(xml)
			initWithDictionary(dict, loadTexture, flipY)
		}

		//解析plist，初始化发射器
		protected function onLoadPlist(loader:URLLoader, loadTexture:Boolean = false, flipY:int = -1) : void{
			var xml:XML = new XML(loader.data)

			var dict:Dictionary = PlistParser.parse(xml)

			initWithDictionary(dict, loadTexture, flipY)
		}


		public function initWithPlist(plistPath:String, loadTexture:Boolean = false, flipY:int = -1) : void{
			var loader:URLLoader = new URLLoader(new URLRequest(plistPath))
			loader.addEventListener(Event.COMPLETE, function (e:Event){
				onLoadPlist(loader, loadTexture, flipY)
				}, false, 0, true)
			loader.addEventListener(IOErrorEvent.IO_ERROR, function onLoadError(e : Event){
						dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR))
						throw new Error("IO_ERROR " + e)
					}, false, 0, true)
		}

		public function updateEps() : void{
			m_eps = m_maxParticles / m_lifespan
		}

		//返回[-1, 1]的随机数
		protected function random_minus1_1() : Number{
			return Math.random() * 2 - 1
		}

		//将value的值限制在[low, high]之间
		protected function clampf(value:Number, low:Number = 0, high:Number = 1) : Number{
			return Math.max(low, Math.min(value, high))
		}

		//申请一个粒子，并将其初始化
		public function addParticle() : Boolean{
			if(m_counter >= m_maxParticles){
				return false
			}
			if(m_counter >= m_particles.length || m_particles[m_counter] == null){
				m_particles[m_counter] = ParticlePool.acquire()
			}

			initParticle(m_particles[m_counter])
			m_counter++
			return true
		}

		public function initParticle(p:Particle) : void{
			//life
			p.life = Math.max(0.01, m_lifespan + random_minus1_1() * m_lifespanVar)

			//position
			p.startX = m_startX + m_startXVar * random_minus1_1()
			p.startY = m_startY + m_startYVar * random_minus1_1()
			p.x = p.startX 
			p.y = p.startY

			//color
			p.color.r = clampf(m_startColor.r + m_startColorVar.r * random_minus1_1())
			p.color.g = clampf(m_startColor.g + m_startColorVar.g * random_minus1_1())
			p.color.b = clampf(m_startColor.b + m_startColorVar.b * random_minus1_1())
			p.color.a = clampf(m_startColor.a + m_startColorVar.a * random_minus1_1())

			p.deltaColor.r = clampf(m_endColor.r + m_endColorVar.r * random_minus1_1()
			 	- p.color.r) / p.life
			p.deltaColor.g = clampf(m_endColor.g + m_endColorVar.g * random_minus1_1() 
				- p.color.g) / p.life
			p.deltaColor.b = clampf(m_endColor.b + m_endColorVar.b * random_minus1_1() 
				- p.color.b) / p.life
			p.deltaColor.a = clampf(m_endColor.a + m_endColorVar.a * random_minus1_1() 
				- p.color.a) / p.life

			//scale
			if(m_texture == null){
				throw new Error("initialize the particle's texture first!")
			}

			var startSize:Number = 
				Math.max(0, m_startSize + m_startSizeVar * random_minus1_1())
			var deltaSize:Number = 0
			if(m_endSize != -1){
				deltaSize = (m_endSize + 
					m_endSizeVar * random_minus1_1() - startSize) / p.life
			}
				
				//假设粒子位图是矩形的
			p.scale = startSize / m_texture.width
			p.deltaScale = deltaSize / m_texture.width

			var angle:Number = (m_emitAngle + m_emitAngleVar * random_minus1_1()) * PI_RAD
			if(m_emitterMode == GRAVITY_MODE){
				//vx, vy
				var speed:Number = m_speed + m_speedVar * random_minus1_1()
				p.vx = Math.cos(angle) * speed
				p.vy = Math.sin(angle) * speed

				//rotation，转换为弧度
				p.rotation = (m_startRotation + 
					m_startRotationVar * random_minus1_1()) * PI_RAD
				p.deltaRotation = ((m_endRotation + m_endRotationVar 
					* random_minus1_1()) * PI_RAD - p.rotation)  / p.life 

				//accel
				p.radialAccel = m_radialAccel + m_radialAccelVar * random_minus1_1()
				p.tangentialAcceel = m_tangentialAcceel + 
					m_tangentialAcceelVar * random_minus1_1()
			}
			else if(m_emitterMode == RADIUS_MODE){
				p.radius = m_startRadius + m_startRadiusVar * random_minus1_1()
				p.deltaRadius = (m_endRadius + 
					m_endRadiusVar * random_minus1_1() - p.radius) / p.life
				p.angle = angle
				p.degreesPerSec = (m_rotatePerSec + 
					m_rotatePerSecVar * random_minus1_1()) * PI_RAD
			}
		}

		public function isDone() : Boolean{
			return !m_isActive && !m_counter
		}

		public function update(dt:Number) : void{
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
				var p:Particle = m_particles[i]

				p.life -= dt
				//die
				if(p.life <= 0){
					if(i != m_counter - 1){
						//与最后一个粒子交换
						var tmp:Particle = m_particles[i]
						m_particles[i] = m_particles[m_counter - 1]
						m_particles[m_counter - 1] = tmp
						tmp = null
					}
					ParticlePool.release(m_particles[m_counter - 1])
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
				}
				i++
			}

			m_render.renderParticles(m_particles, m_counter)

			
			if(m_duration != -1 &&  m_duration + m_delayTime <= m_elpased){
				this.stop()
			}
		}

		public function stop() : void{
			m_isActive = false
			m_elpased = m_duration
			//m_counter = 0
			//m_render.cleanUp()
		}

		public function reset() : void{
			m_isActive = true
			m_elpased = 0
			for(var i:int = 0; i < m_counter; i++){
				m_particles[i].life = 0
			}
			m_counter = 0
			//m_render.cleanUp()
		}

		public function dispose() : void{
			this.stop()
			//release the particles ...
			var len:int = m_particles.length
			for(var i:int = 0; i < len; i++){
				if(m_particles[i] != null){
					ParticlePool.release(m_particles[i])
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

		public function get duration() : Number { return m_duration }
		public function set duration(d:Number) : void{
			m_duration = d
		}

		public function get eps() : Number { return m_eps }
		public function set eps(_eps:Number) : void{
			m_eps = _eps
		}

		public function get render() : Render { return m_render }
		public function set render(_render:Render) : void{
			if(m_render != null)
				m_render.dispose()
			m_render = _render
		}

		public function get isActive() : Boolean { return m_isActive }
		public function set isActive(_isActive:Boolean) : void{
			m_isActive = _isActive
		}

		public function get emitterMode() : int { return m_emitterMode }
		public function set emitterMode(mode:int) : void{
			m_emitterMode = mode
			this.reset()
		}

		public function get renderMode() : int { return m_renderMode }
		public function set renderMode(mode:int) : void{
			if(mode != m_renderMode || m_render == null){
				m_renderMode = mode
				if(m_render != null)
					m_render.dispose()

				if(mode == PARTICLE_RENDER){
					m_render = new ParticleRender(
						this, m_maxParticles, m_texture, m_blendMode)
				}
				else if(mode == CANVAS_RENDER){
					m_render = new CanvasRender(this, m_texture, m_blendMode)
				}
			}
		}

		public function get texture() : BitmapData { return m_texture }
		public function set texture(_texture:BitmapData) : void{
			m_texture = _texture
			if(m_render != null)
				m_render.texture = _texture
		}

		public function get maxParticles() : int { return m_maxParticles }
		public function set maxParticles(value:int) : void{
			//防止内存泄露
			var i:int = 0
			if(value < m_maxParticles && value > m_particles.length){
				var len:int = m_particles.length
				for(i = value; i < len; i++){
					if(m_particles[i] != null){
						ParticlePool.release(m_particles[i])
						m_particles[i] = null
					}
				}
			}
			m_maxParticles = value
			m_counter >= m_maxParticles ? m_maxParticles - 1 : m_counter
			updateEps()
		}

		public function get lifespan() : Number { return m_lifespan	}
		public function set lifespan(value:Number) : void{
			m_lifespan = value
			updateEps()
		}

		public function get lifespanVar() : Number { return m_lifespanVar }
		public function set lifespanVar(value : Number) : void {m_lifespanVar = value }

		public function get startSize() : Number { return m_startSize }
		public function set startSize(value : Number) : void { m_startSize = value }

		public function get startSizeVar() : Number {return m_startSizeVar}
		public function set startSizeVar(value : Number) : void { m_startSizeVar = value }

		public function get endSize() : Number { return m_endSize }
		public function set endSize(value : Number) : void { m_endSize = value } 

		public function get endSizeVar() : Number {return m_endSizeVar}
		public function set endSizeVar(value : Number) : void { m_endSizeVar = value } 

		public function get emitAngle() : Number { return m_emitAngle }
		public function set emitAngle(value : Number) : void { m_emitAngle = value }

		public function get emitAngleVar() : Number {return m_emitAngleVar }
		public function set emitAngleVar(value : Number) : void {m_emitAngleVar = value }

		public function get startRotation() : Number {return m_startRotation }
		public function set startRotation(value : Number) : void { m_startRotation = value }

		public function get startRotationVar() : Number {return m_startRotationVar}
		public function set startRotationVar(value : Number) : void{m_startRotationVar = value}

		public function get endRotation() : Number {return m_endRotation}
		public function set endRotation(value : Number) : void {m_endRotation = value}

		public function get endRotationVar() : Number {return m_endRotationVar}
		public function set endRotationVar(value : Number) : void {m_endRotationVar = value}

		public function get startX() : Number {return m_startX}
		public function set startX(value : Number) : void {m_startX = value}

		public function get startXVar() : Number{return m_startXVar}
		public function set startXVar(value : Number) : void {m_startXVar = value}

		public function get startY() : Number{return m_startY}
		public function set startY(value : Number) : void {m_startY = value}

		public function get startYVar() : Number {return m_startYVar}
		public function set startYVar(value : Number) : void {m_startYVar = value} 

		public function get startColorR() : Number{return m_startColor.r}
		public function set startColorR(value : Number) : void {m_startColor.r = value}

		public function get startColorG() : Number{return m_startColor.g}
		public function set startColorG(value : Number) : void {m_startColor.g = value}

		public function get startColorB() : Number{return m_startColor.b}
		public function set startColorB(value : Number) : void {m_startColor.b = value}

		public function get startColorA() : Number{return m_startColor.a}
		public function set startColorA(value : Number) : void {m_startColor.a = value}

		public function get startColorVarR() : Number{return m_startColorVar.r}
		public function set startColorVarR(value : Number) : void {m_startColorVar.r = value}

		public function get startColorVarG() : Number{return m_startColorVar.g}
		public function set startColorVarG(value : Number) : void {m_startColorVar.g = value}

		public function get startColorVarB() : Number{return m_startColorVar.b}
		public function set startColorVarB(value : Number) : void {m_startColorVar.b = value}

		public function get startColorVarA() : Number{return m_startColorVar.a}
		public function set startColorVarA(value : Number) : void {m_startColorVar.a = value}

		public function get endColorR() : Number{return m_endColor.r}
		public function set endColorR(value : Number) : void {m_endColor.r = value}

		public function get endColorG() : Number{return m_endColor.g}
		public function set endColorG(value : Number) : void {m_endColor.g = value}

		public function get endColorB() : Number{return m_endColor.b}
		public function set endColorB(value : Number) : void {m_endColor.b = value}

		public function get endColorA() : Number{return m_endColor.a}
		public function set endColorA(value : Number) : void {m_endColor.a = value}

		public function get endColorVarR() : Number{return m_endColorVar.r}
		public function set endColorVarR(value : Number) : void {m_endColorVar.r = value}

		public function get endColorVarG() : Number{return m_endColorVar.g}
		public function set endColorVarG(value : Number) : void {m_endColorVar.g = value}

		public function get endColorVarB() : Number{return m_endColorVar.b}
		public function set endColorVarB(value : Number) : void {m_endColorVar.b = value}

		public function get endColorVarA() : Number{return m_endColorVar.a}
		public function set endColorVarA(value : Number) : void {m_endColorVar.a = value}

		public function get gravityX() : Number{return m_gravityX}
		public function set gravityX(value : Number) : void {m_gravityX = value}

		public function get gravityY() : Number{return m_gravityY}
		public function set gravityY(value : Number) : void {m_gravityY = value}

		public function get speed() : Number{return m_speed}
		public function set speed(value : Number) : void {m_speed = value}

		public function get speedVar() : Number{return m_speedVar}
		public function set speedVar(value : Number) : void {m_speedVar = value}

		public function get tangentialAcceel() : Number{return m_tangentialAcceel}
		public function set tangentialAcceel(value : Number) : void {m_tangentialAcceel = value}

		public function get tangentialAcceelVar() : Number{return m_tangentialAcceelVar}
		public function set tangentialAcceelVar(value : Number) : void {m_tangentialAcceelVar = value}

		public function get radialAccel() : Number{return m_radialAccel}
		public function set radialAccel(value : Number) : void {m_radialAccel = value}

		public function get radialAccelVar() : Number{return m_radialAccelVar}
		public function set radialAccelVar(value : Number) : void {m_radialAccelVar = value}

		public function get startRadius() : Number{return m_startRadius}
		public function set startRadius(value : Number) : void {m_startRadius = value}

		public function get startRadiusVar() : Number{return m_startRadiusVar}
		public function set startRadiusVar(value : Number) : void {m_startRadiusVar = value}

		public function get endRadius() : Number{return m_endRadius}
		public function set endRadius(value : Number) : void {m_endRadius = value}

		public function get endRadiusVar() : Number{return m_endRadiusVar}
		public function set endRadiusVar(value : Number) : void {m_endRadiusVar = value}

		public function get rotatePerSec() : Number{return m_rotatePerSec}
		public function set rotatePerSec(value : Number) : void {m_rotatePerSec = value}

		public function get rotatePerSecVar() : Number{return m_rotatePerSecVar}
		public function set rotatePerSecVar(value : Number) : void {m_rotatePerSecVar = value}

		public function get delayTime() : Number{return m_delayTime}
		public function set delayTime(value : Number) : void {m_delayTime = value}

		override public function get blendMode() : String{return m_blendMode}
		override public function set blendMode(value : String) : void {
		 	m_blendMode = value
		 	if(m_render != null){
		 		m_render.blendMode = m_blendMode
		 	}
		}

		public function get isAutoRemoveOnFinish() : Boolean{return m_isAutoRemoveOnFinish}
		public function set isAutoRemoveOnFinish(value : Boolean) : void {m_isAutoRemoveOnFinish = value}

		// public function get () : Number{return }
		// public function set (value : Number) : void { = value}
	}
}