package utils.action{
	import flash.display.*
	import flash.geom.*

	public class ASMoveTo3D extends ASMoveBy3D{

		protected var m_endX:Number
		protected var m_endY:Number
		protected var m_endZ:Number

		public function ASMoveTo3D(duration:Number, endX:Number, endY:Number,
			endZ:Number){
			super(duration, endX, endY, endZ)

			m_endX = endX
			m_endY = endY
			m_endZ = endZ
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)

			m_deltaX = m_endX - m_startX
			m_deltaY = m_endY - m_startY
			m_deltaZ = m_endZ - m_startZ
		}

		override public function reverse() : Object {
			throw new Error("Reverse is not supported in ASMoveTo")
			return null
		}

		override public function clone() : Object{
			return new ASMoveTo3D(m_duration, m_endX, m_endY, m_endZ)
		}
	}
}