package  Screen
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import Screen.Level.Game;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Result extends GameScreen
	{
		var TextBonus:TextField;
		
		var next:SimpleButton;
		var again:SimpleButton;
		var exit:SimpleButton;
		
		var bolt1:MovieClip;
		
		var cloud1:Sprite;
		var cloud2:Sprite;
		var cloud3:Sprite;
		
		var tree1:Sprite;
		var tree3:Sprite;
		
		var grass:Sprite;
		var sky:Sprite;
		
		var wonBack:MovieClip;
		
		public function Result()
		{
			
		}
		
		private function nextClick(e:MouseEvent):void 
		{
			var newLevel:int = Game.levelNum + 1;
			
			var str:String;
			
			if (newLevel == 11)
			{
				str = "GoToLevelMenu2";
			}
			else
			{
				str = "Level" + newLevel.toString();
			}

			dispatchEvent( new StatusEvent( StatusEvent.STATUS, false, false, "", str ) );
		}
		
		private function againClick(e:MouseEvent):void 
		{
			var newLevel:int = Game.levelNum;
			var str:String = "Level" + newLevel.toString();
			dispatchEvent( new StatusEvent( StatusEvent.STATUS, false, false, "", str ) );
		}
		
		private function exitClick(e:MouseEvent):void 
		{
			dispatchEvent( new StatusEvent( StatusEvent.STATUS, false, false, "", "GoToLevelMenu" ) );
		}
		
		override public function Start():void 
		{

			super.Start();
			
			sky = new gSky();
			addChild(sky);
			
			if (SoundEffect.SoundOn)
			{
			
				bolt1 = new gMainBolt();
				bolt1.x = 100;
				bolt1.y = 30;
				addChild(bolt1);
				
				
				/*bolt2 = new gBigMainBolt();
				bolt2.x = 300;
				bolt2.y = 100;
				addChild(bolt2);*/
			}
			else
			{
				bolt1 = new gMainBoltWithoutSound();
				bolt1.x = 100;
				bolt1.y = 30;
				addChild(bolt1);
				
				
				/*bolt2 = new gBigMainBoltWithoutSound();
				bolt2.x = 300;
				bolt2.y = 100;
				addChild(bolt2);*/
			}
			
			cloud3 = new gCloud3();
			cloud3.x = 700;
			cloud3.y = 100;
			addChild(cloud3);
			
			cloud1 = new gCloud1();
			cloud1.x = 30;
			cloud1.y = 10;
			addChild(cloud1);
			
			cloud2 = new gCloud2();
			cloud2.x = 320;
			cloud2.y = 10;
			addChild(cloud2);
			
			tree1 = new gTree1();
			tree1.x = 50;
			tree1.y = 155;
			addChild(tree1);
			
			tree3 = new gTree3();
			tree3.x = 370;
			tree3.y = 180;
			addChild(tree3);
			
			grass = new gGrass();
			grass.x = 0;
			grass.y = 400;
			addChild(grass);
			
			next = new gNext();
			again = new gAgain();
			exit = new mainMenu_button();
			
			next.x = 320;
			next.y = 250;
			
			again.x = 320;
			again.y = 320;
			
			exit.x = 320;
			exit.y = 390;
			
			addChild(next);
			addChild(again);
			addChild(exit);
			
			
			wonBack = new gWonBack2();
			addChild(wonBack);
			
			
			next.addEventListener(MouseEvent.CLICK, nextClick);
			again.addEventListener(MouseEvent.CLICK, againClick);
			exit.addEventListener(MouseEvent.CLICK, exitClick);
			
			
			ShowBonus();
			
			
		}
		
		
		private function ShowBonus():void
		{
			var bonus_:int = Bonus.GetTempBonus();
			var start:int = 270;
			var distance:int = 45;
			var h:int = 160;
			
			var size:int = 40;
			
			if (bonus_ == 0)
			{
				var listnoBonus:Vector.<Sprite> = new Vector.<Sprite>();
				for (var i:int = 0; i < 3; i++)
				{
					listnoBonus.push(new gNoBonus());
					listnoBonus[i].x = start + i * distance;
					listnoBonus[i].y = h;
					
					listnoBonus[i].width = size;
					listnoBonus[i].height = size;
					
					addChild(listnoBonus[i]);
				}
			}
			else if (bonus_ == 1)
			{
				var listnoBonus:Vector.<Sprite> = new Vector.<Sprite>();
				for (var i:int = 0; i < 3; i++)
				{
					if (i == 0)
					{
						listnoBonus.push(new gBonus());
						listnoBonus[i].x = start + i * distance;
						listnoBonus[i].y = h;
											
					listnoBonus[i].width = size;
					listnoBonus[i].height = size;
					
						addChild(listnoBonus[i]);
					}
					else
					{
						listnoBonus.push(new gNoBonus());
						listnoBonus[i].x = start + i * distance;
						listnoBonus[i].y = h;
											
					listnoBonus[i].width = size;
					listnoBonus[i].height = size;
					
						addChild(listnoBonus[i]);
					}
				}
			}
			else if (bonus_ == 2)
			{
				var listnoBonus:Vector.<Sprite> = new Vector.<Sprite>();
				for (var i:int = 0; i < 3; i++)
				{
					if (i == 0 || i == 1)
					{
						listnoBonus.push(new gBonus());
						listnoBonus[i].x = start + i * distance;
						listnoBonus[i].y = h;
											
					listnoBonus[i].width = size;
					listnoBonus[i].height = size;
					
						addChild(listnoBonus[i]);
					}
					else
					{
						listnoBonus.push(new gNoBonus());
						listnoBonus[i].x = start + i * distance;
						listnoBonus[i].y = h;
											
					listnoBonus[i].width = size;
					listnoBonus[i].height = size;
					
						addChild(listnoBonus[i]);
					}
				}
			}
			
			else if (bonus_ == 3)
			{
				var listnoBonus:Vector.<Sprite> = new Vector.<Sprite>();
				for (var i:int = 0; i < 3; i++)
				{
					/*if (i == 0 || i == 1 || i == 2)
					{*/
						listnoBonus.push(new gBonus());
						listnoBonus[i].x = start + i * distance;
						listnoBonus[i].y = h;
											
					listnoBonus[i].width = size;
					listnoBonus[i].height = size;
					
						addChild(listnoBonus[i]);
					/*}
					else
					{
						listnoBonus.push(new gNoBonus());
						listnoBonus[i].x = 240 + i * 20;
						listnoBonus[i].y = 90;
						addChild(listnoBonus);
					}*/
				}
			}
			
		}
		
		override public function Stop():void 
		{
			Bonus.SetTempBonus( -1);
			
			if(bolt1)
			{	
				removeChild(bolt1);
				bolt1.stop();
				bolt1 = null;
			}
			
			if (wonBack)
			{
				wonBack.stop();
				removeChild(wonBack);
			}
			
			removeChild(grass);
			removeChild(sky);
			removeChild(cloud1);
			removeChild(cloud2);
			removeChild(cloud3);
			removeChild(tree1);
			removeChild(tree3);
			
			grass = null;
			sky = null;
			cloud1 = null;
			cloud2 = null;
			cloud3 = null;
			tree1 = null;
			tree3 = null;
			
			//removeChild(TextBonus);
			//TextBonus = null;
			super.Stop();
		}
		
	}

}