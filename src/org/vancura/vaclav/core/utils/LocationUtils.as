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

package org.vancura.vaclav.core.utils {
	import flash.display.DisplayObject;
	import flash.system.Capabilities;

	public class LocationUtils {



		/**
		 * Constructor.
		 */
		public function LocationUtils() {
		}



		/**
		 Determines if the SWF is being served on the internet.
CASA
		 @param location: DisplayObject to get location of.
		 @return Returns <code>true</code> if SWF is being served on the internet; otherwise <code>false</code>.
		 @usage
		 <code>
		 trace(LocationUtils.isWeb(_root));
		 </code>
		 */
		public static function isWeb(location:DisplayObject):Boolean {
			return location.loaderInfo.url.substr(0, 4) == 'http';
		}



		/**
		 Detects if MovieClip's embed location matches passed domain.
CASA
		 @param location: MovieClip to compare location of.
		 @param domain: Web domain.
		 @return Returns <code>true</code> if file's embed location matched passed domain; otherwise <code>false</code>.
		 @usage
		 To check for domain:
		 <code>
		 trace(LocationUtils.isDomain(_root, "google.com"));
		 trace(LocationUtils.isDomain(_root, "bbc.co.uk"));
		 </code>

		 You can even check for subdomains:
		 <code>
		 trace(LocationUtils.isDomain(_root, "subdomain.aaronclinger.com"))
		 </code>
		 */
		public static function isDomain(location:DisplayObject, domain:String):Boolean {
			return getDomain(location).slice(-domain.length) == domain;
		}



		/**
		 Detects MovieClip's domain location.
CASA
		 @param location: MovieClip to get location of.
		 @return Returns full domain (including sub-domains) of MovieClip's location.
		 @usage
		 <code>
		 trace(LocationUtils.getDomain(_root));
		 </code>
		 @usageNote Function does not return folder path or file name. The method also treats "www" and sans "www" as the same; if "www" is present method does not return it.
		 */
		public static function getDomain(location:DisplayObject):String {
			var baseUrl:String = location.loaderInfo.url.split('://')[1].split('/')[0];
			return (baseUrl.substr(0, 4) == 'www.') ? baseUrl.substr(4) : baseUrl;
		}



		/**
		 Determines if the SWF is running in a browser plug-in.
CASA
		 @return Returns <code>true</code> if SWF is running in the Flash Player browser plug-in; otherwise <code>false</code>.
		 */
		public static function isPlugin():Boolean {
			return Capabilities.playerType == 'PlugIn' || Capabilities.playerType == 'ActiveX';
		}



		/**
		 Determines if the SWF is running in the IDE.
CASA
		 @return Returns <code>true</code> if SWF is running in the Flash Player version used by the external player or test movie mode; otherwise <code>false</code>.
		 */
		public static function isIde():Boolean {
			return Capabilities.playerType == 'External';
		}



		/**
		 Determines if the SWF is running in the StandAlone player.
CASA
		 @return Returns <code>true</code> if SWF is running in the Flash StandAlone Player; otherwise <code>false</code>.
		 */
		public static function isStandAlone():Boolean {
			return Capabilities.playerType == 'StandAlone';
		}



		/**
		 Determines if the runtime environment is an Air application.
CASA
		 @return Returns <code>true</code> if the runtime environment is an Air application; otherwise <code>false</code>.
		 */
		public static function isAirApplication():Boolean {
			return Capabilities.playerType == 'Desktop';
		}
	}
}
