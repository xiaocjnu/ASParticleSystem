package utils.particles
{
	import flash.display.BitmapData
	import flash.display.Bitmap
	import flash.display.BlendMode
	import flash.display.Sprite
	import flash.geom.Matrix

	public class Particle3DRender extends ParticleRender
	{
		public function Particle3DRender(owner:Emitter,
			maxParticles:uint = 50,	texture:BitmapData = null, 
			mode:String = BlendMode.ADD)
		{
			super(owner, maxParticles, texture, mode)
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
			var size:int = m_sprites.length
			for(i = 0; i < size; i++){
				target = m_sprites[i]
				target.transform.matrix3D = null
			}
			for(i = 0; i < len; i++){
				var p:Particle3D = particles[i] as Particle3D
				target = m_sprites[i]

				target.blendMode = blendMode
				// target.bitmapData.fillRect(target.bitmapData.rect, 0x0)
				// target.bitmapData.draw(m_texture, null,
				// 	p.color.colorTransform, null, null, false)
				target.transform.colorTransform = p.color.colorTransform
				target.transform.matrix3D = p.matrix3DTransform
				// target.scaleX = target.scaleY = p.scale
				// target.rotation = p.rotation / Emitter.PI_RAD
				// target.x = p.x
				// target.y = p.y

				
				target.visible = true
			}

			//隐藏不需要渲染的位图
			for(i = len; i < size; i++){
				m_sprites[i].visible = false
			}
		}
	}
}