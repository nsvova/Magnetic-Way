package  Box2DObject
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Collision.b2WorldManifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2FilterData;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Joints.b2WeldJoint;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Joints.b2JointEdge;
	import flash.events.StatusEvent;
	import flash.events.Event;
	import Screen.Level.Game;
	
	
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class my_contactListener extends b2ContactListener 
	{
		static public var isContactPersonAndFloor:Boolean = false;
		private var worldRef:b2World;
		private var canJoint:Boolean = true;
		
		public function SetCanJoint(_canJoint:Boolean):void
		{
			canJoint = _canJoint;
		}
		
		
		public function my_contactListener() 
		{
			
		}
		

		
		override public function BeginContact(contact:b2Contact):void 
		{
			super.BeginContact(contact);
			
			var a:b2Body = contact.GetFixtureA().GetBody();	
			var b:b2Body = contact.GetFixtureB().GetBody();

			var aData:UserData = a.GetUserData();
			var bData:UserData = b.GetUserData();
			
			worldRef = a.GetWorld();
			var joint:Joints = new Joints(worldRef, 30);
			
			//перевірка на дотик з виграшною стіною
			if (aData.objectName == "winWall" &&
				bData.objectName == "person")
				{
					var _lasLevel:int = Save.GetLastLevel();
					if (_lasLevel < Game.levelNum)
					{
						Save.LastLevel(Game.levelNum);
						Game.isEndLevel = true;
						Game.isWon = true;
					}
					else
					{
						Game.isWon = true;
						//Game.isEndLevel = true;
					}
				}
			
			if (bData.objectName == "winWall" &&
				aData.objectName == "person")
				{
					_lasLevel = Save.GetLastLevel();
					if (_lasLevel < Game.levelNum)
					{
						Save.LastLevel(Game.levelNum);
						Game.isWon = true;
						//Game.isEndLevel = true;
					}
					else
					{
						Game.isWon;
						//Game.isEndLevel = true;
					}
				}
			
				
			//перевірка на контакт з смертельним предметом
			if (aData.objectName == "person" &&
				bData.objectName == "die" && 
					!Game.isDied)
				{
					//bData.objectName = "delete";
					//aData.objectName = "delete";
					Game.isDied = true;
				}
					
			if (bData.objectName == "person" &&
				aData.objectName == "die" && 
					!Game.isDied)
				{	
					//bData.objectName = "delete";
					//aData.objectName = "delete";
					Game.isDied = true;
				}
				
			
	//researching on touch rope and persone___________________________
		if (!isContactPersonAndFloor)
		{
				if ((aData.objectName == "node" || 
					aData.objectName == "node2")&&
					bData.objectName == "person")
					{
						if (Rope.isHangRope(aData))
						{
							var flag:Boolean = true;	
							var jointList1:b2JointEdge = b.GetJointList();
							while (jointList1 != null)
							{
								if (jointList1.joint.GetUserData() == "personRope")//якшо персонаж вже зєднаний з мотузкою то знову зєднувати не потрібно
									{
										flag = false;
										break;
									}
								jointList1 = jointList1.next;
							}
							if (flag && !aData.isJointNode)
							{
								joint.CreateDistanceJoint(a,
														  b,
														  a.GetPosition(),
														  b.GetPosition(),
														  15,
														  "personRope"
														  )
								//aData.textureInfo = "node";
								//aData.textureChange = true;
								/*joint.CreateWeldJoint(a, 
													  b,
													  b.GetPosition(),
													  "personeRope"
													  );*/
								aData.isJointPerson = true;
								bData.isJointPerson = true;
								
								Game.SetPersonAndNode(a, b);
								
							  
							}
						}
					}
					
				if ((bData.objectName == "node" || 
					bData.objectName == "node2")&&
					aData.objectName == "person")
					{

						if (Rope.isHangRope(bData))
						{
							var flag2:Boolean = true;	
							var jointList2:b2JointEdge = a.GetJointList();
							while (jointList2 != null)
							{
								if (jointList2.joint.GetUserData() == "personRope")//якшо персонаж вже зєднаний з мотузкою то знову зєднувати не потрібно
									{
										flag2 = false;
										break;
									}
								jointList2 = jointList2.next;
							}
							if (flag2 && !bData.isJointNode)
							{
								
								joint.CreateDistanceJoint(a,
														  b,
														  a.GetPosition(),
														  b.GetPosition(),
														  15,
														  "personRope"
														  )
														  
								//bData.textureInfo = "node";
								//bData.textureChange = true;
								/*joint.CreateWeldJoint(a, 
													  b,
													  b.GetPosition(),
													  "personRope"
													  );*/
								bData.isJointPerson = true;
								aData.isJointPerson = true;
								
								Game.SetPersonAndNode(a, b);
								
							}
						}
					}
		}
			//____________________________________________________	

			
			if (aData.objectName == "person" &&
				bData.objectName == "floor")
				{
					a.SetLinearDamping(1.3)
					aData.textureInfo = "personGetEnergy";
					aData.textureChange = true;
					var tempVec:b2Vec2 = new b2Vec2(0, 0);
					tempVec = Calc.CMeterToPixel(a.GetPosition(), 30);
					aData.x = tempVec.x;
					aData.y = tempVec.y;
				}
			if (bData.objectName == "person" &&
				aData.objectName == "floor")
				{
					b.SetLinearDamping(1.3);
					bData.textureInfo = "personGetEnergy";
					bData.textureChange = true;
					var tempVec:b2Vec2 = new b2Vec2(0, 0);
					tempVec = Calc.CMeterToPixel(b.GetPosition(), 30);
					bData.x = tempVec.x;
					bData.y = tempVec.y;
				}
			
			
			
			/*//Sensor or not sensor for rope
			var dataA:UserData = contact.GetFixtureA().GetBody().GetUserData();
			var dataB:UserData = contact.GetFixtureB().GetBody().GetUserData();
			
			if ((dataA.objectName == "node" ||
				dataA.objectName == "node2" ||
				dataA.objectName == "partOfRope") &&
				(dataB.objectName == "floor" ||
				 dataB.objectName == "die" ||
				 dataB.objectName == "wall"))
				 {
						var fixA:b2Fixture = contact.GetFixtureA();
						fixA.SetSensor(false);
				 }
			else if ((dataB.objectName == "node" ||
					  dataB.objectName == "node2" ||
						dataB.objectName == "partOfRope") &&
						(dataA.objectName == "floor" ||
						 dataA.objectName == "die" ||
						 dataA.objectName == "wall"))
						{
							var fixB:b2Fixture = contact.GetFixtureB();
							fixB.SetSensor(false);
						}
			else if(dataA.objectName == "node" ||
					  dataA.objectName == "node2" ||
						dataA.objectName == "partOfRope")
						{
							var fixA:b2Fixture = contact.GetFixtureA();
							fixA.SetSensor(true);
						}
			else if(dataB.objectName == "node" ||
					  dataB.objectName == "node2" ||
						dataB.objectName == "partOfRope")
						{
							var fixB:b2Fixture = contact.GetFixtureB();
							fixB.SetSensor(true);
						}
			
			*/
			
		}
		
		
		private function MetersToPixel(vec:b2Vec2):b2Vec2
		{
			vec.x *= 10;
			vec.y *= 10;
			
			return vec;
		}
		
		private function MiddlePoint(p1:b2Vec2, p2:b2Vec2):b2Vec2
		{
			var result:b2Vec2 = new b2Vec2(0 , 0);
			
			result.x = (p1.x + p2.x) / 2;
			result.y = (p1.y + p2.y) / 2;
			
			return result;

		}
		
		override public function EndContact(contact:b2Contact):void 
		{
			super.EndContact(contact);
			
			var a:b2Body = contact.GetFixtureA().GetBody();	
			var b:b2Body = contact.GetFixtureB().GetBody();

			var aData:UserData = a.GetUserData();
			var bData:UserData = b.GetUserData();
			
			if (aData.objectName == "person" &&
				bData.objectName == "floor")
				{
					a.SetLinearDamping(0);
				}
			if (bData.objectName == "person" &&
				aData.objectName == "floor")
				{
					b.SetLinearDamping(0);
				}

		}
		
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void 
		{
			super.PreSolve(contact, oldManifold);
			
			var a:b2Body = contact.GetFixtureA().GetBody();	
			var b:b2Body = contact.GetFixtureB().GetBody();

			var aData:UserData = a.GetUserData();
			var bData:UserData = b.GetUserData();
			
			if (aData.objectName == "bonus" &&
				bData.objectName == "person" )
				{
					//***
					aData.objectName = "delete";
				}
				
			else if (bData.objectName == "bonus" &&
						aData.objectName == "person" )
						{
							//***
							bData.objectName = "delete";
						}
						
						
						
						

			
		
			
		}
		
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
		{
			super.PostSolve(contact, impulse);
			

		}
		
	
		
	}

}