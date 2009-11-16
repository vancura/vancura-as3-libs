package org.vancura.vaclav.widgets.widgets {
	import org.vancura.vaclav.core.addChildren;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IImage;
	import org.vancura.vaclav.widgets.interfaces.IImageSkin;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;

	
	
	public class Image extends Widget implements IImage {

		
		
		protected var $skin:IImageSkin;
		protected var $backBM:Bitmap;

		
		
		public function Image(	skin:IImageSkin,
								config:Object = null,
								parent:DisplayObjectContainer = null,
								debugLevel:String = null) {
									
			if(config == null) {
				config = new Object();
			}
			
			if(skin != null) {
				super(config, parent, (debugLevel != null) ? debugLevel : SkinManager.debugLevel);
			}
			else {
				throw new Error('No skin defined');
			}
			
			this.skin = skin;
		}

		
		
		override protected function $init():void {
			super.$init();
			
			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}

		
		
		override protected function $addChildren():void {
			super.$addChildren();
			
			$backBM = new Bitmap();
			
			addChildren($contentSpr, $backBM);
		}

		
		
		override protected function $removeChildren():void {
			super.$removeChildren();
			
			removeChildren($contentSpr, $backBM);
		}

		
		
		override public function draw():void {
			super.draw();
			
			$backBM.bitmapData = $skin.backBD;
			$backBM.smoothing = true;
			$backBM.x = $skin.paddingLeft;
			$backBM.y = $skin.paddingTop;
		}

		
		
		public function get skin():IImageSkin {
			return $skin;
		}

		
		
		public function set skin(skin:IImageSkin):void {
			$skin = skin;
			
			if($width == 0) {
				$width = $skin.assetWidth;
			}
			
			if($height == 0) {
				$height = $skin.assetHeight;
			}
			
			draw();
		}
		
		
		
		public function get bitmap():Bitmap {
			return $backBM;
		}
	}
}