package utils.action.instant{
	import flash.display.DisplayObject

	//调用一个以精灵作为参数的函数
	public class ASCallFuncN extends ASActionInstant{
		protected var m_function:Object

		public function ASCallFuncN(func:Object){
			m_function = func
		}

	 	override public function update(percent:Number) : void{
	 		m_function(m_target)
	 		m_isDone = true
	 	}

	 	override public function reverse() : Object{
	 		return this.clone()
	 	}

	 	override public function clone() : Object{
	 		return new ASCallFuncN(m_function)
	 	}
	}
}