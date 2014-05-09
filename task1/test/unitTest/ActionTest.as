package test.unitTest{
	import asunit.framework.TestCase
	import action.*
	import flash.display.*
	import flash.events.*
	import flash.geom.Point;

	public class ActionTest extends TestCase{
		protected var mc1:MovieClip
		protected static const dt:Number = 1.0 / 24

		public function ActionTest(testMethod:String){
			super(testMethod)
		}

		protected override function setUp() : void{
			mc1 = new MovieClip()
		}

		public function testMoveBy() : void{
			mc1.x = 100
			mc1.y = 100
			var act:ASActionInterval = new ASMoveBy(1, new Point(100, 100))
			act.startWithTarget(mc1)
			while(!act.isDone())
				act.step(dt)

			assertEquals("",new Point(200,200), new Point(mc1.x, mc1.y))
		}

		public function testMoveTo() : void{
			mc1.x = 100
			mc1.y = 100

			var dst:Point = new Point(45, 76)

			var act:ASActionInterval = new ASMoveTo(1, new Point(45, 76))
			act.startWithTarget(mc1)

			while(!act.isDone())
				act.step(dt)

			assertEquals("", dst, new Point(mc1.x, mc1.y))
		}

		public function testScaleBy() : void {
			mc1.scaleX = 4
			mc1.scaleY = 2

			var act:ASActionInterval = new ASScaleBy(1, 0.5, 2)
			act.startWithTarget(mc1)

			while(!act.isDone())
				act.step(dt)

			assertEquals("", new Point(2, 4), 
				new Point(mc1.scaleX, mc1.scaleY))
		}

		public function testRotateBy() : void{
			mc1.rotationZ = 0
			mc1.rotationX = 20
			mc1.rotationY = 300

			var act:ASActionInterval = new ASRotateBy(1, 50, 20, 30)
			act.startWithTarget(mc1)

			while(!act.isDone())
				act.step(dt)


			assertEquals(50, mc1.rotationZ)
			assertEquals(40, mc1.rotationX)
			assertEquals(330, mc1.rotationY)
		}

		public function testRotateTo() : void{
			mc1.rotationZ = 0
			mc1.rotationX = 20
			mc1.rotationY = 300

			var act:ASActionInterval = new ASRotateTo(1, 50, 20, 30)
			act.startWithTarget(mc1)

			while(!act.isDone())
				act.step(dt)


			assertEquals(50, mc1.rotationZ % 360)
			assertEquals(20, mc1.rotationX % 360)
			assertEquals(30, mc1.rotationY % 360)
		}

		public function testJumpBy() : void{
			mc1.x = 10
			mc1.y = 20

			var delta:Point = new Point(45, 76)
			var act:ASActionInterval = new ASJumpBy(1, delta, 50, 5)
			act.startWithTarget(mc1)

			while(!act.isDone())
				act.step(dt)

			assertEquals("",new Point(55, 96), new Point(mc1.x, mc1.y))
		}

		public function testFadeTo() : void{
			mc1.alpha = 0.5

			var act:ASActionInterval = new ASFadeTo(1, 0.8)
			act.startWithTarget(mc1)

			while(!act.isDone())
				act.step(dt)

			assertEquals(0.8, mc1.alpha)
		}


	}
}