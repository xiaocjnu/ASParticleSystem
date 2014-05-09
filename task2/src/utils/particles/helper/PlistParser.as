package utils.particles.helper{
	import flash.utils.Dictionary

	//这个类能也仅能解析cocos的粒子系统的plist配置文件
	public class PlistParser {
		public static function parse(plist:XML) : Dictionary{
			var dictList:XMLList = plist.child(0)
			var len:int = dictList.children().length()
			//trace(len)
			var dict:Dictionary = new Dictionary()
			var key:String = ""
			for(var i = 0; i < len; i++){
				if(dictList.child(i).name() == "key"){
					key = dictList.child(i)
					i++
					dict[key] = dictList.child(i)
					var name:String = dictList.child(i).name()
					if(name == "integer"){
						dict[key] = parseInt(dictList.child(i))
					}
					else if(name == "real"){
						dict[key] = Number(dictList.child(i))
					}
					else if(name == "string"){
						dict[key] = dictList.child(i)
					}
					else {
						throw new Error("unsupported format!")
					}
				}
			}
			return dict
		}
	}
}