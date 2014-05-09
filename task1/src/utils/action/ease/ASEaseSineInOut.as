package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	public class ASEaseSineInOut extends ASActionEase{
		protected static const M_PI_2 = Math.PI / 2

		public function ASEaseSineInOut(action:ASActionInterval){
			super(action)
		}

		//一次导数为 0.5sin(t), t属于[0, pi]。加速先大后小
		override protected function tweenFunc(percent:Number) : Number{
			return -0.5 * (Math.cos(Math.PI * percent) - 1)
		}

		override public function reverse() : Object{
			return new ASEaseSineInOut(
				ASActionInterval(m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASEaseSineInOut(
				ASActionInterval(m_action.clone()))
		}
	}

}