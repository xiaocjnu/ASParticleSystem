package utils.particles{
	//简单的粒子池
	public class ParticlePool{
		private static var freeList:Vector.<Particle> = new Vector.<Particle>()

		static public function cache(size:int) : void{
			if(freeList.length < size){
				for(var i = freeList.length; i < size; i++){
					freeList[i] = new Particle()
				}
			}
		}

		static public function acquire() : Particle{
			return freeList.length ? freeList.pop() : new Particle()
		}	

		static public function release(p:Particle) : void{
			if(p != null)
				freeList.push(p)
		}	

		static public function dispose() : void{
			freeList.splice(0, freeList.length)
			freeList = null
		}
	}
}