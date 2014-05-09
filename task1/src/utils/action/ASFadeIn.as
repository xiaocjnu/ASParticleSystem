package utils.action{
	import flash.display.*

	//淡入
	public class ASFadeIn extends ASFadeTo{

		public function ASFadeIn(duration:Number){
			super(duration, 1.0)
		}

		override public function clone() : Object{
			return new ASFadeIn(m_duration)
		}

		override public function reverse() : Object{
			return new ASFadeOut(m_duration)
		}
	}	
}