package utils.action.ease{
	import utils.action.ASActionInterval

	public class ASEaseBackOut extends ASActionEase{
		protected var m_coef:Number

		//系数越大，回弹的幅度越大
		public function ASEaseBackOut(act:ASActionInterval, coef:Number = 1.70158){
			super(act)
			m_coef = coef
		}

		override protected function tweenFunc(percent:Number) : Number{
			percent -= 1
			return percent * percent * ((m_coef + 1) * percent + m_coef) + 1
		}

		override public function reverse() : Object{
			return new ASEaseBackIn(
				ASActionInterval(m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASEaseBackOut(
				ASActionInterval(m_action.clone()))
		}
	}
}