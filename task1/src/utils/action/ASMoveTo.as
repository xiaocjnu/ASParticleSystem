package utils.action{
	import flash.display.*
	import flash.geom.*

	public class ASMoveTo extends ASMoveBy{
		protected var m_endPosition:Point

		public function ASMoveTo(duration:Number, endPosition:Point){
			super(duration, endPosition.clone())//第二个参数会在设定精灵后改变
			m_endPosition = endPosition
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_deltaPosition = m_endPosition.subtract(m_startPosition)
		}

		override public function reverse() : Object {
			throw new Error("Reverse is not supported in ASMoveTo")
			return null
		}

		override public function clone() : Object{
			return new ASMoveTo(m_duration, m_endPosition.clone())
		}
	}
}