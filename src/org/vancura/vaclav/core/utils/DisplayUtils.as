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

package org.vancura.vaclav.core.utils {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;

	/**
	 * A class covering few graphics methods I can't put anywhere else.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public final class DisplayUtils {



		/** Default width */
		public static const DEFAULT_WIDTH:Number = 100;

		/** Default height */
		public static const DEFAULT_HEIGHT:Number = 100;

		/** Default color */
		public static const DEFAULT_COLOR:uint = 0xFF0000;

		/** Default alpha */
		public static const DEFAULT_ALPHA:Number = 1;

		/** Default thickness */
		public static const DEFAULT_THICKNESS:Number = 0;

		/** Default radius */
		public static const DEFAULT_RADIUS:Number = 20;

		/** Default segments */
		public static const DEFAULT_SEGMENTS:Number = 6;



		/**
		 * Constructor.
		 * Cannot be instantiated, throws an Error.
		 * @throws Error, since the class could not be instantiated
		 */
		public function DisplayUtils() {
			throw new Error('The DisplayUtils class cannot be instantiated.');
		}



		/**
		 * Clear graphics. Shortcut to canvas.graphics.clear().
		 * @param canvas Canvas to be cleared
		 */
		public static function clear(canvas:Sprite):void {
			canvas.graphics.clear();
		}



		/**
		 * Shortcut to draw a rectangle.
		 * @param canvas Canvas to draw on
		 * @param x X position
		 * @param y Y position
		 * @param width Width
		 * @param height Height
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection OverlyComplexFunctionJS
		public static function drawRect(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT,
		                                color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			canvas.graphics.beginFill(color, alpha);
			canvas.graphics.drawRect(x, y, width, height);
			canvas.graphics.endFill();
		}



		/**
		 * Shortcut to draw a circle.
		 * @param canvas Canvas to draw on
		 * @param x X center position
		 * @param y Y center position
		 * @param radius Radius
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection OverlyComplexFunctionJS
		public static function drawCircle(canvas:Sprite, x:Number, y:Number, radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR,
		                                  alpha:Number = DEFAULT_ALPHA):void {
			canvas.graphics.beginFill(color, alpha);
			canvas.graphics.drawCircle(x, y, radius);
			canvas.graphics.endFill();
		}



		/**
		 * Shortcut to draw a rounded rectangle.
		 * @param canvas Canvas to draw on
		 * @param x X position
		 * @param y Y position
		 * @param width Width
		 * @param height Height
		 * @param radius Radius
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection OverlyComplexFunctionJS
		public static function drawRoundRect(canvas:Sprite, x:Number, y:Number, width:Number = DEFAULT_WIDTH, height:Number = DEFAULT_HEIGHT,
		                                     radius:Number = DEFAULT_RADIUS, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			canvas.graphics.beginFill(color, alpha);
			canvas.graphics.drawRoundRect(x, y, width, height, radius, radius);
			canvas.graphics.endFill();
		}



		/**
		 * Shortcut to draw a pie.
		 * @param canvas Canvas to draw on
		 * @param x X center position
		 * @param y Y center position
		 * @param radius Radius
		 * @param segments Segments
		 * @param angle1 Angle 1
		 * @param angle2 Angle 2
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection FunctionTooLongJS,MagicNumberJS,OverlyComplexFunctionJS
		public static function drawPie(canvas:Sprite, x:Number, y:Number, radius:Number = DEFAULT_RADIUS, segments:int = DEFAULT_SEGMENTS,
		                               angle1:Number = 0, angle2:Number = 360, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA):void {
			var segm:Number;
			var grad:Number;
			var x1:Number;
			var y1:Number;

			//noinspection MagicNumberJS
			var rad:Number = Math.PI / 180;

			//noinspection UnnecessaryLocalVariableJS
			var a2:Number = angle2;
			var a1:Number = angle1;

			canvas.graphics.beginFill(color, alpha);

			if(!a1 && !a2 || a1 == a2) {
				// full circle

				//noinspection MagicNumberJS
				grad = 360;

				segm = grad / segments;
				x1 = radius + x;
				y1 = y;
				canvas.graphics.moveTo(x1, y1);
			}
			else {
				// not a full circle
				if(a1 > a2) {
					//noinspection MagicNumberJS
					a1 -= 360;
				}
				x1 = radius * Math.cos(a1 * rad) + x;
				y1 = radius * Math.sin(a1 * rad) + y;
				grad = a2 - a1;
				segm = grad / segments;
				canvas.graphics.moveTo(x, y);
				canvas.graphics.lineTo(x1, y1);
			}

			//noinspection MagicNumberJS
			for(var s:Number = segm + a1; s < grad + 0.1 + a1; s += segm) {
				var x2:Number = radius * Math.cos((s - segm / 2) * rad) + x;
				var y2:Number = radius * Math.sin((s - segm / 2) * rad) + y;
				var x3:Number = radius * Math.cos(s * rad) + x;
				var y3:Number = radius * Math.sin(s * rad) + y;

				//noinspection MagicNumberJS
				var cx:Number = 2 * x2 - 0.5 * (x1 + x3);

				//noinspection MagicNumberJS
				var cy:Number = 2 * y2 - 0.5 * (y1 + y3);

				x1 = x3;
				y1 = y3;

				canvas.graphics.curveTo(cx, cy, x3, y3);
			}

			//noinspection MagicNumberJS
			if(grad != 360) canvas.graphics.lineTo(x, y);

			canvas.graphics.endFill();
		}



		/**
		 * Shortcut to stroke a rectangle.
		 * @param canvas Canvas to draw on
		 * @param x X position
		 * @param y Y position
		 * @param width Width
		 * @param height Height
		 * @param color Color
		 * @param alpha Alpha
		 * @param thickness Thickness
		 */
		//noinspection OverlyComplexFunctionJS
		public static function strokeRect(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH,
		                                  height:Number = DEFAULT_HEIGHT, color:uint = DEFAULT_COLOR, alpha:Number = DEFAULT_ALPHA,
		                                  thickness:Number = DEFAULT_THICKNESS):void {
			var w:Number = width - 1;
			var h:Number = height - 1;

			canvas.graphics.lineStyle(thickness, color, alpha, true);
			canvas.graphics.drawRect(x, y, w, h);
		}



		/**
		 * Shortcut to draw a line.
		 * @param canvas Canvas to draw on
		 * @param x1 Start X position
		 * @param y1 Start Y position
		 * @param x2 End X position
		 * @param y2 End Y position
		 * @param color Color
		 * @param alpha Alpha
		 * @param thickness Thickness
		 */
		//noinspection OverlyComplexFunctionJS
		public static function strokeLine(canvas:Sprite, x1:Number, y1:Number, x2:Number, y2:Number, color:uint = DEFAULT_COLOR,
		                                  alpha:Number = DEFAULT_ALPHA, thickness:Number = DEFAULT_THICKNESS):void {
			canvas.graphics.lineStyle(thickness, color, alpha, true);
			canvas.graphics.moveTo(x1, y1);
			canvas.graphics.lineTo(x2, y2);
		}



		/**
		 * Draw bounding corners.
		 * @param canvas Canvas to draw on
		 * @param x X position
		 * @param y Y position
		 * @param width Width
		 * @param height Height
		 * @param padding Padding
		 * @param color Color
		 * @param alpha Alpha
		 */
		//noinspection OverlyComplexFunctionJS
		public static function strokeBounds(canvas:Sprite, x:Number = 0, y:Number = 0, width:Number = DEFAULT_WIDTH,
		                                    height:Number = DEFAULT_HEIGHT, padding:Number = 5, color:uint = DEFAULT_COLOR,
		                                    alpha:Number = DEFAULT_ALPHA):void {
			var w:Number = width - 1;
			var h:Number = height - 1;

			canvas.graphics.lineStyle(0, color, alpha, true);
			canvas.graphics.moveTo(x, padding + y);
			canvas.graphics.lineTo(x, y);
			canvas.graphics.lineTo(padding + x, y);
			canvas.graphics.moveTo(w - padding + x, y);
			canvas.graphics.lineTo(w + x, y);
			canvas.graphics.lineTo(w + x, padding + y);
			canvas.graphics.moveTo(w + x, h - padding + y);
			canvas.graphics.lineTo(w + x, h + y);
			canvas.graphics.lineTo(w - padding + x, h + y);
			canvas.graphics.moveTo(padding + x, h + y);
			canvas.graphics.lineTo(x, h + y);
			canvas.graphics.lineTo(x, h - padding + y);
		}



		/**
		 * Apply a scroll rect from (0,0) to (width,height).
		 * Original article: http://jacksondunstan.com/articles/519
		 * @param dispObj Display object to apply on
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function applyNaturalScrollRect(dispObj:DisplayObject):void {
			dispObj.scrollRect = new Rectangle(0, 0, dispObj.width, dispObj.height);
		}



		/**
		 * Wait a given number of frames then call a callback.
		 * Original article: http://jacksondunstan.com/articles/519
		 * @param numFrames Number of frames to wait before calling the callback
		 * @param callback Function to call once the given number of frames have passed
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function wait(numFrames:uint, callback:Function):void {
			var nf:uint = numFrames;
			var obj:Shape = new Shape();

			obj.addEventListener(Event.ENTER_FRAME, function(ev:Event):void {
				nf--;
				if(nf == 0) {
					obj.removeEventListener(Event.ENTER_FRAME, arguments.callee);
					callback();
				}
			});
		}



		/**
		 * Basically an addChild() for more children at once.
		 * Just saves few lines of code, nothing special.
		 * @param obj Target DisplayObject
		 * @param children Children to be added
		 * @author Vaclav Vancura (http://vaclav.vancura.org)
		 */
		public static function addChildren(obj:*, ... children:Array):void {
			for each(var i:DisplayObject in children) obj.addChild(i);
		}



		/**
		 * Basically an addChild() for more children at once.
		 * Just saves few lines of code, nothing special.
		 * @param obj Target DisplayObject
		 * @param children Children to be removed
		 * @author Vaclav Vancura (http://vaclav.vancura.org)
		 */
		public static function removeChildren(obj:*, ... children:Array):void {
			for each(var i:DisplayObject in children) obj.removeChild(i);
		}



		/**
		 * Remove all children from a container and leave the bottom few.
		 * Original article: http://jacksondunstan.com/articles/519
		 * @param container Container to remove from
		 * @param leave (optional) Number of bottom children to leave
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function removeAllChildren(container:DisplayObjectContainer, leave:int = 0):void {
			while(container.numChildren > leave) container.removeChildAt(leave);
		}



		/**
		 * Duplicate a MovieClip.
		 * @param source Source MovieClip
		 * @return Duplicated MovieClip
		 * @author Vaclav Vancura (http://vaclav.vancura.org)
		 */
		public static function duplicateMovieClip(source:MovieClip):MovieClip {
			var targetClass:Class = Object(source).constructor as Class;
			return(new targetClass() as MovieClip);
		}



		/**
		 * Instantiate a new instance of a certain class of display object.
		 * Original article: http://jacksondunstan.com/articles/519
		 * @param obj Display object whose class a new display object should be instantiated of
		 * @param args Arguments to pass to the display object's constructor
		 * @return A new instance of the given display object's class
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function instantiate(obj:Object, args:Array):DisplayObject {
			var c:Class = ClassUtils.getDisplayObjectClass(obj);

			//noinspection NestedFunctionCallJS
			return c == null ? null : DisplayObject(instantiate(c, args));
		}



		/**
		 * Check if a display object is visible. This checks all of its parents' visibilities.
		 * Original article: http://jacksondunstan.com/articles/519
		 * @param obj Display object to check
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function isVisible(obj:DisplayObject):Boolean {
			for(var cur:DisplayObject = obj; cur != null; cur = cur.parent) {
				if(!cur.visible) return false;
			}
			return true;
		}



		/**
		 * Get the children of a container as an array.
		 * Original article: http://jacksondunstan.com/articles/519
		 * @param container Container to get the children of
		 * @return The children of the given container as an array
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function getChildren(container:DisplayObjectContainer):Array {
			var ret:Array = [];

			var numChildren:int = container.numChildren;
			for(var i:int = 0; i < numChildren; ++i) ret.push(container.getChildAt(i));

			return ret;
		}



		/**
		 * Get the parents of a display object as an array.
		 * Original article: http://jacksondunstan.com/articles/519
		 * @param obj Object whose parents should be retrieved
		 * @param includeSelf If obj should be included in the returned array
		 * @param stopAt Display object to stop getting parents at. Passing null indicates that all parents should be included.
		 * @return An array of the parents of the given display object. This includes all parents unless stopAt is non-null. If stopAt is non-null, it and its parents will not be included in the returned array.
		 * @author Jackson Dunstan (http://jacksondunstan.com)
		 */
		public static function getParents(obj:DisplayObject, includeSelf:Boolean = true, stopAt:DisplayObject = null):Array {
			var ret:Array = [];

			for(var cur:DisplayObject = includeSelf ? obj : obj.parent; cur != stopAt && cur != null; cur = cur.parent) {
				ret.push(cur);
			}

			return ret;
		}



		/**
		 * @author VitaLee (http://meet.berovbros.com)
		 */
		public static function filterChildrenByProps(container:DisplayObjectContainer, props:Object):Array {
			var filteredChildren:Array = [];
			var child:DisplayObject;

			for(var i:int = 0, l:int = container.numChildren; i < l; i++) {
				child = container.getChildAt(i);
				var isOK:Boolean = true;
				for(var prop:String in props) {
					if(child[prop] != props[prop]) {
						isOK = false;
						break;
					}
				}
				if(isOK) filteredChildren.push(child);
			}
			return filteredChildren;
		}



		/**
		 * @author VitaLee (http://meet.berovbros.com)
		 */
		public static function setProperties(children:Array, props:Object):void {
			var child:DisplayObject;
			for(var i:int = 0, l:uint = children.length; i < l; i++) {
				child = children[i];
				for(var prop:String in props) {
					child[prop] = props[prop];
				}
			}
		}



		/**
		 * @author VitaLee (http://meet.berovbros.com)
		 */
		public static function sumProps(children:Array, prop:String):Number {
			var sum:Number = 0;
			for(var i:int = 0, l:uint = children.length; i < l; i++) {
				sum += children[i][prop];
			}
			return sum;
		}



		/**
		 * @author VitaLee (http://meet.berovbros.com)
		 */
		public static function originalWidth(obj:DisplayObject):Number {
			return obj.width / obj.scaleX;
		}



		/**
		 * @author VitaLee (http://meet.berovbros.com)
		 */
		public static function originalHeight(obj:DisplayObject):Number {
			return obj.height / obj.scaleY;
		}



		/**
		 * @author Karl Knocking
		 */
		public static function relativePos(dO1:DisplayObject, dO2:DisplayObject):Point {
			var pos:Point = new Point(0, 0);
			pos = dO1.localToGlobal(pos);
			pos = dO2.globalToLocal(pos);
			return pos;
		}



		/**
		 * Determines the full bounds of the display object regardless of masking elements.
		 * @param displayObject The display object to analyze.
		 * @return the display object dimensions.
		 * @author Matt W (http://blog.nobien.net)
		 */
		public static function getFullBounds(displayObject:DisplayObject):Rectangle {
			var bounds:Rectangle, transform:Transform, toGlobalMatrix:Matrix, currentMatrix:Matrix;

			transform = displayObject.transform;
			currentMatrix = transform.matrix;
			toGlobalMatrix = transform.concatenatedMatrix;
			toGlobalMatrix.invert();
			transform.matrix = toGlobalMatrix;

			bounds = transform.pixelBounds.clone();

			transform.matrix = currentMatrix;

			return bounds;
		}



		/**
		 * Stops all timelines of the specified display object and its children.
		 * @param displayObject The display object to loop through.
		 * @author Matt W (http://blog.nobien.net)
		 */
		public static function stopAllTimelines(displayObject:DisplayObjectContainer):void {
			var numChildren:int = displayObject.numChildren;

			for(var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = displayObject.getChildAt(i);

				if(child is DisplayObjectContainer) {
					if(child is MovieClip) MovieClip(child).stop();

					stopAllTimelines(child as DisplayObjectContainer);
				}
			}
		}



		/**
		 * Brings the DisplayObject to the front of the display list. The <code>back</code> parameter can be used to pull the DisplayObject back a few levels from the front.
		 * @param object the DisplayObject to reorder
		 * @param back the number of levels from the front of the display list
		 * @return the new index of the DisplayObject
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function bringToFront(object:DisplayObject, back:uint = 0):int {
			if(!object.parent) return -1;

			var index:int = object.parent.numChildren - (back + 1);
			index = NumberUtils.confine(index, 0, object.parent.numChildren - 1);

			object.parent.setChildIndex(object, index);

			return index;
		}



		/**
		 * Brings the DisplayObject forward in the display list. The <code>steps</code> parameter can be used to jump more than one level.
		 * @param object the DisplayObject to reorder
		 * @param steps the number of levels bring the DisplayObject forward
		 * @return the new index of the DisplayObject
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function bringForward(object:DisplayObject, steps:uint = 1):int {
			if(!object.parent) return -1;

			var index:int = object.parent.getChildIndex(object) + steps;
			index = NumberUtils.confine(index, 0, object.parent.numChildren - 1);

			object.parent.setChildIndex(object, index);

			return index;
		}



		/**
		 * Sends the DisplayObject to the back of the display list. The <code>forward</code> parameter can be used to bring the DisplayObject forward a few levels from the back.
		 * @param object the DisplayObject to reorder
		 * @param forward the number of levels from the back of the display list
		 * @return the new index of the DisplayObject
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function sendToBack(object:DisplayObject, forward:uint = 0):int {
			if(!object.parent) return -1;

			var index:int = NumberUtils.confine(forward, 0, object.parent.numChildren - 1);

			object.parent.setChildIndex(object, index);

			return index;
		}



		/**
		 * Sends the DisplayObject back in the display list. The <code>steps</code> parameter can be used to jump more than one level.
		 * @param object the DisplayObject to reorder
		 * @param steps the number of levels send the DisplayObject backward
		 * @return the new index of the DisplayObject
		 * @author Jonnie Hallman / Destroytoday (http://destroytoday.com)
		 */
		public static function sendBackward(object:DisplayObject, steps:uint = 1):int {
			if(!object.parent) return -1;

			var index:int = object.parent.getChildIndex(object) - steps;
			index = NumberUtils.confine(index, 0, object.parent.numChildren - 1);

			object.parent.setChildIndex(object, index);

			return index;
		}



		/**
		 * Moje
		 * @param container
		 * @param indentLevel
		 */
		//noinspection FunctionWithMultipleLoopsJS
		public static function traceChildren(container:DisplayObjectContainer, indentLevel:int = 0):void {
			for(var i:int = 0; i < container.numChildren; i++) {
				var thisChild:DisplayObject = container.getChildAt(i);
				var output:String = '';

				for(var j:int = 0; j < indentLevel; j++) {
					output += '   ';
				}
				output += '+  ' + thisChild.name + ' = ' + thisChild.toString();
				trace(output);

				if(thisChild is DisplayObjectContainer) {
					traceChildren(DisplayObjectContainer(thisChild), indentLevel + 1);
				}
			}
		}
	}
}
