package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//动作以percent ^ m_rate 的速度完成
	public class ASEaseIn extends ASActionEaseRate{

		public function ASEaseIn(action:ASActionInterval, rate:Number){
			super(action, rate)
		}

		override protected function tweenFunc(percent:Number) : Number{
			return Math.pow(percent, m_rate)
		}

		override public function clone() : Object{
			return new ASEaseIn(ASActionInterval(m_action.clone()), m_rate)
		}

		override public function reverse() : Object{
			return new ASEaseIn(ASActionInterval(m_action.reverse()), 1 / m_rate)
		}
	}
}