package utils.action{
	import flash.display.*

	public class ASScaleTo extends ASScaleBy{
		protected var m_dstScaleX:Number
		protected var m_dstScaleY:Number

		public function ASScaleTo(duration:Number, sx:Number, sy:Number){
			super(duration, 0, 0)
			m_dstScaleX = sx
			m_dstScaleY = sy
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)

			m_deltaScaleX = m_dstScaleX - m_startScaleX
			m_deltaScaleY = m_dstScaleY - m_startScaleY
		}

		override public function clone() : Object{
			return new ASScaleTo(m_duration, m_dstScaleX, m_dstScaleY)
		}

		override public function reverse() : Object{
			throw new Error("Reverse is not supported in ASScaleTo")
			return null
		}
	}
}