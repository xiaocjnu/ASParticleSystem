package utils.action{
	import flash.display.*

	//闪烁动作
	public class ASBlink extends ASActionInterval{
		protected var m_blinks:int
		//一次闪烁的间隔(%)
		protected var m_slice:Number
		protected var m_startVisible:Boolean

		public function ASBlink(duration:Number, blinks:int){
			if(blinks < 1)
				blinks = 1

			super(duration)
			m_blinks = blinks
			m_slice = 1.0 / m_blinks
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_startVisible = target.visible
		}

		override public function update(percent:Number) : void{
			if(m_target){
				//m在[0, slice]之间
				var m:Number = percent % m_slice
				//小于slice的一半时显示，否则隐藏
				if(m * 2 > m_slice)
					m_target.visible = true
				else
					m_target.visible = false
			}
		}

		override public function stop() : void{
			if(m_target)
				m_target.visible = m_startVisible
			super.stop()
		}

		override public function clone() : Object{
			return new ASBlink(m_duration, m_blinks)
		}

		override public function reverse() : Object{
			return this.clone()
		}
	}
}