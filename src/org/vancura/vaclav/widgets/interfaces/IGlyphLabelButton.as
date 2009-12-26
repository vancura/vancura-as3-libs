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

package org.vancura.vaclav.widgets.interfaces {


	public interface IGlyphLabelButton extends IWidget {

		function forceRelease():void;

		function autoWidth(padding:Number, max:Number = 500):void

		function get skin():IGlyphLabelButtonSkin;
		function set skin(skin:IGlyphLabelButtonSkin):void;

		function set areEventsEnabled(value:Boolean):void;
		function get areEventsEnabled():Boolean;

		function get mouseStatus():String;
		function set mouseStatus(value:String):void;

		function get text():String;
		function set text(value:String):void;

		function get glyph():IImage;
		function get glyphOut():IImage;
		function get glyphHover():IImage;
		function get glyphFocus():IImage;

		function get label():ILabel;
		function get labelOut():ILabel;
		function get labelHover():ILabel;
		function get labelFocus():ILabel;

		function get button():IButton;

	}
}
