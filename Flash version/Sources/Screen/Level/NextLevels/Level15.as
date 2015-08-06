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
	public class Level15 extends Game 
	{
		
		
		private var whiteScreen:Sprite;
		
		public function Level15(sp:Sprite) 
		{
			super(sp, 15);
			
			CreateWorld(0, 9.81, false);
			
			AddSky(1);
			
			AddSun(30, 20);
			AddCloud(10, 30, 4);
			AddCloud(320, 80, 1);
			
			AddMountains(0, 260);
			

			
			
			CreateStaticBox(320,5 ,640, 10, new UserData( -1, "wall"));
			CreateStaticBox(320, 470, 640, 20, new UserData( -1, "die"));
			CreateStaticBox(5, 240, 10, 480,new UserData(-1, "wall"));
			CreateStaticBox(635, 240, 10, 480, new UserData( -1, "wall"));
			
			CreateStaticBox(190, 240, 360, 10, new UserData( -1, "die"));
			CreateStaticBox(120, 230, 60, 15, new UserData( -1, "floor"));
			CreateStaticBox(180, 450, 60, 10, new UserData( -1, "winWall"));
			CreateStaticBox(520, 20, 80, 20, new UserData( -1, "floor"));
			
			
			var rope:Rope = new Rope(this);
			rope.CreateRopeWithHook(_world, 220, 160, 40, worldScale);
			rope.CreateRopeWithHook(_world, 490, 320, 40, worldScale);
			
			var rock:Rock = new Rock(_world, worldScale);
			rock.CreateRock(210, 390, 20);
			
			CreatePersone(120, 210, 20);
			
			bonus.CreateBonus(315, 90, 10, 1);
			bonus.CreateBonus(530, 210, 10, 1);
			bonus.CreateBonus(520, 100, 10, 1);
			
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

