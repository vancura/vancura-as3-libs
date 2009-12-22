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


	public interface ILabelSkin extends ISkinnable, IConfigSkin {

		function get hAlign():String;
		function set hAlign(value:String):void;

		function get vAlign():String;
		function set vAlign(value:String):void;

		function get bold():Boolean;
		function set bold(value:Boolean):void;

		function get blockIndent():Number;
		function set blockIndent(value:Number):void;

		function get bullet():Boolean;
		function set bullet(value:Boolean):void;

		function get color():uint;
		function set color(value:uint):void;

		function get font():String;
		function set font(value:String):void;

		function get indent():Number;
		function set indent(value:Number):void;

		function get italic():Boolean;
		function set italic(value:Boolean):void;

		function get kerning():Boolean;
		function set kerning(value:Boolean):void;

		function get leading():Number;
		function set leading(value:Number):void;

		function get letterSpacing():Number;
		function set letterSpacing(value:Number):void;

		function get size():Number;
		function set size(value:Number):void;

		function get underline():Boolean;
		function set underline(value:Boolean):void;

		function get url():String;
		function set url(value:String):void;

		function get alpha():Number;
		function set alpha(value:Number):void;

		function get filters():Array;
		function set filters(value:Array):void;

		function get sharpness():Number;
		function set sharpness(value:Number):void;

		function get thickness():Number;
		function set thickness(value:Number):void;

		function get paddingTop():Number;
		function set paddingTop(value:Number):void;

		function get paddingBottom():Number;
		function set paddingBottom(value:Number):void;

		function get paddingLeft():Number;
		function set paddingLeft(value:Number):void;

		function get paddingRight():Number;
		function set paddingRight(value:Number):void;

		function get marginLeft():Number;
		function set marginLeft(value:Number):void;

		function get marginRight():Number;
		function set marginRight(value:Number):void;

	}
}
