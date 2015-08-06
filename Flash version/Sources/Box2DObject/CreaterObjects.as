package Box2DObject 
{
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2DObject.CreaterObjects;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class CreaterObjects 
	{
		
		public function CreaterObjects() 
		{
			
		}

		
		protected function CreateDynamicBox(world:b2World,x:Number, y:Number, width:Number, height:Number, worldScale:Number, userData:UserData, groupIndex:int):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(x  / worldScale, y / worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = userData;
			
			var box:b2PolygonShape = new b2PolygonShape();
			box.SetAsBox((width / 2) / worldScale, (height / 2) / worldScale);
			
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = box;
			fixtureDef.density = 2;
			/////
			fixtureDef.filter.groupIndex = groupIndex;
			//////
			
			var body:b2Body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			bodyDef = null;
			box = null;
			fixtureDef = null;
			
			return body;
		}
		
		protected function CreateDynamicCircle(world:b2World,x:Number, y:Number, radius:Number, worldScale:Number, userData:UserData, groupIndex:int):b2Body
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
			fixtureDef.filter.groupIndex = groupIndex;
			
			var body:b2Body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetFixedRotation(true);
			
			
			bodyDef = null;
			circle = null;
			fixtureDef = null;
			
			return body;
		}
		
		
		
		protected function CreateStaticBox(world:b2World, x:Number, y:Number, width:Number, height:Number, worldScale:Number, uData:UserData):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(x  / worldScale, y / worldScale);
			bodyDef.userData = uData;
			
			var box:b2PolygonShape = new b2PolygonShape();
			box.SetAsBox((width / 2) / worldScale, (height / 2) / worldScale);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = box;
			fixtureDef.density = 0;
			fixtureDef.friction = 0.4;
			fixtureDef.restitution = 0.0;
			
			var body:b2Body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			
			bodyDef = null;
			box = null;
			fixtureDef = null;
			
			return body;
		}
		
	}

}