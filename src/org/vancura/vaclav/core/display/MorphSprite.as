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
		 * Possible config contents:
		 *      morphDuration - Morphing duration in seconds. If not defined, defMorphDuration used instead.
		 *      morphEase - Morphing transition function. If not defined, defMorphEase used instead.
		 *      isChangeWidthEnabled - Width change flag. If not defined, defIsChangeWidthEnabled used instead.
		 *      isChangeHeightEnabled - Height change flag. If not defined, defIsChangeHeightEnabled used instead.
		 *      isMorphXEnabled - X morphing flag. If not defined, defIsMorphXEnabled used instead.
		 *      isMorphYEnabled - Y morphing flag. If not defined, defIsMorphYEnabled used instead.
		 *      isMorphWidthEnabled - Width morphing flag. If not defined, defIsMorphWidthEnabled used instead.
		 *      isMorphHeightEnabled - Height morphing flag. If not defined, defIsMorphHeightEnabled used instead.
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
		 * Possible config contents:
		 *      x - New X position
		 *      y -  New Y position
		 *      width - New width
		 *      height - New height
		 *      morphEase - Easing
		 *      morphDuration - Duration
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
		 * @param value New width
		 */
		override public function set width(value:Number):void {
			if(isChangeWidthEnabled) {
				super.width = value;
			}
		}



		/**
		 * If height change flag is set, directly change height.
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
