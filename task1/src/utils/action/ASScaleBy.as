package utils.action{
	import flash.display.*

	//缩放动作
	public class ASScaleBy extends ASActionInterval{
		protected var m_startScaleX:Number
		protected var m_startScaleY:Number

		protected var m_deltaScaleX:Number
		protected var m_deltaScaleY:Number

		//缩放的倍数，需要记录用于reverse
		protected var m_scaleX:Number
		protected var m_scaleY:Number

		public function ASScaleBy(duration:Number, sx:Number, sy:Number){
			super(duration)
			m_scaleX = sx
			m_scaleY = sy
			m_startScaleX = m_startScaleY = 0
			m_deltaScaleX = m_deltaScaleY = 0
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_startScaleX = target.scaleX
			m_startScaleY = target.scaleY

			//缩放的变化量需要根据精灵起始的scale值计算
			m_deltaScaleX = m_startScaleX * m_scaleX - m_startScaleX
			m_deltaScaleY = m_startScaleY * m_scaleY - m_startScaleY
		}

		override public function update(percent:Number) : void{
			if(m_target){
				m_target.scaleX = m_startScaleX + m_deltaScaleX * percent
				m_target.scaleY = m_startScaleY + m_deltaScaleY * percent
			}
		}

		override public function reverse() : Object{
			var sx:Number = m_scaleX
			var sy:Number = m_scaleY
			//防止除0
			if(sx < FLT_EPSILON)
				sx = FLT_EPSILON
			if(sy < FLT_EPSILON)
				sy = FLT_EPSILON

			return new ASScaleBy(m_duration, 1 / sx, 1 / sy)
		}

		override public function clone() : Object {
			return new ASScaleBy(m_duration, m_scaleX, m_scaleY)
		}
	}
}