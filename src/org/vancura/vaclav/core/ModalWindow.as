/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the “Software”), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package org.vancura.vaclav.core {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;

	/*
	 *	Class: ModalWindow
	 *
	 *	Modal Window allows to show critical information if nothing is embedded
	 *	and everything is screwed up.
	 *
	 *	Author: Vaclav Vancura <http://vaclav.vancura.org>
	 */
	public class ModalWindow extends Sprite {


		private static const _FONT:String = '_sans';
		private static const _BACKGROUND_COLOR:uint = 0xFFAAAA;
		private static const _BACKGROUND_ALPHA:Number = 0.9;
		private static const _TEXT_HORIZ_PADDING:uint = 10;
		private static const _TEXT_VERT_PADDING:uint = 5;
		private static const _DESCRIPTION_COLOR:uint = 0x660000;
		private static const _DESCRIPTION_FONT_SIZE:uint = 9;

		private var _fillSPR:Sprite;
		private var _descText:QTextField;
		private var _isVisible:Boolean;



		/**
		 * Modal Window constructor.
		 */
		public function ModalWindow() {
			super();

			// add components
			_fillSPR = new QSprite({}, this);
			_descText = new QTextField({embedFonts:false, x:_TEXT_HORIZ_PADDING, y:_TEXT_VERT_PADDING, height:400, defaultTextFormat:new TextFormat(_FONT, _DESCRIPTION_FONT_SIZE, _DESCRIPTION_COLOR)}, this);

			// drawing
			GraphicsUtil.drawRect(_fillSPR, 0, 0, 2880, 100, _BACKGROUND_COLOR, _BACKGROUND_ALPHA);

			// set visual properties
			this.visible = false;

			// add event listeners
			addEventListener(MouseEvent.CLICK, _onClick, false, 0, true);
		}



		/**
		 * Modal Window desctructor.
		 */
		public function destroy():void {
			// remove event listeners
			removeEventListener(MouseEvent.CLICK, _onClick);

			// remove from display list
			removeChildren(this, _fillSPR, _descText);
		}



		/**
		 * Show the Modal Window.
		 * @param description Text to be displayed ("No description given" used if not defined)
		 */
		public function show(description:String = 'No description given'):void {
			_descText.text = description;
			_fillSPR.height = _descText.textHeight + _TEXT_VERT_PADDING * 3;
			_isVisible = true;
			this.visible = true;
		}



		/**
		 * Hide the Modal Window.
		 */
		public function hide():void {
			_isVisible = false;
			this.visible = false;
		}



		// Getters & setters
		// -----------------


		/**
		 * Set Modal Window width.
		 * @param value Modal Window width
		 */
		public override function set width(value:Number):void {
			_descText.width = value - _TEXT_HORIZ_PADDING * 2;
		}



		/**
		 * Set Modal Window height. Unused here, so it doesn't do anything at all :]
		 * @param value Modal Window height
		 */
		public override function set height(value:Number):void {
		}



		// Event listeners
		// ---------------


		private function _onClick(event:MouseEvent):void {
			hide();
		}
	}
}
