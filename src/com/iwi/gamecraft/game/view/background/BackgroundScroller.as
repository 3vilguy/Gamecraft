package com.iwi.gamecraft.game.view.background
{
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	public class BackgroundScroller extends Sprite
	{
		private var bgImages:Vector.<Image>;
		private var bgQuad:QuadBatch;
		private var bg1:Image;
		private var bg2:Image;
		private var bgWidth:Number;
		private var bgHalfWidth:Number;
		
		private var currX:Number = 0;
		private var prevX:Number = 0;
		
		
		public function BackgroundScroller()
		{
			super();
			init();
		}
		
		private function init():void
		{
			bgImages = new Vector.<Image>();
			bgImages.push( new Image( GameCraft.assetManager.getTexture("bgLevel") ));
			bgImages.push( new Image( GameCraft.assetManager.getTexture("bgLevel") ));
			
			bgQuad = new QuadBatch();
			
			bg1 = bgImages[ Math.floor(Math.random() * bgImages.length) ];
			bg1.readjustSize();
			bg1.scaleX = bg1.scaleY = 1.3;
			bg1.y = -50;
			bgQuad.addImage(bg1);
			
			bg2 = bgImages[ Math.floor(Math.random() * bgImages.length) ];
			bg2.x = bg1.width;
			bg2.readjustSize();
			bg2.scaleX = bg2.scaleY = 1.3;
			bg2.y = -50;
			bgQuad.addImage(bg2);
			
			bgWidth = -bgQuad.width;
			bgHalfWidth = bgWidth >> 1;
			
			addChild(bgQuad);
		}
		
		public function moveBg(parentX:Number, parentY:Number):void
		{
			currX = parentX % bgHalfWidth;
			x = currX;
			
			if(currX > prevX)
			{
				bgQuad.reset();
				
				bg1 = bg2
				bg1.x = 0;
				bgQuad.addImage(bg1);
				
				bg2 = bgImages[ Math.floor(Math.random() * bgImages.length) ];
				bg2.x = bg1.width;
				bg2.readjustSize();
				bg2.scaleX = bg2.scaleY = 1.3;
				bg2.y = -50;
				bgQuad.addImage(bg2);
			}
			
			prevX = currX;
		}
	}
}