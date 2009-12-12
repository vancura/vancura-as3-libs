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

package org.vancura.vaclav.core {
	import br.com.stimuli.string.printf;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	/*
	 * Class: FPS
	 *
	 * FPS and memory meter.
	 * Based on work by Pierluigi Pesenti http://blog.oaxoa.com.
	 * Feel free to use or redistribute but please leave this credits.
	 *
	 * - Author: Pierluigi Pesenti <http://blog.oaxoa.com>
	 * - Author: Vaclav Vancura <http://vaclav.vancura.org>
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


		/*
		 * Constructor: FPS
		 *
		 * FPS constructor.
		 *
		 * Parameters:
		 *
		 * 		tf		- Label TextFormat
		 * 		bc		- Background color (default 0x000000)
		 * 		gc		- Graph color (default 0xFF0000)
		 */
		public function FPS(tf:TextFormat, bc:uint = 0x808080, gc:uint = 0xFFFFFF) {
			_backSpr = new QSprite({}, this);
			_graphMaskSpr = new QSprite({}, this);
			_graphScrollSpr = new QSprite({mask: _graphMaskSpr}, this);
			_textTF = new QTextField({y: _GRAPH_HEIGHT - 15, defaultTextFormat: tf, width: _GRAPH_WIDTH, autoSize: TextFieldAutoSize.LEFT}, this);

			// drawing
			GraphicsUtil.drawRect(_graphMaskSpr, 0, 0, _GRAPH_WIDTH, _GRAPH_HEIGHT, 0xFF0000, 0.2);
			GraphicsUtil.drawRoundRect(_backSpr, 0, 0, _GRAPH_WIDTH, _GRAPH_HEIGHT, 8, bc, 0.8);

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



		/*
		 * Destructor: destroy
		 *
		 * Destructor.
		 */
		public function destroy():void {
			// remove from display list
			removeChildren(this, _backSpr, _graphScrollSpr, _graphMaskSpr, _textTF);

			// stop timer
			_timer.stop();

			// remove event listeners
			_timer.removeEventListener(TimerEvent.TIMER, _onTimer);
			this.removeEventListener(Event.ENTER_FRAME, _onFrame);
		}



		/*
		 * Method: computeTime
		 *
		 * Compute and return current time.
		 *
		 * Returns:
		 *
		 * 		Current time
		 */
		public function computeTime():Number {
			var retValue:uint = _c;
			_c = 0;
			return retValue * 2 - 1;
		}



		/*
		 * Method: updateGraph
		 *
		 * Force update graph.
		 *
		 * Parameters:
		 *
		 * 		n	- Current time
		 */
		public function updateGraph(n:Number):void {
			if(_graphCounter > _GRAPH_WIDTH) {
				_graphScrollSpr.x--;
			}
			_graphCounter++;
			_graphScrollSpr.graphics.lineTo(_graphCounter, 1 + (stage.frameRate - n) / 3);
		}



		private function _onTimer(event:TimerEvent):void {
			var val:Number = computeTime();
			_textTF.text = printf('%u FPS / %u MB', val, System.totalMemory / 1048576);
			updateGraph(val);
		}



		private function _onFrame(event:Event):void {
			_c++;
		}
	}
}
