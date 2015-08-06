package  
{
	import adobe.utils.CustomActions;
	import Box2D.Collision.b2BroadPhase;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.display.Sprite;
	import Box2DObject.CircleData;
	
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Bonus
	{
		
		private var sprite:Sprite;
		private var mainSprite:Sprite;
		
		public function Bonus(_mainSprite:Sprite) 
		{
			mainSprite = _mainSprite;
			sprite = new Sprite();
			
			listBonusPoints = new Vector.<int>();
			
		}
		
		static public function GetBonusPoints(levelNum:int):int
		{
			if (listBonusPoints)
			{
				if (levelNum >= 1 && levelNum <= listBonusPoints.length)
				{
					return listBonusPoints[levelNum - 1];
				}
			}
			
			listBonusPoints.push(0);
			return 0;
		}
		
		
		public function SetLastBonusPoint(levelNum:int):void
		{
			
			if (listBonusPoints)
			{
				if (listBonusPoints.length < levelNum)
				{
					lastBonusPoints = 0;
				}
				else
				{
					if (levelNum >= 1 && levelNum <= listBonusPoints.length)
					{
						lastBonusPoints = listBonusPoints[levelNum - 1];
					}
					else
					{
						lastBonusPoints = 0;
					}
				}
			}
			else 
			{
				lastBonusPoints = 0;
			}
		}
		
		
		static public function GetLastBonusPoints():int
		{
			return lastBonusPoints;
		}
		
		
		public function SetBonusPoints(levelNum:int, i:int):void
		{
			if (listBonusPoints)
			{
				if (listBonusPoints.length < levelNum)
				{
					listBonusPoints.push(0);
				}
				
				if (levelNum >= 1 && levelNum <= listBonusPoints.length)
				{
					listBonusPoints[levelNum - 1] += 1/*listBonus[i].bonusPoints*/;
					//Save.BonusPoints(listBonusPoints);
				}
			}
		}
		
		public static function SaveBonus(levelNum:int):void
		{
			if (listBonusPoints)
			{
				if (levelNum >= 1 && levelNum <= listBonusPoints.length)
					{
						Save.BonusPoints(listBonusPoints);
					}
			}
		}
		
		public function SetBonusPointsWithoutSave(levelNum:int, indexOfBonus:int):void
		{
			if (!listBonusPoints)
			{
				listBonusPoints = new Vector.<int>();
			}
			if (listBonusPoints.length < levelNum)
			{
				listBonusPoints.push(0);
			}
			
			if (levelNum >= 1 && levelNum <= listBonusPoints.length)
			{
				listBonusPoints[levelNum - 1] += listBonus[indexOfBonus].bonusPoints;
			}
		}
		
		
		static public function GetBonusPointsFromFile(levelNum:int):int
		{
			var list:Vector.<int> = Save.GetBonusPoints();
			
			if (list)
			{
				if (levelNum >= 1 && levelNum <= list.length)
					{
						return list[levelNum - 1];
					}
			}
			return 0;	
		}
		

		public function DeleteBonusPoints(levelNum:int):void
		{
			if (listBonusPoints)
			{
				if (levelNum >= 1 && levelNum <= listBonusPoints.length)
				{
					listBonusPoints[levelNum - 1] = 0;
				}
			}
		}
		
		public function CreateBonus(x:Number, y:Number, radius:Number, points:int):void
		{
			sprite = null;
			sprite = new gBonus();
			sprite.x = x;
			sprite.y = y;
			//sprite.graphics.beginFill(0x00dddd, 1);
			//sprite.graphics.drawCircle(x, y, radius);
			listBonusSprite.push(sprite);
			mainSprite.addChild(sprite);
			
			var cData:CircleData = new CircleData();
			cData.SetData(x, y, radius);
			cData.bonusPoints = points;
			listBonus.push(cData);
			
		}
		
		
		public function Getb2Vec2(i:Number, worldScale:Number):b2Vec2
		{
			if (i < listBonus.length && i >= 0);
			{
				return new b2Vec2(listBonus[i].x / worldScale, listBonus[i].y / worldScale);
			}
			return new b2Vec2(0, 0);
			
		}
		
		
		public function GetRadius(i:Number):Number
		{
			if (i < listBonus.length && i >= 0);
			{
				return listBonus[i].radius;
			}
			return -1;
		}
		
		
		public function Delete(i:Number):Boolean
		{
			if (i < listBonus.length && i >= 0)
			{
				if (listBonusSprite[i] != null)
				{
					mainSprite.removeChild(listBonusSprite[i]);
					listBonusSprite[i] = null;
					return true;
				}
			}
			return false;
		}
			
		public function GetX(i:Number):Number
		{
			if (i < listBonus.length && i >= 0)
			{
				if (listBonus[i] != null)
				{
					return listBonus[i].x;
				}
			}
			return null;
		}
		
		public function GetY(i:Number):Number
		{
			if (i < listBonus.length && i >= 0)
			{
				if (listBonus[i] != null)
				{
					return listBonus[i].y;
				}
			}
			return null;
		}
		
		
		public function DeleteAllBonus():void
		{
			for (var i:int = 0; i < listBonusSprite.length; i++)
			{
				if(listBonusSprite[i] != null)
					mainSprite.removeChild(listBonusSprite[i]);
			}
		}
		
		
		public function isPersonCatchABonus(personVec:b2Vec2):int
		{
			for (var i:int = 0; i < listBonus.length; i++)
			{
				if ( Calc.isObjectInCircle(Calc.CMeterToPixel(personVec ,30), Calc.CMeterToPixel(Getb2Vec2(i, 30), 30), GetRadius(i) * 3) && listBonusSprite[i])
				{
					return i;
				}
			}
			return -1;
		}
		
		
		
		public function GetFromFile():void
		{
			listBonusPoints = Save.GetBonusPoints();

			if (!listBonusPoints)
			{
				listBonusPoints = new Vector.<int>();
			}
		}
		
		
		public static function GetTempBonus():int
		{
			return tempBonus;
		}
		
		
		public static function SetTempBonus(_bonus:int):void
		{
			tempBonus = _bonus;
		}
		
		public static function AllBonus():int
		{
			listBonusPoints = Save.GetBonusPoints();
			
			var result:int = 0;
			
			if (listBonusPoints)
			{
				for (var i:int = 0; i < listBonusPoints.length; i++)
				{
					result += listBonusPoints[i];
				}
			}
			
			return result;
		}
		
		private var listBonus:Vector.<CircleData> = new Vector.<CircleData>();
		private var listBonusSprite:Vector.<Sprite> = new Vector.<Sprite>();
		
		static private var listBonusPoints:Vector.<int>;
		static private var lastBonusPoints:int = 0;
		static private var tempBonus:int = 0;
	}

}