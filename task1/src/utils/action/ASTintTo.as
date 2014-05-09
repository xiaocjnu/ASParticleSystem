package utils.action{
	import flash.display.DisplayObject
	import flash.geom.ColorTransform

	public class ASTintTo extends ASTintBy{
		protected var m_dstR:Number
		protected var m_dstG:Number
		protected var m_dstB:Number

		public function ASTintTo(duration:Number, dstR:Number,
			dstG:Number, dstB:Number){
			super(duration, 0, 0, 0)

			m_dstR = dstR
			m_dstG = dstG
			m_dstB = dstB
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)

			m_deltaR = m_dstR - m_startR
			m_deltaG = m_dstG - m_startG
			m_deltaB = m_dstB - m_startB
		}

		override public function clone() : Object{
			return new ASTintTo(m_duration, m_deltaR, m_deltaG, m_deltaB)
		}

		override public function reverse() : Object{
			throw new Error("Reverse is not supported in ASTintTo")
			return null
		}
	}

}