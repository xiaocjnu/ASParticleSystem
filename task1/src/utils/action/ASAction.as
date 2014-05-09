package utils.action{
	import flash.display.*
	import utils.action.iface.*

	//动作类的基类
	public class ASAction extends Object implements Cloneable, Reverseable{
		protected var m_target:DisplayObject
		protected var m_tag:int

		public function ASAction(){
			m_target = null
			m_tag = -1
		}
		
		//动作完成后返回true
		public function isDone() : Boolean{
			return true
		}

		//abstract
		public function clone() : Object{
			//to do
			throw new Error("should override this method")
			return null
		}

		//abstract
		public function reverse() : Object{
			//to do
			throw new Error("should override this method")
			return null
		}

		public function startWithTarget(target:DisplayObject) : void{
			this.setTarget(target)
		}

		public function stop() : void{
			m_target = null
		}

		//每一帧调用该方法，参数dt为这一帧经过的时间
		public function step(dt:Number) : void{
			throw new Error("should override this method")
		}

		//abstract，由具体的动作类实现。参数percent为动作已完成的百分比
		public function update(percent:Number) : void{

		}

		protected function setTarget(target:DisplayObject) : void{
			this.m_target = target
		}		

		public function getTarget() : DisplayObject{
			return this.m_target
		}

		public function getTag() : int{
			return m_tag
		}

		public function setTag(tag:int) : void{
			m_tag = tag
		}
	}
}