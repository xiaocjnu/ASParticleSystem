package utils.particles{
	import flash.display.BitmapData
	import flash.display.Bitmap
	import flash.display.BlendMode
	import flash.display.Sprite
	import flash.geom.Matrix

	//每个粒子对应一张位图进行渲染
	public class ParticleRender extends Render{
		protected var m_sprites:Vector.<Sprite>
		protected var m_owner:Emitter

		public function ParticleRender(owner:Emitter,
			maxParticles:uint = 50,	texture:BitmapData = null, 
			mode:String = BlendMode.ADD){

			super(texture, mode)
			m_owner = owner
			m_sprites = new Vector.<Sprite>(maxParticles)
			initTexture(texture)
		}

		protected function initTexture(texture:BitmapData) : void{
			var len:int = m_sprites.length
			if(m_texture == null){
				for(var i:int = 0; i < len; i++){
					m_sprites[i] = null
				}
			}
			else{
				for(var j:int = 0; j < len; j++){	
					if(m_sprites[j] != null)						
						m_owner.removeChild(m_sprites[j])
					//改变图片的锚点
					var bitmap:Bitmap = new Bitmap(texture)
					bitmap.x -= texture.width / 2
					bitmap.y -= texture.height / 2

					m_sprites[j] = new Sprite()
					m_sprites[j].addChild(bitmap)
					m_sprites[j].visible = false
					m_owner.addChild(m_sprites[j])
				}
			}
		}

		override public function set texture(texture:BitmapData) : void{
			if(texture == m_texture)
				return

			m_texture = texture
			initTexture(texture)
		}

		override public function renderParticles(particles:Vector.<Particle>,
			len:int) : void{

			var i:int = 0
			//如果粒子数量超过已分配的位图，调整位图数
			for(i = m_sprites.length; i < len; i++){
				var bitmap:Bitmap = new Bitmap(m_texture)
				bitmap.x -= m_texture.width / 2
				bitmap.y -= m_texture.height / 2

				var sprite:Sprite = new Sprite()
				sprite.addChild(bitmap)
				m_sprites.push(sprite)
				m_owner.addChild(sprite)
			}

			var target:Sprite = null
			for(i = 0; i < len; i++){
				var p:Particle = particles[i]
				target = m_sprites[i]

				target.blendMode = blendMode
				// target.bitmapData.fillRect(target.bitmapData.rect, 0x0)
				// target.bitmapData.draw(m_texture, null,
				// 	p.color.colorTransform, null, null, false)
				target.transform.colorTransform = p.color.colorTransform
				target.transform.matrix = p.matrixTransform
				// target.scaleX = target.scaleY = p.scale
				// target.rotation = p.rotation / Emitter.PI_RAD
				// target.x = p.x
				// target.y = p.y

				
				target.visible = true
			}

			//隐藏不需要渲染的位图
			var size:int = m_sprites.length
			for(i = len; i < size; i++){
				m_sprites[i].visible = false
			}
		}

		override public function cleanUp() : void{
			var len:int = m_sprites.length
			for(var i = 0; i < len; i++){
				m_sprites[i].visible = false
			}
		}

		override public function dispose() : void{
			this.cleanUp()
			super.dispose()

			var len:int = m_sprites.length
			for(var i = 0; i < len; i++){
				m_owner.removeChild(m_sprites[i])
				// m_bitmaps[i].bitmapData.dispose()
				m_sprites[i] = null
			}
			m_sprites = null
		}
	}
}