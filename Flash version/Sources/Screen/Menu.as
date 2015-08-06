package  Screen
{
	import Box2DObject.my_contactListener;
	import fl.motion.MotionBase;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import mochi.as3.*;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public dynamic class Menu extends GameScreen 
	{
		
		private var _play:SimpleButton;
		private var _help:SimpleButton;
		private var _authors:SimpleButton;
		private var _sound:SimpleButton;
		
		private var bolt1:MovieClip;
		private var bolt2:MovieClip;
		
		private var vova:SimpleButton;
		private var music:SimpleButton;
		private var title:Sprite;
		
		var cloud1:Sprite;
		var cloud2:Sprite;
		var cloud3:Sprite;
		var tree1:Sprite;
		var tree2:Sprite;
		var tree3:Sprite;
		var sakura:Sprite;
		var sun:Sprite;
		var fall:Sprite;
		var fall2:Sprite;
		
		var grass:Sprite;
		var sky:Sprite;
		
		var isFirst:Boolean = true;
		
		private var between:MovieClip;
		private var between2:MovieClip;
		
		public function Menu() 
		{
			
			
		}
		

		
		private function clickPlay(e:MouseEvent):void 
		{
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerLevelMenu);
			
			between = new gWonBack();
			addChild(between);
			
			timer.start();
			
		}
		
		private function timerLevelMenu(e:TimerEvent):void 
		{
			dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "GoToLevelMenu"));
		}
		
		private function clickHelp(e:MouseEvent):void
		{
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerHelp);
			
			between = new gWonBack();
			addChild(between);
			
			timer.start();
		}
		
		private function timerHelp(e:TimerEvent):void 
		{
			dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "GoToHelp"));
		}
		
		private function clickAuthors(e:MouseEvent):void 
		{
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerAuthors);
			
			between = new gWonBack();
			addChild(between);
			
			timer.start();
			
		}
		
		private function timerAuthors(e:TimerEvent):void 
		{
			dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "GoToAuthors"));
		}
		
		
		
		
		
		
		override public function Start():void
		{
			
	
			
				if (SoundEffect.SoundOn && isFirst)
				{
					SoundEffect.FirstPlayMain();
					isFirst = false;
				}
			
			sky = new gSky();
			addChild(sky);
			
			/*if (SoundEffect.SoundOn)
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
			}*/
			
			sun = new gSun();
			sun.x = 90;
			sun.y = 20;
			addChild(sun);
			
			cloud3 = new gCloud3();
			cloud3.x = 700;
			cloud3.y = 100;
			addChild(cloud3);
			
			cloud1 = new gCloud1();
			cloud1.x = 30;
			cloud1.y = 55;
			addChild(cloud1);
			

			
			cloud2 = new gCloud2();
			cloud2.x = 350;
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
			
			fall = new gFalling();
			addChild(fall);
			fall2 = new gFalling2();
			addChild(fall2);
			
			vova = new gVova();
			vova.x = 470;
			vova.y = 380;
			addChild(vova);
			
			title = new gTitle();
			title.x = 320;
			title.y = 140;
			addChild(title);
			
			music = new gMusic();
			music.x = 0;
			music.y = 380;
			addChild(music);
			
			_play = new Play();
			_play.x = 320;
			_play.y = 240;
			addChild(_play);
			
			
			
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
			
			
			
			between2 = new gWonBack2();
			addChild(between2);
			
			_sound.addEventListener(MouseEvent.CLICK, soundClick);			
			_play.addEventListener(MouseEvent.CLICK, clickPlay);
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
		
		
		override public function Stop():void
		{
			
			//stop();
			//clip.play();
			
			if (between)
			{
				between.stop();
				removeChild(between);
				between = null;
			}
			
			
			removeChild(cloud1);
			removeChild(cloud2);
			removeChild(cloud3);
			
			removeChild(tree2);
			removeChild(tree3);
			
			removeChild(grass);
			removeChild(sky);
			removeChild(sakura);
			removeChild(sun);
			removeChild(fall);
			removeChild(fall2);
			
			cloud1 = null;
			cloud2 = null;
			cloud3 = null;
			
			fall = null;
			fall2 = null;
			
			tree1 = null;
			tree2 = null;
			tree3 = null;
			
			grass = null;
			sky = null;
			sakura = null;
			sun = null;
			
			
			removeChild(vova);
			removeChild(music);
			removeChild(title);
			
			title = null;
			vova = null;
			music = null;
			
			
			
			removeChild(_play);
			_play = null;
		}
		
	}

}