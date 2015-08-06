package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Shape;
	import flash.events.WeakFunctionClosure;
	import flash.events.StatusEvent;
	import flash.text.TextFormat;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.utils.Timer;
	import Screen.*;
	import Screen.Level.*;
	import Screen.Level.NextLevels.*;
	import mochi.as3.*;
 
	/**	 * ...
	 * @author Vova_Nos
	 */
	//[Frame(factoryClass="preloader.PreloaderClass")]
	public class Main extends Sprite
	{
		
		var _currentScreen:GameScreen;
		var menu:Menu = null;
		var result:Result = null;
		var beforMenu:BeforMenu = null;
		private var wasSiteLock:Boolean = false;
		
		static public var globalSprite:Sprite;
		
		public function Main():void 
		{	

			
				globalSprite = new Sprite();
				addChild(globalSprite);
				
				menu = new Menu();
				result = new Result();
				beforMenu = new BeforMenu();
				
				
				_currentScreen = beforMenu;
				
				_currentScreen.addEventListener(StatusEvent.STATUS, gameStatus);
				
				addChild(_currentScreen);
				

		}
		

		
		private function UrlOk():Boolean
		{
				var url:String=stage.loaderInfo.url;
				var urlStart:Number = url.indexOf("://")+3;
				var urlEnd:Number = url.indexOf("/", urlStart);
				var domain:String = url.substring(urlStart, urlEnd);
				var LastDot:Number = domain.lastIndexOf(".")-1;
				var domEnd:Number = domain.lastIndexOf(".", LastDot)+1;
				domain = domain.substring(domEnd, domain.length);
				if (domain != "flashgamelicense.com") 
				{
					removeChild(_currentScreen);
					
					var tf:TextField = new TextField();
					tf.text = "Error url";
					tf.x = 300;
					tf.y = 230;
					addChild(tf);
					return false;
				}
				
				return true;
		}
		
		public function gameStatus(e:StatusEvent):void
		{
			
			
			
			
			/*if (!wasSiteLock)
			{
				wasSiteLock = true;
				if (!UrlOk())
				{
					return;
				}
			}*/
			
			switch(e.level)
			{
				case "GoToLevelMenu":
					{
						if (Save.GetLastLevel() < 10)
						{
							changeScreen(new LevelMenu());
						}
						else
						{
							changeScreen(new LevelMenu2());
						}
						break;
					}
				case "GoToLevelMenu!":
						{
							changeScreen(new LevelMenu());
							break;
						}
				case "GoToLevelMenu2":
					{
						changeScreen(new LevelMenu2());
						break;
					}
				case "GoToMenu":
					{
						changeScreen(menu);
						/*MochiServices.connect("20962c19e8d9fd80", menu, errorConnect);
						
									MochiAd.loadDock({
												clip:menu,
												id:"20962c19e8d9fd80",
												position:"bottom_center",                   // See below for explanation.
												ad_count:5,                                 // The number of ads to display in the showcase.
												ad_size:90,                                 // Force dimensions for all Ads displayed.
												ad_loaded: function(w:int, h:int):void { }, // A callback that occurs when ad is first displayed.
												ad_opened: function():void {},              // A callback that occurs when the user opens the Dock by mousing over the tab.
												ad_closed: function():void {}               // A callback that occurs when the Dock auto-hides.
											});
						//MochiAd.showPreGameAd( { id:"20962c19e8d9fd80", res:"640x480" } );*/
						break;
					}
				case "GoToResult":
					{
						changeScreen(result);
						break;
					}
				case "GoToAuthors":
					{
						changeScreen(new Authors());
						break;
					}
					
					
				
					
				case "Level1":
					{
						changeScreen(new Level1(globalSprite));
						break;
					}
				case "Level2":
					{
						if (Save.GetLastLevel() >= 1)
						{
							changeScreen(new Level2(globalSprite));
							break;
						}
						break;
					}
				case "Level3":
					{
						if (Save.GetLastLevel() >= 2)
						{
							changeScreen(new Level3(globalSprite));
							break;
						}
						break;
					}
				case "Level4":
					{
						if (Save.GetLastLevel() >= 3)
						{
							changeScreen(new Level4(globalSprite));
							break;
						}
						break;
					}
				case "Level5":
					{
						if (Save.GetLastLevel() >= 4)
						{
							changeScreen(new Level5(globalSprite));
							break;
						}
						break;
					}
				case "Level6":
					{
						if (Save.GetLastLevel() >= 5)
						{
							changeScreen(new Level6(globalSprite));
							break;
						}
						break;
					}
				case "Level7":
					{
						if (Save.GetLastLevel() >= 6)
						{
							changeScreen(new Level7(globalSprite));
							break;
						}
						break;
					}
				case "Level8":
					{
						if (Save.GetLastLevel() >= 7)
						{
							changeScreen(new Level8(globalSprite));
							break;
						}
						break;
					}
				case "Level9":
					{
						if (Save.GetLastLevel() >= 8)
						{
							changeScreen(new Level9(globalSprite));
							break;
						}
						break;
					}
				case "Level10":
					{
						if (Save.GetLastLevel() >= 9)
						{
							changeScreen(new Level10(globalSprite));
							break;
						}
						break;
					}
				case "Level11":
					{
						if (Save.GetLastLevel() >= 10  && Bonus.AllBonus() >= 25)
						{
							changeScreen(new Level11(globalSprite));
							break;
						}
						break;
					}
				case "Level12":
					{
						if (Save.GetLastLevel() >= 11)
						{
							changeScreen(new Level12(globalSprite));
							break;
						}
						break;
					}
				case "Level13":
					{
						if (Save.GetLastLevel() >= 12)
						{
							changeScreen(new Level13(globalSprite));
							break;
						}
						break;
					}
				case "Level14":
					{
						if (Save.GetLastLevel() >= 13)
						{
							changeScreen(new Level14(globalSprite));
							break;
						}
						break;
					}
				case "Level15":
					{
						if (Save.GetLastLevel() >= 14)
						{
							changeScreen(new Level15(globalSprite));
							break;
						}
						break;
					}
				case "Level16":
					{
						if (Save.GetLastLevel() >= 15)
						{
							changeScreen(new Level16(globalSprite));
							break;
						}
						break;
					}
				case "Level17":
					{
						if (Save.GetLastLevel() >= 16)
						{
							changeScreen(new Level17(globalSprite));
							break;
						}
						break;
					}
				case "Level18":
					{
						if (Save.GetLastLevel() >= 17)
						{
							changeScreen(new Level18(globalSprite));
							break;
						}
						break;
					}
				case "Level19":
					{
						if (Save.GetLastLevel() >= 18)
						{
							changeScreen(new Level19(globalSprite));
							break;
						}
						break;
					}
				case "Level20":
					{
						if (Save.GetLastLevel() >= 19)
						{
							changeScreen(new Level20(globalSprite));
							break;
						}
						break;
					}
				case "Level21":
					{
						if (Save.GetLastLevel() >= 20)
						{
							changeScreen(new HelpScreen());
						}
						break;
					}
					
					
					
					
				
				
			}
		}
		
		public function changeScreen(curScreen:GameScreen):void
		{
			_currentScreen.Stop();
			_currentScreen.removeEventListener(StatusEvent.STATUS, gameStatus);
			
			removeChild(_currentScreen);
			
			_currentScreen = curScreen;
			
			addChild(_currentScreen);
			
			
			_currentScreen.addEventListener(StatusEvent.STATUS, gameStatus);
			
			_currentScreen.Start();
		}
		
		
		
		
		

 
		
		
	}
	
}