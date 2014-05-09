package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//弹性变速的基类，带有一个波动周期
	public class ASEaseElastic extends ASActionEase{
		protected var m_period:Number

		public function ASEaseElastic(action:ASActionInterval, period:Number = 0.3){
			super(action)

			if(period <= FLT_EPSILON)
				period = FLT_EPSILON
			m_period = period
		}

		public function getPeriod() : Number{
			return m_period
		}

		public function setPeriod(period:Number) : void{
			m_period = period
		}
	}
}