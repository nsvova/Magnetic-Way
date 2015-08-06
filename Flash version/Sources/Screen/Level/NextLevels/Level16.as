package Screen.Level.NextLevels 
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
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import Box2D.Dynamics.Joints.*;
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
	import Box2DObject.*;
	import Screen.Level.Game;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Level16 extends Game 
	{
		
		
		private var whiteScreen:Sprite;
		
		public function Level16(sp:Sprite) 
		{
			super(sp, 16);
			
			CreateWorld(0, 9.81, false);
			
			AddSky(2);
			
			AddSun(30, -70);
			AddCloud(10, -50, 4);
			AddCloud(320, -120, 1);
			
			AddMountains(0, 260);
			
			
			CreateStaticBox(320,-195 ,640, 10, new UserData( -1, "wall"));
			CreateStaticBox(320, 465, 640, 20, new UserData( -1, "die"));
			CreateStaticBox(5, 140, 10, 680,new UserData(-1, "wall"));
			CreateStaticBox(635, 140, 10, 680, new UserData( -1, "wall"));
			
			CreateStaticBox(90,  -120, 80, 15, new UserData( -1, "floor"));
			CreateStaticBox(150, -30, 260, 10, new UserData( -1, "die"));
			
			CreateStaticBox(280, 100, 420, 35, new UserData( -1, "floor"));
			CreateStaticBox(510, 260, 250, 25, new UserData( -1, "floor"));
			
			CreateStaticBox(330, 450, 70, 10, new UserData( -1, "winWall"));
			
			CreatePersone(90, -150, 20);
			
			var rock:Rock = new Rock(_world, worldScale);
			rock.CreateRock(460, 50 , 20);
			rock.CreateRock(330, 400, 20);
			
			bonus.CreateBonus(180, 60, 10, 1);
			bonus.CreateBonus(470, 290, 10, 1);
			bonus.CreateBonus(170, 150, 10, 1);
			
			_height = 680;
			isScroll = true;
			
			AddRadius();
			
			whiteScreen = FlashGrafic.drawBox(0, 0, 640, 480, 0xffffff);
			addChild(whiteScreen);
			
			gSprite.stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		
		
		private function update(e:Event):void 
		{
			
			super._update(e);
			
			if (whiteScreen)
			{
				removeChild(whiteScreen);
				whiteScreen = null;
			}
			
		}
		
		override public function Start():void 
		{
			super.Start();
		}
		
		override public function Stop():void 
		{
			super.Stop();
		}
		
	}

}















/*			CreateStaticBox(320,-195 ,640, 10, new UserData( -1, "wall"));
			CreateStaticBox(320, 465, 640, 20, new UserData( -1, "die"));
			CreateStaticBox(5, 140, 10, 680,new UserData(-1, "wall"));
			CreateStaticBox(635, 140, 10, 680, new UserData( -1, "wall"));
			
			CreateStaticBox(90,  -120, 80, 15, new UserData( -1, "floor"));
			CreateStaticBox(150, -30, 260, 10, new UserData( -1, "die"));
			
			CreateStaticBox(280, 100, 420, 15, new UserData( -1, "floor"));
			CreateStaticBox(510, 260, 250, 15, new UserData( -1, "floor"));
			
			var dieBox:DynamicBox = new DynamicBox(_world, worldScale);
			dieBox.CreateDynamicBoxApeak(380, 220, 10, 40, 70, 1.3);
			
			CreateStaticBox(330, 450, 70, 10, new UserData( -1, "winWall"));
			
			CreatePersone(90, -150, 20);
			
			Rope.CreateCircleData(260, -160, 10);
			_drawGroundBodyCircle(260, -160, 10, 0x000000);
			Rope.CreateCircleData(220, 270, 10);
			_drawGroundBodyCircle(220, 270, 10, 0x000000);
			
			var rope:Rope = new Rope(this);
			rope.CreateRope(_world, 175, -140, 40, worldScale);
			
			var rock:Rock = new Rock(_world, worldScale);
			rock.CreateRock(470, 70 , 20);
			
			bonus.CreateBonus(180, 60, 10, 1);
			bonus.CreateBonus(550, 240, 10, 1);
			bonus.CreateBonus(170, 150, 10, 1);
			
			_height = 680;
			isScroll = true;
			
			isApeakUpdate = true;*/