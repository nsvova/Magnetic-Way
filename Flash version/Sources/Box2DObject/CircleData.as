package  Box2DObject
{
	/**
	 * ...
	 * @author ...Vova_Nos
	 */
	public class CircleData
	{
		public var x:Number;
		public var y:Number;
		public var radius:Number;
		public var dataNum:int = -1;
		public var dataNum2:int = -1;
		public var dataString:String = "";
		public var bonusPoints:int = 0;
		
		public function CircleData():void
		{
			x = 0;
			y = 0;
			radius = 0;
		}
		public function SetData(_x:Number, _y:Number, _radius:Number):void
		{
			x = _x;
			y = _y;
			radius = _radius;
		}
		
		public function SetDataNum(data:int):void
		{
			dataNum = data;
		}
		
		public function SetDataString(data:String):void
		{
			dataString = data;
		}
	}

}