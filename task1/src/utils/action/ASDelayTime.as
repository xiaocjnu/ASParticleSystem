package utils.action{
	import flash.display.*

	//延时动作
	public class ASDelayTime extends ASActionInterval{

		public function ASDelayTime(duration:Number){
			super(duration)
		}

		override public function reverse() : Object{
			return this.clone()
		}

		override public function clone() : Object{
			return new ASDelayTime(getDuration())
		}
	}
}