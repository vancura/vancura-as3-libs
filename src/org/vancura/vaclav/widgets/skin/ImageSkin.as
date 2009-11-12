package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.core.BitmapUtil;
	import org.vancura.vaclav.widgets.skin.interfaces.IImageSkin;

	import flash.display.BitmapData;
	import flash.display.MovieClip;

	
	
	public class ImageSkin extends Skin implements IImageSkin {

		
		
		protected var $paddingTop:Number;
		protected var $paddingLeft:Number;
		protected var $backBD:BitmapData;

		private var _oldPaddingTop:Number;
		private var _oldPaddingLeft:Number;

		
		
		public function ImageSkin(id:String = null) {
			super(Skin.TYPE_IMAGE, id);
			
			$paddingTop = 0;
			$paddingLeft = 0;
			
			$backBD = new BitmapData(1, 1, true, 0x00000000);
		}

		
		
		public function getAssetsFromComposition(source:BitmapData):void {
			$assetWidth = source.width;
			$assetHeight = source.height;
			
			$backBD = BitmapUtil.crop(source, $assetWidth * 1, 0, $assetWidth, $assetHeight);
		}

		
		
		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			$getSkinSize(source, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);
			
			$backBD = $getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'back' : labels[0]);
		}

		
		
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
			
			_oldPaddingTop = $paddingTop;
			_oldPaddingLeft = $paddingLeft;
			
			if(source.paddingTop != undefined) {
				$paddingTop = source.paddingTop;
			}
			
			if(source.paddingLeft != undefined) {
				$paddingLeft = source.paddingLeft;
			}
		}
		
		
		
		override public function revertConfig():void {
			super.revertConfig();
			
			$paddingTop = _oldPaddingTop;
			$paddingLeft = _oldPaddingLeft;
		}

		
		
		public function get paddingTop():Number {
			return $paddingTop;
		}

		
		
		public function set paddingTop(value:Number):void {
			$paddingTop = value;
		}

		
		
		public function get paddingLeft():Number {
			return $paddingLeft;
		}

		
		
		public function set paddingLeft(value:Number):void {
			$paddingLeft = value;
		}

		
		
		public function set backBD(source:BitmapData):void {
			$checkSize(source);
			$backBD = source;
		}

		
		
		public function get backBD():BitmapData {
			return $backBD;
		}
	}
}
