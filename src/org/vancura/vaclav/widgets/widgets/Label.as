/***********************************************************************************************************************
 * Copyright (c) 2010. Vaclav Vancura.
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

package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	import org.vancura.vaclav.core.display.GraphicsUtil;
	import org.vancura.vaclav.core.display.QTextField;
	import org.vancura.vaclav.core.global.removeChildren;
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

			removeChildren(_contentSpr, _textField);
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
						GraphicsUtil.strokeBounds(_debugSpr, l, t, w, h, 5, _debugColor);
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
