package utils.action.instant{
	import utils.action.ASFiniteTimeAction
	import flash.display.DisplayObject

	public class ASShow extends ASActionInstant{
		public function ASShow() {

		}

		override public function update(percent:Number) : void{
			m_target.visible = true
			m_isDone = true
		}

		override public function reverse() : Object{
			return new ASHide()
		}

		override public function clone() : Object{
			return new ASShow()
		}
	}
}