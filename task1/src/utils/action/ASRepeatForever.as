package utils.action{
	import flash.display.*

	// 无限循环执行一个action
	public class ASRepeatForever extends ASActionInterval{
		//待执行的action
		protected var m_action:ASFiniteTimeAction

		public function ASRepeatForever(act:ASFiniteTimeAction){
			super(Number.POSITIVE_INFINITY)
			if(act == null)
				throw new Error("act should not be null")
			m_action = act
		}

		override public function isDone() : Boolean{
			return false
		}

		override public function stop() : void{
			super.stop()
			m_action.stop()
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_action.startWithTarget(target)
		}

		//无限循环
		override public function step(dt:Number) : void{
			m_action.step(dt)

			if(m_action.isDone()){
				m_action.startWithTarget(m_target)
			}
		}

		override public function reverse() : Object{
			return new ASRepeatForever(ASFiniteTimeAction(m_action.reverse()))
		}

		override public function clone() : Object{
			return new ASRepeatForever(ASFiniteTimeAction(m_action.clone()))
		}
	}
}