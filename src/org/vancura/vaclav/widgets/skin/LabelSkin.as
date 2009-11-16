package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	
	
	public class LabelSkin extends Skin implements ILabelSkin {

		
		
		protected var $font:String;
		protected var $size:Number;
		protected var $color:uint;
		protected var $alpha:Number;
		protected var $hAlign:String;
		protected var $vAlign:String;
		protected var $filters:Array;
		protected var $sharpness:Number;
		protected var $thickness:Number;
		protected var $paddingTop:Number;
		protected var $paddingBottom:Number;
		protected var $paddingLeft:Number;
		protected var $paddingRight:Number;

		private var _oldFont:String;
		private var _oldSize:Number;
		private var _oldColor:uint;
		private var _oldAlpha:Number;
		private var _oldHAlign:String;
		private var _oldVAlign:String;
		private var _oldFilters:Array;
		private var _oldSharpness:Number;
		private var _oldThickness:Number;
		private var _oldPaddingTop:Number;
		private var _oldPaddingBottom:Number;
		private var _oldPaddingLeft:Number;
		private var _oldPaddingRight:Number;

		
		
		public function LabelSkin(id:String = null) {
			super(SkinType.LABEL, id);
			
			$font = '';
			$size = 10;
			$color = 0x000000;
			$alpha = 1;
			$hAlign = Align.LEFT;
			$vAlign = Align.TOP;
			$filters = new Array();
			$sharpness = 0;
			$thickness = 0;
			$paddingTop = 0;
			$paddingBottom = 0;
			$paddingLeft = 0;
			$paddingRight = 0;
		}

		
		
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);
			
			_oldFont = $font;
			_oldSize = $size;
			_oldColor = $color;
			_oldAlpha = $alpha;
			_oldHAlign = $hAlign;
			_oldVAlign = $vAlign;
			_oldFilters = $filters;
			_oldSharpness = $sharpness;
			_oldThickness = $thickness;
			_oldPaddingTop = $paddingTop;
			_oldPaddingBottom = $paddingBottom;
			_oldPaddingLeft = $paddingLeft;
			_oldPaddingRight = $paddingRight;
			
			if(source.font != undefined) {
				$font = source.font;
			}
			
			if(source.size != undefined) {
				$size = source.size;
			}
			
			if(source.color != undefined) {
				$color = source.color;
			}
			
			if(source.alpha != undefined) {
				$alpha = source.alpha;
			}
			
			if(source.hAlign != undefined) {
				$hAlign = source.hAlign;
			}
			
			if(source.vAlign != undefined) {
				$vAlign = source.vAlign;
			}
			
			if(source.filters != undefined) {
				$filters = source.filters;
			}
			
			if(source.sharpness != undefined) {
				$sharpness = source.sharpness;
			}
			
			if(source.thickness != undefined) {
				$thickness = source.thickness;
			}
			
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

			$font = _oldFont;			
			$size = _oldSize;
			$color = _oldColor;
			$alpha = _oldAlpha;
			$hAlign = _oldHAlign;
			$vAlign = _oldVAlign;
			$filters = _oldFilters;
			$sharpness = _oldSharpness;
			$thickness = _oldThickness;
			$paddingTop = _oldPaddingTop;
			$paddingBottom = _oldPaddingBottom;
			$paddingLeft = _oldPaddingLeft;
			$paddingRight = _oldPaddingRight;
		}
		
		
		
		public function get font():String {
			return $font;
		}
		
		
		
		public function set font(value:String):void {
			$font = value;
		}

		
		
		public function get size():Number {
			return $size;
		}

		
		
		public function set size(value:Number):void {
			$size = value;
		}

		
		
		public function get color():uint {
			return $color;
		}

		
		
		public function set color(value:uint):void {
			$color = value;
		}

		
		
		public function get alpha():Number {
			return $alpha;
		}

		
		
		public function set alpha(value:Number):void {
			$alpha = value;
		}

		
		
		public function get hAlign():String {
			return $hAlign;
		}

		
		
		public function set hAlign(value:String):void {
			$hAlign = value;
		}
		
		
		
		public function get vAlign():String {
			return $vAlign;
		}

		
		
		public function set vAlign(value:String):void {
			$vAlign = value;
		}
		
		
		
		public function get filters():Array {
			return $filters;
		}

		
		
		public function set filters(value:Array):void {
			$filters = value;
		}
		
		
		
		public function get sharpness():Number {
			return $sharpness;
		}
		
		
		
		public function set sharpness(value:Number):void {
			$sharpness = value;
		}

		
		
		public function get thickness():Number {
			return $thickness;
		}
		
		
		
		public function set thickness(value:Number):void {
			$thickness = value;
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
	}
}
