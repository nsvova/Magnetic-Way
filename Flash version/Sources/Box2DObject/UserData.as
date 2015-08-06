package  Box2DObject
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class UserData 
	{
		public var ropeNum:int = -1;
		public var objectName:String = "";
		public var isJointNode:Boolean = false;
		public var isJointRope:Boolean = false;
		public var isJointPerson:Boolean = false;
		public var texture:Sprite = null;
		public var textureInfo:String;
		public var textureChange:Boolean = false;
		
		public var isActiveObject:Boolean = false;
		public var intInformation:int = 0;
		public var delta:int = 0;
		public var canJointPerson:Boolean = false;
		
		public var width:int;
		public var height:int;
		
		public var x:Number;
		public var y:Number;
		
		public function UserData(_ropeNum:int, _objectName:String) 
		{
			ropeNum = _ropeNum;
			objectName = _objectName;
		}
		
		static public function CreateUserData(_ropeNum:int, _objectName:String, _texture:Sprite):UserData
		{
			var US:UserData = new UserData(_ropeNum, _objectName);
			US.texture = _texture;
			
			return US;
		}
		
		public function AddXandY(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}
		
	}

}