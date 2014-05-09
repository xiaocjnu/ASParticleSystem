package utils.action{
	import flash.display.*
	import flash.geom.*

	//将一个精灵以相对位置的形式移动一段距离
	public class ASMoveBy3D extends ASActionInterval{
		//需要移动的相对距离 
		protected var m_deltaX:Number
		protected var m_deltaY:Number
		protected var m_deltaZ:Number
		//记录精灵的起始位置(叠加运动时可能会变化)，叠加多个action时需要用到
		protected var m_startX:Number
		protected var m_startY:Number
		protected var m_startZ:Number
		//上一个位置，叠加多个action时需要用到
		protected var m_previousX:Number
		protected var m_previousY:Number
		protected var m_previousZ:Number

		public function ASMoveBy3D(duration:Number, deltaX:Number, deltaY:Number,
			deltaZ:Number){
			super(duration)

			m_deltaX = deltaX
			m_deltaY = deltaY
			m_deltaZ = deltaZ
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)

			m_startX = m_previousX = target.x
			m_startY = m_previousY = target.y
			m_startZ = m_previousZ = target.z
		}

		override public function reverse() : Object{
			//return new ASMoveBy(m_duration, new Point(-m_deltaPosition.x, -m_deltaPosition.y))
			return new ASMoveBy3D(m_duration, -m_deltaX, -m_deltaY, -m_deltaZ)
		}

		override public function update(percent:Number) : void{
			if(m_target){
				var diffx:Number = m_target.x - m_previousX
				var diffy:Number = m_target.y - m_previousY
				var diffz:Number = m_target.z - m_previousZ
				//如果diff不为0，那么说明存在其他的action也在同时作用于这个
				//精灵，那么为了保证可叠加运动，应在加上其他action的基础上更新
				m_startX = m_startX + diffx
				m_startY = m_startY + diffy
				m_startZ = m_startZ + diffz

				m_target.x = m_startX + m_deltaX * percent
				m_target.y = m_startY + m_deltaY * percent
				m_target.z = m_startZ + m_deltaZ * percent

				m_previousX = m_target.x
				m_previousY = m_target.y
				m_previousZ = m_target.z
			}
		}

		override public function clone() : Object{
			return new ASMoveBy3D(m_duration, m_deltaX, m_deltaY, m_deltaZ)
		}
	}
}