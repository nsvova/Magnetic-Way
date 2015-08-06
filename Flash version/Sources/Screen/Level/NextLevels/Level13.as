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
	import Box2D.Dynamics.Joints.*;
	import flash.display.Bitmap;
	import flash.display.Loader;
//	import flash.display.NativeMenu;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
	public class Level13 extends Game
	{
		
		private var whiteScreen:Sprite;
		
		public function Level13(sp:Sprite) 
		{
			super(sp, 13);
			
			CreateWorld(0, 9.81, false);
			
			AddSky(1);
			AddSun(30, 20);
			AddCloud(10, 30, 4);
			AddCloud(320, 80, 1);
			
			AddMountains(0, 260);

			
			CreateStaticBox(320,5 ,640, 10, new UserData( -1, "wall"));
			CreateStaticBox(320, 475, 640, 15, new UserData( -1, "die"));
			CreateStaticBox(5, 240, 10, 480,new UserData(-1, "wall"));
			CreateStaticBox(635, 240, 10, 480, new UserData( -1, "wall"));
			
			CreateStaticBox(400, 120, 80, 10, new UserData( -1, "floor"));
			CreateStaticBox(400, 130, 60, 10, new UserData( -1, "winWall"));
			
			var rope:Rope = new Rope(this);
			rope.CreateRopeWithHook(_world, 480, 370, 40, worldScale);
			rope.CreateRopeWithHook(_world, 150, 370, 40, worldScale);
			
			bonus.CreateBonus(280, 310, 10, 1);
			bonus.CreateBonus(440, 170, 10, 1);
			bonus.CreateBonus(130, 100, 10, 1);
			
			CreatePersone(400, 90, 20);
			
			
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




			/*CreateStaticBox(400, 120, 80, 10, new UserData( -1, "floor"));
			CreateStaticBox(400, 130, 60, 10, new UserData( -1, "winWall"));
			
			Rope.CreateCircleData(460, 350, 10);
			_drawGroundBodyCircle(460, 350, 10, 0x000000);
			Rope.CreateCircleData(120, 350, 10);
			_drawGroundBodyCircle(120, 350, 10, 0x000000);
			
			var rope:Rope = new Rope(this);
			rope.CreateRope(_world, 400, 410, 40, worldScale);
			rope.CreateRope(_world, 120, 410, 40, worldScale);
			
			bonus.CreateBonus(280, 350, 10, 1);
			bonus.CreateBonus(440, 170, 10, 1);
			bonus.CreateBonus(130, 100, 10, 1);
			
			CreatePersone(400, 90, 20);
			
			gSprite.stage.addEventListener(Event.ENTER_FRAME, update);*/