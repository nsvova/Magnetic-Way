package  Box2DObject
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
	public class Rope extends CreaterObjects
	{
		
		private var BodyList:Vector.<b2Body>;
		static private var AllBodyList:Vector.<b2Body>;
		private var _sprite:Sprite;
		private static var spForTexture:Sprite;
		
		static public var RopeCount:int = 0;
		static public var listCircles:Vector.<CircleData> = new Vector.<CircleData>();
		
		static private var listCirclesOfRope:Vector.<b2Body>;
		//static private var canJointPerson:Boolean = true;
		
		public function Rope(sp:Sprite) 
		{
			_sprite = Main.globalSprite;
			spForTexture = sp;
			
			listCirclesOfRope = new Vector.<b2Body>();
			AllBodyList = new Vector.<b2Body>();
			BodyList = new Vector.<b2Body>();
		}
		
		
		
		static public function CreateCircleData(x:Number, y:Number, radius:Number):void
		{
			var cData:CircleData = new CircleData();
			cData.SetData(x, y, radius);
			listCircles.push(cData);
		}
		

		
		public function CreateRope(world:b2World,x:Number, y:Number, height:Number, scale:Number):void
		{
			
			var joint:Joints = new Joints(world, scale);
			var uData:UserData = new UserData(RopeCount, "partOfRope");
			uData.textureInfo = "partOfRope";
			uData.textureChange = true;
			
			var body:b2Body = CreateDynamicBox(world, x, y, 5, height, scale, uData, -1);
			AllBodyList.push(body);
			
			
			uData = null;
			var uData:UserData =  new UserData(RopeCount, "node");
			uData.canJointPerson = true;
			uData.textureInfo = "node";
			uData.textureChange = true;
			
			var circle:b2Body = CreateDynamicCircle(world, x, y - height / 2 - 5, 10, scale, uData, -1);
			AllBodyList.push(circle);
			listCirclesOfRope.push(circle);
			
			//joint.CreateRevoluteJointToVector(body, circle, new b2Vec2(x, y - height / 2), "");
			joint.CreateRevoluteJoint(body, circle, new b2Vec2(0 , - height / 2), new b2Vec2(0, 0), "");
			
			uData = null;
			uData = new UserData(RopeCount, "node2");
			uData.canJointPerson = true;
			uData.textureInfo = "node";
			uData.textureChange = true;
			
			circle = CreateDynamicCircle(world, x, y + height / 2 + 5, 10, scale, uData, -1);
			
			
			//joint.CreateRevoluteJointToVector(body, circle, new b2Vec2(x, y + height / 2), "");
			joint.CreateRevoluteJoint(body, circle, new b2Vec2(0, height / 2), new b2Vec2(0, 0), "");
			AllBodyList.push(circle);
			listCirclesOfRope.push(circle);
			
			RopeCount++;
			
			/*var uData:UserData = new UserData(RopeCount, "node");
			//uData.texture = new Node();
			//_sprite.addChild(uData.texture);
			
			var prev:b2Body = CreateDynamicCircle(world, x, y, _heigth / 2 , 30, uData, false);
			AllBodyList.push(prev);
			
			var joint:Joints = new Joints(world, 30);

			for ( var i:uint = 1 ; i < length; i++)
			{
				var body_:b2Body;
				if (i != length - 1)
				{
					var uData:UserData = new UserData(RopeCount, "partOfRope");
					//uData.texture = new gRope();
					//_sprite.addChild(uData.texture);
					
					body_ = CreateDynamicBox(world, x , y + i * _heigth - (3 * i) , width, _heigth, 30, uData, false);
					AllBodyList.push(body_);
					joint.CreateRevoluteJointToVector(prev, body_, new b2Vec2(x , y  + (_heigth * i) - _heigth / 2.0 - (3 * i)) , "");
					//joint.CreateDistanceJoint(prev, body_, prev.GetPosition(), body_.GetPosition(), 1, "");
				}
				if (i == length - 1)
				{
					var uData:UserData = new UserData(RopeCount, "node2");
					//uData.texture = new Node();
					//_sprite.addChild(uData.texture);
					
					body_ = CreateDynamicCircle(world,x, y + i * _heigth - (3 * i), _heigth / 2 , 30, uData, false);
					AllBodyList.push(body_);
					joint.CreateRevoluteJointToVector(prev, body_, new b2Vec2(x , y  + (_heigth * i) - (3 * i)), "");
				}
				
				prev = body_;
			}
		
			prev = null;
			RopeCount++;*/
		}
		
		
		
		public function CreateRopeWithHook(world:b2World,x:Number, y:Number, height:Number, scale:Number):void
		{
			
			y = y - height / 2 - 5;
			
			var joint:Joints = new Joints(world, scale);
			var uData:UserData = new UserData(RopeCount, "partOfRope");
			uData.textureInfo = "partOfRope";
			uData.isJointRope = true;
			uData.textureChange = true;
			
			var body:b2Body = CreateDynamicBox(world, x, y, 5, height, scale, uData, -1);
			AllBodyList.push(body);
			
			
			uData = null;
			var uData:UserData =  new UserData(RopeCount, "node");
			uData.textureInfo = "node";
			uData.isJointRope = true;
			uData.isJointNode = true;
			uData.textureChange = true;
			
			var circle:b2Body = CreateDynamicCircle(world, x, y - height / 2 - 5, 10, scale, uData, -1);
			AllBodyList.push(circle);
			listCirclesOfRope.push(circle);
			joint.CreateRevoluteJointToVector(world.GetGroundBody(), circle, new b2Vec2(x, y - height / 2 - 5), "nodeJoint");
			
			
			
			
			//joint.CreateRevoluteJointToVector(body, circle, new b2Vec2(x, y - height / 2), "");
			joint.CreateRevoluteJoint(body, circle, new b2Vec2(0 , - height / 2), new b2Vec2(0, 0), "");
			
			uData = null;
			uData = new UserData(RopeCount, "node2");
			uData.canJointPerson = true;
			uData.isJointRope = true;
			uData.textureInfo = "node";
			uData.textureChange = true;
			
			circle = CreateDynamicCircle(world, x, y + height / 2 + 5, 10, scale, uData, 0);
			
			
			//joint.CreateRevoluteJointToVector(body, circle, new b2Vec2(x, y + height / 2), "");
			joint.CreateRevoluteJoint(body, circle, new b2Vec2(0, height / 2), new b2Vec2(0, 0), "");
			AllBodyList.push(circle);
			listCirclesOfRope.push(circle);
			
			RopeCount++;
			
		}
		
		
		
		
		static public function VerifiDistanceForRope(person:b2Body):void
		{
			if (listCirclesOfRope)
			{
				for (var i:int = 0; i < listCirclesOfRope.length; i++)
				{
					var uData:UserData = listCirclesOfRope[i].GetUserData();
					var dataPerson:UserData = person.GetUserData();
					if (!uData.isJointNode && !dataPerson.isJointPerson && uData.isJointRope)
					{
						if ( Calc.isObjectInCircle( Calc.CMeterToPixel(person.GetPosition(), 30), 
													Calc.CMeterToPixel(listCirclesOfRope[i].GetPosition(), 30),
													60/*radius*/)  && uData.canJointPerson)
													{
														
														person.SetLinearVelocity(Calc.CreateVectorVelocityWithMaxVector(
																														Calc.CMeterToPixel(listCirclesOfRope[i].GetPosition(), 30),
																														Calc.CMeterToPixel(person.GetPosition(), 30),
																														new b2Vec2(0, 9) )	)
														uData.canJointPerson = false;
													}
						else if(!Calc.isObjectInCircle( Calc.CMeterToPixel(person.GetPosition(), 30), 
														Calc.CMeterToPixel(listCirclesOfRope[i].GetPosition(), 30),
														60/*same radius*/)	)
												{
													if(!uData.canJointPerson)
														uData.canJointPerson = true;
												}
					}
					
				}
				
			}
		}
		
		
		static public function SetJointRope(partOfRopeData:UserData, isJoint:Boolean):void
		{
			for (var i:int = 0; i < AllBodyList.length; i++)
			{
				var nowData:UserData = AllBodyList[i].GetUserData();
				if (nowData.ropeNum == partOfRopeData.ropeNum)
				{
					nowData.isJointRope = isJoint;
				}
			}
		}
		
		
		
		static public function GetOtherNode(uData:UserData):b2Body
		{
			for ( var i:int = 0; i < AllBodyList.length; i++)
			{
				var listData:UserData = AllBodyList[i].GetUserData();
				
				if (uData.ropeNum == listData.ropeNum)
				{
					if (uData.objectName == "node")
					{
						if (listData.objectName == "node2")
							return AllBodyList[i];
					}
					if (uData.objectName == "node2")
					{
						if (listData.objectName == "node")
							return AllBodyList[i];
					}
				}
			}
			
			return null;
		}
		
		
		
		
		
		
		
		static public function isHangRope(uData:UserData):Boolean
		{
			if (uData.isJointNode) return true;
			
			for (var i:int = 0; i < AllBodyList.length; i++)
			{
				var listData:UserData = AllBodyList[i].GetUserData();
				if (uData.ropeNum == listData.ropeNum)
				{
					if (uData.objectName == "node")
					{
						if (listData.objectName == "node2")
						{
							if (listData.isJointNode) return true;
							else return false;
						}
					}
					if (uData.objectName == "node2")
					{
						if (listData.objectName == "node")
						{
							if (listData.isJointNode) return true;
							else return false;
						}
					}
				}
			}
			return false;
		}
		
		
		static public function DestroyRopes()
		{
			listCirclesOfRope = null;
			if (AllBodyList)
				AllBodyList = null;
				/*for (var i:int = 0; i < AllBodyList.length; i++)
				{
					var US:UserData = AllBodyList[i].GetUserData();
					if(US.texture != null)
						spForTexture.removeChild(US.texture);
				}*/
		}
		
		
	}

}