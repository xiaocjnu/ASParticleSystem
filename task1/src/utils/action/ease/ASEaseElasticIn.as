package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//指数周期性波动增长
	public class ASEaseElasticIn extends ASEaseElastic{
		public function ASEaseElasticIn(action:ASActionInterval, period:Number = 0.3){
			super(action, period)
		}

		override protected function tweenFunc(percent:Number) : Number{
			if(percent == 0 || percent == 1){
				return percent
			}

			// percent的范围变为[-1, 0]
			percent -= 1

			// 指数增长(0, 1]
			var t1:Number = Math.pow(2, percent * 10)
			// 周期波动
			var t2:Number = -Math.sin((percent - m_period / 4) 
				* Math.PI * 2 / m_period)

			return t1 * t2
		}

		override public function reverse() : Object{
			return new ASEaseElasticOut(ASActionInterval(m_action.reverse()),
				m_period)
		}

		override public function clone() : Object{
			return new ASEaseElasticIn(ASActionInterval(m_action.clone()), 
				m_period)
		}
	}
}