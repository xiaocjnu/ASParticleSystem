package utils.action{
	import flash.display.*
	import flash.geom.*
	
	//跳跃动作
	public class ASJumpBy extends ASActionInterval{
		protected var m_startPosition:Point
		protected var m_deltaPosition:Point
		//跳跃高度
		protected var m_height:Number
		//跳跃次数
		protected var m_jumps:int

		//在duration秒内跳跃一段距离，跳跃jumps次，每次跳跃的高度为height
		public function ASJumpBy(duration:Number, deltaPosition:Point,
			height:Number, jumps:int){
			super(duration)
			m_deltaPosition = deltaPosition
			m_height = -height
			m_jumps = jumps
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_startPosition = new Point(m_target.x, m_target.y)
		}

		override public function update(percent:Number) : void{
			if(m_target){
				//x方向匀速前进
				m_target.x = m_startPosition.x + m_deltaPosition.x * percent

				//y为自由落体
				//某次jump中的进度
				var t:Number = (percent * m_jumps) % 1.0

				//gy为某一时刻上抛运动的位移
				//根据h, t解y = at^2 + bt得到。
				var gy:Number = m_height * 4 * t * (1 - t)
				m_target.y = m_startPosition.y +  m_deltaPosition.y * percent + gy 
			}
		}

		override public function reverse() : Object{
			return new ASJumpBy(m_duration, new Point(-m_deltaPosition.x, 
				-m_deltaPosition.y), -m_height, m_jumps)
		}

		override public function clone() : Object{
			return new ASJumpBy(m_duration, m_deltaPosition.clone(), -m_height, m_jumps)
		}

	}
}