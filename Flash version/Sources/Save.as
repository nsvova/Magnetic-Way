package  
{
	
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author Vova_Nos
	 */
	public class Save 
	{
		
		public function Save() 
		{
			
		}
		
		static public function LastLevel(level:int):void
		{
			var save:SharedObject = SharedObject.getLocal("Magnetic_way_1.0","/");
			save.data.level = level;
			save.flush()
		}
		
		
		static public function SoundOn(on:Boolean):void
		{
			var save:SharedObject = SharedObject.getLocal("Magnetic_way_1.0","/");
			save.data.sound = on;
			save.flush()
		}
		
		static public function GetSoundOn():Boolean
		{
			var save:SharedObject = SharedObject.getLocal("Magnetic_way_1.0","/");
			
			if (save.data.sound)
			{
				return save.data.sound;
			}
			return true;
		}
		
		static public function GetLastLevel():int 
		{
			var save:SharedObject = SharedObject.getLocal("Magnetic_way_1.0","/");
			if (save.data.level)
			{
				return save.data.level;
			}
			else
				return 0;
		}
		
		static public function BonusPoints(_listBonusPoints:Vector.<int>):void
		{
			var save:SharedObject = SharedObject.getLocal("Magnetic_way_1.0","/");
			save.data.bonusPoints = _listBonusPoints;
			save.flush();
		}
		
		
		static public function GetBonusPoints():Vector.<int>
		{
			var save:SharedObject = SharedObject.getLocal("Magnetic_way_1.0","/");
			if (save.data.bonusPoints != null)
			{
				var list:Vector.<int> = save.data.bonusPoints;
				var copyList:Vector.<int> = new Vector.<int>();
				for (var i:int = 0; i < list.length; i++)
				{
					copyList.push(list[i]);
				}
				return copyList;
			}
			return null;	
		}
		
		
		
		static public function Clear():void
		{
			var save:SharedObject = SharedObject.getLocal("Magnetic_way_1.0","/");
			save.clear();
		}
	}

}