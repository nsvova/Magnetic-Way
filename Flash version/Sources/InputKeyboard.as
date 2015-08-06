package  
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Vova_Nos
	 * 
	 */


	public class InputKeyboard 
	{
		
		
		
		public function InputKeyboard(sprite:Sprite)
		{
			sprite.stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyDown);
			sprite.stage.addEventListener(KeyboardEvent.KEY_UP, _keyUp);
			
		}
		
		
		static public function addKeyboardListener(sprite:Sprite):void
		{
			sprite.stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyDown);
			sprite.stage.addEventListener(KeyboardEvent.KEY_UP, _keyUp);
		}
		
		static private function _keyUp(e:KeyboardEvent):void 
		{
			keyDown = false;
			keyUp = true;
			lastKey = e.keyCode;
			pressKey = -1;
		}
		
		static private function _keyDown(e:KeyboardEvent):void 
		{

			keyDown = true;
			keyUp = false;
			
			if(pressKey != lastKey)
				lastKey = e.keyCode;
				
			pressKey = e.keyCode;
		
		}
		
		
		static public function update():void
		{
			keyDown = false;
			keyUp = false;
			
		}
		
		
		/*static public var isMouseDown:Boolean = false;
		static public var isMouseMove:Boolean = false;
		static public var isMouseUp:Boolean = false;
		
		static public var isMouseClick:Boolean = false;*/
		
		static public var keyUp:Boolean = false;
		static public var keyDown:Boolean = false;
		static public var leftUp:Boolean = false;
		static public var rightUp:Boolean = false;
		
		static public var lastKey:int = -1;
		static public var pressKey:int = -1;
		
	}

}