package Screen.Level 
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
	import Box2D.Dynamics.b2DestructionListener;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.*;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
//	import mx.core.FlexSimpleButton;
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
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import flash.display.MovieClip;
	import Screen.GameScreen;
	import Box2DObject.*;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Game extends GameScreen
	{
		
		protected var _world:b2World;
		protected const worldScale:Number = 30.0;
		private var mouseJoint:b2MouseJoint;
		private var _contact:my_contactListener;
		static public var levelNum:int = -1;
		static public var isEndLevel:Boolean = false;//if user finished level(but he don't has to won it level)
		static public var isWon:Boolean = false;
		static public var isDied:Boolean = false;
		protected var bonus:Bonus;

		protected var Persone:b2Body;
		protected var dataPerson:UserData;
		
		private var tempBody:b2Body;
		private var sp:Sprite = new Sprite();
		private var isDeletePause:Boolean = false;
		private var joint:Joints;
		private var isJump:Boolean;
		private var isUpdate:Boolean = true;
		private var isGroundClick:Boolean = true;
		
		protected var isHorisontallyUpdate:Boolean = false;
		protected var isApeakUpdate:Boolean = false;
		
		private const EXIT_LEVEL:int = -2;
		private const RESUME:int = -3;
		private const RESTART:int = -4;
		
		private var pause:SimpleButton;
		private var resume:SimpleButton;
		private var exit:SimpleButton;
		private var restart:SimpleButton;
		private var _sound:SimpleButton;
		private var _effect:SimpleButton;
		
		protected var isScroll:Boolean = false;
		protected var gSprite:Sprite;
		
		protected var canMoveRope:Boolean = false;
		
		static private var nodeAndPerson:Vector.<b2Body>;
		private var energy:int = 0;
		private var maxEnergy:int = 0;
		private var energySprite:Sprite;
		
		
		private var bolt1:MovieClip;
		private var bolt2:MovieClip;
		
		protected var clickHere:Sprite;
		
		private var between:MovieClip;
		private var wasBetween:Boolean = true;
		
		private var spriteList:Vector.<Sprite>;

		
		public function Game(sp:Sprite, _levelNum:int) 
		{
			//"sp" has to be the global Sprite;
			
			spriteList = new Vector.<Sprite>();
			
			InputKeyboard.addKeyboardListener(sp);
			
			energy = 2;
			maxEnergy = 2;
			isWon = false;
			isEndLevel = false;
			isDied = false;
			
			gSprite = sp;
			
			levelNum = _levelNum;
			if (levelNum == 1)
			{
				clickHere = new gClickHere();
			}
			
			bonus = new Bonus(this);
			bonus.GetFromFile();
			bonus.SetLastBonusPoint(levelNum);
			bonus.DeleteBonusPoints(levelNum);
			
			gSprite.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);//listener for ropes and other objects
			//gSprite.stage.addEventListener(MouseEvent.MOUSE_UP, click);//test if person can jump
			
			pause = new pause_button();
			pause.x = 30;
			pause.y = 30;
			
			gSprite.stage.addChild(pause);
			pause.addEventListener(MouseEvent.MOUSE_DOWN, pauseClick);
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
//Functions for scroll world**************************************************************************************

		private function LeftScroll():void
		{
			this.x -= 3;
		}
		
		private function RightScroll():void
		{
			this.x += 3;
		}
		
		private function UpScroll():void
		{
			this.y -= 4;
		}
		
		private function DownScroll():void
		{
			this.y += 4;
		}
		
		protected var _height:Number = 0;
		
		private function ScrollWolrdForPerson():void
		{
			//var pers:b2Vec2 = Calc.CMeterToPixel(Persone.GetPosition() , worldScale);
			var mouse:b2Vec2 = Calc.CMeterToPixel(LocationMouse(), worldScale);
				if ( /*(pers.y < ( ( -this.y) + 100) ) ||*/
						( mouse.y < ( ( -this.y) + 100) ))
				{
					if(this.y <= _height - 480 - 4)
						DownScroll();
					
					/*if (!(Math.abs(this.y) <= _height) )
						UpScroll();*/
				}
				
				if ( /*(pers.y > -this.y + 480 - 100) ||*/
					( mouse.y > -this.y + 480 - 100))
				{
					if(this.y >= 4)
						UpScroll();
					/*if (!((this.y + 480) <=  480))
					{
						DownScroll();
					}*/
				}
		}

//***************************************************************************************************************
		
		
		
		
		
		
		



		
//Listeners for pause, resume, restart and exit *****************************************************************

		private function pauseClick(e:MouseEvent):void 
		{
			Mouse.show();
			isUpdate = false;
			
			resume = new resume_button();
			resume.x = 320;
			resume.y = 160;
			
			restart = new restart_button();
			restart.x = 320;
			restart.y = 230;
			
			exit = new mainMenu_button();
			exit.x = 320;
			exit.y = 300;
			
			
			gSprite.stage.addChild(exit);
			gSprite.stage.addChild(restart);
			gSprite.stage.addChild(resume);
			
			
			if (SoundEffect.SoundOn)
			{
				_sound = new soundOn();
				_sound.x = 290;
				_sound.y = 30;
				gSprite.stage.addChild(_sound);
			}
			else
			{
				_sound = new soundOff();
				_sound.x = 290;
				_sound.y = 30;
				gSprite.stage.addChild(_sound);
			}
			
			
			
			if (SoundEffect.isEffectOn)
			{
				_effect = new gSoundEffect();
				_effect.x = 350;
				_effect.y = 30;
				gSprite.stage.addChild(_effect);
			}
			else
			{
				_effect = new gSoundEffectOff();
				_effect.x = 350;
				_effect.y = 30;
				gSprite.stage.addChild(_effect);
			}
			
			
			pause.removeEventListener(MouseEvent.CLICK, pauseClick);
			gSprite.stage.removeChild(pause);
			
			resume.addEventListener(MouseEvent.CLICK, resumeClick);
			exit.addEventListener(MouseEvent.CLICK, exitClick);
			restart.addEventListener(MouseEvent.CLICK, restartClick);
			gSprite.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_sound.addEventListener(MouseEvent.CLICK, soundClick);	
			_effect.addEventListener(MouseEvent.CLICK, effectClick);
		}
		
		private function effectClick(e:MouseEvent):void 
		{
			if (_effect is gSoundEffect)
			{
				_effect.removeEventListener(MouseEvent.CLICK, effectClick);
				
				SoundEffect.isEffectOn = false;
				gSprite.stage.removeChild(_effect);
				
				_effect = new gSoundEffectOff()
				_effect.x = 350;
				_effect.y = 30;
				gSprite.stage.addChild(_effect);
				
				_effect.addEventListener(MouseEvent.CLICK, effectClick);
				
			}
			else if (_effect is gSoundEffectOff)
			{
				_effect.removeEventListener(MouseEvent.CLICK, effectClick);
				
				SoundEffect.isEffectOn = true;
				
				gSprite.stage.removeChild(_effect);
				_effect = new gSoundEffect()
				_effect.x = 350;
				_effect.y = 30;
				gSprite.stage.addChild(_effect);
				
				
				_effect.addEventListener(MouseEvent.CLICK, effectClick);
				
			}
		}
		
		private function restartClick(e:MouseEvent):void 
		{
			//isEndLevel = true;
			DestroyWorld();
			RemoveResumExitRestartButtons();
			dispatchEvent( new StatusEvent( StatusEvent.STATUS, false, false, "", "Level" + levelNum.toString() ) );
		}
		
		private function exitClick(e:MouseEvent):void 
		{

			//isEndLevel = true;
			RemoveResumExitRestartButtons();
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerExitClick);
			
			between = new gWonBack();
			addChild(between);
			
			timer.start();
			
		}
		
		private function timerExitClick(e:TimerEvent):void 
		{
			DestroyWorld();
			dispatchEvent( new StatusEvent( StatusEvent.STATUS, false, false, "", "GoToLevelMenu" ) );
		}
		
		private function resumeClick(e:MouseEvent):void
		{
				RemoveResumExitRestartButtons();
			
				gSprite.stage.addChild(pause);
				pause.addEventListener(MouseEvent.CLICK, pauseClick);
				
				isUpdate = true;
				
				gSprite.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		
		private function RemoveResumExitRestartButtons()
		{
			    resume.removeEventListener(MouseEvent.CLICK, resumeClick);
				gSprite.stage.removeChild(resume);
				
				restart.removeEventListener(MouseEvent.CLICK, restartClick);
				gSprite.stage.removeChild(restart);
			
				exit.removeEventListener(MouseEvent.CLICK, exitClick);
				gSprite.stage.removeChild(exit);
				
				if (_sound)
				{
					gSprite.stage.removeChild(_sound);
					_sound.removeEventListener(MouseEvent.CLICK, soundClick);
					_sound = null;
				}
				
				if (_effect)
				{
					gSprite.stage.removeChild(_effect);
					_effect.removeEventListener(MouseEvent.CLICK, effectClick);
					_effect = null;
				}
				
		}
		
		
		private function RemovePauseButton():void
		{
			if (!isDeletePause)
			{
				if (pause)
				{
					pause.removeEventListener(MouseEvent.CLICK, pauseClick);
					gSprite.stage.removeChild(pause);
					isDeletePause = true;
					pause = null;
				}
			}
		}
		
		
		
		
		private function soundClick(e:MouseEvent):void 
		{
			if (_sound is soundOn)
			{
				_sound.removeEventListener(MouseEvent.CLICK, soundClick);
				
				SoundEffect.StopAll();
				SoundEffect.SoundOn = false;
				Save.SoundOn(false);
				gSprite.stage.removeChild(_sound);
				
				_sound = new soundOff()
				_sound.x = 290;
				_sound.y = 30;
				gSprite.stage.addChild(_sound);
				
				ChangeBolt();
				
				_sound.addEventListener(MouseEvent.CLICK, soundClick);
				
			}
			else if (_sound is soundOff)
			{
				_sound.removeEventListener(MouseEvent.CLICK, soundClick);
				
				Save.SoundOn(true);
				SoundEffect.SoundOn = true;
				
				SoundEffect.PlayMain();
				
				gSprite.stage.removeChild(_sound);
				_sound = new soundOn()
				_sound.x = 290;
				_sound.y = 30;
				gSprite.stage.addChild(_sound);
				
				ChangeBolt();
				
				_sound.addEventListener(MouseEvent.CLICK, soundClick);
				
			}
		}
		
		
		
		private function ChangeBolt():void
		{
			if ((bolt1 is gMainBoltWithoutSound) && ( bolt2 is gBigMainBoltWithoutSound ))
			{
				var ind:int = getChildIndex(bolt1);
				var _x:Number = bolt1.x;
				var _y:Number = bolt1.y;
				
				removeChild(bolt1);
				bolt1.stop();
				bolt1 = new gMainBolt();
				bolt1.x = _x;
				bolt1.y = _y;
				addChildAt(bolt1,ind);
				
				ind = getChildIndex(bolt2);
				
				_x = bolt2.x;
				_y = bolt2.y;
				
				removeChild(bolt2);
				bolt2.stop();
				bolt2 = new gBigMainBolt();
				bolt2.x = _x;
				bolt2.y = _y;
				addChildAt(bolt2, ind);
			}
			
			else if ((bolt1 is gMainBolt) && ( bolt2 is gBigMainBolt))
			{
				var ind:int = getChildIndex(bolt1);
				var _x:Number = bolt1.x;
				var _y:Number = bolt1.y;
				
				removeChild(bolt1);
				bolt1.stop();
				bolt1 = new gMainBoltWithoutSound();
				bolt1.x = _x;
				bolt1.y = _y;
				addChildAt(bolt1, ind);
				
				ind = getChildIndex(bolt2);
				_x = bolt2.x;
				_y = bolt2.y;
				
				
				removeChild(bolt2);
				bolt2.stop();
				bolt2 = new gBigMainBoltWithoutSound();
				bolt2.x = _x;
				bolt2.y = _y;
				addChildAt(bolt2,ind);
			}
		}
		
//*************************************************************************************************	













//Function for start or stop some proces behind and after change screen ****************************
		override public function Start():void 
		{
			super.Start();
		}
		
		override public function Stop():void 
		{
			super.Stop();
			
			if (between)
			{
				between.stop();
				removeChild(between);
				between = null;
			}
			
			if (won)
			{
				won.stop();
				won = null;
			}
			
			if (bolt1)
			{
				bolt1.stop();
				removeChild(bolt1);
				bolt1 = null;
			}
			if (bolt2)
			{
				bolt2.stop();
				removeChild(bolt2);
				bolt2 = null;
			}
			
			for (var i:int = 0; i < spriteList.length; i++)
			{
				if (spriteList[i])
				{
					if (contains(spriteList[i]))
					{
						removeChild(spriteList[i]);
						spriteList[i] = null;
					}
				}
			}
			
			Mouse.show();
			if (_world)
			{
				DestroyWorld();
				gSprite.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				gSprite.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				gSprite.stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeave);
				gSprite.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				
				if (isWon)
				{
					if(Bonus.GetBonusPoints(levelNum) >= Bonus.GetLastBonusPoints())
					{
						Bonus.SetTempBonus(Bonus.GetBonusPoints(levelNum));
						Bonus.SaveBonus(levelNum);
					}
					else
					{
						Bonus.SetTempBonus(Bonus.GetBonusPoints(levelNum));
					}
					
					RemovePauseButton();
					
				}
				
				
				bonus.DeleteAllBonus();
				
				//isEndLevel = false;
			}
			
			
		}
//******************************************************************************************************	


		protected function AddRadius():void
		{
			clickHere = new gRadius1();
			addChild(clickHere);
		}
		
		//add cloud on screen ( num might be 1, 2, 3 or 4)
		protected function AddCloud( x:int, y:int, num:int = 1):void
		{
			if (num == 1)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gCloud1(), "cloud");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				
				addChild(spriteList[len]);
			}
			else if (num == 2)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gCloud2(), "cloud");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
			else if (num == 3)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gCloud3(), "cloud");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
			else if (num == 4)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gCloud4(), "cloud");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
		}
		
		protected function AddMountains(x:int, y:int):void
		{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gMountains(), "mountains");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
		}
		
		//num = 1 for height = 480(standart height), and num = 2 for height = 680;
		protected function AddSky(num:int = 1):void
		{
			if (num == 1)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gSky(), "sky");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
			else if (num == 2)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gSky2(), "sky2");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
		}
		
		//num = 1 or num = 2 for big lightninge;
		protected function AddLighninge(x:int, y:int, num:int = 1):void
		{
			if (num == 1)
			{
				bolt1 = new gMainBolt(); 
				bolt1.x = x;
				bolt1.y = y;
				addChild(bolt1);
				
				spriteList.push(null);
			}
			else if (num == 2)
			{
				bolt2 = new gBigMainBolt(); 
				bolt2.x = x;
				bolt2.y = y;
				addChild(bolt2);
				
				spriteList.push(null);
			}
		}
		
		
		//num = 1 or 2, lightninges without sound
		protected function AddLighningeWithoutSound( x:int, y:int, num:int = 1):void
		{
			if (num == 1)
			{
				bolt1 = new gMainBoltWithoutSound(); 
				bolt1.x = x;
				bolt1.y = y;
				addChild(bolt1);
				
				spriteList.push(null);
			}
			else if (num == 2)
			{
				bolt2 = new gBigMainBoltWithoutSound(); 
				bolt2.x = x;
				bolt2.y = y;
				addChild(bolt2);
				
				spriteList.push(null);
			}
		}
		//num = 1, 2 or 3;
		protected function AddTree( x:int, y:int, num:int = 1):void
		{
			if (num == 1)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gTree1(), "tree");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
			else if (num == 2)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gTree2(), "tree");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
			else if (num == 3)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gTree3(), "tree");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
		}
		
		
		protected function AddSun(x:int, y:int):void
		{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gSun(), "sun");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
		}
		
		protected function AddSakura(x:int, y:int):void
		{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gSakura(), "sakura");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
		}
		
		protected function AddFalling(x:int, y:int, num:int):void
		{
			if (num == 1)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gFalling(), "falling");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
			else if (num == 2)
			{
				var len:int = spriteList.length;
				
				var sd:SpriteData = new SpriteData(new gFalling2(), "falling");
				
				spriteList.push(sd.sprite);
				spriteList[len].x = x;
				spriteList[len].y = y;
				addChild(spriteList[len]);
			}
		}
		
//***************************************************************************************************************
		
		
		
		
		
		
		










//Listenrs for for control the world's objects*******************************************************************			
		private function mouseDown(e:MouseEvent):void 
		{
			if (_world)
			{
				_world.QueryPoint(myCallBack, LocationMouse());
				if (isGroundClick)
				{
					click();
				}
				isGroundClick = true;
			}
		}
		
		private function click():void 
		{
			
			if (Calc.GetDistanse(Calc.CMeterToPixel(Persone.GetPosition(), worldScale), new b2Vec2(mouseX, mouseY)) <= 150)
			{
						//далі в циклі перевірка чи персон може стрибати
						var flag:Boolean = true;
						
						
						
							if (energy > 0 && !dataPerson.isJointPerson)
								{
									isJump = true;
									flag = false;
								}
								
							if (flag) 
							{
								var h:Number;
								isJump = false;
							}
						
						if (isJump)
						{
							var flag2:Boolean = true;
							var pos:b2Vec2 = new b2Vec2(Persone.GetPosition().x * worldScale, Persone.GetPosition().y * worldScale);
							var vecVelocity:b2Vec2 = Calc.CreateVectorVelocityWithEnergy(mouseX, mouseY, pos,maxEnergy, energy);
							
							isJump = false;
							
							var contactList:b2ContactEdge = Persone.GetContactList();
							
							while (contactList)
							{
								var uData:UserData = contactList.contact.GetFixtureA().GetBody().GetUserData();
								var uDataB:UserData = contactList.contact.GetFixtureB().GetBody().GetUserData();
								if (uData.objectName == "floor" ||
									( uData.objectName == "person" && uDataB.objectName == "floor" ) )
								{
									flag2 = false;
								}
								contactList = contactList.next;
							}
							if (flag2)
							{
								energy--;
								ChangeRadius(energy);
							}
							
							Persone.SetLinearVelocity(vecVelocity);
						}

			}
				
		}
		

		
		private function mouseUp(e:MouseEvent):void 
		{
			
			var tempBodyData:UserData;
			if(tempBody != null)
				tempBodyData = tempBody.GetUserData();
			
			
		if (tempBodyData)
			if (tempBodyData.objectName == "node" || tempBodyData.objectName == "node2")
			{
				if (!tempBodyData.isJointNode)
				{
				
					for (var i:uint = 0; i < Rope.listCircles.length; i++)
						{
							if ( (tempBody.GetPosition().x * worldScale >= Rope.listCircles[i].x - Rope.listCircles[i].radius) &&
								 (tempBody.GetPosition().y * worldScale >= Rope.listCircles[i].y - Rope.listCircles[i].radius) &&
								 (tempBody.GetPosition().x * worldScale <= Rope.listCircles[i].x + Rope.listCircles[i].radius) &&
								 (tempBody.GetPosition().y * worldScale <= Rope.listCircles[i].y + Rope.listCircles[i].radius)
								 )
								{
									joint.CreateRevoluteJointToVector(_world.GetGroundBody(), tempBody, new b2Vec2(Rope.listCircles[i].x, Rope.listCircles[i].y), "nodeJoint");
									
									//далі позначаю мотузкy як підвішеною
									tempBodyData.isJointNode = true;
									Rope.SetJointRope(tempBodyData, true);
									
									
									var otherNode:b2Body = Rope.GetOtherNode(tempBodyData);
									ChangeGroup(otherNode, 0);
									break;
								}	
						}
				}
				
				/*if (tempBodyData.isJointPerson)
				{
					joint.DestroyAllJoints(Persone);
					
					var dataPerson:UserData = Persone.GetUserData();
					dataPerson.isJointPerson = false;
					
					tempBodyData.isJointPerson = false;
				}*/
			}
				tempBody = null;
				
				if (mouseJoint != null)
					_world.DestroyJoint(mouseJoint);
				mouseJoint = null;
			
				if (gSprite.stage)
				{
					gSprite.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
					gSprite.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				}
		}
	
		
		private function mouseMove(e:MouseEvent):void 
		{
			if (mouseJoint != null)
			{
				mouseJoint.SetTarget(LocationMouse());
			}
		}
		
		
		private function myCallBack(fix:b2Fixture):Boolean
		{
			
			//if(fix.GetBody() != null)
			tempBody = fix.GetBody();
			var tempBodyData:UserData = tempBody.GetUserData();
			if ((tempBodyData.objectName == "node" || tempBodyData.objectName == "node2") && canMoveRope)
			{

			
					var jointList:b2JointEdge = tempBody.GetJointList();
					var fixList:b2Fixture = tempBody.GetFixtureList();
					
					while (jointList != null)
					{
							if ( jointList.joint.GetUserData() == "nodeJoint")
							{
								tempBodyData.isJointNode = false;
								Rope.SetJointRope(tempBodyData, false);
								_world.DestroyJoint(jointList.joint);
								
								var otherNode:b2Body = Rope.GetOtherNode(tempBodyData);
								var OtherNodeData:UserData = otherNode.GetUserData();
								
								if (OtherNodeData.isJointPerson)
								{
									joint.DestroyAllJoints(Persone);
									
									var dataPerson:UserData = Persone.GetUserData();
										dataPerson.isJointPerson = false;
										
									OtherNodeData.isJointPerson = false;
								}
								
								ChangeGroup(otherNode, -1);
								
								//isGroundClick = false;
								break;
							}
							
							jointList = jointList.next;
					}	
							
						
				if ( tempBodyData.objectName == "node" || tempBodyData.objectName == "node2" )
				{
					
					mouseJoint = joint.mouseJoint(_world.GetGroundBody(), tempBody, LocationMouse(), 500 * tempBody.GetMass());
					
					gSprite.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
					gSprite.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
					gSprite.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave);
					
				}
				/*else if (tempBodyData.objectName == "person")
				{
					if (tempBodyData.isJointPerson)
					{
						mouseJoint = joint.mouseJoint(_world.GetGroundBody(), tempBody, LocationMouse(), 500 * tempBody.GetMass());
					
						gSprite.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
						gSprite.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
						gSprite.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave);
					}
				}*/
				else
				{
					mouseJoint = null;
					tempBody = null;
				}
				isGroundClick = false;
			}
			else if ( tempBodyData.objectName == "node" || tempBodyData.objectName == "node2" )
				{
					
					mouseJoint = joint.mouseJoint(_world.GetGroundBody(), tempBody, LocationMouse(), 500 * tempBody.GetMass());
					
					gSprite.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
					gSprite.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
					gSprite.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave);
				}

			return false;
			
		}
		
		
		private function mouseLeave(e:Event):void 
		{
			if (gSprite.stage)
			{
				gSprite.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				gSprite.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
			if (mouseJoint != null)
				_world.DestroyJoint(mouseJoint);
		}
		
		
//*************************************************************************************************		














//Box2D's functions********************************************************************************	

		protected function CreateWorld(gravityX:Number, gravityY:Number, Sleep:Boolean):void
		{
			_world = new b2World(new b2Vec2(gravityX, gravityY), Sleep);
			_world.GetGroundBody().SetUserData(new UserData( -1, "ground"));
			
			_contact = new my_contactListener();
			_world.SetContactListener(_contact);
			
			joint = new Joints(_world, worldScale);
			
			//gSprite.stage.addEventListener(Event.ENTER_FRAME, _update);
		}
		
		
					
		protected function GetPerson():b2Body
		{
			return Persone;
		}
		

		
		
		protected function CreatePersone(x:Number, y:Number, radius:Number):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(x / worldScale, y / worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			
			var data:UserData = new UserData( -1, "person");
			data.textureInfo = "person";
			data.textureChange = true;
			bodyDef.userData = data;
			dataPerson = data;
			
			var fixDef:b2FixtureDef = new b2FixtureDef();
			fixDef.shape = new b2CircleShape(radius / worldScale);
			fixDef.density = 2;
			fixDef.friction = 1;
			fixDef.restitution = 0.0;
			/////
			fixDef.filter.groupIndex = -1;
			////
			
			var personeBody:b2Body = _world.CreateBody(bodyDef);
			personeBody.CreateFixture(fixDef);
			
			fixDef = null;
			bodyDef = null;
			
			//joint.CreateFrictionJoint(personeBody, _world.GetGroundBody(), personeBody.GetPosition());
			
			Persone = personeBody;
			return personeBody;
		}
		
		
		protected function CreateStaticCircle(x:Number, y:Number, radius:Number, _userData:UserData):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set( x  / worldScale, y/ worldScale);
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.userData = _userData;
			
			var circle:b2CircleShape = new b2CircleShape(radius / worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.density = 1;
			fixtureDef.friction = 0.5;
			fixtureDef.restitution = 0.0;
			fixtureDef.shape = circle;
			
			var body:b2Body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			bodyDef = null;
			circle = null;
			fixtureDef = null;
			
			return body;
		}
		
		protected function CreateDynamicCircle(x:Number, y:Number, radius:Number, _userData:UserData):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set( x  / worldScale, y/ worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = _userData;
			
			var circle:b2CircleShape = new b2CircleShape(radius / worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.density = 1;
			fixtureDef.friction = 0.5;
			fixtureDef.restitution = 0.0;
			fixtureDef.shape = circle;
			
			var body:b2Body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			bodyDef = null;
			circle = null;
			fixtureDef = null;
			
			return body;
		}
		
		
		protected function CreateDynamicBox(x:Number, y:Number, width:Number, height:Number):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(x  / worldScale, y / worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			
			
			var box:b2PolygonShape = new b2PolygonShape();
			box.SetAsBox((width / 2) / worldScale, (height / 2) / worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = box;
			fixtureDef.density = 1;
			
			var body:b2Body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			bodyDef = null;
			box = null;
			fixtureDef = null;
			
			return body;
		}

		
		protected function CreateStaticBox(x:Number, y:Number, width:Number, height:Number, uData:UserData):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(x  / worldScale, y / worldScale);
			
			if (uData.objectName == "die")
			{
				uData.width = width;
				uData.height = height;
				if ( width > height)
				{
					if (width > 200)
						uData.textureInfo = "dieBoxLongH";
					else
						uData.textureInfo = "dieBoxH";
				}
				else
				{
					if (height >= 200)
						uData.textureInfo = "dieBoxLong";
					else
						uData.textureInfo = "dieBox";
				}
				uData.textureChange = true;
			}
			else if (uData.objectName == "floor")
			{
				uData.width = width;
				uData.height = height;
				
				if (width >= height)
				{
					if (width > 500)
					{
						uData.textureInfo = "floor3";
					}
					else if (width <= 500 && width > 180)
					{
						uData.textureInfo = "floor2";
					}
					else
					{
						uData.textureInfo = "floor1";
					}
				}
				else
				{
					if (height > 500)
					{
						uData.textureInfo = "floor3V";
					}
					else if (height <= 500 && height > 160)
					{
						uData.textureInfo = "floor2V";
					}
					else
					{
						uData.textureInfo = "floor1V";
					}
				}
				uData.textureChange = true;
			}
			else if (uData.objectName == "winWall")
			{
				uData.width = width;
				uData.height = height;
				
				if (width > height)
				{
					uData.textureInfo = "winWallH";
					uData.textureChange = true;
				}
				else
				{
					uData.textureInfo = "winWall";
					uData.textureChange = true;
				}
			}
			else if (uData.objectName == "wall")
			{
				if (width > height)
				{
					uData.textureInfo = "wallH";
					uData.width = width;
					uData.height = height;
				}
				else
				{
					uData.textureInfo = "wall";
					uData.width = width;
					uData.height = height;
				}
				uData.textureChange = true;
			}
			
			bodyDef.userData = uData;
			
			var box:b2PolygonShape = new b2PolygonShape();
			box.SetAsBox((width / 2) / worldScale, (height / 2) / worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = box;
			fixtureDef.density = 10;
			fixtureDef.friction = 1;
			fixtureDef.restitution = 0.0;
			
			var body:b2Body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			bodyDef = null;
			box = null;
			fixtureDef = null;
			
			return body;
		}
		
		
		protected function debugDraw():void
		{
			var dDraw:b2DebugDraw = new b2DebugDraw();
			
			var sprite:Sprite = new Sprite();
			addChild(sprite);
			dDraw.SetAlpha(0.5);
			dDraw.SetDrawScale(worldScale);
			dDraw.SetSprite(sprite);
			
			dDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit /*| b2DebugDraw.e_centerOfMassBit*/);

			_world.SetDebugDraw(dDraw);
		}
		
		
		private function ChangeGroup(body:b2Body, group:int):void
		{
					var fix:b2Fixture = body.GetFixtureList();
					var fd:b2FilterData = new b2FilterData();
					fd.groupIndex = group;
					fix.SetFilterData(fd);
		}
		
		
		protected function DestroyWorld()
		{
			var p:b2Body;
			
			Rock.DestroyRocks();
			Rope.DestroyRopes();
			
			if(_world)
			for (p = _world.GetBodyList(); p; p = p.GetNext())
			{
				_world.DestroyBody(p);
			}
		
			_world = null;
		}
	
		
		
//*******************************************************************************************************************













//Some other functions********************************************************************************************
		
		protected function _update(e:Event):void 
		{
			if (isUpdate)
			{
				
				if (!isEndLevel)
				{
					_world.Step(1 / 30, 3, 3);
					_world.ClearForces();
				}
					//_world.DrawDebugData();
					
					if (isScroll)
						ScrollWolrdForPerson();
					
						
					VerifyDistanseNodeAndPerson();
						
					if (InputKeyboard.keyDown)
					{			
						if (InputKeyboard.pressKey == 32 || InputKeyboard.lastKey == 32)//Space
						{
 							var jointList:b2JointEdge = Persone.GetJointList();
							while (jointList != null)
							{
								if (jointList.joint.GetUserData() == "personRope")
								{
									_world.DestroyJoint(jointList.joint);
									dataPerson = Persone.GetUserData();
									dataPerson.isJointPerson = false;
								}
								jointList = jointList.next;	
							}
						}
						
					}
					
					
					var p:b2Body;
					var spr:UserData;
					
					for (p = _world.GetBodyList(); p; p = p.GetNext())
					{
						
						spr = p.GetUserData();
						if (spr.textureChange)
						{
							ChangeTexture(p);
						}
						
						if (spr)
						{
							
							if (spr.texture != null)
							{
								spr.texture.x = p.GetPosition().x*worldScale;
								spr.texture.y = p.GetPosition().y*worldScale;
								spr.texture.rotation = p.GetAngle() * 180 / Math.PI;
							}
							
							if (spr.objectName == "delete")
								_world.DestroyBody(p);
						}
					}
					
					if (energySprite)
					{
						energySprite.x = Persone.GetPosition().x * 30;
						energySprite.y = Persone.GetPosition().y * 30;
					}
					
					
					
					
					
					//if person cougth bonus( I think it's clear =) )
					if(Persone)
						if (bonus.isPersonCatchABonus(Persone.GetPosition()) != -1)
						{
							var i:int = bonus.isPersonCatchABonus(Persone.GetPosition());
							bonus.Delete(i);
							bonus.SetBonusPoints(levelNum, i);
							
							var deleteBonus:Sprite = new gBonusCought();
							deleteBonus.x = bonus.GetX(i);
							deleteBonus.y = bonus.GetY(i);
							
							addChild(deleteBonus);
						}
						
					UpdateRadius();
					
					//if person near a rock
					var _rock:Vector.<b2Body> = Rock.isPersonNearTheRock(Persone.GetPosition(), 120);
					if ( _rock != null)
					{
						Rock.SetActiveRocks(_rock, Persone.GetPosition());
						_rock = null;
					}
					
					IsMouseNearPerson(Persone.GetPosition());
					Rope.VerifiDistanceForRope(Persone);
						
					//if person died
					if (isDied && isDieFlag)
					{
						dataPerson.textureInfo = "personDie";
						dataPerson.textureChange = true;
						RemovePauseButton();
						isEndLevel = true;
						
						var timer:Timer = new Timer(1000, 1);
						timer.addEventListener(TimerEvent.TIMER, timerHandler);
						timer.start();
						
						isDieFlag = false;
						
						if (SoundEffect.isEffectOn)
						{
							SoundEffect.PlayDie();
						}
					}
					InputKeyboard.update();
					
					
				if (isWon)
				{
					ChangeRadius(0);
					RemovePauseButton();
					
					var timer:Timer = new Timer(600, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, personWon);
					timer.start();
					
					isUpdate = false;
					
					won = new gWonBack();
					
					addChild(won);
					
					if(SoundEffect.isEffectOn)
						SoundEffect.PlayWon();
					
				}
				
				
				if (isApeakUpdate && !isEndLevel)
				{
					DynamicBox.SpeedApeak();
				}
				if (isHorisontallyUpdate && !isEndLevel)
				{
					DynamicBox.SpeedHorizontally();
				}
				
				if (wasBetween)
				{
					between = new gWonBack2();
					addChild(between);
					between = null;
					wasBetween = false;
				}
			}
			
		}
		
		
		private var won:MovieClip = null;
		
		private function personWon(e:TimerEvent):void 
		{
				won.stop();
				removeChild(won);
				dispatchEvent( new StatusEvent( StatusEvent.STATUS, false, false, "", "GoToResult" ) );
		}
		
		
		
		
		
		
		
		
		
		
		
		private var isDieFlag:Boolean = true;
		
		private function timerHandler(e:TimerEvent):void 
		{
			isDiedFinction();
		}
		
		
		private function isDiedFinction():void
		{
			DestroyWorld();
				var str:String = "Level" + levelNum.toString();
				isUpdate = false;
				Stop();
				//RemovePauseButton();
				dispatchEvent( new StatusEvent( StatusEvent.STATUS, false, false, "", str ) );
		}
		
		
		private function VerifyDistanseNodeAndPerson():void
		{
			if (nodeAndPerson)
			{
				if (   Calc.GetDistanse(  Calc.CMeterToPixel(nodeAndPerson[0].GetPosition(), worldScale),
						Calc.CMeterToPixel( nodeAndPerson[1].GetPosition(), worldScale ))      > 60 
				      )
					  {
						  joint.DestroyAllJoints(Persone);
						  
						  var data:UserData = nodeAndPerson[0].GetUserData();
						  data.isJointPerson = false;
						  
						  data = nodeAndPerson[1].GetUserData();
						  data.isJointPerson = false;
						  
						  nodeAndPerson = null;
					  }
			}
		}
		
		
		
		
		
		
		private function ChangeTexture(body:b2Body ):void
		{
			var data:UserData = body.GetUserData();
			
			switch(data.textureInfo)
			{
				case "winWall":
					{
						if (data.texture)
							removeChild(data.texture);
						data.texture = new gWinWall();
						data.texture.width = data.width;
						data.texture.height = data.height;
						
						addChild(data.texture);
						break;
					}
				case "winWallH":
					{
						if (data.texture)
							removeChild(data.texture);
						data.texture = new gWinWallH();
						data.texture.width = data.width;
						data.texture.height = data.height;
						
						addChild(data.texture);
						break;
					}
				case "node":
					{
						if (data.texture)
							removeChild(data.texture);
						data.texture = new gNode();
						addChild(data.texture);
						break;
					}
				case "partOfRope":
					{
						if (data.texture)
							removeChild(data.texture);
						data.texture = new gPartOfRope();
						addChildAt(data.texture, 9);
						break;
					}
				case "person":
					{
						if (data.texture)
							removeChild(data.texture);
						data.texture = new gPerson();
						addChild(data.texture);
						break;
					}
				case "personDie":
					{
						if (data.texture)
							removeChild(data.texture);
						data.texture = new gPersonDie();
						addChild(data.texture);
						break;
					}
				case "dieBox":
					{
						
						if (data.texture)
							removeChild(data.texture);
							
						data.texture = new gDieBox();
						data.texture.width = data.width;
						data.texture.height = data.height;
						
						addChild(data.texture);
						break;
					}
				case "dieBoxH":
					{
						if (data.texture)
							removeChild(data.texture);
						
							data.texture = new gDieBoxH();
							data.texture.width = data.width;
							data.texture.height = data.height;
							
							addChild(data.texture);
							break;
					}
				case "dieBoxLongH":
					{
						if (data.texture)
							removeChild(data.texture);
						
						data.texture = new gDieBoxLongH();
						data.texture.width = data.width;
						data.texture.height = data.height;
							
						addChild(data.texture);
						break;
					}
				case "dieBoxLong":
					{
						if (data.texture)
							removeChild(data.texture);
						
						data.texture = new gDieBoxLong();
						data.texture.width = data.width;
						data.texture.height = data.height;
							
						addChild(data.texture);
						break;
					}
				case "floor1":
					{
						if (data.texture)
							removeChild(data.texture);
								
						data.texture = new gFloor1();
						data.texture.width = data.width;
						data.texture.height = data.height;
							
						addChild(data.texture);
						break;
					}
				case "floor2":
					{
						if (data.texture)
							removeChild(data.texture);
								
						data.texture = new gFloor2();
						data.texture.width = data.width;
						data.texture.height = data.height;
							
						addChild(data.texture);
						break;
					}
				case "floor3":
					{
						if (data.texture)
							removeChild(data.texture);
						
						data.texture = new gFloor3();
						data.texture.width = data.width;
						data.texture.height = data.height;
							
						addChild(data.texture);
						break;
					}
				case "floor1V":
					{
						if (data.texture)
							removeChild(data.texture);
						
						data.texture = new gFloor1V();
						data.texture.width = data.width;
						data.texture.height = data.height;
							
						addChild(data.texture);
						break;
					}
				case "floor2V":
					{
						if (data.texture)
							removeChild(data.texture);
						
						data.texture = new gFloor2V();
						data.texture.width = data.width;
						data.texture.height = data.height;
							
						addChild(data.texture);
						break;
					}
				case "floor3V":
					{
						if (data.texture)
							removeChild(data.texture);
						
						data.texture = new gFloor3V();
						data.texture.width = data.width;
						data.texture.height = data.height;
							
						addChild(data.texture);
						break;
					}
				case "wall":
				{
					if (data.texture)
						removeChild(data.texture);
					data.texture = new gWall();
					data.texture.width = data.width;
					data.texture.height = data.height;
					
					addChild(data.texture);
					break;
				}
				case "wallH":
				{
					if (data.texture)
						removeChild(data.texture);
					data.texture = new gWallH();
					data.texture.width = data.width;
					data.texture.height = data.height;
					
					addChild(data.texture);
					break;
				}
				case "rock":
					{
						if (data.texture)
							removeChild(data.texture);
						
						data.texture = new gRock();
						
						addChild(data.texture);
						break;
					}
				case "rockActive":
					{
						if (data.texture)
							removeChild(data.texture);
						
						data.texture = new gRockActive();
						
						addChild(data.texture);
						break;
					}
				case "nodeHelp":
					{
						if (data.texture)
							removeChild(data.texture);
						
						data.texture = new gNodeHelp();
						
						addChild(data.texture);
						break;
					}
				case "personGetEnergy":
					{
						if (data.texture == null)
						{
							data.texture = new gPerson();
							addChild(data.texture);	
						}
						
						if (energySprite)
						{
							removeChild(energySprite);
							energySprite = null;
						}
						
						if (energy < maxEnergy)
						{
							energySprite = new gEnergy();
							energySprite.x = data.x;
							energySprite.y = data.y;
							
							var timer:Timer = new Timer(400, 1);
							timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerEnergy);
							
							addChild(energySprite);
							
							timer.start();
						}
						break;
					}
			}
			
			data.textureChange = false;
		}
		
		private function timerEnergy(e:TimerEvent):void 
		{
			if (energySprite)
			{
				removeChild(energySprite);
				energySprite = null;
			}
			
			energy = maxEnergy;
			ChangeRadius(maxEnergy);
		}
		
		
		
		
		private var isntMouseNearPers:Boolean = false;
		private var mouse:Sprite = new gMouse();
		
		
		
		
		
		
		private function IsMouseNearPerson(personVec:b2Vec2):void
		{
			if (energy == 0)
			{
				if (clickHere)
				{
					removeChild(clickHere);
					clickHere = null;
				}
				if (contains(mouse))
				{
					Mouse.show();
					removeChild(mouse);
				}
			}
			else
			{
				var data:UserData = Persone.GetUserData();
				
				ChangeRadius(energy);
				
				
				if (!data.isJointPerson)
				{
					if (contains(mouse))
					{
						mouse.x = mouseX;
						mouse.y = mouseY;
					}
					if (	Calc.GetDistanse(Calc.CMeterToPixel(personVec, worldScale),
												new b2Vec2(mouseX, mouseY))		 <=   150)
												{
													if (!contains(mouse))
													{
														Mouse.hide();
														mouse.x = -200;
														addChild(mouse);
													}
												}
					else 
					{
						Mouse.show();
						if (contains(mouse))
							removeChild(mouse);
					}
				}
				else
				{
					ChangeRadius(0);
					
					Mouse.show();
					if (contains(mouse))
						removeChild(mouse);
				}
			}
			
			
			
			/*if (!isntMouseNearPers)
			{
				if (!contains(mouse))
				{
					Mouse.hide();
					addChild(mouse);
				}
				
				mouse.x = mouseX;
				mouse.y = mouseY;
			}
			
			
			
			if (data.isJointPerson)
			{
				Mouse.show();
				isntMouseNearPers = true;
				if (contains(mouse))
					removeChild(mouse);
				if (clickHere)
				{
					removeChild(clickHere);
					clickHere = null;
				}
			}
			else if (Calc.GetDistanse(Calc.CMeterToPixel(personVec, worldScale), new b2Vec2(mouseX, mouseY)) <= 150 && isntMouseNearPers
					 &&	(energy > 0)	)
			{
				if (!clickHere)
				{
					ChangeRadius(energy);
				}
				
				Mouse.hide();
				isntMouseNearPers = false;
				mouse.x = -100;
				addChild(mouse);
				
			}
			else if(Calc.GetDistanse(Calc.CMeterToPixel(personVec, worldScale), new b2Vec2(mouseX, mouseY)) > 150 && !isntMouseNearPers)
			{
				if (!clickHere)
				{
					ChangeRadius(energy);
				}
				
				Mouse.show();
				isntMouseNearPers = true;
				if (contains(mouse))
					removeChild(mouse);
			}
			else if (energy == 0)
			{
				Mouse.show();
				if (contains(mouse))
				{
					removeChild(mouse);
				}
			}*/
		}
		
		
		
		
		protected function _drawGroundBodyCircle(x:Number, y: Number, radius:Number, color:uint):void
		{
			var circle:Sprite = new Hook();
			circle.x = x;
			circle.y = y;
			
			/*circle.graphics.beginFill(color);
			circle.graphics.drawCircle(x - radius, y - radius, radius);
			circle.graphics.endFill();*/
			
			var tempData:CircleData = new CircleData();
			tempData.SetData(x, y, radius);
			
			addChild(circle);
			
			circle = null;
			tempData = null;
		}
		
		
		protected function LocationMouse():b2Vec2
		{
			return new b2Vec2(mouseX / worldScale, mouseY/ worldScale);
		}
		
		static public function SetPersonAndNode(body1:b2Body, body2:b2Body):void
		{
			nodeAndPerson = null;
			nodeAndPerson = new Vector.<b2Body>();
			
			nodeAndPerson.push(body1);
			nodeAndPerson.push(body2);
		}
		
		protected function SetMaxEnergy(max:int):void
		{
			maxEnergy = max;
		}
		
		
		private function ChangeRadius(number:int):void
		{

			if (clickHere)
			{
				removeChild(clickHere);
				clickHere = null;
			}
			if (number == 0)
			{
				//continue;
			}
			else if (number == 1)
				{
					clickHere = new gRadius2();
					clickHere.x = Persone.GetPosition().x * 30;
					clickHere.y = Persone.GetPosition().y * 30;
					addChild(clickHere);
				}
			else if (number == 2)
				{
					clickHere = new gRadius1();
					clickHere.x = Persone.GetPosition().x * 30;
					clickHere.y = Persone.GetPosition().y * 30;
					addChild(clickHere);
				}
		}
		
		private function UpdateRadius():void
		{
			if (clickHere)
			{
				var i:int = getChildIndex(clickHere);
				removeChild(clickHere);
				
				clickHere.x = Persone.GetPosition().x * 30;
				clickHere.y = Persone.GetPosition().y * 30;
				
				addChildAt(clickHere, i);
			}
		}
		
		
		private function SetSpriteData(sp:Sprite, name:String):void
		{
			spriteList.push(new SpriteData(sp, name));
		}
		
		
		private function ArrangeIndexs():void
		{
			if (spriteList)
			{
				var count:int = spriteList.length - 1;
				
				
			}
		}
		
//**********************************************************************************************************************
		
	}

}