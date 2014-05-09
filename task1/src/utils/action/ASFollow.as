package utils.action{
	import flash.display.DisplayObject
	import flash.geom.Rectangle

	//跟随一个精灵运动。
	public class ASFollow extends ASAction{
		var m_followedNode:DisplayObject
		var m_offsetX:Number
		var m_offsetY:Number
		var m_bound:Rectangle

		/*
		@ followedNode: 待跟随的精灵
		@ bound : 跟随者的运动范围
		@ offsetX : 相对精灵的X轴偏移量
		@ offsetY : 相对精灵的Y轴偏移量
		*/
		public function ASFollow(followedNode:DisplayObject, bound:Rectangle = null, offsetX:Number = -100, offsetY:Number = 0){
			m_followedNode = followedNode
			m_offsetX = offsetX
			m_offsetY = offsetY
			m_bound = bound
		}

		override public function step(dt:Number) : void{
			if(m_followedNode && m_target){
				m_target.x = m_followedNode.x + m_offsetX
				m_target.y = m_followedNode.y + m_offsetY
				if(m_bound){
					m_target.x = Math.max(Math.min(m_bound.right, m_target.x), m_bound.x)
					m_target.y = Math.max(Math.min(m_bound.bottom, m_target.y), m_bound.y)
				}
			}
		}

		override public function isDone() : Boolean{
			return ASActionManager.getInstance().
				getNumberOfRunningActionsInTarget(m_followedNode) == 0
		}

		override public function clone() : Object{
			return new ASFollow(m_followedNode)
		}

		override public function reverse() : Object{
			return this.clone()
		}
	}
}