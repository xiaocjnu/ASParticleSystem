package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//变速Action的基类，带有速率
	public class ASActionEaseRate extends ASActionEase{
		protected var m_rate:Number

		public function ASActionEaseRate(action:ASActionInterval, rate:Number){
			super(action)
			if(rate < FLT_EPSILON)
				rate = FLT_EPSILON
			m_rate = rate
		}

		public function setRate(rate:Number) : void{
			m_rate = rate
		}

		public function getRate() : Number{
			return m_rate
		}
	}
}