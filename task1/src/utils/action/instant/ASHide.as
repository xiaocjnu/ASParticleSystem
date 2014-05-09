package utils.action.instant{
	import utils.action.ASFiniteTimeAction
	import flash.display.DisplayObject

	public class ASHide extends ASActionInstant{
		public function ASHide() {

		}

		override public function update(percent:Number) : void{
			m_target.visible = false
			m_isDone = true
		}

		override public function reverse() : Object{
			return new ASShow()
		}

		override public function clone() : Object{
			return new ASHide()
		}
	}
}