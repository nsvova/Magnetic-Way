package  
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Other
	 */
	public class SoundEffect 
	{
		
		private static var mainSound:Sound = new sMainSound();
		private static var soundChanel:SoundChannel = null;
		
		
		public static var isEffectOn:Boolean = true;
		public static var SoundOn:Boolean = true;
		
		private static var position:Number = 0;
		
		
		public function SoundEffect()
		{
			
		}
		
		public static function FirstPlayMain():void
		{
			var st:SoundTransform = new SoundTransform(0.5, 0);
			soundChanel = mainSound.play(0, 0, st);
			soundChanel.addEventListener(Event.SOUND_COMPLETE, completeSound);
		}
		
		public static function PlayMain():void
		{
			var st:SoundTransform = new SoundTransform(0.5, 0);
			soundChanel = mainSound.play(position, 0, st);
			soundChanel.addEventListener(Event.SOUND_COMPLETE, completeSound);
		}
		
		static private function completeSound(e:Event):void 
		{
			FirstPlayMain();
			
			//soundChanel.removeEventListener(Event.SOUND_COMPLETE, completeSound);
		}
		
		
		public static function StopMain():void
		{
			if (soundChanel)
			{
				soundChanel.stop();
			}
		}
		
		public static function StopAll():void
		{
			position = soundChanel.position;
			SoundMixer.stopAll();
		}
		
		
		public static function PlayDie():void
		{
			var dieSound:Sound = new sDie();
			dieSound.play();
		}
		
		public static function PlayWon():void
		{
			var wonSound:Sound = new sWon();
			wonSound.play();
		}
		
		public static function PlayFelt():void 
		{
			var feltSound:Sound = new sFelt();
			feltSound.play();
		}
		
		
	}

}