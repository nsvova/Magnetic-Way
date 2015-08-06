package Screen.Level.NextLevels 
{
	import Box2D.Dynamics.b2Body;
	import Box2DObject.DynamicBox;
	import Box2DObject.Rock;
	import Box2DObject.UserData;
	import flash.display.Sprite;
	import Screen.Level.Game;
	import Box2DObject.Rope;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Other
	 */
	public class Level19 extends Game 
	{
		
		private var whiteScreen:Sprite;
		
		public function Level19(sp:Sprite) 
		{
			super(sp, 19);
			CreateWorld(0, 9.81, false);
			
			AddSky(1);
			
			AddSun(30, 20);
			AddCloud(10, 30, 4);
			AddCloud(320, 80, 1);
			
			AddMountains(0, 260);

			
			debugDraw();
			
			CreateStaticBox(320,5 ,640, 10, new UserData( -1, "wall"));
			CreateStaticBox(320, 475, 640, 35, new UserData( -1, "floor"));
			CreateStaticBox(5, 240, 25, 480,new UserData(-1, "floor"));
			CreateStaticBox(635, 240, 10, 480, new UserData( -1, "wall"));
			
			CreateStaticBox(150, 375, 10, 80, new UserData( -1, "winWall"));
			CreateStaticBox(480, 385, 20, 130, new UserData( -1, "die"));
			CreateStaticBox(475, 225, 20, 180, new UserData( -1, "floor"));
			CreateStaticBox(150, 325, 100, 15, new UserData( -1, "die"));
			
			CreateStaticBox(240, 450, 450, 15, new UserData( -1, "die"));
			
			var rope:Rope = new Rope(this);
			rope.CreateRopeWithHook(_world, 300, 170, 40, worldScale);
			
			bonus.CreateBonus(40, 430, 10, 1);
			bonus.CreateBonus(575, 50, 10, 1);
			bonus.CreateBonus(150, 270, 10, 1);
			
			CreatePersone(570, 460, 20);
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