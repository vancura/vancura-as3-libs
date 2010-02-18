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
 *	         - Your fair dealing or fair use rights � All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 *	         - The author's moral rights � In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 *	         - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. � Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice � For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.template {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;

	import org.vancura.vaclav.core.utils.ClassUtils;
	import org.vancura.vaclav.interfaces.IMain;



	/**
	 * Global application preloader.
	 *
	 * @author Vaclav Vancura (<a href="http://vaclav.vancura.org">vaclav.vancura.org</a>, <a href="http://twitter.com/vancura">@vancura</a>)
	 * @since 1.0
	 */
	public class GlobalPreloader extends MovieClip {


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
		public function GlobalPreloader(mainClassName:String) {
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
			_mainClass = ClassUtils.getClassByName(_mainClassName);
			if(_mainClass === null) {
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
