package utils.particles{
	import flash.display.BitmapData
	import flash.display.Bitmap
	import flash.display.DisplayObjectContainer
	import flash.display.BlendMode
	import flash.display.Stage
	import flash.geom.Matrix
	import flash.geom.Rectangle
	import flash.events.Event

	//在一张大的位图上渲染所有的粒子
	public class CanvasRender extends Render{
		protected var m_owner:Emitter
		//全局共享一张位图
		protected static var m_canvas:Bitmap
		//cleanUp操作是否由外部操控
		protected static var m_isGlobalCleanUp:Boolean = true

		public function CanvasRender(owner:Emitter, texture:BitmapData = null, 
			mode:String = BlendMode.ADD){
			super(texture, mode)
			m_owner = owner
		}

		public static function get isGlobalCleanUp() : Boolean {return m_isGlobalCleanUp}
		public static function set isGlobalCleanUp(value : Boolean) : void{m_isGlobalCleanUp = value}

		public static function get canvas() : Bitmap{
			return m_canvas
		}

		public static function initCanvas(w:uint, h:uint) : void{
			if(m_canvas == null){
				var bmd:BitmapData = new BitmapData(w, h, true, 0x0)
				m_canvas = new Bitmap(bmd)
			}
			else if(m_canvas.bitmapData.width != w ||
				m_canvas.bitmapData.height != h){
				m_canvas.bitmapData.dispose()
				m_canvas.bitmapData = new BitmapData(w, h, true, 0x0)
			}
		}

		override public function cleanUp() : void{
			if(m_canvas != null)
				m_canvas.bitmapData.fillRect(m_canvas.bitmapData.rect, 0x0)
		}

		override public function renderParticles(particles:Vector.<Particle>, len:int) : void{
			if(m_canvas == null){
				throw new Error("null point error. Initialize the canvas first")
			}

			m_canvas.bitmapData.lock()

			if(!m_isGlobalCleanUp)
				this.cleanUp()

			while(len--){
				drawParticle(particles[len])
			}

			m_canvas.bitmapData.unlock()
		}

		protected function drawParticle(particle:Particle) : void{
			var m:Matrix = particle.matrixTransform
			m.translate(m_owner.x, m_owner.y)
			m_canvas.bitmapData.draw(m_texture, m, 
				particle.color.colorTransform, blendMode, null, false)
		}

		override public function dispose() : void{
			if(!m_isGlobalCleanUp)
				this.cleanUp()
			super.dispose()
			//m_canvas = null
		}
	}
}