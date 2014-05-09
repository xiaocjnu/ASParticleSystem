package utils.action{
	import flash.display.*
	import flash.geom.ColorTransform

	//改变精灵的颜色
	public class ASTintBy extends ASActionInterval{
		protected var m_startR:Number 
		protected var m_startG:Number 
		protected var m_startB:Number 

		protected var m_deltaR:Number 
		protected var m_deltaG:Number 
		protected var m_deltaB:Number 

		public function ASTintBy(duration:Number, deltaR:Number, 
			deltaG:Number, deltaB:Number){

			super(duration)

			m_deltaR = deltaR
			m_deltaG = deltaG
			m_deltaB = deltaB
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			var colorInfo:ColorTransform = target.transform.colorTransform
			m_startR = colorInfo.redOffset
			m_startG = colorInfo.greenOffset
			m_startB = colorInfo.blueOffset
		}

		/*
		private function rangeFix(offset:Number) : Number{
			return Math.min(255, Math.max(-255, offset))
		}
		*/

		override public function update(percent:Number) : void{
			if(m_target){
				var colorInfo:ColorTransform = m_target.transform.colorTransform

				colorInfo.redOffset = m_startR + m_deltaR * percent
				colorInfo.greenOffset = m_startG + m_deltaG * percent
				colorInfo.blueOffset = m_startB + m_deltaB * percent

				m_target.transform.colorTransform = colorInfo
					//new ColorTransform(colorInfo.redMultiplier,
					//colorInfo.greenMultiplier, colorInfo.blueMultiplier,
					//colorInfo.alphaMultiplier, redOffset, greenOffset, blueOffset, 
					//colorInfo.alphaOffset)
			}
		}

		override public function clone() : Object{
			return new ASTintBy(m_duration, m_deltaR, m_deltaG, m_deltaB)
		}

		override public function reverse() : Object{
			return new ASTintBy(m_duration, -m_deltaR, -m_deltaG, -m_deltaB)
		}
	}

}