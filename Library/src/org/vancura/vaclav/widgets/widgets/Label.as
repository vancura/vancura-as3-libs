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
 * 	        - Your fair dealing or fair use rights Ñ All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights Ñ In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. Ñ Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice Ñ For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	import org.vancura.vaclav.core.display.QTextField;
	import org.vancura.vaclav.core.utils.DisplayUtils;
	import org.vancura.vaclav.widgets.constants.Align;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.ILabel;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	public class Label extends Widget implements ILabel {


		protected var _skin:ILabelSkin;
		protected var _textField:QTextField;
		protected var _textFormat:TextFormat;

		private var _isWidthOverriden:Boolean;
		private var _isHeightOverriden:Boolean;
		private var _vAlign:String;
		private var _isInput:Boolean;



		public function Label(skin:ILabelSkin, config:Object = null, text:String = '', parent:DisplayObjectContainer = null,
		                      debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			//noinspection NegatedIfStatementJS
			if(skin != null) super(c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			else throw new Error('No skin defined');

			_isWidthOverriden = (c.width != undefined);
			_isHeightOverriden = (c.height != undefined);

			this.skin = skin;
			this.text = text;
		}



		override protected function _init():void {
			super._init();

			_textFormat = new TextFormat();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		override protected function _addChildren():void {
			super._addChildren();

			_textField = new QTextField({width:2880, autoSize:(_isWidthOverriden) ? TextFieldAutoSize.NONE : Align.LEFT, borderColor:_debugColor, border:(_debugLevel == DebugLevel.ALWAYS)}, _contentSpr);
		}



		override protected function _removeChildren():void {
			super._removeChildren();

			DisplayUtils.removeChildren(_contentSpr, _textField);
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		override public function draw():void {
			super.draw();

			if(_skin != null) {
				var l:Number = _skin.paddingLeft;
				var t:Number = _skin.paddingTop;
				var w:Number = _width - _skin.paddingLeft - _skin.paddingRight;
				var h:Number = _height - _skin.paddingTop - _skin.paddingBottom;

				if(_width != 0) _textField.width = w;

				if(_height != 0) {
					// set label height
					_textField.height = h;

					// non-top alignment
					if(_vAlign == Align.CENTER) {
						_textField.y = Math.round((h - _textField.textHeight) / 2) + _skin.paddingTop;
					}
					if(_vAlign == Align.BOTTOM) {
						_textField.y = h - _textField.textHeight + _skin.paddingTop;
					}
				}

				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(_width != 0 && _height != 0) {
						DisplayUtils.strokeBounds(_debugSpr, l, t, w, h, 5, _debugColor);
					}
				}
			}
		}



		override public function set debugLevel(value:String):void {
			super.debugLevel = value;

			_textField.border = (_debugLevel == DebugLevel.ALWAYS);
		}



		public function get skin():ILabelSkin {
			return _skin;
		}



		//noinspection FunctionTooLongJS
		public function set skin(skin:ILabelSkin):void {
			_skin = skin;

			_vAlign = _skin.vAlign;

			_textFormat = new TextFormat();
			_textFormat.align = _skin.hAlign;
			_textFormat.blockIndent = _skin.blockIndent;
			_textFormat.bold = _skin.bold;
			_textFormat.bullet = _skin.bullet;
			_textFormat.color = _skin.color;
			_textFormat.font = _skin.font;
			_textFormat.indent = _skin.indent;
			_textFormat.italic = _skin.italic;
			_textFormat.kerning = _skin.kerning;
			_textFormat.leading = _skin.leading;
			_textFormat.leftMargin = _skin.marginLeft;
			_textFormat.letterSpacing = _skin.letterSpacing;
			_textFormat.rightMargin = _skin.marginRight;
			_textFormat.size = _skin.size;
			_textFormat.underline = _skin.underline;
			_textFormat.url = _skin.url;

			_textField.setTextFormat(_textFormat);
			_textField.defaultTextFormat = _textFormat;
			_textField.setPosition(_skin.paddingLeft, _skin.paddingTop);
			_textField.filters = _skin.filters;
			_textField.sharpness = _skin.sharpness;
			_textField.thickness = _skin.thickness;
			_textField.alpha = _skin.alpha;
			_textField.embedFonts = (_skin.font != '');

			if(_width == 0) _width = _skin.assetWidth;
			if(_height == 0) _height = _skin.assetHeight;

			draw();
		}



		public function get text():String {
			return _textField.text;
		}



		public function set text(value:String):void {
			var v:String = value;

			if(_textField != null) {
				_textField.defaultTextFormat = _textFormat;

				if(v != null) {
					if(v == '') {
						// fix alignment problem when empty string was applied to the html enabled TextField
						// noinspection ReuseOfLocalVariableJS
						v = '&nbsp;';
					}

					_textField.htmlText = v;
				}
			}

			draw();
		}



		public function get textField():TextField {
			return _textField;
		}



		override public function get width():Number {
			return (_isWidthOverriden) ? _textField.width : _textField.textWidth + _skin.paddingLeft + _skin.paddingRight;
		}



		override public function get height():Number {
			return (_isHeightOverriden) ? _textField.height : _textField.textHeight + _skin.paddingTop + _skin.paddingBottom;
		}



		override public function get x():Number {
			return super.x - _skin.paddingLeft;
		}



		override public function get y():Number {
			return super.y - _skin.paddingTop;
		}



		public function get isInput():Boolean {
			return _isInput;
		}



		public function get isPassword():Boolean {
			return _textField.displayAsPassword;
		}



		public function set isPassword(value:Boolean):void {
			_textField.displayAsPassword = value;
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		public function set isInput(value:Boolean):void {
			if(_textField != null) {
				_textField.type = (value) ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
				_textField.selectable = value;
				_textField.multiline = !value;
				_textField.condenseWhite = !value;

				if(value) _textField.autoSize = TextFieldAutoSize.NONE;

				_textFormat.kerning = !value;
				_textField.setTextFormat(_textFormat);
			}

			_isInput = value;
		}



		override protected function _onDebugOver(event:MouseEvent):void {
			super._onDebugOver(event);

			if(_debugLevel == DebugLevel.HOVER) {
				_textField.border = true;
			}
		}



		override protected function _onDebugOut(event:MouseEvent):void {
			super._onDebugOut(event);

			if(_debugLevel == DebugLevel.HOVER) {
				_textField.border = false;
			}
		}
	}
}
