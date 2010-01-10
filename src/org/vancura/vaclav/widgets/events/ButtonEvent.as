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

package org.vancura.vaclav.widgets.events {
	import flash.events.Event;

	public class ButtonEvent extends Event {


		public static const DRAG_OVER:String = 'drag_over';
		public static const DRAG_OUT:String = 'drag_out';
		public static const DRAG_CONFIRM:String = 'drag_confirm';
		public static const HOVER_IN:String = 'hover_in';
		public static const HOVER_OUT:String = 'hover_out';
		public static const FOCUS_IN:String = 'focus_in';
		public static const RELEASE_INSIDE:String = 'release_inside';
		public static const RELEASE_OUTSIDE:String = 'release_outside';
		public static const HOVER_IN_TWEEN:String = 'hover_in_tween';
		public static const HOVER_OUT_TWEEN:String = 'hover_out_tween';
		public static const FOCUS_IN_TWEEN:String = 'focus_in_tween';
		public static const DRAG_CONFIRMED_TWEEN:String = 'drag_confirmed_tween';
		public static const RELEASED_INSIDE_TWEEN:String = 'released_inside_tween';
		public static const RELEASED_OUTSIDE_TWEEN:String = 'released_outside_tween';



		public function ButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}



		public override function clone():Event {
			return new ButtonEvent(type, bubbles, cancelable);
		}



		public override function toString():String {
			return formatToString('ButtonEvent', 'type', 'bubbles', 'cancelable');
		}
	}
}
