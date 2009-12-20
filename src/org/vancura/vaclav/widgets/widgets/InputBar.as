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

package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.display.MorphSprite;
	import org.vancura.vaclav.core.global.removeChildren;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IBar;
	import org.vancura.vaclav.widgets.interfaces.IInputBar;
	import org.vancura.vaclav.widgets.interfaces.IInputBarSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabel;
	import org.vancura.vaclav.widgets.interfaces.IWidget;

	public class InputBar extends MorphSprite implements IWidget, IInputBar {


		protected var _skin:IInputBarSkin;
		protected var _bar:Bar;
		protected var _label:Label;

		private var _debugLevel:String;



		public function InputBar(skin:IInputBarSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                         debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			var dl:String = (debugLevel == null) ? SkinManager.debugLevel : debugLevel;

			_bar = new Bar(skin.barSkin, {}, this, dl);
			_label = new Label(skin.labelSkin, {}, '', this, dl);

			_bar.debugColor = SkinManager.debugColor;
			_label.debugColor = SkinManager.debugColor;
			_label.isInput = true;

			this.isMorphHeightEnabled = true;
			this.isMorphWidthEnabled = false;

			if(c.width == undefined) c.width = skin.assetWidth;
			if(c.height == undefined) c.height = skin.assetHeight;

			//noinspection NegatedIfStatementJS
			if(skin != null) super(c, parent);
			else throw new Error('No skin defined');

			_skin = skin;
		}



		public function destroy():void {
			removeChildren(this, _bar, _label);

			_bar.destroy();
			_label.destroy();
		}



		public function draw():void {
			_bar.draw();
			_label.draw();

			_label.height = _bar.height;
		}



		override public function get width():Number {
			return _bar.width;
		}



		override public function set width(value:Number):void {
			_bar.width = value;
			_label.width = value;

			draw();
		}



		override public function get height():Number {
			return _bar.height;
		}



		override public function set height(value:Number):void {
		}



		public function set areEventsEnabled(value:Boolean):void {
			_label.isInput = value;
			_label.alpha = (value) ? 1 : 0.5;

			draw();
		}



		public function get areEventsEnabled():Boolean {
			return _label.isInput;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			_bar.debugLevel = value;
			_label.debugLevel = value;
		}



		public function get bar():IBar {
			return _bar;
		}



		public function get label():ILabel {
			return _label;
		}



		public function get text():String {
			return _label.text;
		}



		public function set text(value:String):void {
			_label.text = value;
		}



		public function get skin():IInputBarSkin {
			return _skin;
		}



		public function set skin(skin:IInputBarSkin):void {
			_skin = skin;

			_bar.skin = _skin.barSkin;
			_label.skin = _skin.labelSkin;

			draw();
		}
	}
}
