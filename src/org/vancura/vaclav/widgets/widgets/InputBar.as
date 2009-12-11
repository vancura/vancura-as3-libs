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

package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.MorphSprite;
	import org.vancura.vaclav.core.removeChildren;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IBar;
	import org.vancura.vaclav.widgets.interfaces.IInputBar;
	import org.vancura.vaclav.widgets.interfaces.IInputBarSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabel;
	import org.vancura.vaclav.widgets.interfaces.IWidget;

	public class InputBar extends MorphSprite implements IWidget, IInputBar {


		protected var $skin:IInputBarSkin;
		protected var $bar:Bar;
		protected var $label:Label;

		private var _debugLevel:String;



		public function InputBar(skin:IInputBarSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                         debugLevel:String = null) {

			if(config == null) {
				config = new Object();
			}

			var dl:String = (debugLevel != null) ? debugLevel : SkinManager.debugLevel;

			$bar = new Bar(skin.barSkin, {}, this, dl);
			$label = new Label(skin.labelSkin, {}, '', this, dl);

			$bar.debugColor = SkinManager.debugColor;
			$label.debugColor = SkinManager.debugColor;
			$label.isInput = true;

			this.isMorphHeightEnabled = true;
			this.isMorphWidthEnabled = false;

			if(config.width == undefined) {
				config.width = skin.assetWidth;
			}

			if(config.height == undefined) {
				config.height = skin.assetHeight;
			}

			if(skin != null) {
				super(config, parent);
			}
			else {
				throw new Error('No skin defined');
			}

			$skin = skin;
		}



		public function destroy():void {
			removeChildren(this, $bar, $label);

			$bar.destroy();
			$label.destroy();
		}



		public function draw():void {
			$bar.draw();
			$label.draw();

			$label.height = $bar.height;
		}



		override public function get width():Number {
			return $bar.width;
		}



		override public function set width(value:Number):void {
			$bar.width = value;
			$label.width = value;

			draw();
		}



		override public function get height():Number {
			return $bar.height;
		}



		override public function set height(value:Number):void {
		}



		public function set areEventsEnabled(value:Boolean):void {
			$label.isInput = value;
			$label.alpha = (value) ? 1 : .5;

			draw();
		}



		public function get areEventsEnabled():Boolean {
			return $label.isInput;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			$bar.debugLevel = value;
			$label.debugLevel = value;
		}



		public function get bar():IBar {
			return $bar;
		}



		public function get label():ILabel {
			return $label;
		}



		public function get text():String {
			return $label.text;
		}



		public function set text(value:String):void {
			$label.text = value;
		}



		public function get skin():IInputBarSkin {
			return $skin;
		}



		public function set skin(skin:IInputBarSkin):void {
			$skin = skin;

			$bar.skin = $skin.barSkin;
			$label.skin = $skin.labelSkin;

			draw();
		}
	}
}
