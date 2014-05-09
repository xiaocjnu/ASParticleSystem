package test{
	import utils.action.*
	import utils.action.ease.*
	import utils.action.instant.*
	import flash.display.*; 
	import flash.net.*
	import flash.events.*
	import flash.geom.*
	import flash.text.*
	import fl.controls.Button
	import flash.utils.Timer

	public class ActionDemo extends Object{
		protected var m_currentIndex:int
		protected var m_stage:Stage

		protected var m_lhsprite:Sprite
		protected var m_mhsprite:Sprite
		protected var m_rhsprite:Sprite

		protected const m_duration:Number = 2


		protected const m_actionName:Array = new Array("welcome",
			"move", "scale", "rotate", "jump", "blink", "fade", "tint", "bezier",
			"repeat", "sequence", "spawn", "delay", "ease", "easeExpo", "easeSine",
			"easeElastic",  "easeBack","speed", "follow")

		protected const m_lhsURL:String = "resource/sprite1.jpg"
		protected const m_mhsURL:String = "resource/sprite2.jpg"
		protected const m_rhsURL:String = "resource/sprite3.jpg"

		protected var m_manager:ASActionManager = ASActionManager.getInstance()

		protected var m_title:TextField

		//
		protected var m_lhsColor:ColorTransform 
		protected var m_mhsColor:ColorTransform
		protected var m_rhsColor:ColorTransform

		//去除测试内监听器的标记
		protected var m_isStop:Boolean

		//中心点设置为图片中心
		private function completeHandler(event:Event, loader:Loader) :void {
        	loader.x = -loader.width / 2
			loader.y = -loader.height / 2
        }

        //将图片加载入精灵中
        private function loadPictureWithSprite(sprite:Sprite, url:String) : void{
        	var pict:Loader = new Loader()
        	pict.load(new URLRequest(url))
        	pict.contentLoaderInfo.addEventListener(Event.COMPLETE, 
				function (e:Event){completeHandler(e, pict)});
			sprite.addChild(pict)
        }

        //初始化3个精灵
        private function initSprites(){
        	m_rhsprite = new Sprite()
			this.loadPictureWithSprite(m_rhsprite, m_rhsURL)
			m_rhsColor = m_rhsprite.transform.colorTransform
			m_stage.addChild(m_rhsprite)

        	m_lhsprite = new Sprite()
			this.loadPictureWithSprite(m_lhsprite, m_lhsURL)
			m_lhsColor = m_lhsprite.transform.colorTransform
			m_stage.addChild(m_lhsprite)

			m_mhsprite = new Sprite()
			this.loadPictureWithSprite(m_mhsprite, m_mhsURL)
			m_mhsColor = m_mhsprite.transform.colorTransform
			m_stage.addChild(m_mhsprite)
        }

        //初始化标题
        private function initTextField(){
        	m_title = new TextField()
			
			m_title.x = m_stage.stageWidth / 2 - 50
			var format:TextFormat = new TextFormat()
			format.size = 30
			format.color = 0xFFFFFF;
			m_title.defaultTextFormat = format
			m_title.text = "ActionTest Demo"
			m_title.autoSize = TextFieldAutoSize.CENTER
			m_stage.addChild(m_title)
        }

        //初始化按钮
        private function initButtons(){
        	var format:TextFormat = new TextFormat()
			format.size = 12
			format.color = 0xFFFFFF

        	var bprev:Button = new Button()
        	bprev.move(m_stage.stageWidth / 4 - 50, m_stage.stageHeight - 30)
        	bprev.label = "Previous"
        	bprev.setStyle("textFormat", format)
        	m_stage.addChild(bprev)
        	bprev.addEventListener(MouseEvent.CLICK, onPrevClick, false, 0, true)

        	var brestart:Button = new Button()
        	brestart.move(m_stage.stageWidth / 2 - 50, m_stage.stageHeight - 30)
        	brestart.label = "Restart"
        	brestart.setStyle("textFormat", format)
        	m_stage.addChild(brestart)
        	brestart.addEventListener(MouseEvent.CLICK, onRestartClick, false, 0, true)


        	var bnext:Button = new Button()
        	bnext.move(m_stage.stageWidth * 3 / 4 - 50, m_stage.stageHeight - 30)
        	bnext.label = "Next"
        	bnext.setStyle("textFormat", format)
        	m_stage.addChild(bnext)
        	bnext.addEventListener(MouseEvent.CLICK, onNextClick, false, 0, true)
        }

		public function ActionDemo(stage:Stage){
			m_isStop = true
			m_currentIndex = 0
			m_stage = stage

			initTextField()

			initSprites()

			restoreSprite()

			initButtons()

			m_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame)

			//doWelcome()
			//doCustormTest()
			doEaseBackTest()
		}

		function onEnterFrame(e:Event):void{
			var manager:ASActionManager = ASActionManager.getInstance()
			manager.update(1.0 / m_stage.frameRate)
		}

		public function stop() {
			m_stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame)
		}

		public function restoreSprite(kind:int = 0){
			//actionInterval 展示
			if(0 == kind){
				m_lhsprite.x = m_stage.stageWidth / 4
				m_lhsprite.y = m_stage.stageHeight / 2

				m_mhsprite.x = m_stage.stageWidth / 2
				m_mhsprite.y = m_stage.stageHeight / 2

				m_rhsprite.x = 3 * m_stage.stageWidth / 4
				m_rhsprite.y = m_stage.stageHeight / 2
			}
			// actionEase 展示
			else if(1 == kind){
				m_lhsprite.x = m_stage.stageWidth / 5
				m_lhsprite.y = m_stage.stageHeight / 4

				m_mhsprite.x = m_lhsprite.x
				m_mhsprite.y = m_stage.stageHeight / 2

				m_rhsprite.x = m_lhsprite.x
				m_rhsprite.y = 3 * m_stage.stageHeight / 4
			}


			m_lhsprite.scaleX = 0.5
			m_lhsprite.scaleY = 0.5
			m_lhsprite.rotationX = m_lhsprite.rotationY = m_lhsprite.rotationZ = 0
			m_lhsprite.transform.colorTransform = m_lhsColor

			m_mhsprite.scaleX = 0.35
			m_mhsprite.scaleY = 0.35
			m_mhsprite.rotationX = m_mhsprite.rotationY = m_mhsprite.rotationZ = 0
			m_mhsprite.transform.colorTransform = m_mhsColor

			m_rhsprite.scaleX = 0.25
			m_rhsprite.scaleY = 0.25
			m_rhsprite.rotationX = m_rhsprite.rotationY = m_rhsprite.rotationZ = 0
			m_rhsprite.transform.colorTransform = m_rhsColor

			m_lhsprite.visible = m_mhsprite.visible = m_rhsprite.visible = true
			m_lhsprite.alpha = m_mhsprite.alpha = m_rhsprite.alpha = 1
			m_manager.removeAllActions()

			m_isStop = true
		}

		public function onNextClick(e:Event) : void{
			m_currentIndex = (m_currentIndex + 1) % m_actionName.length
			restoreSprite()
			doActionTest(m_currentIndex)
		}

		public function onPrevClick(e:Event) : void{
			m_currentIndex = (m_currentIndex - 1 + m_actionName.length) 
				% m_actionName.length
			restoreSprite()
			doActionTest(m_currentIndex)
		}

		public function onRestartClick(e:Event) : void{
			restoreSprite()
			doActionTest(m_currentIndex)
		}

		public function doActionTest(index:int) : void{
			var actName:String = m_actionName[index]
			//"move", "scale", "rotate", "jump", "blink", "fade", "tint", "bezier",
			//"repeat", "sequence", "spawn", "delay")
			if(actName == "welcome"){
				doWelcome()
			}
			else if(actName == "move"){
				doMoveTest()
			}
			else if(actName == "scale"){
				doScaleTest()
			}
			else if(actName == "rotate"){
				doRotateTest()
			}
			else if(actName == "jump"){
				doJumpTest()
			}
			else if(actName == "blink"){
				doBlinkTest()
			}
			else if(actName == "fade"){
				doFadeTest()
			}
			else if(actName == "tint"){
				doTintTest()
			}
			else if(actName == "bezier"){
				doBezierTest()
			}
			else if(actName == "repeat"){
				doRepeatTest()
			}
			else if(actName == "sequence"){
				doSequenceTest()
			}
			else if(actName == "spawn"){
				doSpawnTest()
			}
			else if(actName == "delay"){
				doDelayTest()
			}
			else if(actName == "ease"){
				doEaseTest()
			}
			else if(actName == "easeExpo"){
				doEaseExpoTest()
			}
			else if(actName == "easeSine"){
				doEaseSineTest()
			}
			else if(actName == "easeElastic"){
				doEaseElasticTest()
			}
			else if(actName == "easeBack"){
				doEaseBackTest()
			}
			else if(actName == "speed"){
				doSpeedTest()
			}
			else if(actName == "follow"){
				doFollowTest()
			}
		}

		public function doCustormTest() : void{
			m_title.text = "CustormTest"

			

			//var act1:ASActionInterval = new ASShake(1, 20, 10)
			//m_manager.addActionWithTarget(act1, m_lhsprite)

			//var act1:ASActionInterval = new ASMoveBy(0.5, new Point(0, 0))
			//跳跃前进动作
			var act2:ASActionInterval = new ASJumpBy(0.5, new Point(0, 0), 20, 1)
			var act3:ASActionInterval = new ASScaleBy(0.25, 1.15, 1.15)
			var act4:ASActionInterval = ASActionInterval(act3.reverse())
			var seq:ASActionInterval = new ASSpawn(act2, new ASSequence(act3, act4))

			m_manager.addActionWithTarget(new ASRepeatForever(seq), m_lhsprite)

			//攻击效果
			/*var a0:ASActionInterval = new ASRotateBy(0, 30)
			var a1:ASActionInterval = new ASRotateBy(0.25, -60)
			var a2:ASActionInterval = new ASRotateBy(0.25, 30)
			var a3:ASActionInterval = new ASScaleBy(0.25, 1.15, 1.15)
			var a4:ASActionInterval = ASActionInterval(a3.reverse())
			var spawn:ASActionInterval = new ASSpawn(new ASSequence(a0, a1, a2), new ASSequence(a3, a4))
			m_manager.addActionWithTarget(new ASRepeatForever(spawn), m_lhsprite)*/

			//选中效果
			m_rhsprite.scaleY = m_rhsprite.scaleX = 0.2
			var m0:ASActionInterval = new ASScaleBy(0.5, 2, 2)
			var m1:ASActionInterval = new ASMoveTo(0.5, new Point(m_mhsprite.x, m_mhsprite.y))
			var m2:ASActionInstant = new ASToggleVisibility()
			var m3:ASActionInstant = new ASCallFunc(function (){trace ("hello")})
			m_manager.addActionWithTarget(new ASSpawn(m0, m1, m3), m_rhsprite)

			//隐藏
			var hide:ASActionInstant = new ASHide()
			m_manager.addActionWithTarget(hide, m_mhsprite)


		}

		public function doWelcome() : void{
			m_title.text = "ActionTest"
		}

		public function doMoveTest() : void{
			m_title.text = "ASMoveBy / ASMoveTo"

			var act1:ASActionInterval = new ASMoveTo(m_duration, new Point(
				m_stage.stageWidth - 80, m_stage.stageHeight - 80))
			var act2:ASActionInterval = new ASMoveBy(m_duration, new Point(180, -180))
			var act3:ASActionInterval = new ASMoveTo(m_duration, new Point(80, 80))


			m_manager.addActionWithTarget(act1, m_lhsprite)
			m_manager.addActionWithTarget(new ASSequence(act2, 
				ASActionInterval(act2.reverse())), m_mhsprite)
			m_manager.addActionWithTarget(act3, m_rhsprite)
		}

		public function doScaleTest() : void{
			m_title.text = "ASScaleBy / ASScaleTo"

			var act1:ASActionInterval = new ASScaleTo(m_duration, 0.2, 0.2)
			var act2:ASActionInterval = new ASScaleBy(m_duration, 1, 10)
			var act3:ASActionInterval = new ASScaleBy(m_duration, 5, 1)

			m_manager.addActionWithTarget(act1, m_lhsprite)
			m_manager.addActionWithTarget(new ASSequence(act2, 
				ASActionInterval(act2.reverse())), m_mhsprite)
			m_manager.addActionWithTarget(new ASSequence(act3,
				ASActionInterval(act3.reverse())), m_rhsprite)
		}

		public function doRotateTest() :  void{
			m_title.text = "ASRotateBy / ASRotateTo"

			var act1:ASActionInterval = new ASRotateTo(m_duration, 180, 180, 0)
			var act2:ASActionInterval = new ASRotateBy(m_duration, 180, 0, 0)
			var act3:ASActionInterval = new ASRotateBy(m_duration, 0, 0, 180)
			var act4:ASActionInterval = new ASRotateBy(m_duration, 150, 150, 150)

			m_manager.addActionWithTarget(new ASSequence(act1, act4), m_lhsprite)
			m_manager.addActionWithTarget(new ASRepeatForever(act2), m_mhsprite)
			m_manager.addActionWithTarget(new ASRepeatForever(act3), m_rhsprite)

		}

		public function doJumpTest() : void{
			m_title.text = "ASJumpBy / ASJumpTo"

			var act1:ASActionInterval = new ASJumpTo(m_duration, new Point(
				m_stage.stageWidth - 80, 80),
				100, 3)
			var act2:ASActionInterval = new ASJumpBy(m_duration, new Point(200, -200),
				80, 2)
			var act3:ASActionInterval = new ASJumpBy(m_duration, new Point(0, 0),
				100, 3)

			m_manager.addActionWithTarget(act1, m_lhsprite)
			m_manager.addActionWithTarget(new ASSequence(act2, ASActionInterval(
				act2.reverse())), m_mhsprite)
			m_manager.addActionWithTarget(new ASRepeatForever(act3), m_rhsprite)
		}

		public function doBlinkTest() : void{
			m_title.text = "ASBlink"

			m_lhsprite.visible = false
			m_rhsprite.visible = false

			var act2:ASActionInterval = new ASBlink(m_duration, 5)
			m_manager.addActionWithTarget(act2, m_mhsprite)
		}

		public function doFadeTest() : void{
			m_title.text = "ASFadeTo/ASFadeIn/ASFadeOut"

			var act1:ASActionInterval = new ASFadeIn(m_duration)
			var act2:ASActionInterval = new ASFadeTo(m_duration, 0.3)
			var act3:ASActionInterval = new ASFadeOut(m_duration)

			m_lhsprite.alpha = 0
			m_manager.addActionWithTarget(new ASSequence(act1, act3.clone()), m_lhsprite)
			m_manager.addActionWithTarget(act2, m_mhsprite)
			m_manager.addActionWithTarget(new ASSequence(act3, act1.clone()), m_rhsprite)
		}

		public function doTintTest() : void{
			m_title.text = "ASTintBy / ASTintTo"

			m_mhsprite.visible = false

			var act1:ASActionInterval = new ASTintTo(m_duration, 255, 0, 255)
			var act3:ASActionInterval = new ASTintBy(m_duration, -127, -255, -127)

			m_manager.addActionWithTarget(act1, m_lhsprite)
			m_manager.addActionWithTarget(new ASSequence(act3, 
				ASActionInterval(act3.reverse())), m_rhsprite)
		}

		public function doBezierTest() : void{
			m_title.text = "ASBezierBy / ASBezierTo"

			m_mhsprite.visible = false

			var act1:ASBezierBy = new ASBezierBy(m_duration, 
				new Point(80, -150),
				new Point(250, -280), 
				new Point(300, 0))

			var act3:ASBezierTo = new ASBezierTo(m_duration, 
				new Point(m_stage.stageWidth / 2, m_stage.stageHeight / 3),
				new Point(m_stage.stageWidth / 3, m_stage.stageHeight / 2), 
				new Point(80,  m_stage.stageHeight - 80))

			m_manager.addActionWithTarget(act1, m_lhsprite)
			m_manager.addActionWithTarget(act3, m_rhsprite)
		}

		public function doRepeatTest() : void{
			m_title.text = "ASRepeat / ASRepeatForever"

			m_rhsprite.visible = false
			
			var act1:ASActionInterval = new ASRepeat(
				new ASSequence(
					new ASMoveBy(m_duration, new Point(m_stage.stageWidth / 2, 0)),
					new ASMoveBy(0, new Point(-m_stage.stageWidth / 2, 0)))
					, 
				3)

			var act2:ASActionInterval = new ASRepeatForever(
				new ASRotateBy(m_duration, 180, 180, 180))

			m_manager.addActionWithTarget(act1, m_lhsprite)
			m_manager.addActionWithTarget(act2, m_mhsprite)
		}

		public function doSequenceTest() : void{
			m_title.text = "ASSequence"

			m_mhsprite.visible = false
			//m_rhsprite.visible = false
			m_rhsprite.y -= 100

			var act1:ASActionInterval = new ASMoveBy(1, new Point(150, 0))
			var act2:ASActionInterval = new ASJumpTo(1, 
				new Point(m_rhsprite.x, m_rhsprite.y + 100), 100, 2)
			var act3:ASActionInterval = new ASBlink(1, 3)
			var act4:ASActionInterval = new ASRotateBy(0.8, 90, 0, 0)
			var act5:ASActionInterval = new ASFadeOut(2)
			var seq:ASActionInterval = new ASSequence(act1, act2, act3, act4, act5)

			m_manager.addActionWithTarget(seq, m_lhsprite)
		}

		public function doSpawnTest() : void{
			m_title.text = "ASSpawn"

			m_lhsprite.visible = false
			m_rhsprite.visible = false

			var act1:ASActionInterval = new ASBlink(m_duration, 4)
			var act2:ASActionInterval = new ASScaleBy(m_duration, 2.0, 2.0)
			var act3:ASActionInterval = new ASRotateBy(m_duration, 360, 0, 0)

			var spawn:ASActionInterval = new ASSpawn(act1, act2, act3)
			m_manager.addActionWithTarget(spawn, m_mhsprite)
		}

		public function doDelayTest() : void{
			m_title.text = "ASDelayTime"

			m_mhsprite.visible = false
			m_rhsprite.visible = false

			var act1:ASActionInterval = new ASMoveBy(1, new Point(150, 0))
			var delay:ASActionInterval = new ASDelayTime(m_duration)

			m_manager.addActionWithTarget(new ASSequence(act1, delay, 
				ASActionInterval(act1.clone())), 
				m_lhsprite)

		}
		
		public function doEaseTest() : void{
			m_title.text = "ASEaseIn / ASEaseOut /ASEaseInOut"
			restoreSprite(1)
			
			var act:ASActionInterval = new ASMoveBy(m_duration, new Point(500, 0))
			var act1:ASActionEaseRate = new ASEaseIn(act, 2)
			var seq1:ASActionInterval = new ASSequence(
				act1, ASActionInterval(act1.reverse()))

			var act2:ASActionEaseRate = new ASEaseOut(ASActionInterval(act.clone()), 2)
			var seq2:ASActionInterval = new ASSequence(
				act2, ASActionInterval(act2.reverse()))

			var act3:ASActionEaseRate = new ASEaseInOut(ASActionInterval(act.clone()), 2)
			var seq3:ASActionInterval = new ASSequence(
				act3, ASActionInterval(act3.reverse()))

			m_manager.addActionWithTarget(seq1, m_lhsprite)
			m_manager.addActionWithTarget(seq2, m_mhsprite)
			m_manager.addActionWithTarget(seq3, m_rhsprite)
		}

		public function doEaseExpoTest() : void{
			m_title.text = "ASEaseExpotentialIn / Out / InOut"
			restoreSprite(1)

			var act:ASActionInterval = new ASMoveBy(m_duration, new Point(500, 0))

			var act1:ASActionEase = new ASEaseExponentialIn(act)
			var seq1:ASActionInterval = new ASSequence(
				act1, ASActionInterval(act1.reverse()))

			var act2:ASActionEase = new ASEaseExponentialOut(
				ASActionInterval(act.clone()))
			var seq2:ASActionInterval = new ASSequence(
				act2, ASActionInterval(act2.reverse()))

			var act3:ASActionEase = new ASEaseExponentialInOut(
				ASActionInterval(act.clone()))
			var seq3:ASActionInterval = new ASSequence(
				act3, ASActionInterval(act3.reverse()))

			m_manager.addActionWithTarget(seq1, m_lhsprite)
			m_manager.addActionWithTarget(seq2, m_mhsprite)
			m_manager.addActionWithTarget(seq3, m_rhsprite)
		}

		public function doEaseSineTest() : void{
			m_title.text = "ASEaseSineIn / Out / InOut"
			restoreSprite(1)

			var act:ASActionInterval = new ASMoveBy(m_duration, new Point(500, 0))

			var act1:ASActionInterval = new ASEaseSineIn(act)
			var seq1:ASActionInterval = new ASRepeatForever(new ASSequence(
				act1, ASActionInterval(act1.reverse())))

			var act2:ASActionInterval = new ASEaseSineOut(
				ASActionInterval(act.clone()))
			var seq2:ASActionInterval = new ASRepeatForever(new ASSequence(
				act2, ASActionInterval(act2.reverse())))

			var act3:ASActionInterval = new ASEaseSineInOut(
				ASActionInterval(act.clone()))
			var seq3:ASActionInterval = new ASRepeatForever(new ASSequence(
				act3, ASActionInterval(act3.reverse())))

			m_manager.addActionWithTarget(seq1, m_lhsprite)
			m_manager.addActionWithTarget(seq2, m_mhsprite)
			m_manager.addActionWithTarget(seq3, m_rhsprite)
		}

		public function doEaseElasticTest() : void{
			m_title.text = "ASEaseElasticIn / Out /InOut"
			restoreSprite(1)
			var act:ASActionInterval = new ASMoveBy(m_duration, new Point(500, 0))

			var act1:ASActionInterval = new ASEaseElasticIn(act)
			var seq1:ASActionInterval = new ASRepeatForever(new ASSequence(
				act1, ASActionInterval(act1.reverse())))

			var act2:ASActionInterval = new ASEaseElasticOut(
				ASActionInterval(act.clone()))
			var seq2:ASActionInterval = new ASRepeatForever(new ASSequence(
				act2, ASActionInterval(act2.reverse())))

			var act3:ASActionInterval = new ASEaseElasticInOut(
				ASActionInterval(act.clone()))
			var seq3:ASActionInterval = new ASRepeatForever(new ASSequence(
				act3, ASActionInterval(act3.reverse())))

			m_manager.addActionWithTarget(seq1, m_lhsprite)
			m_manager.addActionWithTarget(seq2, m_mhsprite)
			m_manager.addActionWithTarget(seq3, m_rhsprite)

		}

		public function doEaseBackTest() : void{
			m_title.text = "ASEaseBackIn / Out /InOut"
			
			m_lhsprite.visible = false
			m_rhsprite.visible = false

			var act:ASActionInterval = new ASScaleBy(0.5, 2, 2)
			var seq:ASActionEase = new ASEaseBackInOut(act, 5)
			m_manager.addActionWithTarget(seq, m_mhsprite)
			/*restoreSprite(1)
			var act:ASActionInterval = new ASMoveBy(m_duration, new Point(500, 0))

			var act1:ASActionInterval = new ASEaseBackIn(act)
			var seq1:ASActionInterval = new ASRepeatForever(new ASSequence(
				act1, ASActionInterval(act1.reverse())))

			var act2:ASActionInterval = new ASEaseBackOut(
				ASActionInterval(act.clone()))
			var seq2:ASActionInterval = new ASRepeatForever(new ASSequence(
				act2, ASActionInterval(act2.reverse())))

			var act3:ASActionInterval = new ASEaseBackInOut(
				ASActionInterval(act.clone()))
			var seq3:ASActionInterval = new ASRepeatForever(new ASSequence(
				act3, ASActionInterval(act3.reverse())))

			m_manager.addActionWithTarget(seq1, m_lhsprite)
			m_manager.addActionWithTarget(seq2, m_mhsprite)
			m_manager.addActionWithTarget(seq3, m_rhsprite)*/
		}

		public function doSpeedTest() : void{
			m_title.text = "ASSpeed"

			m_rhsprite.visible = false
			m_mhsprite.visible = false

			var jump1:ASActionInterval = new ASJumpBy(3, new Point(300, 0), 100, 4)
			var jump2:ASActionInterval = ASActionInterval(jump1.reverse())
			var seq1:ASActionInterval = new ASSequence(jump1, jump2)

			var rot1:ASActionInterval = new ASRotateBy(3, 720)
			var rot2:ASActionInterval = ASActionInterval(rot1.reverse())
			var seq2:ASActionInterval = new ASSequence(rot1, rot2)

			var spawn:ASActionInterval = new ASSpawn(seq1, seq2)
			var speed:ASSpeed = new ASSpeed(new ASRepeatForever(spawn))


			m_manager.addActionWithTarget(speed, m_lhsprite)

			m_isStop = false	

			var speedTimer:Timer = new Timer(1000, 10000)
			speedTimer.start()

			speedTimer.addEventListener(TimerEvent.TIMER, 
				function (e:Event){
					speedChangeHandler(speed, speedTimer)
				}, false, 0, true)

		}	

		private function speedChangeHandler(action:ASSpeed, timer:Timer) : void{
			if(!m_isStop)
				action.setSpeed(Math.random() * 2)
			else{
				timer.stop()
			}
		}

		public function doFollowTest() : void{
			m_title.text = "ASFollow"
			m_rhsprite.visible = false

			var jump1:ASActionInterval = new ASJumpBy(3, new Point(300, 0), 100, 4)
			var jump2:ASActionInterval = ASActionInterval(jump1.reverse())

			m_manager.addActionWithTarget(new ASSequence(jump1, jump2), m_mhsprite)

			var follow:ASAction = new ASFollow(m_mhsprite, new Rectangle(0, 0, 500, 500))
			m_manager.addActionWithTarget(follow, m_lhsprite)

		}


	}
}
