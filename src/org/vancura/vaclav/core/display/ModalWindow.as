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

package org.vancura.vaclav.core.display {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;

	import org.vancura.vaclav.core.utils.DisplayUtils;

	/**
	 * Modal Window allows to show critical information if nothing is embedded and everything is broken.
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
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
		 * Constructor.
		 */
		public function ModalWindow() {
			super();

			// add components
			_fillSPR = new QSprite({}, this);
			_descText = new QTextField({embedFonts:false, x:_TEXT_HORIZ_PADDING, y:_TEXT_VERT_PADDING, height:400, defaultTextFormat:new TextFormat(_FONT, _DESCRIPTION_FONT_SIZE, _DESCRIPTION_COLOR)}, this);

			// drawing
			DisplayUtils.drawRect(_fillSPR, 0, 0, 2880, 100, _BACKGROUND_COLOR, _BACKGROUND_ALPHA);

			// set visual properties
			this.visible = false;

			// add event listeners
			addEventListener(MouseEvent.CLICK, _onClick, false, 0, true);
		}



		/**
		 * Destructor.
		 */
		public function destroy():void {
			// remove event listeners
			removeEventListener(MouseEvent.CLICK, _onClick);

			// remove from display list
			DisplayUtils.removeChildren(this, _fillSPR, _descText);
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
