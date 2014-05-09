package utils.action{
	import flash.display.*
	import flash.geom.*

	//改变透明度
	public class ASFadeTo extends ASActionInterval{
		protected var m_startAlpha:Number
		protected var m_dstAlpha:Number
		protected var m_deltaAlpha:Number

		//在duration秒内将透明度设定为dstAlpha
		public function ASFadeTo(duration:Number, dstAlpha:Number){
			super(duration)
			if(dstAlpha < 0)
				dstAlpha = 0
			else if(dstAlpha > 1)
				dstAlpha = 1

			m_dstAlpha = dstAlpha
			m_startAlpha = m_deltaAlpha = 0
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			if(target){
				m_startAlpha = target.alpha
				m_deltaAlpha = m_dstAlpha - m_startAlpha
			}
		}

		override public function update(percent:Number) : void{
			if(m_target){
				m_target.alpha = m_startAlpha + m_deltaAlpha * percent
			}
		}

		override public function reverse() : Object{
			throw new Error("Reverse is not supported in ASMoveTo")
			return null
		}

		override public function clone() : Object{
			return new ASFadeTo(m_duration, m_dstAlpha)
		}
	}
}