package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	public class ASEaseElasticInOut extends ASEaseElastic{
		public function ASEaseElasticInOut(action:ASActionInterval, period:Number = 0.3){
			super(action, period)
		}

		override protected function tweenFunc(percent:Number) : Number{
			if(percent == 0 || percent == 1){
				return percent
			}

			//percent的范围变为(-1, 1)
			percent *= 2 - 1

			var res:Number = 0
			var t1:Number = 0
			var t2:Number = 0
			//前半部分 elasticIn
			if(percent < 0){
				// 指数增长(0, 1]
				t1 = Math.pow(2, percent * 10)
				// 周期波动
				t2 = -Math.sin((percent - m_period / 4) 
					* Math.PI * 2 / m_period)
				res = 0.5 * t1 * t2
			}
			//后半部分elastacOut
			else{
				// 指数递减 1 -> 0
				t1 = Math.pow(2, -percent * 10)
				// 周期波动
				t2 = -Math.sin((percent - m_period / 4) 
					* Math.PI * 2 / m_period)
				res = 1 - 0.5 * t1 * t2
			}


			return res
		}

		override public function reverse() : Object{
			return new ASEaseElasticInOut(ASActionInterval(m_action.reverse()),
				m_period)
		}

		override public function clone() : Object{
			return new ASEaseElasticInOut(ASActionInterval(m_action.clone()), 
				m_period)
		}
	}
}