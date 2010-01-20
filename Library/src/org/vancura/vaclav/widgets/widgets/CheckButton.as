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
 * * Attribution � You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver � Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights � In no way are any of the following rights affected by the license:
 * 	        - Your fair dealing or fair use rights � All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights � In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. � Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice � For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.widgets.widgets {
	import flash.display.DisplayObjectContainer;

	import org.vancura.vaclav.core.display.MorphSprite;
	import org.vancura.vaclav.core.utils.DisplayUtils;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.interfaces.IButton;
	import org.vancura.vaclav.widgets.interfaces.ICheckButton;
	import org.vancura.vaclav.widgets.interfaces.ICheckButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.IWidget;

	public class CheckButton extends MorphSprite implements IWidget, ICheckButton {


		protected var _skin:ICheckButtonSkin;
		protected var _buttonOff:StaticButton;
		protected var _buttonOn:StaticButton;

		private var _debugLevel:String;
		private var _isChecked:Boolean;



		public function CheckButton(skin:ICheckButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			var dl:String = (debugLevel == null) ? SkinManager.debugLevel : debugLevel;

			_buttonOff = new StaticButton(skin.buttonOffSkin, {}, this, dl);
			_buttonOn = new StaticButton(skin.buttonOnSkin, {visible:false}, this, dl);

			_buttonOff.debugColor = SkinManager.debugColor;
			_buttonOn.debugColor = SkinManager.debugColor;

			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;
			this.isMorphHeightEnabled = false;
			this.isMorphWidthEnabled = false;

			_buttonOff.addEventListener(ButtonEvent.RELEASE_INSIDE, _onToggle, false, 0, true);
			_buttonOn.addEventListener(ButtonEvent.RELEASE_INSIDE, _onToggle, false, 0, true);

			if(c.width == undefined) c.width = skin.buttonOffSkin.assetWidth;
			if(c.height == undefined) c.height = skin.buttonOffSkin.assetHeight;

			//noinspection NegatedIfStatementJS
			if(skin != null) super(c, parent);
			else throw new Error('No skin defined');

			_skin = skin;
		}



		public function destroy():void {
			_buttonOff.removeEventListener(ButtonEvent.RELEASE_INSIDE, _onToggle);

			DisplayUtils.removeChildren(this, _buttonOff, _buttonOn);

			_buttonOff.destroy();
			_buttonOn.destroy();
		}



		public function draw():void {
			_buttonOff.draw();
			_buttonOn.draw();

			_buttonOff.visible = !_isChecked;
			_buttonOn.visible = _isChecked;
		}



		public function forceRelease():void {
			_buttonOff.forceRelease();
			_buttonOn.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		override public function get tabEnabled():Boolean {
			return button.tabEnabled;
		}



		override public function set tabEnabled(enabled:Boolean):void {
			button.tabEnabled = enabled;
		}



		override public function get tabIndex():int {
			return button.tabIndex;
		}



		override public function set tabIndex(index:int):void {
			button.tabIndex = index;
		}



		override public function get width():Number {
			return _buttonOff.width;
		}



		override public function set width(value:Number):void {
		}



		override public function get height():Number {
			return _buttonOff.height;
		}



		override public function set height(value:Number):void {
		}



		public function set areEventsEnabled(value:Boolean):void {
			_buttonOff.areEventsEnabled = value;
			_buttonOn.areEventsEnabled = value;

			this.buttonMode = value;
			this.useHandCursor = value;

			draw();
		}



		public function get areEventsEnabled():Boolean {
			return _buttonOff.areEventsEnabled;
		}



		public function get mouseStatus():String {
			return button.mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			button.mouseStatus = value;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			_buttonOff.debugLevel = value;
			_buttonOn.debugLevel = value;
		}



		public function get isChecked():Boolean {
			return _isChecked;
		}



		public function set isChecked(value:Boolean):void {
			_isChecked = value;
			draw();
		}



		public function get skin():ICheckButtonSkin {
			return _skin;
		}



		public function set skin(skin:ICheckButtonSkin):void {
			_skin = skin;

			_buttonOff.skin = skin.buttonOffSkin;
			_buttonOn.skin = skin.buttonOnSkin;

			draw();
		}



		public function get button():IButton {
			return (_isChecked) ? _buttonOn : _buttonOff;
		}



		public function get buttonOff():IButton {
			return _buttonOff;
		}



		public function get buttonOn():IButton {
			return _buttonOn;
		}



		private function _onToggle(event:ButtonEvent):void {
			isChecked = !isChecked;
		}
	}
}
