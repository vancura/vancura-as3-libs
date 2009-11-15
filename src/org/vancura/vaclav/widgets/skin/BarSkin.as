package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.core.BitmapUtil;
	import org.vancura.vaclav.widgets.interfaces.IBarSkin;

	import flash.display.BitmapData;
	import flash.display.MovieClip;

	
	
	public class BarSkin extends Skin implements IBarSkin {

		
		
		protected var $paddingTop:Number;
		protected var $paddingBottom:Number;
		protected var $paddingLeft:Number;
		protected var $paddingRight:Number;
		protected var $guideBD:BitmapData;
		protected var $backBD:BitmapData;

		private var _oldPaddingTop:Number;
		private var _oldPaddingBottom:Number;
		private var _oldPaddingLeft:Number;
		private var _oldPaddingRight:Number;

		
		
		public function BarSkin(id:String = null) {
			super(Skin.TYPE_BAR, id);
			
			$paddingTop = 0;
			$paddingBottom = 0;
			$paddingLeft = 0;
			$paddingRight = 0;
			
			$guideBD = new BitmapData(1, 1, true, 0x00000000);
			$backBD = new BitmapData(1, 1, true, 0x00000000);
		}

		
		
		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 2 != 0) {
				throw new Error('Width has to be multiple of 2');
			}
			
			$assetWidth = source.width / 2;
			$assetHeight = source.height;
			
			$guideBD = BitmapUtil.crop(source, 0, 0, $assetWidth, $assetHeight);
			$backBD = BitmapUtil.crop(source, $assetWidth * 1, 0, $assetWidth, $assetHeight);
		}

		
		
		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			$getSkinSize(source, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);
			
			$backBD = $getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'back' : labels[0]);
			$guideBD = $getSkinFrame(source, elements, (labels[1] == undefined || labels[1] == '') ? 'guide' : labels[1]);
		}

		
		
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
			
			_oldPaddingTop = $paddingTop;
			_oldPaddingBottom = $paddingBottom;
			_oldPaddingLeft = $paddingLeft;
			_oldPaddingRight = $paddingRight;
			
			if(source.paddingTop != undefined) {
				$paddingTop = source.paddingTop;
			}
			
			if(source.paddingBottom != undefined) {
				$paddingBottom = source.paddingBottom;
			}
			
			if(source.paddingLeft != undefined) {
				$paddingLeft = source.paddingLeft;
			}
			
			if(source.paddingRight != undefined) {
				$paddingRight = source.paddingRight;
			}
		}
		
		
		
		override public function revertConfig():void {
			super.revertConfig();
			
			$paddingTop = _oldPaddingTop;
			$paddingBottom = _oldPaddingBottom;
			$paddingLeft = _oldPaddingLeft;
			$paddingRight = _oldPaddingRight;
		}

		
		
		public function get paddingTop():Number {
			return $paddingTop;
		}

		
		
		public function set paddingTop(value:Number):void {
			$paddingTop = value;
		}

		
		
		public function get paddingBottom():Number {
			return $paddingBottom;
		}

		
		
		public function set paddingBottom(value:Number):void {
			$paddingBottom = value;
		}

		
		
		public function get paddingLeft():Number {
			return $paddingLeft;
		}

		
		
		public function set paddingLeft(value:Number):void {
			$paddingLeft = value;
		}

		
		
		public function get paddingRight():Number {
			return $paddingRight;
		}

		
		
		public function set paddingRight(value:Number):void {
			$paddingRight = value;
		}
		
		
		
		public function set guideBD(source:BitmapData):void {
			$checkSize(source);
			$guideBD = source;
		}

		
		
		public function get guideBD():BitmapData {
			return $guideBD;
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
