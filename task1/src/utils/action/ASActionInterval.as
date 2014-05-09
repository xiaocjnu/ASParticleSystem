package utils.action{
	import flash.display.*
	
	// 常用限时动作类的基类，实现了step方法
	public class ASActionInterval extends ASFiniteTimeAction{
		public static const FLT_EPSILON:Number = 1.192092896e-07

		//动作已经运行的时间
		protected var m_elapsed:Number

		public function ASActionInterval(duration:Number){
			//防止出现除0错误
			if(duration < FLT_EPSILON)
				this.setDuration(FLT_EPSILON)
			else
				this.setDuration(duration)

			m_elapsed = 0
		}

		override public function isDone() : Boolean{
			return m_elapsed >= m_duration
		}

		override public function step(dt:Number) : void{
			m_elapsed += dt

			//update接受的参数范围为[0, 1]
			this.update(Math.max(0, Math.min(1, m_elapsed / m_duration)))
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_elapsed = 0.0
		}
	}
}