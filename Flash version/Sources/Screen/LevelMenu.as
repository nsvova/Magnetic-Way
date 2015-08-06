package  Screen
{
	import adobe.utils.CustomActions;
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.b2BroadPhase;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2EdgeShape;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Transform;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.*;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.TimerEvent;
	import flash.text.StaticText;
	import flash.utils.Timer;
//	import flash.automation.StageCapture;
//	import flash.display.NativeMenu;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import Box2D.Dynamics.b2ContactFilter;
	import flash.display.Bitmap;
	import flash.display.Loader
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	 
	public class LevelMenu extends GameScreen
	{
		
		//var levelNum:Game;
		var listLevels:Vector.<LevelButton>;
		
		var cloud1:Sprite;
		var cloud2:Sprite;
		var cloud3:Sprite;
		var tree1:Sprite;
		var tree2:Sprite;
		var tree3:Sprite;
		
		var grass:Sprite;
		var sky:Sprite;
		var sakura:Sprite;
		
		private var bolt1:MovieClip;
		private var bolt2:MovieClip;
		
		private var _sound:SimpleButton;
		private var _menu:SimpleButton;
		private var _next:SimpleButton;
		
		private var between:MovieClip;
		private var between2:MovieClip;
		
		
		private var tempButton:String;
		
		public function LevelMenu():void
		{
			//goMenu.addEventListener(MouseEvent.CLICK, click);
			
		}	
		
		
		private function chooseLevel(e:MouseEvent):void
		{
			var button:TextField = e.target as TextField;
			tempButton = button.text;
			
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerChooseLevel);
			
			between = new gWonBack();
			addChild(between);
			
			timer.start();

		}
		
		private function timerChooseLevel(e:TimerEvent):void 
		{
			var level:String = "Level" + tempButton;
			dispatchEvent( new StatusEvent( StatusEvent.STATUS, false, false, "", level ) );
			tempButton = null;
		}
		
		
		
		override public function Start():void
		{
			stop();
			
			sky = new gSky();
			addChild(sky);
			
			
			
			if (SoundEffect.SoundOn)
			{
				bolt1 = new gMainBolt();
				bolt1.x = 100;
				bolt1.y = 30;
				addChild(bolt1);
				
				
				bolt2 = new gBigMainBolt();
				bolt2.x = 300;
				bolt2.y = 100;
				addChild(bolt2);
			}
			else
			{
				bolt1 = new gMainBoltWithoutSound();
				bolt1.x = 100;
				bolt1.y = 30;
				addChild(bolt1);
				
				
				bolt2 = new gBigMainBoltWithoutSound();
				bolt2.x = 300;
				bolt2.y = 100;
				addChild(bolt2);
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
			
			sakura = new gSakura();
			sakura.y = 200;
			addChild(sakura);
			
			tree3 = new gTree3();
			tree3.x = 370;
			tree3.y = 180;
			addChild(tree3);
			
			tree2 = new gTree2();
			tree2.x = 250;
			tree2.y = 200;
			addChild(tree2);
			
			grass = new gGrass();
			grass.x = 0;
			grass.y = 400;
			addChild(grass);
			
			
			
			listLevels = FlashGrafic.drawManyLevelBoxs(10, 170, 170, 50, 50, 25, 5, 1);
			
			for (var i:uint = 0; i < listLevels.length; i++)
			{
				addChild(listLevels[i].button);
				addChild(listLevels[i].bonus);
				if (listLevels[i].textNum)
				{
					addChild(listLevels[i].textNum);
					listLevels[i].textNum.addEventListener(MouseEvent.CLICK, chooseLevel);
				}
				
			}
			
			
			//all_bonus = FlashGrafic.DrawText(Bonus.AllBonus().toString() + "", 270, 230, this);
			
			
			if (SoundEffect.SoundOn)
			{
				_sound = new soundOn();
				_sound.x = 30;
				_sound.y = 30;
				addChild(_sound);
			}
			else
			{
				_sound = new soundOff();
				_sound.x = 30;
				_sound.y = 30;
				addChild(_sound);
			}
			
			_menu = new mainMenu_button();
			_menu.x = 320;
			_menu.y = 450;
			addChild(_menu);
			
			var lastLevel:int = Save.GetLastLevel();
			
			if (lastLevel >= 10)
			{
				_next = new gNextLevels();
				_next.x = 540;
				_next.y = 450;
				addChild(_next);
				
				_next.addEventListener(MouseEvent.CLICK, clickNext);
			}
			
			
			between2 = new gWonBack2();
			addChild(between2);
			
			_menu.addEventListener(MouseEvent.CLICK, clickMenu);
			_sound.addEventListener(MouseEvent.CLICK, soundClick);
			
			addEventListener(Event.ENTER_FRAME , update);
		}
		
		private function clickMenu(e:MouseEvent):void 
		{
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerClickMenu);
			
			between = new gWonBack();
			addChild(between);
			
			timer.start();
		}
		
		private function timerClickMenu(e:TimerEvent):void 
		{
			dispatchEvent( new StatusEvent( StatusEvent.STATUS, false, false, "", "GoToMenu" ) );
		}
		
		
		private function clickNext(e:MouseEvent):void
		{
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerClicNext);
			
			between = new gWonBack();
			addChild(between);
			
			timer.start();
			
		}
		
		private function timerClicNext(e:TimerEvent):void 
		{
			dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "GoToLevelMenu2"));
		}
		
		
		private function soundClick(e:MouseEvent):void 
		{
			if (_sound is soundOn)
			{
				_sound.removeEventListener(MouseEvent.CLICK, soundClick);
				
				SoundEffect.StopAll();
				SoundEffect.SoundOn = false;
				Save.SoundOn(false);
				removeChild(_sound);
				
				_sound = new soundOff()
				_sound.x = 30;
				_sound.y = 30;
				addChild(_sound);
				
				ChangeBolt();
				
				_sound.addEventListener(MouseEvent.CLICK, soundClick);
				
			}
			else if (_sound is soundOff)
			{
				_sound.removeEventListener(MouseEvent.CLICK, soundClick);
				
				Save.SoundOn(true);
				SoundEffect.SoundOn = true;
				
				SoundEffect.PlayMain();
				
				removeChild(_sound);
				_sound = new soundOn()
				_sound.x = 30;
				_sound.y = 30;
				addChild(_sound);
				
				ChangeBolt();
				
				_sound.addEventListener(MouseEvent.CLICK, soundClick);
			}
		}
		
		
		private function ChangeBolt():void
		{
			if ((bolt1 is gMainBoltWithoutSound) && ( bolt2 is gBigMainBoltWithoutSound ))
			{
				removeChild(bolt1);
				bolt1.stop();
				bolt1 = new gMainBolt();
				bolt1.x = 100;
				bolt1.y = 30;
				addChildAt(bolt1,3);
				
				removeChild(bolt2);
				bolt2.stop();
				bolt2 = new gBigMainBolt();
				bolt2.x = 300;
				bolt2.y = 100;
				addChildAt(bolt2, 3);
			}
			
			else if ((bolt1 is gMainBolt) && ( bolt2 is gBigMainBolt))
			{
				removeChild(bolt1);
				bolt1.stop();
				bolt1 = new gMainBoltWithoutSound();
				bolt1.x = 100;
				bolt1.y = 30;
				addChildAt(bolt1, 3);
				
				removeChild(bolt2);
				bolt2.stop();
				bolt2 = new gBigMainBoltWithoutSound();
				bolt2.x = 300;
				bolt2.y = 100;
				addChildAt(bolt2,3);
			}
		}
		
		
		
		
		
		var all_bonus:TextField;
		
		private function removeAllListenrsLevel():void
		{
			for (var i:int = 0; i < listLevels.length; i++)
			{
				listLevels[i].button.removeEventListener(MouseEvent.CLICK, chooseLevel);
			}
		}
		
		override public function Stop():void
		{
			
			if (between)
			{
				between.stop();
				removeChild(between);
				between = null;
			}
			bolt1.stop();
			bolt2.stop();
			
			removeChild(cloud1);
			removeChild(cloud2);
			removeChild(cloud3);
			
			removeChild(tree2);
			removeChild(tree3);
			
			removeChild(grass);
			removeChild(sky);
			removeChild(sakura);
			
			cloud1 = null;
			cloud2 = null;
			cloud3 = null;
			
			tree2 = null;
			tree3 = null;
			
			sakura = null;
			
			grass = null;
			sky = null;
			
			
			FlashGrafic.DeleteAll(this);
			removeAllListenrsLevel();
			listLevels = null;
			//removeChild(all_bonus);
			removeEventListener(Event.ENTER_FRAME , update);
			
		}
		
		private function update(e:Event)
		{
			
		}
		
		
		private function ChooseLevelButton(button:SimpleButton):String
		{
			
			
			
			/*if (button is gLevel1)
			{
				var str:String = "Level" + "1" + "Help";
				return str;
			}
			else if (button is gLevel2)
			{
				var str:String = "Level" + "2" + "Help";
				return str;
			}
			else if (button is gLevel3)
			{
				var str:String = "Level" + "3";
				return str;
			}
			else if (button is gLevel4)
			{
				var str:String = "Level" + "4";
				return str;
			}
			else if (button is gLevel5)
			{
				var str:String = "Level" + "5";
				return str;
			}
			else if (button is gLevel6)
			{
				var str:String = "Level" + "6";
				return str;
			}
			else if (button is gLevel7)
			{
				var str:String = "Level" + "7";
				return str;
			}
			else if (button is gLevel8)
			{
				var str:String = "Level" + "8";
				return str;
			}
			else if (button is gLevel9)
			{
				var str:String = "Level" + "9";
				return str;
			}
			else if (button is gLevel10)
			{
				var str:String = "Level" + "10";
				return str;
			}
			else if (button is gLevel11)
			{
				var str:String = "Level" + "11";
				return str;
			}
			else if (button is gLevel12)
			{
				var str:String = "Level" + "12";
				return str;
			}
			else if (button is gLevel13)
			{
				var str:String = "Level" + "13";
				return str;
			}
			else if (button is gLevel14)
			{
				var str:String = "Level" + "14";
				return str;
			}
			else if (button is gLevel15)
			{
				var str:String = "Level" + "15";
				return str;
			}
			else if (button is gLevel16)
			{
				var str:String = "Level" + "16";
				return str;
			}
			else if (button is gLevel17)
			{
				var str:String = "Level" + "17";
				return str;
			}
			else if (button is gLevel18)
			{
				var str:String = "Level" + "18";
				return str;
			}
			else if (button is gLevel19)
			{
				var str:String = "Level" + "19";
				return str;
			}
			else if (button is gLevel20)
			{
				var str:String = "Level" + "20";
				return str;
			}*/
			
			return null;
			
		}
		
	}

}