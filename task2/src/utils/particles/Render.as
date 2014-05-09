package utils.particles{
	import flash.display.BitmapData
	import flash.display.Bitmap
	import flash.display.Sprite
	import flash.display.BlendMode
	import flash.display.DisplayObject

	//渲染器的基类
	public class Render extends Object{
		//待渲染的位图
		protected var m_texture:BitmapData
		protected var m_blendMode:String
		//protected var m_srcBlendMode:String
		//protected var m_dstBlendMode:String

		public function Render(texture:BitmapData, 
			mode:String) {
			m_texture = texture
			m_blendMode = mode
		}

		public function get blendMode() : String{
			return m_blendMode
		}

		public function set blendMode(mode:String) : void{
			m_blendMode = mode
		}

		public function get texture() : BitmapData{
			return m_texture
		}

		public function set texture(texture:BitmapData) : void{
			m_texture = texture
		}

		//abstract
		//渲染粒子
		public function renderParticles(particles:Vector.<Particle>, len:int) : void{
			throw new Error("please override this function")
		}

		//abstract
		//将粒子清除
		public function cleanUp() : void{
			throw new Error("please override this function")
		}

		public function dispose() : void{
			//m_texture.dispose()
			m_texture = null
		}
	}
}