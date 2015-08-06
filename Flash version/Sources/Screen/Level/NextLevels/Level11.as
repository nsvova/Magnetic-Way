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
	import Box2DObject.DynamicBox;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Level11 extends Game
	{
		
		private var whiteScreen:Sprite;
		
		public function Level11(sp:Sprite) 
		{
			super(sp, 11);
			
			CreateWorld(0, 9.81, false);
			
			AddSky(2);
			
			AddSun(30, -70);
			AddCloud(10, -50, 4);
			AddCloud(320, -120, 1);
			
			AddMountains(0, 260);
			
			
			CreateStaticBox(320,-185 ,640, 35, new UserData( -1, "floor"));
			CreateStaticBox(320, 465, 640, 35, new UserData( -1, "floor"));
			CreateStaticBox(5, 140, 10, 680,new UserData(-1, "wall"));
			CreateStaticBox(635, 140, 10, 680, new UserData( -1, "wall"));
			
			
			
			CreateStaticBox(15, -60, 10, 80, new UserData( -1, "winWall"));
			
			var rope:Rope = new Rope(this);
			rope.CreateRopeWithHook(_world, 250, 340, 40, worldScale);
			rope.CreateRopeWithHook(_world, 470, 40, 40, worldScale);
			
			var dieBox:DynamicBox = new DynamicBox(_world, worldScale);
			dieBox.CreateDynamicBoxApeak(100, -50, 10, 80, 75, 1.7);
			
			isApeakUpdate = true;
			
			CreatePersone(50, 440, 20);
			
			bonus.CreateBonus(70, -140, 10, 1);
			bonus.CreateBonus(340, 140, 10, 1);
			bonus.CreateBonus(50, 20, 10, 1);
			
			
			AddRadius();
			
			
			_height = 680;
			isScroll = true;
			
											
			
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