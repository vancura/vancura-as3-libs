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
 * * Attribution — You must give the original author credit.
 *
 * With the understanding that:
 *    * Waiver — Any of the above conditions can be waived if you get permission from the copyright holder. CC licenses
 *      anticipate that a licensor may want to waive compliance with a specific condition, such as attribution.
 *    * Other Rights — In no way are any of the following rights affected by the license:
 * 	        - Your fair dealing or fair use rights — All jurisdictions allow some limited uses of copyrighted material
 *            without permission. CC licenses do not affect the rights of users under those copyright limitations and
 *            exceptions, such as fair use and fair dealing where applicable.
 * 	        - The author's moral rights — In addition to the right of licensors to request removal of their name from
 *            the work when used in a derivative or collective they don't like, copyright laws in most jurisdictions
 *            around the world (with the notable exception of the US except in very limited circumstances) grant
 *            creators "moral rights" which may provide some redress if a derivative work represents a "derogatory
 *            treatment" of the licensor's work.
 * 	        - Rights other persons may have either in the work itself or in how the work is used, such as publicity or
 *            privacy rights. — Publicity rights allow individuals to control how their voice, image or likeness is used
 *            for commercial purposes in public. If a CC-licensed work includes the voice or image of anyone other than
 *            the licensor, a user of the work may need to get permission from those individuals before using the work
 *            for commercial purposes.
 *
 * Notice — For any reuse or distribution, you must make clear to others the licence terms of this work.
 **********************************************************************************************************************/

package org.vancura.vaclav.core.utils {
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class NavigateUtils {


		public static const WINDOW_SELF:String = '_self';
		public static const WINDOW_BLANK:String = '_blank';
		public static const WINDOW_PARENT:String = '_parent';
		public static const WINDOW_TOP:String = '_top';



		/**
		 * Constructor.
		 */
		public function NavigateUtils() {
		}



		/**
		 Simlifies <code>navigateToURL</code> by allowing you to either use a <code>String</code> or an <code>URLRequest</code> reference to the URL. This method also helps prevent pop-up blocking by trying to use {@link #openWindow} before calling <code>navigateToURL</code>.
CASA
		 @param request: A <code>String</code> or an <code>URLRequest</code> reference to the URL you wish to open/navigate to.
		 @param window: The browser window or HTML frame in which to display the URL indicated by the <code>request</code> parameter.
		 @throws ArguementTypeError if you pass a value type other than a <code>String</code> or <code>URLRequest</code> to parameter <code>request</code>.
		 */
		public static function openUrl(request:*, window:String = WINDOW_SELF):void {
			if(request is String)
				request = new URLRequest(request); else if(!(request is URLRequest))
				throw new Error('request');

			if(window == WINDOW_BLANK && ExternalInterface.available && !LocationUtils.isIde() && request.data == null)
			if(openWindow(request.url, window))
				return;

			navigateToURL(request, window);
		}



		/**
		 A Flash wrapper for JavaScript’s <code>window.open</code>.
CASA
		 @param url: Specifies the URL you wish to open/navigate to.
		 @param window: The browser window or HTML frame in which to display the URL indicated by the <code>url</code> parameter.
		 @param features: Defines the various window features to be included.
		 @return Returns <code>true</code> if the window was successfully created; otherwise <code>false</code>.
		 @see <a href="http://google.com/search?q=JavaScript+window.open+documentation">JavaScript documentation for window.open</a>.
		 */
		public static function openWindow(url:String, window:String = WINDOW_BLANK, features:String = ""):Boolean {
			return ExternalInterface.call("function casaOpenWindow(url, windowOrName, features) { return window.open(url, windowOrName, features) != null; }", url, (window == WINDOW_BLANK) ? 'casaWindow' + int(1000 * Math.random()) : window, features);
		}
	}
}
