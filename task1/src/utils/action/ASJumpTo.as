package utils.action{
	import flash.display.*
	import flash.geom.Point

	public class ASJumpTo extends ASJumpBy{
		protected var m_dstPosition:Point

		public function ASJumpTo(duration:Number, dstPosition:Point,
			height:Number, jumps:int){
			super(duration, dstPosition.clone(), height, jumps)
			m_dstPosition = dstPosition
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_deltaPosition = m_dstPosition.subtract(m_startPosition)
		}

		override public function clone() : Object{
			return new ASJumpTo(m_duration, m_dstPosition.clone(), 
				-m_height, m_jumps)
		}

		override public function reverse() : Object{
			throw new Error("Reverse is not supported in ASJumpTo")
			return null
		}
	}
}