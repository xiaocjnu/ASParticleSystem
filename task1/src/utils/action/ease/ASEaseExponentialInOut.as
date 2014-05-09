package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	public class ASEaseExponentialInOut extends ASActionEase{
		public function ASEaseExponentialInOut(action:ASActionInterval){
			super(action)
		}

		override protected function tweenFunc(percent:Number) : Number{
			percent *= 2
			//前半段指数递增增加
			if(percent < 1){
				percent = 0.5 * Math.pow(2, 10 * (percent - 1.0))
			}
			//后半段指数递减增加
			else {
				percent = 0.5 * (2 - Math.pow(2, -10 * (percent - 1.0)))
			}
			return Math.min(1, Math.max(0, percent))
		}

		override public function reverse() : Object{
			return new ASEaseExponentialInOut(
				ASActionInterval(m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASEaseExponentialInOut(
				ASActionInterval(m_action.clone()))
		}
	}
}