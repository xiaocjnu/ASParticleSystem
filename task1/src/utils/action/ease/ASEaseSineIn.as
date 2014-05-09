package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//完成速度正弦增长
	public class ASEaseSineIn extends ASActionEase{
		protected static const M_PI_2 = Math.PI / 2

		public function ASEaseSineIn(action:ASActionInterval){
			super(action)
		}

		// 一次导数为 sin (t), t属于[0, pi / 2]。加速度逐渐增大
		override protected function tweenFunc(percent:Number) : Number{
			return 1.0 - Math.cos(M_PI_2 * percent)
		}

		override public function reverse() : Object{
			return new ASEaseSineOut(
				ASActionInterval(m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASEaseSineIn(
				ASActionInterval(m_action.clone()))
		}
	}

}