package utils.action.instant{
	import utils.action.ASFiniteTimeAction
	import flash.display.DisplayObject

	public class ASRemoveSelf extends ASActionInstant{
		public function ASRemoveSelf(){

		}

		override public function update(percent:Number) : void{
			m_target.parent.removeChild(m_target)
			m_isDone = true
		}

		override public function reverse() : Object{
			return new ASRemoveSelf()
		}

		override public function clone() : Object{
			return new ASRemoveSelf()
		}
	}
}