package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//动作以 percent ^ (1 / m_rate)的速度完成
	public class ASEaseOut extends ASActionEaseRate{

		public function ASEaseOut(action:ASActionInterval, rate:Number){
			super(action, rate)
		}

		override protected function tweenFunc(percent:Number) : Number{
			return Math.pow(percent, 1 / m_rate)
		}

		override public function clone() : Object{
			return new ASEaseOut(ASActionInterval(m_action.clone()), m_rate)
		}

		override public function reverse() : Object{
			return new ASEaseOut(ASActionInterval(m_action.reverse()), 1 / m_rate)
		}
	}
}