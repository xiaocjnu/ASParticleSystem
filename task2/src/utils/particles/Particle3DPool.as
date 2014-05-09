package utils.particles{
	//简单的粒子池
	public class Particle3DPool{
		private static var freeList:Vector.<Particle3D> = new Vector.<Particle3D>()

		static public function cache(size:int) : void{
			if(freeList.length < size){
				for(var i = freeList.length; i < size; i++){
					freeList[i] = new Particle3D()
				}
			}
		}

		static public function acquire() : Particle3D{
			return freeList.length ? freeList.pop() : new Particle3D()
		}	

		static public function release(p:Particle3D) : void{
			if(p != null)
				freeList.push(p)
		}	

		static public function dispose() : void{
			freeList.splice(0, freeList.length)
			freeList = null
		}
	}
}