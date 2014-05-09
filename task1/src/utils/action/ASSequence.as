package utils.action{
	import flash.display.*

	public class ASSequence extends ASActionInterval{
		//需要执行的action
		protected var m_actions:Vector.<ASFiniteTimeAction>
		//标记当前执行的action的索引
		protected var m_currentIndex:int
		//当前的动作占总时长的百分比的倒数， 即总的执行时间除以当前动作的时长
		protected var m_invcurrentActPercent:Number
		// 下一个动作开始的百分比时间
		protected var m_nextStartPercent:Number
		// 累计完成的动作百分比时间
		protected var m_accPercent:Number

		public function ASSequence(action1:ASFiniteTimeAction, ... args){
			var totalDuration:Number = 0
			m_actions = new Vector.<ASFiniteTimeAction>

			if(action1 != null){
				m_actions.push(action1)
				totalDuration += action1.getDuration()
			}
			

			for(var i:int = 0; i < args.length; i++){
				if(args[i] != null && args[i] is ASFiniteTimeAction){
					var tmpAction:ASFiniteTimeAction = ASFiniteTimeAction(args[i])
					m_actions.push(tmpAction)
					totalDuration += tmpAction.getDuration()
				}
				else {
					//trace("args " + i + " is not ASFiniteTimeAction")
					//throw new Error("args " + i + " is not ASFiniteTimeAction")
				}
			}

			super(totalDuration)
			m_currentIndex = 0
			m_accPercent = 0
			m_nextStartPercent = 0
			m_invcurrentActPercent = 0
			if(action1 != null && totalDuration >= FLT_EPSILON){
				m_nextStartPercent = action1.getDuration() / totalDuration
				m_invcurrentActPercent = totalDuration / action1.getDuration()
			}
		}

		override public function startWithTarget(target:DisplayObject) : void{
			m_currentIndex = 0
			m_accPercent = 0
			m_nextStartPercent = 0
			if(m_actions.length > 0 && getDuration() >= FLT_EPSILON){
				m_nextStartPercent = m_actions[0].getDuration() / getDuration()
				m_invcurrentActPercent = 1.0 / m_nextStartPercent
			}

			super.startWithTarget(target)
			m_actions[0].startWithTarget(target)
		}

		override public function update(percent:Number) : void{
			//切换到下一个action，如果存在instant动作，需要切换多次
			while(percent >= m_nextStartPercent && m_currentIndex + 1 < m_actions.length){
				if(!m_actions[m_currentIndex].isDone())
					m_actions[m_currentIndex].update(1.0)
				m_actions[m_currentIndex].stop()
				m_currentIndex++

				m_accPercent = m_nextStartPercent

				m_nextStartPercent += m_actions[m_currentIndex]
					.getDuration() / getDuration()

				m_invcurrentActPercent = getDuration() / 
					m_actions[m_currentIndex].getDuration()

				m_actions[m_currentIndex].startWithTarget(m_target)
			}
			
			var percentInAction = (percent - m_accPercent) * m_invcurrentActPercent
			m_actions[m_currentIndex].update(Math.min(1, percentInAction))	
		}

		override public function stop() : void{
			for each(var act:ASFiniteTimeAction in m_actions)
				act.stop()
			super.stop()
		}


		//一个clone和reverse时使用的辅助方法
		public function addActions(actions:Vector.<ASFiniteTimeAction>) : void{
			var totalDuration:Number = super.getDuration()
			for each(var act:ASFiniteTimeAction in actions){
				if(act != null){
					m_actions.push(act)
					totalDuration += act.getDuration()
				}
			}
			this.setDuration(totalDuration)
			
			if(m_actions.length > 0)
				m_nextStartPercent = m_actions[0].getDuration() / totalDuration
		}

		override public function clone() : Object{
			var actions:Vector.<ASFiniteTimeAction> = new Vector.<ASFiniteTimeAction>
			for (var i = 0; i < m_actions.length; i++){
				actions.push(m_actions[i].clone())
			}

			var seq:ASSequence = new ASSequence(null)
			seq.addActions(actions)
			return seq
		}

		override public function reverse() : Object{
			var actions:Vector.<ASFiniteTimeAction> = new Vector.<ASFiniteTimeAction>
			for (var i = m_actions.length - 1; i >=0; i--){
				actions.push(m_actions[i].reverse())
			}

			var seq:ASSequence = new ASSequence(null)
			seq.addActions(actions)
			return seq
		}

	}
}