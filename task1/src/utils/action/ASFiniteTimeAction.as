package utils.action{
	//限时动作的基类，派生出ASActionInterval 和 ASActionInstant
	public class ASFiniteTimeAction extends ASAction {
		//动作持续的时间
		protected var m_duration:Number 

		public function ASFiniteTimeAction(){
			m_duration = 0.0
		}

		public function setDuration(duration:Number) : void{
			m_duration = duration
		}
		
		public function getDuration() : Number{
			return m_duration
		}
	}
}