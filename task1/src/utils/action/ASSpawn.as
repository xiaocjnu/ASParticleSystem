package utils.action{
	import flash.display.*

	public class ASSpawn extends ASActionInterval{
		//需要执行的action
		protected var m_actions:Vector.<ASFiniteTimeAction>

		public function ASSpawn(action1:ASFiniteTimeAction, ... args){
			var maxDuration:Number = 0
			m_actions = new Vector.<ASFiniteTimeAction>

			if(action1 != null){
				m_actions.push(action1)
				maxDuration = action1.getDuration()
			}

			for(var i:int = 0; i < args.length; i++){
				if(args[i] != null && args[i] is ASFiniteTimeAction){
					var tmpAction:ASFiniteTimeAction = ASFiniteTimeAction(args[i])
					m_actions.push(tmpAction)
					maxDuration = Math.max(maxDuration, tmpAction.getDuration())
				}
			}

			super(maxDuration)
			
			alignActions()
		}

		//通过添加delayTime action将所有action的duration与最长的action对齐
		public function alignActions() : void{
			for(var i:int = 0; i < m_actions.length; i++){
				if(m_actions[i].getDuration() < this.getDuration()){
					m_actions[i] = new ASSequence(m_actions[i], new ASDelayTime(
						this.getDuration() - m_actions[i].getDuration()))
				}
			}
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			for each(var act:ASFiniteTimeAction in m_actions){
				act.startWithTarget(target)
			}
		}

		//同时更新所有action
		override public function update(percent:Number) : void{
			for each(var act:ASFiniteTimeAction in m_actions)
				act.update(percent)
		}		

		override public function stop() : void{
			for each(var act:ASFiniteTimeAction in m_actions)
				act.stop()
			super.stop()
		}

		//一个clone和reverse时使用的辅助方法
		public function addActions(actions:Vector.<ASFiniteTimeAction>) : void{
			var maxDuration:Number = super.getDuration()
			for each(var act:ASFiniteTimeAction in actions){
				if(act != null){
					m_actions.push(act)
					maxDuration = Math.max(maxDuration, act.getDuration())
				}
			}
			this.setDuration(maxDuration)
			
			alignActions()
		}

		override public function clone() : Object{
			var actions:Vector.<ASFiniteTimeAction> = new Vector.<ASFiniteTimeAction>
			for (var i = 0; i < m_actions.length; i++){
				actions.push(m_actions[i].clone())
			}

			var spawn:ASSpawn = new ASSpawn(null)
			spawn.addActions(actions)
			return spawn
		}

		override public function reverse() : Object{
			var actions:Vector.<ASFiniteTimeAction> = new Vector.<ASFiniteTimeAction>
			for (var i = m_actions.length - 1; i >=0; i--){
				actions.push(m_actions[i].reverse())
			}

			var spawn:ASSpawn = new ASSpawn(null)
			spawn.addActions(actions)
			return spawn
		}

	}
}