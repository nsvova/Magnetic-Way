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
	public class Level18 extends Game 
	{
		
		
		private var whiteScreen:Sprite;
		
		public function Level18(sp:Sprite)
		{
			super(sp, 18);
			
			CreateWorld(0, 9.81, false);
			
			AddSky(1);
			
			AddSun(30, 20);
			AddCloud(10, 30, 4);
			AddCloud(320, 80, 1);
			
			AddMountains(0, 260);
			

			
			
			CreateStaticBox(320,5 ,640, 10, new UserData( -1, "wall"));
			CreateStaticBox(320, 475, 640, 35, new UserData( -1, "floor"));
			CreateStaticBox(0, 140, 35, 680,new UserData(-1, "floor"));
			CreateStaticBox(640, 140, 35, 680, new UserData( -1, "floor"));

			
			CreateStaticBox(320, 20, 60, 10, new UserData( -1, "winWall"));
			CreateStaticBox(565, 450, 130, 15, new UserData( -1, "die"));
			CreateStaticBox(75, 450, 130, 15, new UserData( -1, "die"));
			
			var dieBox:DynamicBox = new DynamicBox(_world, worldScale);
			dieBox.CreateDynamicBoxHorizontally(525, 85, 50, 10, 50, 2);
			dieBox.CreateDynamicBoxHorizontally(115, 85, 50, 10, 50, 1.3);
			
			isHorisontallyUpdate = true;
			
			var rock:Rock = new Rock(_world, worldScale);
			rock.CreateRock(220, 220, 20);
			rock.CreateRock(220, 170, 20);
			rock.CreateRock(220, 120, 20);
			rock.CreateRock(220, 70, 20);
			
			rock.CreateRock(420, 220, 20);
			rock.CreateRock(420, 170, 20);
			rock.CreateRock(420, 120, 20);
			rock.CreateRock(420, 70, 20);
			
			var rope:Rope = new Rope(this);
			rope.CreateRopeWithHook(_world, 400, 350, 40, worldScale);
			
			
			bonus.CreateBonus(600, 60, 10, 1);
			bonus.CreateBonus(40, 50, 10, 1);
			bonus.CreateBonus(350, 70, 10, 1);
			
			CreatePersone(320, 450, 20);
			
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
			CreateStaticBox(5, 140, 10, 680,new UserData(-1, "wall"));
			CreateStaticBox(635, 140, 10, 680, new UserData( -1, "wall"));

			
			CreateStaticBox(320, 20, 60, 10, new UserData( -1, "winWall"));
			CreateStaticBox(565, 450, 130, 15, new UserData( -1, "die"));
			CreateStaticBox(75, 450, 130, 15, new UserData( -1, "die"));
			
			var dieBox:DynamicBox = new DynamicBox(_world, worldScale);
			dieBox.CreateDynamicBoxHorizontally(525, 85, 50, 10, 50, 2);
			dieBox.CreateDynamicBoxHorizontally(115, 85, 50, 10, 50, 1.3);
			
			isHorisontallyUpdate = true;
			
			var rock:Rock = new Rock(_world, worldScale);
			rock.CreateRock(220, 220, 20);
			rock.CreateRock(220, 170, 20);
			rock.CreateRock(220, 120, 20);
			rock.CreateRock(220, 70, 20);
			
			rock.CreateRock(420, 220, 20);
			rock.CreateRock(420, 170, 20);
			rock.CreateRock(420, 120, 20);
			rock.CreateRock(420, 70, 20);
			
			Rope.CreateCircleData(400, 350, 10);
			_drawGroundBodyCircle(400, 350, 10, 0x000000);
			Rope.CreateCircleData(555, 300, 10);
			_drawGroundBodyCircle(555, 300, 10, 0x000000);
			Rope.CreateCircleData(85, 300, 10);
			_drawGroundBodyCircle(85, 300, 10, 0x000000);
			
			var rope:Rope = new Rope(this);
			rope.CreateRope(_world, 400, 400, 40, worldScale);
			rope.CreateRope(_world, 450, 400, 40, worldScale);
			
			bonus.CreateBonus(600, 100, 10, 1);
			bonus.CreateBonus(40, 50, 10, 1);
			bonus.CreateBonus(350, 70, 10, 1);
			*/
