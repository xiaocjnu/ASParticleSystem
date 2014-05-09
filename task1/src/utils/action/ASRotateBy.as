package utils.action{
	import flash.display.*
	import flash.geom.*

	//旋转类，可以绕x/y/z轴旋转
	public class ASRotateBy extends ASActionInterval{
		//沿着Z/X/Y轴旋转的变化量
		protected var m_deltaAngleZ:Number
		protected var m_deltaAngleX:Number
		protected var m_deltaAngleY:Number

		protected var m_startAngleZ:Number
		protected var m_startAngleX:Number
		protected var m_startAngleY:Number

		public function ASRotateBy(duration:Number, deltaAngleZ:Number = 0, 
			deltaAngleX:Number = 0, deltaAngleY:Number = 0){
			super(duration)
			m_deltaAngleZ = deltaAngleZ
			m_deltaAngleX = deltaAngleX
			m_deltaAngleY = deltaAngleY
			m_startAngleX = m_startAngleY = m_startAngleZ = 0
		}

		override public function startWithTarget(target:DisplayObject) : void {
			super.startWithTarget(target)
			m_startAngleZ = target.rotationZ
			m_startAngleX = target.rotationX
			m_startAngleY = target.rotationY
		}

		override public function update(percent:Number) : void{
			if(m_target){
				m_target.rotationZ = m_startAngleZ + m_deltaAngleZ * percent
				m_target.rotationX = m_startAngleX + m_deltaAngleX * percent
				m_target.rotationY = m_startAngleY + m_deltaAngleY * percent
			}
		}

		override public function reverse() : Object{
			return new ASRotateBy(m_duration, -m_deltaAngleZ, -m_deltaAngleX, 
				-m_deltaAngleY)
		}

		override public function clone() : Object{
			return new ASRotateBy(m_duration, m_deltaAngleZ, m_deltaAngleX, 
				m_deltaAngleY)
		}
	}
}