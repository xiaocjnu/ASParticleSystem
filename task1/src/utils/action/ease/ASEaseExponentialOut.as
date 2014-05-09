package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//完成速度指数递减
	public class ASEaseExponentialOut extends ASActionEase{
		public function ASEaseExponentialOut(action:ASActionInterval){
			super(action)
		}

		override protected function tweenFunc(percent:Number) : Number{
			percent = percent == 1 ? 1 : 
				1 - Math.pow(2, -10.0 * percent)
			return Math.min(1, Math.max(0, percent))
		}

		override public function reverse() : Object{
			return new ASEaseExponentialIn(ASActionInterval(
				m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASEaseExponentialOut(ASActionInterval(
				m_action.reverse()))
		}
	}
}