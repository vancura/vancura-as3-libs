package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.core.BitmapUtil;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;

	import flash.display.BitmapData;
	import flash.display.MovieClip;

	
	
	public class ButtonSkin extends Skin implements IButtonSkin {

		
		
		protected var $hoverInDuration:Number;
		protected var $hoverOutDuration:Number;
		protected var $focusInDuration:Number;
		protected var $focusOutDuration:Number;
		protected var $guideBD:BitmapData;
		protected var $outBD:BitmapData;
		protected var $hoverBD:BitmapData;
		protected var $focusBD:BitmapData;

		private var _oldHoverInDuration:Number;
		private var _oldHoverOutDuration:Number;
		private var _oldFocusInDuration:Number;
		private var _oldFocusOutDuration:Number;

		
		
		public function ButtonSkin(id:String = null) {
			super(SkinType.BUTTON, id);
			
			$hoverInDuration = 0;
			$hoverOutDuration = .15;
			$focusInDuration = 0;
			$focusOutDuration = .1;
			
			$guideBD = new BitmapData(1, 1, true, 0x00000000);
			$outBD = new BitmapData(1, 1, true, 0x00000000);
			$hoverBD = new BitmapData(1, 1, true, 0x00000000);
			$focusBD = new BitmapData(1, 1, true, 0x00000000);
		}

		
		
		public function getAssetsFromAtlas(source:BitmapData):void {
			if(source.width % 4 != 0) {
				throw new Error('Width has to be multiple of 4');
			}
			
			$assetWidth = source.width / 4;
			$assetHeight = source.height;
			
			$guideBD = BitmapUtil.crop(source, 0, 0, $assetWidth, $assetHeight);
			$outBD = BitmapUtil.crop(source, $assetWidth * 1, 0, $assetWidth, $assetHeight);
			$hoverBD = BitmapUtil.crop(source, $assetWidth * 2, 0, $assetWidth, $assetHeight);
			$focusBD = BitmapUtil.crop(source, $assetWidth * 3, 0, $assetWidth, $assetHeight);
		}

		
		
		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			$getSkinSize(source, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);
			
			$outBD = $getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'out' : labels[0]);
			$hoverBD = $getSkinFrame(source, elements, (labels[1] == undefined || labels[1] == '') ? 'hover' : labels[1]);
			$focusBD = $getSkinFrame(source, elements, (labels[2] == undefined || labels[2] == '') ? 'focus' : labels[2]);
			$guideBD = $getSkinFrame(source, elements, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);
		}

		
		
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
			
			_oldHoverInDuration = $hoverInDuration;
			_oldHoverOutDuration = $hoverOutDuration;
			_oldFocusInDuration = $focusInDuration;
			_oldFocusOutDuration = $focusOutDuration;
			
			if(source.hoverInDuration != undefined) {
				$hoverInDuration = source.hoverInDuration;
			}
			
			if(source.hoverOutDuration != undefined) {
				$hoverOutDuration = source.hoverOutDuration;
			}
			
			if(source.pressInDuration != undefined) {
				$focusInDuration = source.pressInDuration;
			}
			
			if(source.pressOutDuration != undefined) {
				$focusOutDuration = source.pressOutDuration;
			}
		}
		
		
		
		override public function revertConfig():void {
			super.revertConfig();
			
			$hoverInDuration = _oldHoverInDuration;
			$hoverOutDuration = _oldHoverOutDuration;
			$focusInDuration = _oldFocusInDuration;
			$focusOutDuration = _oldFocusOutDuration;
		}

		
		
		public function set hoverInDuration(value:Number):void {
			$hoverInDuration = value;
		}

		
		
		public function get hoverInDuration():Number {
			return $hoverInDuration;
		}

		
		
		public function set hoverOutDuration(value:Number):void {
			$hoverOutDuration = value;
		}

		
		
		public function get hoverOutDuration():Number {
			return $hoverOutDuration;
		}

		
		
		public function set focusInDuration(value:Number):void {
			$focusInDuration = value;
		}

		
		
		public function get focusInDuration():Number {
			return $focusInDuration;
		}

		
		
		public function set focusOutDuration(value:Number):void {
			$focusOutDuration = value;
		}

		
		
		public function get focusOutDuration():Number {
			return $focusOutDuration;
		}

		
		
		public function set outBD(source:BitmapData):void {
			$checkSize(source);
			$outBD = source;
		}

		
		
		public function get outBD():BitmapData {
			return $outBD;
		}

		
		
		public function set hoverBD(source:BitmapData):void {
			$checkSize(source);
			$hoverBD = source;
		}

		
		
		public function get hoverBD():BitmapData {
			return $hoverBD;
		}

		
		
		public function set focusBD(source:BitmapData):void {
			$checkSize(source);
			$focusBD = source;
		}

		
		
		public function get focusBD():BitmapData {
			return $focusBD;
		}

		
		
		public function set guideBD(source:BitmapData):void {
			$checkSize(source);
			$guideBD = source;
		}

		
		
		public function get guideBD():BitmapData {
			return $guideBD;
		}
	}
}
