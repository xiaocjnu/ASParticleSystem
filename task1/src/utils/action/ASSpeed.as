package utils.action{
	import flash.display.DisplayObject

	//控制动作的速度，调整为原来的speed倍
	public class ASSpeed extends ASAction{
		protected var m_speed:Number
		protected var m_action:ASActionInterval

		public function ASSpeed(action:ASActionInterval, speed:Number = 1){
			m_action = action
			m_speed = speed
		}

		public function getSpeed() : Number{
			return m_speed
		}

		public function setSpeed(speed:Number) : void{
			m_speed = speed
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_action.startWithTarget(target)
		}

		override public function step(dt:Number) : void{
			m_action.step(dt * m_speed)
		}

		override public function isDone() : Boolean {
			return m_action.isDone()
		}

		override public function stop() : void{
			super.stop()
			m_action.stop()
		}

		override public function reverse() : Object{
			return new ASSpeed(ASActionInterval(m_action.reverse()), m_speed)
		}

		override public function clone() : Object{
			return new ASSpeed(ASActionInterval(m_action.clone()), m_speed)
		}

		public function getInnerAction() : ASActionInterval{
			return m_action
		}

		public function setInnerAction(action:ASActionInterval) : void{
			m_action = action
		}
	}
}