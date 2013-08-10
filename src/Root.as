package
{
    import com.iwi.gamecraft.game.audiointerface.IPlaysBackingTrack;
    import com.iwi.gamecraft.game.hiscore.HiScoreList;
    import com.iwi.gamecraft.game.hiscore.Hiscore;
    import com.iwi.gamecraft.game.view.scoreInterface.IHiScoreView;
    
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;
    import starling.utils.AssetManager;
    
    import utils.ProgressBar;

    public class Root extends Sprite
    {
        private static var sAssets:AssetManager;
        
        private var mActiveScene:IHiScoreView;

		public var hiScoreList:HiScoreList;
		
        public function Root()
        {
			hiScoreList = new HiScoreList();

			var paparazzi:Hiscore = new Hiscore();
			paparazzi.score = 60;
			paparazzi.name = "Paparazzi";
			hiScoreList.pushScore(paparazzi);

			var snoop:Hiscore = new Hiscore();
			snoop.score = 120;
			snoop.name = "Snoop";
			hiScoreList.pushScore(snoop);

			var privateEye:Hiscore = new Hiscore();
			privateEye.score = 180;
			privateEye.name = "Private Eye";
			hiScoreList.pushScore(privateEye);
			
			var professional:Hiscore = new Hiscore();
			professional.score = 240;
			professional.name = "Professional";
			hiScoreList.pushScore(professional);
			
            addEventListener(Menu.START_GAME, onStartGame);
            //addEventListener(Game.GAME_OVER,  onGameOver);
        }
        
        public function start(background:Texture, assets:AssetManager):void
        {
            sAssets = assets;
            
            addChild(new Image(background));
            
            var progressBar:ProgressBar = new ProgressBar(175, 20);
            progressBar.x = (background.width  - progressBar.width)  / 2;
            progressBar.y = (background.height - progressBar.height) / 2;
            progressBar.y = background.height * 0.85;
            addChild(progressBar);
            
            assets.loadQueue(function onProgress(ratio:Number):void
            {
                progressBar.ratio = ratio;
                
                if (ratio == 1)
                    Starling.juggler.delayCall(function():void
                    {
                        progressBar.removeFromParent(true);
                        showScene(Menu);
                    }, 0.15);
            });
        }
        
        private function onGameOver(event:Event, score:int):void
        {
            trace("Game Over! Score: " + score);
            showScene(Menu);
        }
        
        private function onStartGame(event:Event, gameMode:String):void
        {
            trace("Game starts! Mode: " + gameMode);
            showScene(Game);
        }
        
        private function showScene(screen:Class):void
        {
            if (mActiveScene)
			{
				(mActiveScene as Sprite).removeFromParent(true);
				mActiveScene.stopBackingTrack();
			}
            mActiveScene = new screen();
			mActiveScene.setScoreList(hiScoreList);
            addChild(mActiveScene as Sprite);
			mActiveScene.playBackingTrack();
        }
        
        public static function get assets():AssetManager { return sAssets; }
    }
}