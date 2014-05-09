package utils.action.instant{

	//调用一个函数
	public class ASCallFunc extends ASActionInstant{
		protected var m_function:Object

		public function ASCallFunc(func:Object){
			m_function = func
		}

	 	override public function update(percent:Number) : void{
	 		m_function()
	 		m_isDone = true
	 	}

	 	override public function reverse() : Object{
	 		return this.clone()
	 	}

	 	override public function clone() : Object{
	 		return new ASCallFunc(m_function)
	 	}
	}
}