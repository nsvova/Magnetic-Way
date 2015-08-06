package Box2DObject 
{
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	/**
	 * ...
	 * @author Other
	 */
	public class DynamicBox extends CreaterObjects
	{
		
		private var world:b2World;
		private var worldScale:Number;
		
		private var joint:Joints;
		
		public function DynamicBox(_world:b2World, _worldScale:Number) 
		{
			world = _world;
			worldScale = _worldScale;
			
			joint = new Joints(world, worldScale);
			listDynamicDieBoxHorizontally = new Vector.<b2Body>();
			listDynamicDieBoxApeak = new Vector.<b2Body>();
		}
		
		
		public function CreateDynamicBoxHorizontally(x:Number, y:Number, width:Number, height:Number, maxLength:Number, delta:int):void
		{
			var ud:UserData = new UserData( -1, "die");
			
			ud.AddXandY(x, y);
			ud.intInformation = maxLength;

				ud.width = width;
				ud.height = height;
				if ( width > height)
				{
					if (width > 300)
						ud.textureInfo = "dieBoxLongH";
					else
						ud.textureInfo = "dieBoxH";
				}
				else
				{
					if (height >= 200)
						ud.textureInfo = "dieBoxLong";
					else
						ud.textureInfo = "dieBox";
				}
				ud.textureChange = true;
			
			
			ud.delta = delta;
			
			var body:b2Body = CreateStaticBox(world, x, y, width, height, worldScale, ud);
			listDynamicDieBoxHorizontally.push(body);
			//listJointsDynamicDieBox.push(joint.CreatePrismaticJoint(body, world.GetGroundBody(), body.GetPosition(), maxLength));
			
		}
		
		public function CreateDynamicBoxApeak(x:Number, y:Number, width:Number, height:Number, maxLength:Number, delta:int):void
		{
			var ud:UserData = new UserData( -1, "die");
			ud.AddXandY(x, y);
			ud.intInformation = maxLength;
			
				ud.width = width;
				ud.height = height;
				if ( width > height)
				{
					if (width > 300)
						ud.textureInfo = "dieBoxLongH";
					else
						ud.textureInfo = "dieBoxH";
				}
				else
				{
					if (height >= 200)
						ud.textureInfo = "dieBoxLong";
					else
						ud.textureInfo = "dieBox";
				}
				ud.textureChange = true;
			ud.delta = delta;
			
			var body:b2Body = CreateStaticBox(world, x, y, width, height, worldScale, ud);
			listDynamicDieBoxApeak.push(body);
			//listJointsDynamicDieBox.push(joint.CreatePrismaticJoint(body, world.GetGroundBody(), body.GetPosition(), maxLength));
			
		}
		
		
		
		public static function SpeedHorizontally():void
		{
			if (listDynamicDieBoxHorizontally)
			{
				for (var i:int = 0; i < listDynamicDieBoxHorizontally.length; i++)
				{
					var body:b2Body = listDynamicDieBoxHorizontally[i];
					var bodyData:UserData = body.GetUserData();

					var x_now:Number = body.GetPosition().x;
					
					if (x_now * 30 >= bodyData.x + bodyData.intInformation)
					{
						bodyData.delta = -bodyData.delta;
					}
					else if (x_now * 30 <= bodyData.x - bodyData.intInformation)
					{
						bodyData.delta = -bodyData.delta;

					}
					
					body.SetPosition(new b2Vec2(x_now + bodyData.delta / 30, body.GetPosition().y));
				}
			}
		}
		
		
		public static function SpeedApeak():void
		{
			if (listDynamicDieBoxApeak)
			{
				for (var i:int = 0; i < listDynamicDieBoxApeak.length; i++)
				{
					var body:b2Body = listDynamicDieBoxApeak[i];
					var bodyData:UserData = body.GetUserData();

					var y_now:Number = body.GetPosition().y;
					
					if (y_now * 30 >= bodyData.y + bodyData.intInformation)
					{
						bodyData.delta = -bodyData.delta;
					}
					else if (y_now * 30 <= bodyData.y - bodyData.intInformation)
					{
						bodyData.delta = -bodyData.delta;
					}
					
					body.SetPosition( new b2Vec2(body.GetPosition().x, y_now + bodyData.delta / 30));
				}
			}
		}
		
		private static var listDynamicDieBoxHorizontally:Vector.<b2Body>;
		private static var listDynamicDieBoxApeak:Vector.<b2Body>;
		
		
	}

}