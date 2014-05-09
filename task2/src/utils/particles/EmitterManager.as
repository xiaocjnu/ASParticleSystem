package utils.particles{
	import flash.events.Event
	import flash.display.Stage
	import flash.display.Sprite
	import flash.display.DisplayObjectContainer

	public class EmitterManager extends Object{
		protected var m_emitters:Vector.<Emitter>
		protected var m_counter:int
		protected static var m_manager:EmitterManager = null//new EmitterManager(new SingletonEnforcer())
		protected var m_hasBatchCleanUp:Boolean

		public function EmitterManager(enforcer:SingletonEnforcer){
			m_emitters = new Vector.<Emitter>()
			m_hasBatchCleanUp = false
			m_counter = 0
		}

		public static function getInstance() : EmitterManager{
			if(m_manager == null){
				m_manager = new EmitterManager(new SingletonEnforcer())
			}
			return m_manager
		}

		public function update(dt:Number) : void{
			m_hasBatchCleanUp = false
			for(var i = 0; i < m_counter; ){
				var emitter:Emitter = m_emitters[i]
				//canvas模式下统一清空一次
				//避免多个render共用一个canvas时的覆盖问题
				if(!m_hasBatchCleanUp && emitter.renderMode == Emitter.CANVAS_RENDER){
					emitter.render.cleanUp()
					m_hasBatchCleanUp = true	
				}
				emitter.update(dt)

				//可以修改这里加入重用发射器的功能
				// 发射完毕后标记为可用，通过reuse接口返回
				if(emitter.isDone()){
					if(emitter.isAutoRemoveOnFinish){
						emitter.dispose()
						if(emitter.parent != null){
							emitter.parent.removeChild(emitter)
						}
					}
					if(i != m_counter - 1){
						m_emitters[i] = m_emitters[m_counter - 1]
					}
					m_emitters[m_counter - 1] = null
					m_counter--
				}
				else
					i++
			}
		}

		public function addEmitter(emitter:Emitter) : void{
			if(emitter != null){
				if(m_counter < m_emitters.length)
					m_emitters[m_counter] = emitter
				else
					m_emitters.push(emitter)
				m_counter++
			}
		}

		public function addEmitterWithTarget(emitter:Emitter, target:DisplayObjectContainer) : void{
			addEmitter(emitter)
			if(target != null && emitter != null){
				target.addChild(emitter)
			}
		}

		public function removeEmitter(emitter:Emitter) : void{
			var len:int = m_emitters.length
			for(var i = 0; i < len; i++){
				if(m_emitters[i] == emitter){
					if(i != m_counter - 1){
						m_emitters[i] = m_emitters[m_counter - 1]
					}
					m_emitters[m_counter - 1] = null
					m_counter--
					break
				}
			}
		}

		public function removeEmitterWithTarget(emitter:Emitter, target:DisplayObjectContainer) : void{
			removeEmitter(emitter)
			if(target != null){
				target.removeChild(emitter)
			}
		}

		public function dispose() : void{
			var len:int = m_emitters.length
			for(var i = 0; i < len; i++){
				var emitter:Emitter = m_emitters[i]
				if(emitter != null){
					if(emitter.parent != null){
						emitter.parent.removeChild(emitter)
					}
					emitter.dispose()
				}
			}

			m_emitters.splice(0, len)
			m_counter = 0
		}

	}
}
//辅助类。由于AS3不支持构造函数声明为public, 声明此类用于实现singleton
class SingletonEnforcer{}