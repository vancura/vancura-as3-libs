package org.vancura.vaclav.core {
	import com.greensock.TweenNano;
	import com.greensock.easing.Elastic;

	import flash.display.DisplayObjectContainer;

	
	
	/*
	 * Class: MorphSprite
	 * 
	 * Morphable sprite. You can animate position and size of any extending class.
	 * 
	 * Author: Vaclav Vancura <http://vaclav.vancura.org>
	 *
	 * 2009-11-04	- Switched to TweenNano (v.vancura)
	 * 2008-11-03	- Morph easing fixes (v.vancura)
	 * 2008-10-16	- Added morphReset() (v.vancura)
	 * 2008-10-13	- Switched to TweenFilterLite because it's now able to round params (v.vancura)
	 * 2008-10-08	- Switched from tweener to GTween (v.vancura)
	 * 2008-07-01	- Initial version (v.vancura)
	 */
	public class MorphSprite extends QSprite {

		
		
		/*
		 * Variables: Default config
		 *
		 * 		defMorphDuration			- Default morphing duration in seconds (1)
		 * 		defMorphEase				- Default morphing transition function (mx.effects.easing.Cubic.easeInOut)
		 * 		defIsChangeWidthEnabled		- Default width change flag (true)
		 * 		defIsChangeHeightEnabled	- Default height change flag (true)
		 * 		defIsMorphXEnabled			- Default X morphing flag (true)
		 * 		defIsMorphYEnabled			- Default Y morphing flag (true)
		 * 		defIsMorphWidthEnabled		- Default width morphing flag (true)
		 * 		defIsMorphHeightEnabled		- Default height morphing flag (true)
		 */
		public static var defMorphDuration:Number = .75;
		public static var defMorphEase:Function = Elastic.easeOut;
		public static var defIsChangeWidthEnabled:Boolean = true;
		public static var defIsChangeHeightEnabled:Boolean = true;
		public static var defIsMorphXEnabled:Boolean = true;
		public static var defIsMorphYEnabled:Boolean = true;
		public static var defIsMorphWidthEnabled:Boolean = true;
		public static var defIsMorphHeightEnabled:Boolean = true;
		
		
		
		/*
		 * Variables: Public variables
		 *	
		 * 		morphDuration			- Current morphing duration in seconds
		 * 		morphEase				- Current morphing transition function
		 * 		isChangeWidthEnabled	- Current width change flag
		 * 		isChangeHeightEnabled	- Current height change flag
		 * 		isMorphXEnabled			- Current X morphing flag
		 * 		isMorphYEnabled			- Current Y morphing flag
		 * 		isMorphWidthEnabled		- Current width morphing flag
		 * 		isMorphHeightEnabled	- Current height morphing flag
		 */
		public var morphDuration:Number;
		public var morphEase:Function;
		public var isChangeWidthEnabled:Boolean;
		public var isChangeHeightEnabled:Boolean;
		public var isMorphXEnabled:Boolean;
		public var isMorphYEnabled:Boolean;
		public var isMorphWidthEnabled:Boolean;
		public var isMorphHeightEnabled:Boolean;
		
		
		
		private var _oldCacheAsBitmap:Boolean;
		private var _initialProperties:Object;

		
		
		/*
		 * Constructor: MorphSprite
		 *	
		 * Parameters:
		 *	
		 *		c		- Config object
		 *		parent	- Parent DisplayObjectContainer
		 *	
		 * Currently these options are available (set in c Object):
		 *	
		 *		morphDuration			- Morphing duration in seconds. If not defined, <defMorphDuration> used instead.
		 *		morphEase				- Morphing transition function. If not defined, <defMorphEase> used instead.
		 *		isChangeWidthEnabled	- Width change flag. If not defined, <defIsChangeWidthEnabled> used instead.
		 *		isChangeHeightEnabled	- Height change flag. If not defined, <defIsChangeHeightEnabled> used instead.
		 *		isMorphXEnabled			- X morphing flag. If not defined, <defIsMorphXEnabled> used instead.
		 *		isMorphYEnabled			- Y morphing flag. If not defined, <defIsMorphYEnabled> used instead.
		 *		isMorphWidthEnabled		- Width morphing flag. If not defined, <defIsMorphWidthEnabled> used instead.
		 *		isMorphHeightEnabled	- Height morphing flag. If not defined, <defIsMorphHeightEnabled> used instead.
		 */
		public function MorphSprite(	c:Object = null,
										parent:DisplayObjectContainer = null) {
											
			// if config is not defined, prepare it
			if(c == null) c = new Object();

			// create parent QSprite
			super(c, parent);

			// assign values
			morphDuration = (c.morphDuration != undefined) ? c.morphDuration : defMorphDuration;
			morphEase = (c.morphEase != undefined) ? c.morphEase : defMorphEase;
			isChangeWidthEnabled = (c.changeWidthEnabled != undefined) ? c.changeWidthEnabled : defIsChangeWidthEnabled;
			isChangeHeightEnabled = (c.changeHeightEnabled != undefined) ? c.changeHeightEnabled : defIsChangeHeightEnabled;
			isMorphXEnabled = (c.morphXEnabled != undefined) ? c.morphXEnabled : defIsMorphXEnabled;
			isMorphYEnabled = (c.morphYEnabled != undefined) ? c.morphYEnabled : defIsMorphYEnabled;
			isMorphWidthEnabled = (c.morphWidthEnabled != undefined) ? c.morphWidthEnabled : defIsMorphWidthEnabled;
			isMorphHeightEnabled = (c.morphHeightEnabled != undefined) ? c.morphHeightEnabled : defIsMorphHeightEnabled;
		}

		
		
		/*
		 * Method: morph
		 *	
		 * Animate state change. Timing is taken from <morphDuration>, transition from <morphEase>.
		 * Follows status flags (<isMorphXEnabled>, <isMorphYEnabled>, <isMorphWidthEnabled> and <isMorphHeightEnabled>)
		 *	
		 * Parameters:
		 *	
		 * c	- Config object
		 *	
		 * Currently these options are available (set in c Object):
		 *	
		 * x				- New X position
		 * y				- New Y position
		 * width			- New width
		 * height			- New height
		 * morphEase		- Easing
		 * morphDuration	- Duration
		 */
		public function morph(c:Object):void {
			if(_initialProperties == null) {
				_initialProperties = new Object();
				_initialProperties.x = this.x;
				_initialProperties.y = this.y;
				_initialProperties.width = this.width;
				_initialProperties.height = this.height;
			}
			
			_oldCacheAsBitmap = cacheAsBitmap;
			cacheAsBitmap = false;

			var t:Object = new Object();
			if(isMorphXEnabled && c.x != undefined) t.x = c.x;
			if(isMorphYEnabled && c.y != undefined) t.y = c.y;
			if(isMorphWidthEnabled && c.width != undefined) t.width = c.width;
			if(isMorphHeightEnabled && c.height != undefined) t.height = c.height;
			
			t.ease = (c.morphEase != undefined) ? c.morphEase : morphEase;
			t.roundProps = ['x', 'y', 'width', 'height'];
			t.onComplete = function():void {
				cacheAsBitmap = _oldCacheAsBitmap;
			};
			
			new TweenNano(this, (c.morphDuration != undefined) ? c.morphDuration : morphDuration, t);
		}
		
		
		
		/*
		 * Method: morphReset
		 * 
		 * Reset to initial position before morph.
		 */
		public function morphReset():void {
			morph(_initialProperties);
			_initialProperties = null;
		}

		
		
		/*
		 * Method: width
		 *	
		 * If width change flag is set, directly change width.
		 *	
		 * Parameters:
		 *	
		 * value	- New width
		 */
		override public function set width(value:Number):void {
			if(isChangeWidthEnabled) super.width = value;
		}

		
		
		/*
		 * Method: height
		 *	
		 * If height change flag is set, directly change height.
		 *	
		 * Parameters:
		 *	
		 * value	- New height
		 */
		override public function set height(value:Number):void {
			if(isChangeHeightEnabled) super.height = value;
		}
	}
}
