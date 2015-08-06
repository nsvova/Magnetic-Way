package  
{
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.SimpleButton;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class FlashGrafic extends Sprite 
	{
		
		public var listNumberLevel:Vector.<uint>;
		static private var levelCount:uint = 0;
		static public var boxLevel:Vector.<LevelButton> = new Vector.<LevelButton>();
		
		
		public function FlashGrafic() 
		{
			listNumberLevel = new Vector.<uint>();
			addEventListener(MouseEvent.CLICK, click);
		}
		
		private function click(e:MouseEvent):void 
		{
			
		}
		
		
		static public function DeleteAll(_sprite:Sprite):void
		{
			if(boxLevel)
				for (var i:int; i < boxLevel.length; i++)
				{
					if(boxLevel[i])
					{	
						_sprite.removeChild(boxLevel[i].button);
						_sprite.removeChild(boxLevel[i].bonus);
					}
				}
			boxLevel = null;
			levelCount = 0;
			
		}
		
		static public function drawLevelBox(x:Number, y:Number, width:Number, height:Number):LevelButton
		{
			var lastLevel:int = Save.GetLastLevel();
			
			levelCount++;
			var bonusSprite = ShowBonus(Bonus.GetBonusPointsFromFile(levelCount), x - 30, y + 25);
				
			
			var levelButt:SimpleButton = ChooseLevelButton(levelCount);
			levelButt.x = x;
			levelButt.y = y;
			
			var button:LevelButton = new LevelButton(levelButt, bonusSprite, levelCount);
			
			if (levelButt is gLevelButton)
			{
				button.textNum.selectable = false;
				
				button.textNum.setTextFormat(CreateTextFormat(), -1, -1);
				
				button.textNum.x = x - 25;
				button.textNum.y = y - 25;
				button.textNum.width = 50;
				button.textNum.height = 50;
			}
			
			return button;
			//boxLevel[levelCount - 1].bonus = tf;
			//boxLevel[levelCount - 1].addBonusToScreen();
		}
		
		
	
		
		

		
		static public function drawManyLevelBoxs( count:int, x:Number, y:Number, width:Number, height:Number, distance:Number, countInLine:Number, firstLevel:int):Vector.<LevelButton>
		{
			
			var next_y:int = 0;
			if (firstLevel > 0)
			{
				levelCount = firstLevel - 1;
			}
			
			if (!boxLevel)
			{
				boxLevel = new Vector.<LevelButton>();
			}
			var j:int = 0;
			for (var i:int = 0; i < count; i++)
			{
				if (countInLine == j)
				{
					y = y + height + distance;
					j = 0;
					i--;
					continue;
				}
				
				if (j == 0)
				{
					boxLevel.push(drawLevelBox( x  , y, width, height));
				}
				else 
				{
						
					boxLevel.push(drawLevelBox( x + (j * width) + distance * j, y, width, height));
				}
				j++;
			}
			
			return boxLevel;
		}
		
		static public function drawBox(x:Number, y:Number, width:Number, height:Number, color:uint):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(color, 1);
			sp.graphics.drawRect(x, y, width, height);
			return sp;
		}
		
		
		static public function DrawText(text:String, x:Number, y:Number, sp:Sprite):TextField
		{
			var tf:TextField = new TextField();
			tf.text = text;
			tf.x = x;
			tf.y = y;
			tf.width = 150;
			tf.height = 30;
			tf.selectable = false;
			tf.setTextFormat(CreateTextFormat());
			
			sp.addChild(tf);
			
			return tf;
		}
		
		
		static public function CreateTextFormat(size:int = 38,color:uint = 0xAAaaAA, font:String = "Franklin Gothic Heavy"):TextFormat
		{
			var form:TextFormat = new TextFormat(font, size, color, true, null, null, null, null,TextFormatAlign.CENTER, null, null, null, null);
		
			return form;
		}
		
		
		
		static private function ShowBonus(bonus_:int, x:int, y:int):Sprite
		{
			var start:int = x;
			var distance:int = 21;
			var h:int = y;
			var sp:Sprite;
			
			var size:int = 20;
			
			if (bonus_ == 0)
			{

					sp = new gNullBonus();
					sp.x = start;
					sp.y = h;
					
					//sp.width = size;
					//sp.height = size;
				return sp;

			}
			else if (bonus_ == 1)
			{
					sp = new gOneBonus();
					sp.x = start;
					sp.y = h;
					
					//sp.width = size;
					//sp.height = size;
				return sp;
			}
			else if (bonus_ == 2)
			{
					sp = new gTwoBonus();
					sp.x = start;
					sp.y = h;
					
					//sp.width = size;
					//sp.height = size;
				return sp;
			}
			
			else if (bonus_ == 3)
			{
					sp = new gThreeBonus();
					sp.x = start;
					sp.y = h;
					
					//sp.width = size;
					//sp.height = size;
				return sp;
				
			}
			
			return null;
			
		}
		
		static private function ChooseLevelButton(level:int):SimpleButton
		{
			var lastLevel:int = Save.GetLastLevel();
			
			if (lastLevel >= level - 1)
			{
				return new gLevelButton();
			}
			else
			{
				return new gLevelLock();
			}
			
		}
		
		static public function CreateText(text:String, x:int, y:int, size:int = 38, color:uint = 0xAAaaAA, font:String = "Franklin Gothic Heavy", width:Number = 0):TextField
		{
			var tf:TextField = new TextField();
			tf.text = text;
			tf.x = x;
			tf.y = y;
			if(width == 0)
				tf.width = size / 2 * text.length;
			else
				tf.width = width;
			
			
			tf.setTextFormat(CreateTextFormat(size, color, font), -1, -1);
			tf.selectable = false;
			
			return tf;
		}
	}

}