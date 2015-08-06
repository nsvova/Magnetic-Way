package  Box2DObject
{
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Collision.Shapes.b2CircleShape;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Rock 
	{
		private var _world:b2World;
		private var _wScale:Number;
		static private var listRock:Vector.<b2Body> = new Vector.<b2Body>();
		
		public function Rock(world:b2World, worldScale:Number) 
		{
			_world = world;
			_wScale = worldScale;
		}
		
		public function CreateRock(x:Number, y:Number, radius:Number):b2Body
		{
			var uData:UserData = new UserData( -1, "die");
			uData.isActiveObject = false;
			uData.textureInfo = "rock";
			uData.textureChange = true;
			
			var rock:b2Body = CreateDynamicCircle(x, y, radius, _wScale, uData);
			
			listRock.push(rock);
			
			return rock;
		}
		
		static public function isPersonNearTheRock(personVec:b2Vec2, radius:Number):Vector.<b2Body>
		{
			var flag:Boolean = false;
			var result:Vector.<b2Body> = new Vector.<b2Body>();
			
			for (var i:int = 0; i < listRock.length; i++)
			{
				if ( Calc.isObjectInCircle(Calc.CMeterToPixel(personVec, 30), Calc.CMeterToPixel(listRock[i].GetPosition(), 30),radius))
				{
					if (!listRock[i].IsActive())
					{
						var userData:UserData = listRock[i].GetUserData();
						userData.textureInfo = "rockActive";
						userData.textureChange = true;
						result.push(listRock[i]);
						flag = true;
					}
				}
				
			}
			
			if (flag)
			{
				return result;
			}
			else
				return null;

		}
		
		
		static public function SetActiveRocks(_listRock:Vector.<b2Body>, vec:b2Vec2):void
		{
			for (var i:int = 0; i < _listRock.length; i++)
			{
				Rock.SetActiveAndVelocity(_listRock[i], vec);
			}
		}
		
		
		public static function SetActiveAndVelocity(_rock:b2Body, where:b2Vec2):void
		{
			var uData:UserData = _rock.GetUserData();
			if ( !uData.isActiveObject )
			{
				_rock.SetActive(true);
				uData.isActiveObject = true;
				
				_rock.SetLinearVelocity(Calc.CreateVectorVelocity(where.x, where.y, _rock.GetPosition()));
				_rock.SetLinearDamping(1);
			}
		}
		
		
		
		private function CreateDynamicCircle(x:Number, y:Number, radius:Number, worldScale:Number, userData:UserData):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set( x  / worldScale, y/ worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = userData;
			
			var circle:b2CircleShape = new b2CircleShape(radius / worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.density = 2;
			fixtureDef.friction = 0.5;
			fixtureDef.restitution = 0.0;
			fixtureDef.shape = circle;
			
			var body:b2Body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetActive(false);
			
			bodyDef = null;
			circle = null;
			fixtureDef = null;
			
			return body;
		}
		
		static public function DestroyRocks()
		{
			listRock = null;
			listRock = new Vector.<b2Body>();
		}
		
	}

}