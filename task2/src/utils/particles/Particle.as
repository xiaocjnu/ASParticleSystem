package utils.particles{
	import flash.geom.Matrix

	public class Particle{
		//public var pos:Point
		public var x:Number
		public var y:Number
		public var startX:Number
		public var startY:Number
		//public var startPos:Point

		//粒子假设是为正方形的
		public var scale:Number
		public var deltaScale:Number

		public var color:ColorARGB
		public var deltaColor:ColorARGB

		public var rotation:Number  //弧度表示
		public var deltaRotation:Number //弧度表示

		public var life:Number

		//gravity mode attribute
			//沿x轴方向的速度
		public var vx:Number
			//沿y轴方向的速度
		public var vy:Number
			//径向加速度
		public var radialAccel:Number
			//切线加速度
		public var tangentialAcceel:Number

		//radius mode attribute
		public var angle:Number
		public var degreesPerSec:Number
		public var radius:Number
		public var deltaRadius:Number

		// 转换矩阵
		// 出于性能考虑储存此值，避免每次调用draw时new
		public var matrix:Matrix
		

		public function Particle(){
			//pos = new Point()
			//startPos = new Point()
			//dir = new Point()
			x = y = startX = startY = deltaScale = 0
			rotation = deltaRotation = life = 0
			vx = vy = radialAccel = tangentialAcceel = 0
			angle = degreesPerSec = radius = deltaRadius = 0
			scale = 1
			color = new ColorARGB()
			deltaColor = new ColorARGB()
			matrix = new Matrix
		}

		public function get matrixTransform():Matrix{
			var sxcos:Number = scale * Math.cos(rotation ) 
			var sxsin:Number = scale * Math.sin(rotation )
			matrix.a = sxcos
			matrix.b = sxsin
			matrix.c = -sxsin
			matrix.d = sxcos
			matrix.tx = x
			matrix.ty = y

			return matrix
			//return new Matrix(scos, ssin, -ssin, scos, x, y)
		}
	}
}