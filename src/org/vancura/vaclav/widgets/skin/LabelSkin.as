/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	public class LabelSkin extends Skin implements ILabelSkin {


		protected var _font:String;
		protected var _size:Number;
		protected var _color:uint;
		protected var _alpha:Number;
		protected var _hAlign:String;
		protected var _vAlign:String;
		protected var _filters:Array;
		protected var _sharpness:Number;
		protected var _thickness:Number;
		protected var _paddingTop:Number;
		protected var _paddingBottom:Number;
		protected var _paddingLeft:Number;
		protected var _paddingRight:Number;

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

			_font = '';
			_size = 10;
			_color = 0x000000;
			_alpha = 1;
			_hAlign = Align.LEFT;
			_vAlign = Align.TOP;
			_filters = new Array();
			_sharpness = 0;
			_thickness = 0;
			_paddingTop = 0;
			_paddingBottom = 0;
			_paddingLeft = 0;
			_paddingRight = 0;
		}



		//noinspection FunctionTooLongJS,FunctionWithMoreThanThreeNegationsJS,OverlyComplexFunctionJS
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			_oldFont = _font;
			_oldSize = _size;
			_oldColor = _color;
			_oldAlpha = _alpha;
			_oldHAlign = _hAlign;
			_oldVAlign = _vAlign;
			_oldFilters = _filters;
			_oldSharpness = _sharpness;
			_oldThickness = _thickness;
			_oldPaddingTop = _paddingTop;
			_oldPaddingBottom = _paddingBottom;
			_oldPaddingLeft = _paddingLeft;
			_oldPaddingRight = _paddingRight;

			if(source.font != undefined) _font = source.font;
			if(source.size != undefined) _size = source.size;
			if(source.color != undefined) _color = source.color;
			if(source.alpha != undefined) _alpha = source.alpha;
			if(source.hAlign != undefined) _hAlign = source.hAlign;
			if(source.vAlign != undefined) _vAlign = source.vAlign;
			if(source.filters != undefined) _filters = source.filters;
			if(source.sharpness != undefined) _sharpness = source.sharpness;
			if(source.thickness != undefined) _thickness = source.thickness;
			if(source.paddingTop != undefined) _paddingTop = source.paddingTop;
			if(source.paddingBottom != undefined) _paddingBottom = source.paddingBottom;
			if(source.paddingLeft != undefined) _paddingLeft = source.paddingLeft;
			if(source.paddingRight != undefined) _paddingRight = source.paddingRight;
		}



		override public function revertConfig():void {
			super.revertConfig();

			_font = _oldFont;
			_size = _oldSize;
			_color = _oldColor;
			_alpha = _oldAlpha;
			_hAlign = _oldHAlign;
			_vAlign = _oldVAlign;
			_filters = _oldFilters;
			_sharpness = _oldSharpness;
			_thickness = _oldThickness;
			_paddingTop = _oldPaddingTop;
			_paddingBottom = _oldPaddingBottom;
			_paddingLeft = _oldPaddingLeft;
			_paddingRight = _oldPaddingRight;
		}



		public function get font():String {
			return _font;
		}



		public function set font(value:String):void {
			_font = value;
		}



		public function get size():Number {
			return _size;
		}



		public function set size(value:Number):void {
			_size = value;
		}



		public function get color():uint {
			return _color;
		}



		public function set color(value:uint):void {
			_color = value;
		}



		public function get alpha():Number {
			return _alpha;
		}



		public function set alpha(value:Number):void {
			_alpha = value;
		}



		public function get hAlign():String {
			return _hAlign;
		}



		public function set hAlign(value:String):void {
			_hAlign = value;
		}



		public function get vAlign():String {
			return _vAlign;
		}



		public function set vAlign(value:String):void {
			_vAlign = value;
		}



		public function get filters():Array {
			return _filters;
		}



		public function set filters(value:Array):void {
			_filters = value;
		}



		public function get sharpness():Number {
			return _sharpness;
		}



		public function set sharpness(value:Number):void {
			_sharpness = value;
		}



		public function get thickness():Number {
			return _thickness;
		}



		public function set thickness(value:Number):void {
			_thickness = value;
		}



		public function get paddingTop():Number {
			return _paddingTop;
		}



		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		public function get paddingBottom():Number {
			return _paddingBottom;
		}



		public function set paddingBottom(value:Number):void {
			_paddingBottom = value;
		}



		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		public function get paddingRight():Number {
			return _paddingRight;
		}



		public function set paddingRight(value:Number):void {
			_paddingRight = value;
		}
	}
}
