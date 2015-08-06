package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class SpriteData
	{
		
		public var nameSprite:String;
		public var sprite:Sprite = null;
		
		public function SpriteData(sp:Sprite, name:String) 
		{
			super();
			
			sprite = sp;
			nameSprite = name;
		}
		
	}

}