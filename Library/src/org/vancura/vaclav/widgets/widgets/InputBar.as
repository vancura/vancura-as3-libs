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

	import org.vancura.vaclav.core.display.MorphSprite;
	import org.vancura.vaclav.core.utils.DisplayUtils;
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
			DisplayUtils.removeChildren(this, _bar, _label);

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
