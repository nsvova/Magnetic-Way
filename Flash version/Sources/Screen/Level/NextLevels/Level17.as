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
	public class Level17 extends Game 
	{
		
		
		private var whiteScreen:Sprite;
		
		public function Level17(sp:Sprite) 
		{
			super(sp, 17);
			
			CreateWorld(0, 9.81, false);
			
			AddSky(1);
			
			AddSun(30, 20);
			AddCloud(10, 30, 4);
			AddCloud(320, 80, 1);
			
			AddMountains(0, 260);
			

			
			
			CreateStaticBox(320,5 ,640, 10, new UserData( -1, "wall"));
			CreateStaticBox(320, 475, 640, 35, new UserData( -1, "floor"));
			CreateStaticBox(5, 240, 10, 480,new UserData(-1, "wall"));
			CreateStaticBox(635, 240, 10, 480, new UserData( -1, "wall"));
			
			CreateStaticBox(320, 400, 10, 200, new UserData( -1, "wall"));
			CreateStaticBox(625, 200, 20, 100, new UserData( -1, "floor"));
			
			CreateStaticBox(480, 400, 80, 10, new UserData( -1, "winWall"));
			
			var dieBox:DynamicBox = new DynamicBox(_world, worldScale);
			dieBox.CreateDynamicBoxApeak(320, 125, 10, 80, 75, 1.9);
			
			isApeakUpdate = true;
			
			var rope:Rope = new Rope(this);
			rope.CreateRopeWithHook(_world, 160, 330, 40, worldScale);
			
			bonus.CreateBonus(315, 283, 10, 1);
			bonus.CreateBonus(480, 100, 10, 1);
			bonus.CreateBonus(515, 380, 10, 1);
			
			var rock:Rock = new Rock(_world, worldScale);
			rock.CreateRock(350, 350, 20);
			rock.CreateRock(400, 350, 20);
			rock.CreateRock(450, 350, 20);
			rock.CreateRock(500, 350, 20);
			rock.CreateRock(550, 350, 20);
			rock.CreateRock(600, 350, 20);
			
			CreatePersone(160, 450, 20);
			
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










/*			CreateStaticBox(320,5 ,640, 10, new UserData( -1, "wall"));
			CreateStaticBox(320, 475, 640, 35, new UserData( -1, "floor"));
			CreateStaticBox(5, 240, 10, 480,new UserData(-1, "wall"));
			CreateStaticBox(635, 240, 10, 480, new UserData( -1, "wall"));
			
			CreateStaticBox(320, 400, 10, 200, new UserData( -1, "wall"));
			CreateStaticBox(320, 299, 10, 2, new UserData( -1, "floor"));
			
			CreateStaticBox(480, 400, 80, 10, new UserData( -1, "winWall"));
			
			var dieBox:DynamicBox = new DynamicBox(_world, worldScale);
			dieBox.CreateDynamicBoxApeak(320, 125, 10, 80, 75, 1.3);
			
			isApeakUpdate = true;
			
			Rope.CreateCircleData(80, 350, 10);
			_drawGroundBodyCircle(80, 350, 10, 0x000000);
			Rope.CreateCircleData(480, 200, 10);
			_drawGroundBodyCircle(480, 200, 10, 0x000000);
			
			var rope:Rope = new Rope(this);
			rope.CreateRope(_world, 20, 400, 40, worldScale);
			rope.CreateRope(_world, 190, 400, 40, worldScale);
			
			bonus.CreateBonus(315, 283, 10, 1);
			bonus.CreateBonus(340, 180, 10, 1);
			bonus.CreateBonus(515, 380, 10, 1);
			
			var rock:Rock = new Rock(_world, worldScale);
			rock.CreateRock(350, 350, 20);
			rock.CreateRock(400, 350, 20);
			rock.CreateRock(450, 350, 20);
			rock.CreateRock(500, 350, 20);
			rock.CreateRock(550, 350, 20);
			rock.CreateRock(600, 350, 20);
			
			CreatePersone(100, 450, 20);
		*/

