package utils.action{
	import flash.display.*

	public class ASRotateTo extends ASRotateBy{
		protected var m_dstAngleZ:Number
		protected var m_dstAngleX:Number
		protected var m_dstAngleY:Number

		public function ASRotateTo(duration:Number, dstAngleZ:Number = 0, dstAngleX:Number = 0, 
			dstAngleY:Number = 0){
			super(duration)
			
			m_dstAngleZ = dstAngleZ
			m_dstAngleX = dstAngleX
			m_dstAngleY = dstAngleY

		}

		//从 0 到 180 的值表示顺时针方向旋转；从 0 到 -180 的值表示逆时针方向旋转。
		//对于此范围之外的值，可以通过加上或减去 360 获得该范围内的值。
		private function calculateDeltaAngle(startAngle:Number, dstAngle:Number) : Number{
			startAngle %= 360
			var deltaAngle:Number = dstAngle - startAngle
			if(deltaAngle > 180)
				deltaAngle -= 360
			else if(deltaAngle < -180)
				deltaAngle += 360
			return deltaAngle
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)

			m_startAngleZ = target.rotationZ
			m_deltaAngleZ = calculateDeltaAngle(m_startAngleZ, m_dstAngleZ)

			m_startAngleX = target.rotationX
			m_deltaAngleX = calculateDeltaAngle(m_startAngleX, m_dstAngleX)

			m_startAngleY = target.rotationY 
			m_deltaAngleY = calculateDeltaAngle(m_startAngleY, m_dstAngleY)
		}

		override public function reverse() : Object{
			throw new Error("Reverse is not supported in ASRotateTo")
			return null
		}

		override public function clone() : Object{
			return new ASRotateTo(m_duration, m_dstAngleZ, m_dstAngleX,
				m_dstAngleY)	
		}
	}
}