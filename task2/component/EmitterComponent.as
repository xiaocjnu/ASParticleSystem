package component{
	import flash.utils.getDefinitionByName
	import utils.particles.*
	import flash.display.Stage
	import flash.events.Event

	public class EmitterComponent extends Emitter{
		protected var m_isPlayOnAwake:Boolean

		public function EmitterComponent(isPlayOnAwake:Boolean = false) {
			m_isPlayOnAwake = isPlayOnAwake
			if(m_isPlayOnAwake){
				playOnAwake()
			}
			mouseChildren = false
		}

		protected function onAddToStage(e:Event) : void{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage)
			CanvasRender.initCanvas(stage.stageWidth, stage.stageHeight)
			stage.addChild(CanvasRender.canvas)
			if(m_isPlayOnAwake){
				stage.frameRate = 60
			}
		}

		private function onEnterFrame(e:Event) : void{
			if(stage != null){
				stage.frameRate = 60
				var dt:Number = 1.0 / stage.frameRate
				this.update(dt) 
			}
		}

		private function playOnAwake() : void{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame)
			if(stage != null){
				onAddToStage(null)
			}
			else
				addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true)
		}

		protected var m_textureName:String

		[Inspectable(defaultValue=false, name = "00. 实时渲染(仅供调试)")]
		public function get isPlayOnAwake() : Boolean{return m_isPlayOnAwake}
		public function set isPlayOnAwake(value:Boolean) : void{
			if(m_isPlayOnAwake == value)
				return

			if(value == false){
				if(stage != null)
					removeEventListener(Event.ADDED_TO_STAGE, onAddToStage)
				removeEventListener(Event.ENTER_FRAME, onEnterFrame)
			}
			else{ // true
				if(stage == null){
					addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true)
				}
				else
					onAddToStage(null)
				addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true)
			}
		 	m_isPlayOnAwake = value

			if(m_render != null)
				m_render.cleanUp()
		}

		[Inspectable(defaultValue=-1, name = "01. 持续时长")]
		override public function get duration() : Number{return super.duration}
		override public function set duration(d:Number) : void{super.duration = d}

		[Inspectable(defaultValue=150, name = "02. 最大粒子数")]
		override public function get maxParticles() : int{return super.maxParticles	}
		override public function set maxParticles(n:int) : void{super.maxParticles = n}

		[Inspectable(defaultValue = "firePng", name = "03. 纹理类名")]
		public function get textureName() : String{ return m_textureName}
		public function set textureName(value :String) : void{		
			m_textureName = value
			var Tmp = getDefinitionByName(value)
			super.texture = new Tmp
		}

		[Inspectable(defaultValue = "particle", name = "04. 渲染器", 
			type = "list", enumeration="particle, canvas")]
		public function get _renderMode() : String { 
			if(super.renderMode == PARTICLE_RENDER){
				return "particle"
			}
			else 
				return "canvas"
		}
		public function set _renderMode(mode:String) : void{
			if(mode == "particle")
				super.renderMode = PARTICLE_RENDER
			else{
				super.renderMode = CANVAS_RENDER
			}
			if(m_render != null)
				m_render.cleanUp()
		}

		[Inspectable(defaultValue = 3, name = "05. 粒子生命")]
		override public function get lifespan() : Number {return super.lifespan}
		override public function set lifespan(value:Number) : void {
			super.lifespan = value
		}

		[Inspectable(defaultValue = 0.25, name = "06. 粒子生命偏差")]
		override public function get lifespanVar() : Number {return super.lifespanVar}
		override public function set lifespanVar(value:Number) : void {
			super.lifespanVar = value
		}


		[Inspectable(defaultValue = 32, name = "07. 起始大小")]
		override public function get startSize() : Number {return super.startSize}
		override public function set startSize(value:Number) : void {
			super.startSize = value
		}

		[Inspectable(defaultValue = 0, name = "08. 起始大小偏差")]
		override public function get startSizeVar() : Number {return super.startSizeVar}
		override public function set startSizeVar(value:Number) : void {
			super.startSizeVar = value
		}

		[Inspectable(defaultValue = 32, name = "09. 终止大小")]
		override public function get endSize() : Number {return super.endSize}
		override public function set endSize(value:Number) : void {
			super.endSize = value
		}

		[Inspectable(defaultValue = 0, name = "10. 终止大小偏差")]
		override public function get endSizeVar() : Number {return super.endSizeVar}
		override public function set endSizeVar(value:Number) : void {
			super.endSizeVar = value
		}

		[Inspectable(defaultValue = -90, name = "11. 发射器角度")]
		override public function get emitAngle() : Number {return super.emitAngle}
		override public function set emitAngle(value:Number) : void {
			super.emitAngle = value
		}

		[Inspectable(defaultValue = 10, name = "12. 发射器角度偏差")]
		override public function get emitAngleVar() : Number {return super.emitAngleVar}
		override public function set emitAngleVar(value:Number) : void {
			super.emitAngleVar = value
		}

		[Inspectable(defaultValue = 0, name = "13. 起始旋转角度")]
		override public function get startRotation() : Number {return super.startRotation}
		override public function set startRotation(value:Number) : void {
			super.startRotation = value
		}

		[Inspectable(defaultValue = 0, name = "14. 起始旋转角度偏差")]
		override public function get startRotationVar() : Number {return super.startRotationVar}
		override public function set startRotationVar(value:Number) : void {
			super.startRotationVar = value
		}

		[Inspectable(defaultValue = 0, name = "15. 终止旋转角度")]
		override public function get endRotation() : Number {return super.endRotation}
		override public function set endRotation(value:Number) : void {
			super.endRotation = value
		}

		[Inspectable(defaultValue = 0, name = "16. 终止旋转角度偏差")]
		override public function get endRotationVar() : Number {return super.endRotationVar}
		override public function set endRotationVar(value:Number) : void {
			super.endRotationVar = value
		}

		[Inspectable(defaultValue = 0, name = "17. 起始位置X")]
		override public function get startX() : Number {return super.startX}
		override public function set startX(value:Number) : void {
			super.startX = value
		}

		[Inspectable(defaultValue = 40, name = "18. 起始位置X偏差")]
		override public function get startXVar() : Number {return super.startXVar}
		override public function set startXVar(value:Number) : void {
			super.startXVar = value
		}

		[Inspectable(defaultValue = 0, name = "19. 起始位置Y")]
		override public function get startY() : Number {return super.startY}
		override public function set startY(value:Number) : void {
			super.startY = value
		}

		[Inspectable(defaultValue = 20, name = "20. 起始位置Y偏差")]
		override public function get startYVar() : Number {return super.startYVar}
		override public function set startYVar(value:Number) : void {
			super.startYVar = value
		}

		[Inspectable(defaultValue = "255, 193, 63, 30",
			name = "21. 起始颜色(ARGB)")]
		 public function get startColor() : Array {
		 	return new Array (int(super.startColorA * 255), int(super.startColorR * 255), 
		 		int(super.startColorG), int(super.startColorB *255))
		 }
		 public function set startColor(value:Array) : void {
		 	super.startColorA = value[0] / 255.0
		 	super.startColorR = value[1] / 255.0
		 	super.startColorG = value[2] / 255.0
		 	super.startColorB = value[3] / 255.0
		}

		[Inspectable(defaultValue = "0, 0, 0, 0", 
			name = "22. 起始颜色偏差(ARGB)")]
		public function get startColorVar() : Array {
			return new Array (int(super.startColorVarA * 255), 
				int(super.startColorVarR * 255), 
		 		int(super.startColorVarG), int(super.startColorVarB *255))
		}
		public function set startColorVar(value:Array) : void {
			super.startColorVarA = value[0] / 255.0
			super.startColorVarR = value[1] / 255.0
			super.startColorVarG = value[2] / 255.0
			super.startColorVarB = value[3] / 255.0
		}

		[Inspectable(defaultValue = "255, 0, 0, 0",
			name = "23. 终止颜色(ARGB)")]
		 public function get endColor() : Array {
		 	return new Array (int(super.endColorA * 255), int(super.endColorR * 255), 
		 		int(super.endColorG), int(super.endColorB *255))
		 }
		 public function set endColor(value:Array) : void {
		 	super.endColorA = value[0] / 255.0
		 	super.endColorR = value[1] / 255.0
		 	super.endColorG = value[2] / 255.0
		 	super.endColorB = value[3] / 255.0
		}

		[Inspectable(defaultValue = "0, 0, 0, 0", 
			name = "24. 终止颜色偏差(ARGB)")]
		public function get endColorVar() : Array {
			return new Array (int(super.endColorVarA * 255), 
				int(super.endColorVarR * 255), 
		 		int(super.endColorVarG), int(super.endColorVarB *255))
		}
		public function set endColorVar(value:Array) : void {
			super.endColorVarA = value[0] / 255.0
			super.endColorVarR = value[1] / 255.0
			super.endColorVarG = value[2] / 255.0
			super.endColorVarB = value[3] / 255.0
		}

		[Inspectable(defaultValue = "gravity", name = "25. 发射类别", 
			type = "list", enumeration="gravity, radius")]
		public function get _emitterMode() : String { 
			if(super.emitterMode == GRAVITY_MODE){
				return "gravity"
			}
			else 
				return "radial"
		}
		public function set _emitterMode(mode:String) : void{
			if(mode == "gravity")
				super.emitterMode = GRAVITY_MODE
			else
				super.emitterMode = RADIUS_MODE
		}


		[Inspectable(defaultValue = 0, name = "26. g-X轴重力")]
		override public function get gravityX() : Number {return super.gravityX}
		override public function set gravityX(value:Number) : void {
			super.gravityX = value
		}

		[Inspectable(defaultValue = 9.8, name = "27. g-Y轴重力")]
		override public function get gravityY() : Number {return super.gravityY}
		override public function set gravityY(value:Number) : void {
			super.gravityY = value
		}

		[Inspectable(defaultValue = 60, name = "28. g-速度")]
		override public function get speed() : Number {return super.speed}
		override public function set speed(value:Number) : void {
			super.speed = value
		}

		[Inspectable(defaultValue = 20, name = "29. g-速度偏差")]
		override public function get speedVar() : Number {return super.speedVar}
		override public function set speedVar(value:Number) : void {
			super.speedVar = value
		}

		[Inspectable(defaultValue = 0, name = "30. g-切线加速度")]
		override public function get tangentialAcceel() : Number {return super.tangentialAcceel}
		override public function set tangentialAcceel(value:Number) : void {
			super.tangentialAcceel = value
		}

		[Inspectable(defaultValue = 0, name = "31. g-切线加速度偏差")]
		override public function get tangentialAcceelVar() : Number {return super.tangentialAcceelVar}
		override public function set tangentialAcceelVar(value:Number) : void {
			super.tangentialAcceelVar = value
		}

		[Inspectable(defaultValue = 0, name = "32. g-径向加速度")]
		override public function get radialAccel() : Number {return super.radialAccel}
		override public function set radialAccel(value:Number) : void {
			super.radialAccel = value
		}

		[Inspectable(defaultValue = 0, name = "33. g-径向加速度偏差")]
		override public function get radialAccelVar() : Number {return super.radialAccelVar}
		override public function set radialAccelVar(value:Number) : void {
			super.radialAccelVar = value
		}

		[Inspectable(defaultValue = 0, name = "34. r-起始半径")]
		override public function get startRadius() : Number {return super.startRadius}
		override public function set startRadius(value:Number) : void {
			super.startRadius = value
		}

		[Inspectable(defaultValue = 0, name = "35. r-起始半径偏差")]
		override public function get startRadiusVar() : Number {return super.startRadiusVar}
		override public function set startRadiusVar(value:Number) : void {
			super.startRadiusVar = value
		}

		[Inspectable(defaultValue = 0, name = "36. r-终止半径")]
		override public function get endRadius() : Number {return super.endRadius}
		override public function set endRadius(value:Number) : void {
			super.endRadius = value
		}

		[Inspectable(defaultValue = 0, name = "37. r-终止半径偏差")]
		override public function get endRadiusVar() : Number {return super.endRadiusVar}
		override public function set endRadiusVar(value:Number) : void {
			super.endRadiusVar = value
		}

		[Inspectable(defaultValue = 0, name = "38. r-旋转速度")]
		override public function get rotatePerSec() : Number {return super.rotatePerSec}
		override public function set rotatePerSec(value:Number) : void {
			super.rotatePerSec = value
		}

		[Inspectable(defaultValue = 0, name = "39. r-旋转速度偏差")]
		override public function get rotatePerSecVar() : Number {return super.rotatePerSecVar}
		override public function set rotatePerSecVar(value:Number) : void {
			super.rotatePerSecVar = value
		}

		[Inspectable(defaultValue = 0, name = "40. 延迟时间")]
		override public function get delayTime() : Number {return super.delayTime}
		override public function set delayTime(value:Number) : void {
			super.delayTime = value
		}

		[Inspectable(defaultValue = "add", name = "41. 渲染模式", 
			type = "list", 
			enumeration=
			"add, alpha, darken, difference, erase, hardlight, \
			invert, layer, lighten, multiply, normal, overlay, \
			screen, shader, subtract")]
		override public function get blendMode() : String{return super.blendMode}
		override public function set blendMode(value : String) : void {
		 	super.blendMode = value
		}

	}	
}