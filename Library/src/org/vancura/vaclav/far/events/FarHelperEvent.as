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
 * 	        - Your fair dealing or fair use rights � All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights � In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. � Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice � For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.far.events {
	import flash.events.Event;

	import org.vancura.vaclav.far.FarHelperItem;

	public class FarHelperEvent extends Event {


		public static const STREAM_DOWNLOAD_DONE:String = 'stream_download_done';
		public static const STREAM_SECURITY_ERROR:String = 'stream_security_error';
		public static const STREAM_IO_ERROR:String = 'stream_io_error';
		public static const ITEM_NOT_FOUND:String = 'item_not_found';
		public static const ITEM_LOAD_FAILED:String = 'item_load_failed';
		public static const ITEM_LOAD_COMPLETE:String = 'item_load_complete';

		public var helperItem:FarHelperItem;
		public var text:String;



		public function FarHelperEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, helperItem:FarHelperItem = null,
		                               text:String = null) {
			this.helperItem = helperItem;
			this.text = text;

			super(type, bubbles, cancelable);
		}



		public override function clone():Event {
			return new FarHelperEvent(type, bubbles, cancelable, helperItem, text);
		}



		public override function toString():String {
			return formatToString('FarHelperEvent', 'type', 'bubbles', 'cancelable', 'helperItem', 'text');
		}
	}
}
