package  Box2DObject
{
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Joints 
	{
		
		private var tempBody:b2Body;
		private var _world:b2World;
		private var worldScale:Number;
		
		public function Joints(world:b2World, worldScale:Number) 
		{
			_world = world;
			this.worldScale = worldScale;
		}
		
		public function CreateRevoluteJointToVector(a:b2Body, b:b2Body, vec:b2Vec2, _userData:String):b2RevoluteJoint
		{

			var jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			
			vec.x /= worldScale;
			vec.y /= worldScale;
			
			jointDef.upperAngle = 0 / Math.PI;
			jointDef.lowerAngle = 0 / Math.PI;
			
			jointDef.collideConnected = false;
			jointDef.userData = _userData;
			
			jointDef.Initialize(a, b, vec );
			var joint:b2RevoluteJoint = _world.CreateJoint(jointDef) as b2RevoluteJoint;
			
			return joint;
		}
		
		public function CreateRevoluteJoint(a:b2Body, b:b2Body, vecA:b2Vec2, vecB:b2Vec2, _userData:String):b2RevoluteJoint
		{
			var jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			jointDef.bodyA = a;
			jointDef.bodyB = b;
			
			jointDef.localAnchorA = new b2Vec2(vecA.x /worldScale, vecA.y / worldScale);
			jointDef.localAnchorB = new b2Vec2(vecB.x / worldScale, vecB.y / worldScale);
			
			jointDef.lowerAngle = -Math.PI / 8;
			jointDef.upperAngle = Math.PI / 8;
			
			jointDef.collideConnected = false;
			
			
			jointDef.userData = _userData;
			
			return _world.CreateJoint(jointDef) as b2RevoluteJoint;
		}
		
		
		public function mouseJoint(a:b2Body, b:b2Body, target:b2Vec2, maxForce:Number):b2MouseJoint
		{

				var jointDef:b2MouseJointDef = new b2MouseJointDef();
				
				jointDef.bodyA = a;
				jointDef.bodyB = b;
				
				jointDef.target = target;
				jointDef.maxForce = maxForce;
				
				var mouseJoint:b2MouseJoint = _world.CreateJoint(jointDef) as b2MouseJoint;
				
				return mouseJoint;
				
		}
		
		public function CreateWeldJoint(a:b2Body, b:b2Body, vec:b2Vec2, userData:String):b2WeldJoint
		{
			var jointDef:b2WeldJointDef = new b2WeldJointDef();
			
			jointDef.bodyA = a;
			jointDef.bodyB = b;
			jointDef.userData = userData;
			
			jointDef.collideConnected = true;
			
			jointDef.Initialize(a, b, vec);
			
			var weld:b2WeldJoint = _world.CreateJoint(jointDef) as b2WeldJoint;
			
			return weld;
		}
		
		public function CreateFrictionJoint(a:b2Body, b:b2Body, vec:b2Vec2, userData:String):b2FrictionJoint
		{
			var frictionDef:b2FrictionJointDef = new b2FrictionJointDef();
			frictionDef.bodyA = a;
			frictionDef.bodyA = b;
			frictionDef.userData = userData;
			
			frictionDef.maxForce = 10;
			
			frictionDef.Initialize(a, b, vec);
			
			return _world.CreateJoint(frictionDef) as b2FrictionJoint;
		}
		
		public function CreateDistanceJoint(a:b2Body, b:b2Body, vec1:b2Vec2, vec2:b2Vec2, length:Number, userData:String):b2DistanceJoint
		{
			var jointDef:b2DistanceJointDef = new b2DistanceJointDef();
			jointDef.bodyA = a;
			jointDef.bodyB = b;
			jointDef.userData = userData;
			
			jointDef.collideConnected = true;
			
			jointDef.length = length;
			jointDef.Initialize(a, b, vec1, vec2);
			
			return _world.CreateJoint(jointDef) as b2DistanceJoint;
		}
		
		
		
		public function CreatePrismaticJoint(a:b2Body, b:b2Body, anchor:b2Vec2, maxLength:Number):b2PrismaticJoint
		{
			var jointDef:b2PrismaticJointDef = new b2PrismaticJointDef();
			jointDef.bodyA = a;
			jointDef.bodyB = b;
			jointDef.localAnchorA = anchor;
			
			jointDef.enableLimit = true;
			jointDef.lowerTranslation = -maxLength / worldScale;
			jointDef.upperTranslation = maxLength / worldScale;
			
			jointDef.Initialize(a, b, anchor, new b2Vec2(1, 0));
			
			var joint:b2PrismaticJoint = _world.CreateJoint(jointDef) as b2PrismaticJoint;
			joint.EnableMotor(true);
			joint.SetMotorSpeed(8);
			joint.SetMaxMotorForce(50);
			
			
			return joint;
		}
		
		public function DestroyAllJoints( body:b2Body):void
		{
			var jointList:b2JointEdge = body.GetJointList();
			
			while (jointList != null)
			{
				_world.DestroyJoint(jointList.joint);
				jointList = jointList.next;
			}
		}
	}

}