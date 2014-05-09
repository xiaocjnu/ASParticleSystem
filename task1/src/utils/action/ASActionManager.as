package utils.action{
	import flash.display.*
	import flash.utils.Dictionary

	public class ASActionManager extends Object{
		protected static var m_manager:ASActionManager = null
		protected var dict:Dictionary //key : DisplayObject, value : ActionNode

		//不要使用构造函数初始化，使用getInstance获得单例
		public function ASActionManager(enforcer:SingletonEnforcer){
			dict = new Dictionary(true)
		}

		public static function getInstance() : ASActionManager{
			if(m_manager == null){
				m_manager = new ASActionManager(new SingletonEnforcer())
			}
			return m_manager
		}

		//加入一个Action
		public function addActionWithTarget(act:ASAction, 
			target:DisplayObject) : void{
			if(target == null || act == null){
				throw new Error("target or action should not be null")
			}

			if(dict[target] == null){
				dict[target] = new ActionNode(target)
			}
			dict[target].addAction(act)
		}

		//去掉所有action
		public function removeAllActions() : void{
			for (var key:Object in dict){
				delete dict[key]
			}
		}

		//去掉target持有的所有action
		public function removeAllActionsFromTarget(
			target:DisplayObject) : void{
			if(target == null)
				return

			delete dict[target]
		}

		//去掉特定的action
		public function removeAction(act:ASAction) : void{
			if(act == null)
				return

			var actNode:ActionNode = dict[act.getTarget()]
			if(actNode != null){
				actNode.removeAction(act)
			}
		}

		//去掉target中标签为tag的action
		public function removeActionByTag(tag:int, target:DisplayObject)
		 : void{
		 	if(target == null)
		 		return

		 	var actNode:ActionNode = dict[target]
			if(actNode != null){
				actNode.removeActionByTag(tag)
			}
		}

		//根据target中标签为tag的action
		public function getActionByTag(tag:int, target:DisplayObject) : ASAction{
			if(target == null)
				return null

			var actNode:ActionNode = dict[target]
			if(actNode != null){
				return actNode.getActionByTag(tag)
			}

			return null
		}

		//返回target持有的action数量
		public function getNumberOfRunningActionsInTarget(
			target:DisplayObject) : int{
			if(target == null)
				return 0

			var actNode:ActionNode = dict[target]
			if(actNode != null){
				return actNode.getNumberOfActions()
			}

			return 0
		}

		//暂停target的动作
		public function pauseTarget(target:DisplayObject) : void{
			if(target == null)
				return
			var actNode:ActionNode = dict[target]
			if(actNode != null){
				actNode.setIsPaused(true)
			}
		}

		//恢复target的动作
		public function resumeTarget(target:DisplayObject) : void{
			if(target == null)
				return

			var actNode:ActionNode = dict[target]
			if(actNode != null){
				actNode.setIsPaused(false)
			}
		}

		//暂停所有运行中的action，返回被暂停动作的target列表
		public function pauseAllRunningActions() : Vector.<DisplayObject>{
			var targets:Vector.<DisplayObject> = new Vector.<DisplayObject>()

			for each(var actNode:ActionNode in dict){
				if(actNode.getIsPaused() == false){
					actNode.setIsPaused(false)
					targets.push(actNode.getTarget())
				}
			}
			return targets
		}

		//恢复一系列target的action
		public function resumeTargets(targets:Vector.<DisplayObject>) : void{
			for(var i:int = 0; i < targets.length; i++){
				this.resumeTarget(targets[i])
			}
		}

		//更新动作
		public function update(dt:Number = 0.041666667/* 1.0 / 24 */){
			/*var cnt:int = 0
			for (var key:Object in dict)
				cnt+=1
			trace("cnt: " + cnt)
			*/
			for(var key:Object in dict){
				var actNode:ActionNode = dict[key]
				if(actNode.getIsPaused() == false){
					actNode.update(dt)
				}

				if(actNode.getNumberOfActions() <= 0){
					delete dict[key]
				}
			}
		}
	}
}

import flash.display.*
import utils.action.*
//辅助类。由于AS3不支持构造函数声明为public, 声明此类用于实现singleton
class SingletonEnforcer{}

//一个target对应多个action
class ActionNode{
	public var m_target:DisplayObject
	public var m_actions:Vector.<ASAction>
	public var m_isPaused:Boolean

	public function ActionNode(target:DisplayObject, isPaused:Boolean = false){
		m_target = target
		m_actions = new Vector.<ASAction>
		m_isPaused = isPaused
	}

	public function getTarget() : DisplayObject{
		return m_target
	}

	public function setIsPaused(isPaused:Boolean) : void{
		m_isPaused = isPaused
	}

	public function getIsPaused() : Boolean{
		return m_isPaused
	}

	public function addAction(act:ASAction) : void{
		if(m_actions.indexOf(act) == -1){
			act.startWithTarget(m_target)
			m_actions.push(act)		
		}
		else{
			throw new Error("should not run the action twice")
		}
	}

	public function removeAction(act:ASAction) : void{
		var index:int = m_actions.indexOf(act)
		if(index != -1){
			m_actions.splice(index, 1)
		}
	}

	public function removeActionByTag(tag:int) : void{
		var index:int = -1
		for(var i:int = 0; i < m_actions.length; i++){
			if(m_actions[i].getTag() == tag){
				index = i
				break
			}
		}

		if(index != -1){
			m_actions.splice(index, 1)
		}
	}

	public function getActionByTag(tag:int) : ASAction{
		var index:int = -1
		for(var i:int = 0; i < m_actions.length; i++){
			if(m_actions[i].getTag() == tag){
				return m_actions[i]
			}
		}
		return null
	}

	public function getNumberOfActions() : int{
		return m_actions.length
	}

	public function update(dt:Number) : void{
		for(var i:int = 0; i < m_actions.length; ){
			var act:ASAction = m_actions[i]
			if(act == null){
				m_actions.splice(i, 1)
				continue
			}

			act.step(dt)

			//完成后清除动作
			if(act.isDone()){
				//act.step(1)
				act.stop()
				m_actions.splice(i, 1)
				continue
			}
			//如果删除过元素，不+1
			i++
		}
	}
}