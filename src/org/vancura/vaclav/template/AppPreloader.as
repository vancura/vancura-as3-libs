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

package org.vancura.vaclav.template {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;

	import org.vancura.vaclav.core.global.getClassByName;
	import org.vancura.vaclav.interfaces.IMain;

	public class AppPreloader extends MovieClip {

		protected var _isLoading:Boolean = true;
		protected var _mainClass:Class;
		protected var _app:IMain;
		protected var _mainClassName:String;
		protected var _progress:Number = 0;



		/**
		 * Constructor.
		 *
		 * @param mainClassName Main Class name (like 'org.vancura.myapp.Main')
		 */
		public function AppPreloader(mainClassName:String) {
			_mainClassName = mainClassName;

			// stop main timeline
			stop();

			// init stage
			stage.showDefaultContextMenu = false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			// add event listeners
			this.addEventListener(Event.ENTER_FRAME, _onEnterFrame, false, 0, true);
			stage.addEventListener(Event.RESIZE, _onStageResize, false, 0, true);
			root.loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _onLoadingError, false, 0, true);
		}



		/**
		 * Destructor.
		 */
		public function destroy():void {
			// remove event listeners
			this.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
			stage.removeEventListener(Event.RESIZE, _onStageResize);
			root.loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _onLoadingError);

			// jump to next frame
			// first is occupied by the preloader
			nextFrame();

			// find and call main class
			_mainClass = getClassByName(_mainClassName);
			if(_mainClass == null) {
				// main class not found
				alert('GlobalPreloader: Main class (' + _mainClassName + ') not found.\nThis is critical.');
			}
			else {
				// main class found
				// add it to the display list
				_app = new _mainClass();
				addChild(_app as DisplayObject);

				// send flashvars to main class
				_app.flashVars = root.loaderInfo.parameters;

				// run application
				_app.start();

				// the app is running now
			}
		}



		/**
		 * Show an alert window if JS enabled. If not, just trace() the message.
		 *
		 * @param message Message to be displayed
		 */
		public function alert(message:String):void {
			//noinspection UnusedCatchParameterJS
			try {
				// try to display JS alert()
				ExternalInterface.call('alert', message);
			}
			catch(err:Error) {
				// no ExternalInterface available (e.g. app is displayed in standalone Flash Player)
				trace(message);
			}
		}



		/**
		 * Load error. Happens when the user navigates somewhere else while Flash is not fully loaded yet.
		 */
		protected function _onLoadingError(event:IOErrorEvent):void {
			// don't do anything here
			// app has to silently fail
		}



		/**
		 * Stage resize. Just a placeholder to be overridden by implementations.
		 */
		protected function _onStageResize(event:Event = null):void {
		}



		/**
		 * EnterFrame handler. Update your progress bar here.
		 */
		protected function _onEnterFrame(event:Event):void {
			_progress = 1 / (root.loaderInfo.bytesTotal / root.loaderInfo.bytesLoaded);

			if(_progress >= 1) {
				_isLoading = false;
				destroy();
			}
		}
	}
}
