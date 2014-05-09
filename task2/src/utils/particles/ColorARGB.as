package utils.particles{
	import flash.geom.ColorTransform

	/**
		1. 增加rMultiplier, gMultiplier, bMultiplier, aMultiplier
	*/
	public class ColorARGB {
		public var r:Number
		public var g:Number
		public var b:Number
		public var a:Number

		// multiplier
		public var rMultiplier:Number
		public var gMultiplier:Number
		public var bMultiplier:Number
		public var aMultiplier:Number

		// 出于性能考虑储存此值，避免每次调用draw时new
		private var transform:ColorTransform

		public function ColorARGB(a:Number=1,r:Number=1, g:Number=1, b:Number=1, 
			rMultiplier=1, gMultiplier=1, bMultiplier=1, aMultiplier=1){
			this.r = r
			this.g = g
			this.b = b
			this.a = a

			this.rMultiplier = rMultiplier
			this.gMultiplier = gMultiplier
			this.bMultiplier = bMultiplier
			this.aMultiplier = aMultiplier

			transform = new ColorTransform()
			transform.color = toARGB()
		}

		//辅助函数，将数值限制在[0, 1]之间
		static private function clampf(value:Number) : Number{
			//avoid function call
			return value > 1 ? 1 : (value < 0 ? 0 : value)
			//return Math.max(0, Math.min(value, 1))
		}

		public function toARGB() : uint{
			return int(clampf(a) * 255) << 24 | int(clampf(r) * 255) << 16 |
				   int(clampf(g) * 255) << 8  | int(clampf(b) * 255)
		}

		public function setWithARGB(argb:uint) : void{
			a = (argb >> 24 & 0xFF) / 255.0
			r = (argb >> 16 & 0xFF) / 255.0
			g = (argb >> 8 & 0xFF) / 255.0
			b = (argb & 0xFF) / 255.0
		}

		public function setWithRGB(rgb:uint) : void{
			r = (rgb >> 16 & 0xFF) / 255.0
			g = (rgb >> 8 & 0xFF) / 255.0
			b = (rgb & 0xFF) / 255.0
		}

		public function get colorTransform() : ColorTransform{
			transform.color = toARGB()
			transform.redMultiplier = rMultiplier
			transform.greenMultiplier = gMultiplier
			transform.blueMultiplier = bMultiplier
			transform.alphaMultiplier = aMultiplier

			return transform
		}
	}
}