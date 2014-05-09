package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//完成速度指数增长
	public class ASEaseExponentialIn extends ASActionEase{

		public function ASEaseExponentialIn(action:ASActionInterval){
			super(action)
		}

		override protected function tweenFunc(percent:Number) : Number{
			percent = percent == 0 ? 0 : 
				Math.pow(2, 10 * (percent - 1.0))
			return Math.min(1, Math.max(0, percent))
		}

		override public function reverse() : Object{
			return new ASEaseExponentialOut(
				ASActionInterval(m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASEaseExponentialIn(
				ASActionInterval(m_action.clone()))
		}
	}

}