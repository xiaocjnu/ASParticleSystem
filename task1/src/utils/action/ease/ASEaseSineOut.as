package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//完成速度余弦降低
	public class ASEaseSineOut extends ASActionEase{
		protected static const M_PI_2 = Math.PI / 2

		public function ASEaseSineOut(action:ASActionInterval){
			super(action)
		}
		
		// 一次导数为 cos (t), t属于[0, pi / 2]。加速度逐渐变慢
		override protected function tweenFunc(percent:Number) : Number{
			return Math.sin(M_PI_2 * percent)
		}

		override public function reverse() : Object{
			return new ASEaseSineIn(
				ASActionInterval(m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASEaseSineOut(
				ASActionInterval(m_action.clone()))
		}
	}

}