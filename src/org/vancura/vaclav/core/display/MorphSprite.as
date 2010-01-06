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

package org.vancura.vaclav.core.display {
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;

	import flash.display.DisplayObjectContainer;

	/**
	 * Morphable sprite. You can animate position and size of any extending class.
	 *
	 * History:
	 * 2009-11-12	- Switched back to TweenLite, TweenNano has no roundProps, sorry (v.vancura)
	 * 2009-11-04	- Switched to TweenNano (v.vancura)
	 * 2008-11-03	- Morph easing fixes (v.vancura)
	 * 2008-10-16	- Added morphReset() (v.vancura)
	 * 2008-10-13	- Switched to TweenFilterLite because it's now able to round params (v.vancura)
	 * 2008-10-08	- Switched from tweener to GTween (v.vancura)
	 * 2008-07-01	- Initial version (v.vancura)
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class MorphSprite extends QSprite {



		/** Default morphing duration in seconds */
		public static var defMorphDuration:Number = 0.75;

		/** Default morphing transition function */
		public static var defMorphEase:Function = Elastic.easeOut;

		/** Default width change flag */
		public static var defIsChangeWidthEnabled:Boolean = true;

		/** Default height change flag */
		public static var defIsChangeHeightEnabled:Boolean = true;

		/** Default X morphing flag */
		public static var defIsMorphXEnabled:Boolean = true;

		/** Default Y morphing flag */
		public static var defIsMorphYEnabled:Boolean = true;

		/** Default width morphing flag */
		public static var defIsMorphWidthEnabled:Boolean = true;

		/** Default height morphing flag */
		public static var defIsMorphHeightEnabled:Boolean = true;

		/** Current morphing duration in seconds */
		public var morphDuration:Number;

		/** Current morphing transition function */
		public var morphEase:Function;

		/** Current width change flag */
		public var isChangeWidthEnabled:Boolean;

		/** Current height change flag */
		public var isChangeHeightEnabled:Boolean;

		/** Current X morphing flag */
		public var isMorphXEnabled:Boolean;

		/** Current Y morphing flag */
		public var isMorphYEnabled:Boolean;

		/** Current width morphing flag */
		public var isMorphWidthEnabled:Boolean;

		/** Current height morphing flag */
		public var isMorphHeightEnabled:Boolean;


		private var _oldCacheAsBitmap:Boolean;
		private var _initialProperties:Object;



		/**
		 * Constructor.
		 *
		 * Possible config contents:
		 *      morphDuration - Morphing duration in seconds. If not defined, defMorphDuration used instead.
		 *      morphEase - Morphing transition function. If not defined, defMorphEase used instead.
		 *      isChangeWidthEnabled - Width change flag. If not defined, defIsChangeWidthEnabled used instead.
		 *      isChangeHeightEnabled - Height change flag. If not defined, defIsChangeHeightEnabled used instead.
		 *      isMorphXEnabled - X morphing flag. If not defined, defIsMorphXEnabled used instead.
		 *      isMorphYEnabled - Y morphing flag. If not defined, defIsMorphYEnabled used instead.
		 *      isMorphWidthEnabled - Width morphing flag. If not defined, defIsMorphWidthEnabled used instead.
		 *      isMorphHeightEnabled - Height morphing flag. If not defined, defIsMorphHeightEnabled used instead.
		 *
		 * @param config Config object
		 * @param parent Parent DisplayObjectContainer
		 */
		public function MorphSprite(config:Object = null, parent:DisplayObjectContainer = null) {
			var c:Object;

			// create config value object
			if(config == null) c = new Object();
			else c = config;

			// create parent QSprite
			super(c, parent);

			// assign values
			morphDuration = (c.morphDuration == undefined) ? defMorphDuration : c.morphDuration;
			morphEase = (c.morphEase == undefined) ? defMorphEase : c.morphEase;
			isChangeWidthEnabled = (c.isChangeWidthEnabled == undefined) ? defIsChangeWidthEnabled : c.isChangeWidthEnabled;
			isChangeHeightEnabled = (c.isChangeHeightEnabled == undefined) ? defIsChangeHeightEnabled : c.isChangeHeightEnabled;
			isMorphXEnabled = (c.isMorphXEnabled == undefined) ? defIsMorphXEnabled : c.isMorphXEnabled;
			isMorphYEnabled = (c.isMorphYEnabled == undefined) ? defIsMorphYEnabled : c.isMorphYEnabled;
			isMorphWidthEnabled = (c.isMorphWidthEnabled == undefined) ? defIsMorphWidthEnabled : c.isMorphWidthEnabled;
			isMorphHeightEnabled = (c.isMorphHeightEnabled == undefined) ? defIsMorphHeightEnabled : c.isMorphHeightEnabled;
		}



		/**
		 * Animate state change. Timing is taken from morphDuration, transition from morphEase.
		 * Follows status flags (isMorphXEnabled, isMorphYEnabled, isMorphWidthEnabled and isMorphHeightEnabled).
		 *
		 * Possible config contents:
		 *      x - New X position
		 *      y -  New Y position
		 *      width - New width
		 *      height - New height
		 *      morphEase - Easing
		 *      morphDuration - Duration
		 *
		 * @param config Config value object
		 */
		//noinspection FunctionWithMoreThanThreeNegationsJS
		public function morph(config:Object):void {
			if(_initialProperties == null) {
				_initialProperties = new Object();
				_initialProperties.x = this.x;
				_initialProperties.y = this.y;
				_initialProperties.width = this.width;
				_initialProperties.height = this.height;
			}

			_oldCacheAsBitmap = this.cacheAsBitmap;
			this.cacheAsBitmap = false;

			var t:Object = new Object();

			if(isMorphXEnabled && config.x != undefined) t.x = config.x;
			if(isMorphYEnabled && config.y != undefined) t.y = config.y;
			if(isMorphWidthEnabled && config.width != undefined) t.width = config.width;
			if(isMorphHeightEnabled && config.height != undefined) t.height = config.height;

			t.ease = (config.morphEase == undefined) ? morphEase : config.morphEase;
			t.roundProps = ['x', 'y', 'width', 'height'];
			t.onComplete = _onMorphComplete;

			//noinspection ObjectAllocationIgnored
			new TweenLite(this, (config.morphDuration == undefined) ? morphDuration : config.morphDuration, t);
		}



		/**
		 * Reset to initial position before morph.
		 */
		public function morphReset():void {
			morph(_initialProperties);
			_initialProperties = null;
		}



		// Getters & setters
		// -----------------


		/**
		 * If width change flag is set, directly change width.
		 *
		 * @param value New width
		 */
		override public function set width(value:Number):void {
			if(isChangeWidthEnabled) {
				super.width = value;
			}
		}



		/**
		 * If height change flag is set, directly change height.
		 *
		 * @param value New height
		 */
		override public function set height(value:Number):void {
			if(isChangeHeightEnabled) {
				super.height = value;
			}
		}



		// Private methods
		// ---------------


		private function _onMorphComplete():void {
			cacheAsBitmap = _oldCacheAsBitmap;
		}
	}
}
