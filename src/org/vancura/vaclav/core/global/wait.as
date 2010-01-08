/***********************************************************************************************************************
 * Copyright (c) 2010. Vaclav Vancura.
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

package org.vancura.vaclav.core.global {
	import flash.display.Shape;
	import flash.events.Event;

	/**
	 *   Wait a given number of frames then call a callback
	 *
	 *   @param numFrames Number of frames to wait before calling the callback
	 *   @param callback Function to call once the given number of frames have passed
	 *
	 *   @author Jackson Dunstan
	 */
	public function wait(numFrames:uint, callback:Function):void {
		var obj:Shape = new Shape();
		obj.addEventListener(Event.ENTER_FRAME, function(ev:Event):void {
			numFrames--;
			if(numFrames == 0) {
				obj.removeEventListener(Event.ENTER_FRAME, arguments.callee);
				callback();
			}
		});
	}
}
