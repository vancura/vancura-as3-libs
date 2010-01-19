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
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	import org.vancura.vaclav.core.utils.DisplayUtils;

	/**
	 * FPS and memory meter.
	 * Based on work by Pierluigi Pesenti (http://blog.oaxoa.com)
	 * Feel free to use or redistribute but please leave this credits.
	 * @author Pierluigi Pesenti (http://blog.oaxoa.com)
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class FPS extends Sprite {


		private static const _GRAPH_WIDTH:uint = 80;
		private static const _GRAPH_HEIGHT:uint = 40;

		private var _c:uint = 0;
		private var _graphScrollSpr:Sprite;
		private var _graphMaskSpr:Sprite;
		private var _graphCounter:uint = 0;
		private var _textTF:QTextField;
		private var _timer:Timer;
		private var _backSpr:QSprite;



		/**
		 * Constructor.
		 * @param tf Label TextFormat
		 * @param bc Background color (default 0x000000)
		 * @param gc Graph color (default 0xFF0000)
		 */
		public function FPS(tf:TextFormat, bc:uint = 0x808080, gc:uint = 0xFFFFFF) {
			_backSpr = new QSprite({}, this);
			_graphMaskSpr = new QSprite({}, this);
			_graphScrollSpr = new QSprite({mask: _graphMaskSpr}, this);
			_textTF = new QTextField({y: _GRAPH_HEIGHT - 15, defaultTextFormat: tf, width: _GRAPH_WIDTH, autoSize: TextFieldAutoSize.LEFT}, this);

			// drawing
			DisplayUtils.drawRect(_graphMaskSpr, 0, 0, _GRAPH_WIDTH, _GRAPH_HEIGHT, 0xFF0000, 0.2);
			DisplayUtils.drawRoundRect(_backSpr, 0, 0, _GRAPH_WIDTH, _GRAPH_HEIGHT, 8, bc, 0.8);

			// set visual properties
			_graphScrollSpr.graphics.lineStyle(0, gc);
			this.mouseEnabled = false;

			// add timer
			_timer = new Timer(500);
			_timer.start();

			// add event listeners
			_timer.addEventListener(TimerEvent.TIMER, _onTimer, false, 0, true);
			this.addEventListener(Event.ENTER_FRAME, _onFrame, false, 0, true);
		}



		/**
		 * Destructor.
		 */
		public function destroy():void {
			// remove from display list
			DisplayUtils.removeChildren(this, _backSpr, _graphScrollSpr, _graphMaskSpr, _textTF);

			// stop timer
			_timer.stop();

			// remove event listeners
			_timer.removeEventListener(TimerEvent.TIMER, _onTimer);
			this.removeEventListener(Event.ENTER_FRAME, _onFrame);
		}



		/**
		 * Compute and return current time.
		 * @return Current time
		 */
		public function computeTime():Number {
			var retValue:uint = _c;
			_c = 0;
			return retValue * 2 - 1;
		}



		/**
		 * Force update graph.
		 * @param n Current time
		 */
		public function updateGraph(n:Number):void {
			if(_graphCounter > _GRAPH_WIDTH) {
				_graphScrollSpr.x--;
			}
			_graphCounter++;
			_graphScrollSpr.graphics.lineTo(_graphCounter, 1 + (stage.frameRate - n) / 3);
		}



		// Private methods
		// ---------------


		private function _onTimer(event:TimerEvent):void {
			var val:Number = computeTime();
			_textTF.text = val + ' FPS / ' + (System.totalMemory / 1048576) + ' MB';
			updateGraph(val);
		}



		private function _onFrame(event:Event):void {
			_c++;
		}
	}
}
