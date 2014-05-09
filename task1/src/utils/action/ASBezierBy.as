package utils.action{
	import flash.display.DisplayObject
	import flash.geom.Point

	//输入两个控制点和一个终点，精灵走贝塞尔曲线
	public class ASBezierBy extends ASActionInterval{
		protected var m_controlPoint1:Point
		protected var m_controlPoint2:Point
		protected var m_endPoint:Point
		protected var m_startPoint:Point

		public function ASBezierBy(duration:Number, controlPoint1:Point, 
			controlPoint2:Point, endPoint:Point){
			super(duration)
			m_controlPoint1 = controlPoint1
			m_controlPoint2 = controlPoint2
			m_endPoint = endPoint
		}

		override public function startWithTarget(target:DisplayObject) : void{
			super.startWithTarget(target)
			m_startPoint = new Point(target.x, target.y)
		}

		//(1 - t)^3*x0 + 3t(1-t)^2*x1 + 3t^2(1 - t)*x2 + t^3*x3
		private function bezierat(x0:Number, x1:Number, x2:Number, x3:Number,
			dt:Number) : Number{
			return Math.pow(1 - dt, 3)*x0 + 3*dt*Math.pow(1 - dt, 2)*x1 + 
				3*dt*dt*(1 - dt)*x2 + dt * dt * dt * x3
		}

		override public function update(percent:Number) : void{
			if(m_target){
				var x:Number = bezierat(0, m_controlPoint1.x,
					 m_controlPoint2.x, m_endPoint.x, percent)
				var y:Number = bezierat(0, m_controlPoint1.y, 
					 m_controlPoint2.y, m_endPoint.y, percent)

				m_target.x = m_startPoint.x + x
				m_target.y = m_startPoint.y + y
			}
		}

		override public function clone() : Object{
			return new ASBezierBy(m_duration, m_controlPoint1.clone(), 
				m_controlPoint2.clone(), m_endPoint.clone())
		}

		override public function reverse() : Object{
			return new ASBezierBy(m_duration, 
				new Point(m_controlPoint1.x - m_endPoint.x, m_controlPoint1.y - m_endPoint.y),
				new Point(m_controlPoint2.x - m_endPoint.x, m_controlPoint2.y - m_endPoint.y),
				new Point(-m_endPoint.x, -m_endPoint.y))
		}
	}
}