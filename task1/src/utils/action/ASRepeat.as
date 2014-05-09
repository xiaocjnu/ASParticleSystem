package utils.action{
	import flash.display.*

	//重复执行一个action N次
	public class ASRepeat extends ASActionInterval{
		//重启总次数
		protected var m_times:int
		//待执行的action
		protected var m_action:ASFiniteTimeAction
		//action已被执行的次数
		protected var m_cnt:int
		//执行一次所占的百分数
		protected var m_slice:Number

		public function ASRepeat(act:ASFiniteTimeAction, repeatTimes:int){
			// if(action == null)
			// 	throw new Error("action cannot be null")
			super(repeatTimes * act.getDuration())
			m_action = act
			m_times = repeatTimes
			m_slice = 1.0 / repeatTimes
			m_cnt = 0
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_action.startWithTarget(target)
			m_cnt = 0
		}


		override public function update(percent:Number) : void{
			if(percent >= m_slice * (m_cnt + 1)){
				//here may need to fixed if instant action exist?
				m_cnt += 1
				m_action.update(1)
				m_action.stop()
				m_action.startWithTarget(m_target)
			}
			else{
				m_action.update(percent * m_times % 1.0)
			}
		}

		override public function clone() : Object {
			return new ASRepeat(ASFiniteTimeAction(m_action.clone()), m_times)
		}

		override public function isDone() : Boolean{
			return m_cnt >= m_times
		}

		override public function stop() : void{
			m_action.stop()
			super.stop()
		}

		override public function reverse() : Object{
			return new ASRepeat(ASFiniteTimeAction(m_action.reverse()), m_times)
		}
	}
}