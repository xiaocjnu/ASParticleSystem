package utils.action.ease{
	import utils.action.ASActionInterval
	import flash.display.DisplayObject

	//变速Action的基类，复合一个action
	public class ASActionEase extends ASActionInterval{
		protected var m_action:ASActionInterval

		public function ASActionEase(action:ASActionInterval){
			super(action.getDuration())
			m_action = action
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_action.startWithTarget(target)
		}

		//调整更新速率的辅助函数，子类重写该函数
		protected function tweenFunc(percent:Number) : Number{
			return percent
		}

		override public function update(percent:Number) : void{
			m_action.update(tweenFunc(percent))
		}

		override public function stop() : void{
			super.stop()
			m_action.stop()
		}

		public function getInnerAction() : ASActionInterval{
			return m_action
		}

		override public function clone() : Object{
			throw new Error("should override this method")
			return null
		}	

		override public function reverse() : Object{
			throw new Error("should override this method")
			return null
		}
	}
}