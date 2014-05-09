package utils.action.ease{
	import utils.action.ASActionInterval

	public class ASEaseBackInOut extends ASActionEase{
		protected var m_coef:Number

		public function ASEaseBackInOut(act:ASActionInterval, coef:Number = 2.5949){
			super(act)
			m_coef = coef
		}

		override protected function tweenFunc(percent:Number) : Number{
			//var coef:Number = 1.70158 * 1.525
			percent *= 2
			if(percent < 1){
				return percent * percent * ((m_coef + 1) * percent - m_coef) * 0.5
			}
			else {
				percent -= 2
				return percent * percent * ((m_coef + 1) * percent + m_coef) * 0.5 + 1
			}
		}

		override public function reverse() : Object{
			return new ASEaseBackInOut(
				ASActionInterval(m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASEaseBackInOut(
				ASActionInterval(m_action.clone()))
		}
	}
}