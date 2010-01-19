/***********************************************************************************************************************
 * Some methods Copyrighted by their authors, specified in ASDocs.
 * If not specified elsewhere: Copyright (c) 2010 Vaclav Vancura.
 *
 * Contact me at vaclav@vancura.org, @vancura or at my homepage at http://vaclav.vancura.org.
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Licensed under Attribution 3.0 Czech Republic (http://creativecommons.org/licenses/by/3.0/cz/deed.en_GB).
 *
 * That means you are free:
 * * to copy, distribute, display, and perform the work
 * * to make derivative works
 *
 * Under the following conditions::
 * * Attribution Ñ You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver Ñ Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights Ñ In no way are any of the following rights affected by the license:
 *	         - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 *	         - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 *	         - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.skin {
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;

	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	public class LabelSkin extends Skin implements ILabelSkin {


		protected var _hAlign:String;
		protected var _vAlign:String;
		protected var _bold:Boolean;
		protected var _blockIndent:Number;
		protected var _bullet:Boolean;
		protected var _color:uint;
		protected var _font:String;
		protected var _indent:Number;
		protected var _italic:Boolean;
		protected var _kerning:Boolean;
		protected var _leading:Number;
		protected var _letterSpacing:Number;
		protected var _size:Number;
		protected var _underline:Boolean;
		protected var _url:String;
		protected var _alpha:Number;
		protected var _filters:Array;
		protected var _sharpness:Number;
		protected var _thickness:Number;
		protected var _paddingTop:Number;
		protected var _paddingBottom:Number;
		protected var _paddingLeft:Number;
		protected var _paddingRight:Number;
		protected var _marginLeft:Number;
		protected var _marginRight:Number;

		private var _oldHAlign:String;
		private var _oldVAlign:String;
		private var _oldBold:Boolean;
		private var _oldBlockIndent:Number;
		private var _oldBullet:Boolean;
		private var _oldColor:uint;
		private var _oldFont:String;
		private var _oldIndent:Number;
		private var _oldItalic:Boolean;
		private var _oldKerning:Boolean;
		private var _oldLeading:Number;
		private var _oldLetterSpacing:Number;
		private var _oldSize:Number;
		private var _oldUnderline:Boolean;
		private var _oldURL:String;
		private var _oldAlpha:Number;
		private var _oldFilters:Array;
		private var _oldSharpness:Number;
		private var _oldThickness:Number;
		private var _oldPaddingTop:Number;
		private var _oldPaddingBottom:Number;
		private var _oldPaddingLeft:Number;
		private var _oldPaddingRight:Number;
		private var _oldMarginLeft:Number;
		private var _oldMarginRight:Number;



		public function LabelSkin(id:String = null) {
			super(SkinType.LABEL, id);

			_hAlign = Align.LEFT;
			_vAlign = Align.TOP;
			_bold = false;
			_blockIndent = 0;
			_bullet = false;
			_color = 0x000000;
			_font = null;
			_indent = 0;
			_italic = false;
			_kerning = false;
			_leading = 0;
			_letterSpacing = 0;
			_size = 10;
			_underline = false;
			_url = null;
			_alpha = 1;
			_filters = new Array();
			_sharpness = 0;
			_thickness = 0;
			_paddingTop = 0;
			_paddingBottom = 0;
			_paddingLeft = 0;
			_paddingRight = 0;
			_marginLeft = 0;
			_marginRight = 0;
		}



		//noinspection FunctionTooLongJS,FunctionWithMoreThanThreeNegationsJS,OverlyComplexFunctionJS
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			// TODO: Figure out how to speed up this mess:
			_oldHAlign = _hAlign;
			_oldVAlign = _vAlign;
			_oldBold = _bold;
			_oldBlockIndent = _blockIndent;
			_oldBullet = _bullet;
			_oldColor = _color;
			_oldFont = _font;
			_oldIndent = _indent;
			_oldItalic = _italic;
			_oldKerning = _kerning;
			_oldLeading = _leading;
			_oldLetterSpacing = _letterSpacing;
			_oldSize = _size;
			_oldUnderline = _underline;
			_oldURL = _url;
			_oldAlpha = _alpha;
			_oldFilters = _filters;
			_oldSharpness = _sharpness;
			_oldThickness = _thickness;
			_oldPaddingTop = _paddingTop;
			_oldPaddingBottom = _paddingBottom;
			_oldPaddingLeft = _paddingLeft;
			_oldPaddingRight = _paddingRight;
			_oldMarginLeft = _marginLeft;
			_oldMarginRight = _marginRight;

			// TODO: This is the way how to speed up skins, apply it everywhere
			for(var i:String in source) if(i != 'filters') this['_' + i] = source[i];

			// TODO: Add this functionality to all skins where it's needed
			if(source.filters != undefined && source.filters is Array) {
				for each(var f:* in source.filters) {
					if(f is BitmapFilter) {
						// bitmapFilter means we got filter already converted
						_filters.push(f);
					} else if(f is Object) {
						// it's an Object, we need to convert it first
						try {
							switch(f.filter) {
								case 'dropShadow' :
									var dsDistance:Number = (f.distance == undefined) ? 1 : f.distance;
									var dsAngle:Number = (f.angle == undefined) ? 45 : f.angle;
									var dsColor:Number = (f.color == undefined) ? 0x000000 : f.color;
									var dsAlpha:Number = (f.alpha == undefined) ? 0.5 : f.alpha;
									var dsBlur:Number = (f.blur == undefined) ? 1 : f.blur;
									var dsStrength:Number = (f.strength == undefined) ? 1 : f.strength;
									var dsQuality:Number = (f.quality == undefined) ? 1 : f.quality;
									var dsInner:Boolean = (f.inner == undefined) ? false : f.inner;
									var dsKnockout:Boolean = (f.knockout == undefined) ? false : f.knockout;
									var dsHideObject:Boolean = (f.hideObject == undefined) ? false : f.hideObject;
									var g:DropShadowFilter = new DropShadowFilter(dsDistance, dsAngle, dsColor, dsAlpha, dsBlur, dsBlur, dsStrength, dsQuality, dsInner, dsKnockout, dsHideObject);
									_filters.push(g);
									break;

								default:
							}
						}
						catch(err:Error) {
							throw new Error('Error converting filters Object to native filters (' + err.message + ')');
						}
					}
				}
			}
		}



		override public function revertConfig():void {
			super.revertConfig();

			_hAlign = _oldHAlign;
			_vAlign = _oldVAlign;
			_bold = _oldBold;
			_blockIndent = _oldBlockIndent;
			_bullet = _oldBullet;
			_color = _oldColor;
			_font = _oldFont;
			_indent = _oldIndent;
			_italic = _oldItalic;
			_kerning = _oldKerning;
			_leading = _oldLeading;
			_letterSpacing = _oldLetterSpacing;
			_size = _oldSize;
			_underline = _oldUnderline;
			_url = _oldURL;
			_alpha = _oldAlpha;
			_filters = _oldFilters;
			_sharpness = _oldSharpness;
			_thickness = _oldThickness;
			_paddingTop = _oldPaddingTop;
			_paddingBottom = _oldPaddingBottom;
			_paddingLeft = _oldPaddingLeft;
			_paddingRight = _oldPaddingRight;
			_marginLeft = _oldMarginLeft;
			_marginRight = _oldMarginRight;
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



		public function get bold():Boolean {
			return _bold;
		}



		public function set bold(value:Boolean):void {
			_bold = value;
		}



		public function get blockIndent():Number {
			return _blockIndent;
		}



		public function set blockIndent(value:Number):void {
			_blockIndent = value;
		}



		public function get bullet():Boolean {
			return _bullet;
		}



		public function set bullet(value:Boolean):void {
			_bullet = value;
		}



		public function get color():uint {
			return _color;
		}



		public function set color(value:uint):void {
			_color = value;
		}



		public function get font():String {
			return _font;
		}



		public function set font(value:String):void {
			_font = value;
		}



		public function get indent():Number {
			return _indent;
		}



		public function set indent(value:Number):void {
			_indent = value;
		}



		public function get italic():Boolean {
			return _italic;
		}



		public function set italic(value:Boolean):void {
			_italic = value;
		}



		public function get kerning():Boolean {
			return _kerning;
		}



		public function set kerning(value:Boolean):void {
			_kerning = value;
		}



		public function get leading():Number {
			return _leading;
		}



		public function set leading(value:Number):void {
			_leading = value;
		}



		public function get letterSpacing():Number {
			return _letterSpacing;
		}



		public function set letterSpacing(value:Number):void {
			_letterSpacing = value;
		}



		public function get size():Number {
			return _size;
		}



		public function set size(value:Number):void {
			_size = value;
		}



		public function get underline():Boolean {
			return _underline;
		}



		public function set underline(value:Boolean):void {
			_underline = value;
		}



		public function get url():String {
			return _url;
		}



		public function set url(value:String):void {
			_url = value;
		}



		public function get alpha():Number {
			return _alpha;
		}



		public function set alpha(value:Number):void {
			_alpha = value;
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



		public function get marginLeft():Number {
			return _marginLeft;
		}



		public function set marginLeft(value:Number):void {
			_marginLeft = value;
		}



		public function get marginRight():Number {
			return _marginRight;
		}



		public function set marginRight(value:Number):void {
			_marginRight = value;
		}
	}
}
