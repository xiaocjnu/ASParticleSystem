package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//前半段动作以percent ^ m_rate 的速度完成
	//后半段动作以percent ^ (1 / m_rate)的速度完成
	public class ASEaseInOut extends ASActionEaseRate{

		public function ASEaseInOut(action:ASActionInterval, rate:Number){
			super(action, rate)
		}

		override protected function tweenFunc(percent:Number) : Number{
			percent *= 2
			if(percent < 1){
				return 0.5 * Math.pow(percent, m_rate)
			}
			else{
				return (1 - 0.5 * Math.pow(2 - percent, m_rate))
			}
		}

		override public function clone() : Object{
			return new ASEaseInOut(ASActionInterval(m_action.clone()), m_rate)
		}

		override public function reverse() : Object{
			return new ASEaseInOut(ASActionInterval(m_action.reverse()), m_rate)
		}
	}
}