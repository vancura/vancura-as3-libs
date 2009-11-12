package org.vancura.vaclav.widgets.widgets {
	import org.bytearray.display.ScaleBitmap;
	import org.vancura.vaclav.core.addChildren;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.interfaces.IBar;
	import org.vancura.vaclav.widgets.interfaces.IBarSkin;
	import org.vancura.vaclav.widgets.skin.SkinManager;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	
	
	public class Bar extends Widget implements IBar {

		
		
		protected var $skin:IBarSkin;
		protected var $bodySBM:ScaleBitmap;

		
		
		public function Bar(	skin:IBarSkin,
								config:Object = null,
								parent:DisplayObjectContainer = null,
								debugLevel:String = null) {
									
			if(config == null) {
				config = new Object();
			}
			
			if(skin != null) {
				var sm:SkinManager = SkinManager.getInstance();
				super(config, parent, (debugLevel != null) ? debugLevel : sm.debugLevel);
			}
			else {
				throw new Error('No skin defined');
			}
			
			this.skin = skin;
		}

		
		
		override protected function $init():void {
			super.$init();
			
			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}

		
		
		override protected function $addChildren():void {
			super.$addChildren();
			
			$bodySBM = new ScaleBitmap();
			
			addChildren($contentSpr, $bodySBM);
		}

		
		
		override protected function $removeChildren():void {
			super.$removeChildren();
			
			removeChildren($contentSpr, $bodySBM);
		}

		
		
		override public function draw():void {
			super.draw();
			
			$bodySBM.bitmapData = $skin.backBD;

			var rect:Rectangle = $skin.guideBD.getColorBoundsRect(0x00FF0000, 0x00000000, false);
			$bodySBM.scale9Grid = rect;
			
			if($width != 0 && !isNaN($width)) {
				$bodySBM.width = $width - $skin.paddingLeft - $skin.paddingRight;
				$bodySBM.x = $skin.paddingLeft;
			}
			if($height != 0 && !isNaN($height)) {
				$bodySBM.height = $height - $skin.paddingTop - $skin.paddingBottom;
				$bodySBM.y = $skin.paddingTop;
			}
		}

		
		
		public function get skin():IBarSkin {
			return $skin;
		}

		
		
		public function set skin(skin:IBarSkin):void {
			$skin = skin;
			
			if($width == 0) {
				$width = $skin.assetWidth;
			}
			if($height == 0) {
				$height = $skin.assetHeight;
			}
			
			draw();
		}
	}
}