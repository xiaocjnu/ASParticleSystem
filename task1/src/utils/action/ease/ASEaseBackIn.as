package utils.action.ease{
	import utils.action.ASActionInterval

	public class ASEaseBackIn extends ASActionEase{
		protected var m_coef:Number

		public function ASEaseBackIn(act:ASActionInterval, coef:Number = 1.70158){
			super(act)
			m_coef = coef
		}

		override protected function tweenFunc(percent:Number) : Number{
			return percent * percent * ((m_coef + 1) * percent - m_coef)
		}

		override public function reverse() : Object{
			return new ASEaseBackOut(
				ASActionInterval(m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASEaseBackIn(
				ASActionInterval(m_action.clone()))
		}
	}
}