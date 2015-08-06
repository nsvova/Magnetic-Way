package  
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Other
	 */
	public class LevelButton
	{
		public var button:SimpleButton = null;
		public var bonus:Sprite = null;
		public var levelNum:int = 0;
		public var textNum:TextField;
		
		public function LevelButton(button:SimpleButton, bonus:Sprite, levelNum:int) 
		{
			this.bonus = bonus;
			this.button = button;
			this.levelNum = levelNum;
			
			
			if (button is gLevelButton)
			{
				this.textNum = new TextField();
				this.textNum.text = levelNum.toString();
			}
			else
			{
				this.textNum = null;
			}
		}
		
		
	}

}