package utils.action.instant{
	import utils.action.ASFiniteTimeAction
	import flash.display.DisplayObject

	public class ASToggleVisibility extends ASActionInstant{
		public function ASToggleVisibility() {

		}

		override public function update(percent:Number) : void{
			m_target.visible = !m_target.visible
			m_isDone = true
		}

		override public function reverse() : Object{
			return this.clone()
		}

		override public function clone() : Object{
			return new ASToggleVisibility()
		}
	}
}