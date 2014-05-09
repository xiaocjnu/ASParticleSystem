package utils.action{
	import flash.display.DisplayObject
	import flash.geom.Point

	public class ASBezierTo extends ASBezierBy{
		protected var m_toConPoint1:Point
		protected var m_toConPoint2:Point
		protected var m_toEndPoint:Point

		public function ASBezierTo(duration:Number, controlPoint1:Point,
			controlPoint2:Point, endPoint:Point){
			super(duration, controlPoint1.clone(), controlPoint2.clone(),
				 endPoint.clone())

			m_toConPoint1 = controlPoint1
			m_toConPoint2 = controlPoint2
			m_toEndPoint = endPoint
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_controlPoint1 = m_toConPoint1.subtract(m_startPoint)
			m_controlPoint2 = m_toConPoint2.subtract(m_startPoint)
			m_endPoint = m_toEndPoint.subtract(m_startPoint)
		}

		override public function clone() : Object{
			return new ASBezierTo(m_duration, m_toConPoint1.clone(), 
				m_toConPoint2.clone(), m_toEndPoint.clone())
		}

		override public function reverse() : Object{
			throw new Error("Reverse is not supported in ASBezierTo")
			return null
		}
	}
}
