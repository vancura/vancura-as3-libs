package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.core.Bitmapping;
	import org.vancura.vaclav.widgets.skin.interfaces.IButtonSkin;

	import flash.display.BitmapData;
	import flash.display.MovieClip;

	
	
	public class ButtonSkin extends Skin implements IButtonSkin {

		
		
		protected var $hoveredInDuration:Number;
		protected var $hoveredOutDuration:Number;
		protected var $pressedInDuration:Number;
		protected var $pressedOutDuration:Number;
		protected var $guideBD:BitmapData;
		protected var $backBD:BitmapData;
		protected var $hoveredBD:BitmapData;
		protected var $pressedBD:BitmapData;

		private var _oldHoveredInDuration:Number;
		private var _oldHoveredOutDuration:Number;
		private var _oldPressedInDuration:Number;
		private var _oldPressedOutDuration:Number;

		
		
		public function ButtonSkin(id:String) {
			super(id, Skin.TYPE_BUTTON);
			
			$hoveredInDuration = 0;
			$hoveredOutDuration = .15;
			$pressedInDuration = 0;
			$pressedOutDuration = .1;
			$guideBD = new BitmapData(1, 1, true, 0x00000000);
			$backBD = new BitmapData(1, 1, true, 0x00000000);
			$hoveredBD = new BitmapData(1, 1, true, 0x00000000);
			$pressedBD = new BitmapData(1, 1, true, 0x00000000);
		}

		
		
		public function getAssetsFromComposition(source:BitmapData):void {
			if(source.width % 4 != 0) throw new Error('Width has to be multiple of 4');
			
			$assetWidth = source.width / 4;
			$assetHeight = source.height;
			
			$guideBD = Bitmapping.crop(source, 0, 0, $assetWidth, $assetHeight);
			$backBD = Bitmapping.crop(source, $assetWidth * 1, 0, $assetWidth, $assetHeight);
			$hoveredBD = Bitmapping.crop(source, $assetWidth * 2, 0, $assetWidth, $assetHeight);
			$pressedBD = Bitmapping.crop(source, $assetWidth * 3, 0, $assetWidth, $assetHeight);
		}

		
		
		public function getAssetsFromMovieClip(source:MovieClip, elements:Array = null, ... labels:Array):void {
			$getSkinSize(source, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);
			
			$backBD = $getSkinFrame(source, elements, (labels[0] == undefined || labels[0] == '') ? 'back' : labels[0]);
			$hoveredBD = $getSkinFrame(source, elements, (labels[1] == undefined || labels[1] == '') ? 'hovered' : labels[1]);
			$pressedBD = $getSkinFrame(source, elements, (labels[2] == undefined || labels[2] == '') ? 'pressed' : labels[2]);
			$guideBD = $getSkinFrame(source, elements, (labels[3] == undefined || labels[3] == '') ? 'guide' : labels[3]);
		}

		
		
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
			
			_oldHoveredInDuration = $hoveredInDuration;
			_oldHoveredOutDuration = $hoveredOutDuration;
			_oldPressedInDuration = $pressedInDuration;
			_oldPressedOutDuration = $pressedOutDuration;
			
			if(source.hoveredInDuration != undefined) $hoveredInDuration = source.hoveredInDuration;
			if(source.hoveredOutDuration != undefined) $hoveredOutDuration = source.hoveredOutDuration;
			if(source.pressedInDuration != undefined) $pressedInDuration = source.pressedInDuration;
			if(source.pressedOutDuration != undefined) $pressedOutDuration = source.pressedOutDuration;
		}
		
		
		
		override public function revertConfig():void {
			super.revertConfig();
			
			$hoveredInDuration = _oldHoveredInDuration;
			$hoveredOutDuration = _oldHoveredOutDuration;
			$pressedInDuration = _oldPressedInDuration;
			$pressedOutDuration = _oldPressedOutDuration;
		}

		
		
		public function set hoveredInDuration(value:Number):void {
			$hoveredInDuration = value;
		}

		
		
		public function get hoveredInDuration():Number {
			return $hoveredInDuration;
		}

		
		
		public function set hoveredOutDuration(value:Number):void {
			$hoveredOutDuration = value;
		}

		
		
		public function get hoveredOutDuration():Number {
			return $hoveredOutDuration;
		}

		
		
		public function set pressedInDuration(value:Number):void {
			$pressedInDuration = value;
		}

		
		
		public function get pressedInDuration():Number {
			return $pressedInDuration;
		}

		
		
		public function set pressedOutDuration(value:Number):void {
			$pressedOutDuration = value;
		}

		
		
		public function get pressedOutDuration():Number {
			return $pressedOutDuration;
		}

		
		
		public function set backBD(source:BitmapData):void {
			$checkSize(source);
			$backBD = source;
		}

		
		
		public function get backBD():BitmapData {
			return $backBD;
		}

		
		
		public function set hoveredBD(source:BitmapData):void {
			$checkSize(source);
			$hoveredBD = source;
		}

		
		
		public function get hoveredBD():BitmapData {
			return $hoveredBD;
		}

		
		
		public function set pressedBD(source:BitmapData):void {
			$checkSize(source);
			$pressedBD = source;
		}

		
		
		public function get pressedBD():BitmapData {
			return $pressedBD;
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
