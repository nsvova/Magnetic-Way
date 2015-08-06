package Screen 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	/**
	 * ...
	 * @author Other
	 */
	public class BeforMenu extends GameScreen 
	{
		
		var back:Sprite;
		
		public function BeforMenu() 
		{
			SoundEffect.SoundOn = Save.GetSoundOn();
			
			back = new gBackBeforeMenu();
			back.x = 0;
			back.y = 0;
			addChild(back);
						
			addEventListener(MouseEvent.CLICK, click);
		}
		
		private function click(e:MouseEvent):void 
		{
			dispatchEvent(new StatusEvent(StatusEvent.STATUS, false, false, "", "GoToMenu") )
		}
		
		
		override public function Start():void 
		{
			super.Start();
			
			

		}
		
		override public function Stop():void 
		{
			super.Stop();
			
			removeChild(back);
			back = null;
		}
		
		
		
	}

}