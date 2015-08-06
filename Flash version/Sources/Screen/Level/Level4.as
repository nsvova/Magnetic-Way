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
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Level4 extends Game
	{
		
		private var whiteScreen:Sprite;
		private var help:TextField;
		
		public function Level4(sp:Sprite) 
		{
			super(sp, 4);
			
			CreateWorld(0, 9.81, false);
			
			AddSky(1);
			
			if (SoundEffect.SoundOn)
			{
				AddLighninge(100, 60, 1);
				AddLighninge(300, 100, 2);
			}
			else 
			{
				AddLighningeWithoutSound(100, 60, 1);
				AddLighningeWithoutSound(300, 100, 2);
			}
			AddCloud(40, 20, 1);
			AddCloud(300, 50, 2);
			AddMountains(0, 260);
			
			
			CreateStaticBox(320,5 ,640, 10, new UserData( -1, "wall"));
			CreateStaticBox(320, 475, 640, 35, new UserData( -1, "floor"));
			CreateStaticBox(5, 240, 10, 480,new UserData(-1, "wall"));
			CreateStaticBox(635, 240, 10, 480, new UserData( -1, "wall"));
			
			CreateStaticBox(100, 250, 25, 300, new UserData( -1, "floor"));
			
			CreateStaticBox(200, 50, 80, 10, new UserData( -1, "winWall"));
			
			
			CreatePersone(140, 440, 20);
			
			bonus.CreateBonus(220, 210, 10, 1);
			bonus.CreateBonus(500, 260, 10, 1);
			bonus.CreateBonus(240, 90, 10, 1);
			
			help = FlashGrafic.CreateText("The ball can takes energy from \nspecial metal walls" ,
												50, 150, 28, 0xffffff, "Comic Sans MS");
			addChild(help);
			
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
			removeChild(help);
			help = null;
		}
		
		
	}

}