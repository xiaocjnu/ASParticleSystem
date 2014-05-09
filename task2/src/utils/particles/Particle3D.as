package utils.particles
{
	import flash.geom.*

	public class Particle3D extends Particle
	{
		public static const X_AXIS:Vector3D = new Vector3D(1,0,0)
		public static const Y_AXIS:Vector3D = new Vector3D(0,1,0)
		public static const Z_AXIS:Vector3D = new Vector3D(0,0,1)

		public var z:Number
		public var startZ:Number

		public var rotationX:Number  //弧度表示
		public var deltaRotationX:Number //弧度表示
		public var rotationY:Number  //弧度表示
		public var deltaRotationY:Number //弧度表示
		public var rotationZ:Number  //弧度表示
		public var deltaRotationZ:Number //弧度表示

		public var matrix3D:Matrix3D
		
		public function Particle3D()
		{
			super()
			z = startZ = 0
			rotationX = rotationY = rotationZ = 0
			deltaRotationX = deltaRotationY = deltaRotationZ = 0

			matrix3D = new Matrix3D()
		}

		public function get matrix3DTransform():Matrix3D
		{
			matrix3D.identity()
			matrix3D.appendRotation(rotationX, X_AXIS)
			matrix3D.appendRotation(rotationY, Y_AXIS)
			matrix3D.appendRotation(rotationZ, Z_AXIS)
			matrix3D.appendTranslation(x, y, z)
			matrix3D.appendScale(scale, scale, scale)
			//trace("Particle3D", rotationX, rotationY, rotationZ, scale, x, y, z)
			return matrix3D
			//return new Matrix(scos, ssin, -ssin, scos, x, y)
		}

	}


}