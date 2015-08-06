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
	import flash.display.MovieClip;
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
	public class Level5 extends Game
	{
		
		private var whiteScreen:Sprite;
		private var help:TextField;
		
		private var ind:int;
		private var wasSwing:Boolean = false;
		private var isEventListener:Boolean = false;
		
		private var helpThrow:Sprite;
		private var helpMove:Sprite;
		private var helpSwing:TextField;
		
		private var nodeHelp:b2Body;
		private var nodeSprite:Sprite;
		
		public function Level5(sp:Sprite) 
		{
			super(sp, 5);
			
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
			
			
			var rope:Rope = new Rope(this);
			rope.CreateRopeWithHook(_world, 320, 390, 40, worldScale);
			
			
			CreateStaticBox(320, 150, 80, 10, new UserData( -1, "winWall"));
			
			
			CreatePersone(140, 440, 20);
			
			bonus.CreateBonus(100, 200, 10, 1);
			bonus.CreateBonus(500, 190, 10, 1);
			bonus.CreateBonus(360, 200, 10, 1);
			
			//help = FlashGrafic.CreateText("The ball can takes energy from \nspecial metal walls" ,
												//50, 150, 28, 0xffffff, "Comic Sans MS");
			//addChild(help);
			
			
			
			helpThrow = new gTextHelpThrow();
			helpThrow.x = 10;
			helpThrow.y = 10;
			
			helpMove = new gTextHelpMove();
			helpMove.x = 370;
			helpMove.y = 280;
			
			helpSwing = FlashGrafic.CreateText("Click on the stick and swing it", 100, 50, 30, 0xffffff, "Comic Sans MS");
			
			AddRadius();
			
			
			whiteScreen = FlashGrafic.drawBox(0, 0, 640, 480, 0xffffff);
			addChild(whiteScreen);
			
			gSprite.stage.addEventListener(Event.ENTER_FRAME, update);
			
		}
		
		
		
		private function update(e:Event):void
		{
			super._update(e);
			
			var data:UserData = Persone.GetUserData();
			
			if (whiteScreen)
			{
				
				
				removeChild(whiteScreen);
				whiteScreen = null;
				
				var p:b2Body;
				var spr:UserData;
					
					for (p = _world.GetBodyList(); p; p = p.GetNext())
					{
						
						spr = p.GetUserData();
						
						if (spr.objectName == "node" || spr.objectName == "node2")
						{
							if (!spr.isJointNode)
							{
								nodeHelp = p;
							}
						}
					}
			}
			
			var dataNode:UserData = nodeHelp.GetUserData();
			
			
			
			if (data.isJointPerson)
			{
				if (!isEventListener && (nodeSprite is gNodeHelp))
				{
					nodeSprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownNode);
					isEventListener = true;
				}
				
				ind = super.getChildIndex(data.texture);
				
				if (dataNode.texture is gNode)
				{
					dataNode.textureInfo = "nodeHelp";
					dataNode.textureChange = true;
				}
				
				if(helpMove)
					if (contains(helpMove))
					{
						removeChild(helpMove);
					}
				
				if (helpSwing)
				{
					if (!contains(helpSwing) && !wasSwing)
					{
						addChildAt(helpSwing, ind - 1 );
					}
				}
			}	
			else
			{
				if (isEventListener)
				{
					nodeSprite.removeEventListener(MouseEvent.MOUSE_MOVE, mouseDownNode);
					isEventListener = false;
				}
				
				ind = super.getChildIndex(data.texture);
				
				if (dataNode.texture is gNodeHelp)
				{
					dataNode.textureInfo = "node";
					dataNode.textureChange = true;
				}
				
				if(helpThrow)
					if (contains(helpThrow))
					{
						removeChild(helpThrow);
					}
				
				if(helpMove)
					if (!contains(helpMove))
					{
						addChildAt(helpMove, ind - 1);
					}
				if (helpSwing)
					if (contains(helpSwing))
					{
						removeChild(helpSwing);
					}
					
				wasSwing = false;	
			}
			
			nodeSprite = dataNode.texture;
			
		}
		
		private function mouseDownNode(e:MouseEvent):void 
		{
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpNode);
		}
		
		private function mouseUpNode(e:MouseEvent):void 
		{	
				if (helpSwing)
					if (contains(helpSwing))
					{
						removeChild(helpSwing);
					}
				if (helpThrow)
					if (!contains(helpThrow))
					{
						addChildAt(helpThrow, ind - 2);
					}
					
					wasSwing = true;
			
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpNode);
		}
		
		override public function Start():void
		{
			super.Start();
			
			
		}
		
		override public function Stop():void
		{
			super.Stop();
			if (contains(helpThrow))
			{
				removeChild(helpThrow);
			}
			helpThrow = null;
		}
		
		
	}

}