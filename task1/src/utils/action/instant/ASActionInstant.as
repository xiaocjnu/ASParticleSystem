package utils.action.instant{
	import utils.action.ASFiniteTimeAction
	import flash.display.DisplayObject

	public class ASActionInstant extends ASFiniteTimeAction{
		protected var m_isDone:Boolean

		public function ASActionInstant(){
			super()
			m_isDone = false
		}

		override public function isDone() : Boolean{
			return m_isDone
		}

		override public function startWithTarget(target : DisplayObject) : void{
			super.startWithTarget(target)
			m_isDone = false
		}

		override public function step(dt:Number) : void{
			this.update(1)
			m_isDone = true
		}

	}

}