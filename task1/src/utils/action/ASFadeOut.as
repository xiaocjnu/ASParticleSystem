package utils.action{
	import flash.display.*

	//淡出
	public class ASFadeOut extends ASFadeTo{

		public function ASFadeOut(duration:Number){
			super(duration, 0)
		}

		override public function clone() : Object{
			return new ASFadeOut(m_duration)
		}

		override public function reverse() : Object{
			return new ASFadeIn(m_duration)
		}
	}
}