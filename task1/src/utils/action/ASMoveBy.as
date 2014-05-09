package utils.action{
	import flash.display.*
	import flash.geom.*

	//将一个精灵以相对位置的形式移动一段距离
	public class ASMoveBy extends ASActionInterval{
		//需要移动的相对距离 
		protected var m_deltaPosition:Point
		//记录精灵的起始位置(叠加运动时可能会变化)，叠加多个action时需要用到
		protected var m_startPosition:Point
		//上一个位置，叠加多个action时需要用到
		protected var m_previousPosition:Point

		public function ASMoveBy(duration:Number, deltaPosition:Point){
			super(duration)
			m_deltaPosition = deltaPosition
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_previousPosition = new Point(target.x, target.y)
			m_startPosition = m_previousPosition.clone()
		}

		override public function reverse() : Object{
			return new ASMoveBy(m_duration, new Point(-m_deltaPosition.x, -m_deltaPosition.y))
		}

		override public function update(percent:Number) : void{
			if(m_target){
				var diffx:Number = m_target.x - m_previousPosition.x
				var diffy:Number = m_target.y - m_previousPosition.y
				//如果diff不为0，那么说明存在其他的action也在同时作用于这个
				//精灵，那么为了保证可叠加运动，应在加上其他action的基础上更新
				m_startPosition.x = m_startPosition.x + diffx
				m_startPosition.y = m_startPosition.y + diffy

				m_target.x = m_startPosition.x + m_deltaPosition.x * percent
				m_target.y = m_startPosition.y + m_deltaPosition.y * percent

				//注意Point和target.x的精度不一样
				m_previousPosition.x = m_target.x
				m_previousPosition.y = m_target.y
			}
		}

		override public function clone() : Object{
			return new ASMoveBy(m_duration, m_deltaPosition.clone())
		}
	}
}