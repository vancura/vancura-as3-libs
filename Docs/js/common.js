

/*
TWiki Javascripts: copyright TWiki, Arthur Clemens
*/

var twiki;
if (!twiki) twiki = {};

/*
Contains:
Cookie Functions -- "Night of the Living Cookie" Version (25-Jul-96)
Written by:  Bill Dortch, hIdaho Design <bdortch@hidaho.com>
The following functions are released to the public domain.

Refactored for TWiki by Arthur Clemens 2006.
*/

/**
The preferred way for reading and writing cookies is using getPref and setPref, otherwise the limit of 20 cookies per domain is reached soon. See http://twiki.org/cgi-bin/view/TWiki/TWikiSettingsCookie.
*/

twiki.Pref = {
	
	TWIKI_PREF_COOKIE_NAME:"TWIKIPREF",
	/**
	Separates key-value pairs
	*/
	COOKIE_PREF_SEPARATOR:"|",
	/**
	Separates key from value
	*/
	COOKIE_PREF_VALUE_SEPARATOR:"=",
	/**
	By default expire one year from now.
	*/
	COOKIE_EXPIRY_TIME:365 * 24 * 60 * 60 * 1000,

	/**
	Writes a TWiki preference value. If the TWiki preference of given name already exists, a new value is written. If the preference name is new, a new preference is created.
	Characters '|' and '=' are reserved as separators.
	@param inPrefName : (String) name of the preference to write, for instance 'SHOWATTACHMENTS'
	@param inPrefValue : (String) stringified value to write, for instance '1'
	*/
	setPref:function(inPrefName, inPrefValue) {
		var prefName = twiki.Pref._getSafeString(inPrefName);
		var prefValue = (isNaN(inPrefValue)) ? twiki.Pref._getSafeString(inPrefValue) : inPrefValue;
		var cookieString = twiki.Pref._getPrefCookie();
		var prefs = cookieString.split(twiki.Pref.COOKIE_PREF_SEPARATOR);
		var index = twiki.Pref._getKeyValueLoc(prefs, prefName);
		if (index != -1) {
			// updating this entry is done by removing the existing entry from the array and then pushing the new key-value onto it
			prefs.splice(index, 1);
		}
		// else not found, so don't remove an existing entry
		var keyvalueString = prefName + twiki.Pref.COOKIE_PREF_VALUE_SEPARATOR + prefValue;
		prefs.push(keyvalueString);
		twiki.Pref._writePrefValues(prefs);
	},
	
	/**
	Reads the value of a preference.
	Characters '|' and '=' are reserved as separators.
	@param inPrefName (String): name of the preference to read, for instance 'SHOWATTACHMENTS'
	@return The value of the preference; an empty string when no value is found.
	*/
	getPref:function(inPrefName) {
		var prefName = twiki.Pref._getSafeString(inPrefName);
		return twiki.Pref.getPrefValueFromPrefList(prefName, twiki.Pref.getPrefList());
	},
	
	/**
	Reads the value of a preference from an array of key-value pairs. Use in conjunction with getPrefList() when you want to store the key-value pairs for successive look-ups.
	@param inPrefName (String): name of the preference to read, for instance 'SHOWATTACHMENTS'
	@param inPrefList (Array): list of key-value pairs, retrieved with getPrefList()
	@return The value of the preference; an empty string when no value is found.
	*/
	getPrefValueFromPrefList:function(inPrefName, inPrefList) {
		var keyvalue = twiki.Pref._getKeyValue(inPrefList, inPrefName);
		if (keyvalue != null) return keyvalue[1];
		return '';
	},
	
	/**
	Gets the list of all values set with setPref.
	@return An Array of key-value pair pref values; null if no value has been set before.
	*/
	getPrefList:function() {
		var cookieString = twiki.Pref._getPrefCookie();
		if (!cookieString) return null;
		return cookieString.split(twiki.Pref.COOKIE_PREF_SEPARATOR);
	},
	
	/**
	To write a TWiki preference cookie (TWIKIPREF), use twiki.Pref.setPref.
	
	Retrieves the value of the cookie specified by "name".
	@param inName : (String) identifier name of the cookie
	@return (String) the cookie value; null if no cookie with name inName has been set.
	*/
	getCookie:function(inName) {
		var arg = inName + "=";
		var alen = arg.length;
		var clen = document.cookie.length;
		var i = 0;
		while (i < clen) {
			var j = i + alen;
			if (document.cookie.substring(i, j) == arg) {
				return twiki.Pref._getCookieVal(j);
			}
			i = document.cookie.indexOf(" ", i) + 1;
			if (i == 0) break; 
		}
		return null;
	},
	
	/**
	Creates a new cookie or updates an existing cookie.
	@param inName : (String) identifier name of the cookie
	@param inValue : (String) stringified cookie value, for instance '1'
	@param inExpires : (Date) (optional) the expiration data of the cookie; if omitted or null, expires the cookie at the end of the current session
	@param inPath : (String) (optional) the path for which the cookie is valid; if omitted or null, uses the path of the current document
	@param inDomain : (String) (optional) the domain for which the cookie is valid; if omitted or null, uses the domain of the current document
	@param inUsesSecure : (Boolean) (optional) whether cookie transmission requires a secure channel (https)
	@use
	To call setCookie using name, value and path, write:
	<pre>
	twiki.Pref.setCookie ("myCookieName", "myCookieValue", null, "/");
	</pre>	
	To set a secure cookie for path "/myPath", that expires after the current session, write:
	<pre>
	twiki.Pref.setCookie ("myCookieName", "myCookieValue", null, "/myPath", null, true);
	</pre>
	*/
	setCookie:function(inName, inValue, inExpires, inPath, inDomain, inUsesSecure) {
		var cookieString = inName + "=" + escape (inValue) +
			((inExpires) ? "; expires=" + inExpires.toGMTString() : "") +
			((inPath) ? "; path=" + inPath : "") +
			((inDomain) ? "; domain=" + inDomain : "") +
			((inUsesSecure) ? "; secure" : "");
		document.cookie = cookieString;
	},
	
	/**
	Function to delete a cookie. (Sets expiration date to start of epoch)
	@param inName : (String) identifier name of the cookie
	@param inPath : (String) The path for which the cookie is valid. This MUST be the same as the path used to create the cookie, or null/omitted if no path was specified when creating the cookie.
	@param inDomain : (String) The domain for which the cookie is valid. This MUST be the same as the domain used to create the cookie, or null/omitted if no domain was specified when creating the cookie.
	*/
	deleteCookie:function(inName, inPath, inDomain) {
		if (twiki.Pref.getCookie(inName)) {
			document.cookie = inName + "=" + ((inPath) ? "; path=" + inPath : "") + ((inDomain) ? "; domain=" + inDomain : "") + "; expires=Thu, 01-Jan-70 00:00:01 GMT";
		}
	},
	
	/* PRIVILIGED METHODS */
	
	/**
	Finds a key-value pair in an array.
	@param inKeyValues: (Array) the array to iterate
	@param inKey: (String) the key to find in the array
	@return The first occurrence of a key-value pair, where key == inKey; null if none is found.
	*/
	_getKeyValue:function(inKeyValues, inKey) {
		if (!inKeyValues) return null;
		var i = inKeyValues.length;
		while (i--) {
			var keyvalue = inKeyValues[i].split(twiki.Pref.COOKIE_PREF_VALUE_SEPARATOR);
			if (keyvalue[0] == inKey) return keyvalue;	
		}
		return null;
	},
	
	/**
	Finds the location of a key-value pair in an array.
	@param inKeyValues: (Array) the array to iterate
	@param inKey: (String) the key to find in the array
	@return The location of the first occurrence of a key-value tuple, where key == inKey; -1 if none is found.
	*/
	_getKeyValueLoc:function(inKeyValues, inKey) {
		if (!inKeyValues) return null;
		var i = inKeyValues.length;
		while (i--) {
			var keyvalue = inKeyValues[i].split(twiki.Pref.COOKIE_PREF_VALUE_SEPARATOR);
			if (keyvalue[0] == inKey) return i;	
		}
		return -1;
	},
	
	/**
	Writes a cookie with the stringified array values of inValues.
	@param inValues: (Array) an array with key-value tuples
	*/
	_writePrefValues:function(inValues) {
		var cookieString = (inValues != null) ? inValues.join(twiki.Pref.COOKIE_PREF_SEPARATOR) : '';
		var expiryDate = new Date ();
		twiki.Pref._fixCookieDate (expiryDate); // Correct for Mac date bug - call only once for given Date object!
		expiryDate.setTime (expiryDate.getTime() + twiki.Pref.COOKIE_EXPIRY_TIME);
		twiki.Pref.setCookie(twiki.Pref.TWIKI_PREF_COOKIE_NAME, cookieString, expiryDate, '/');
	},
	
	/**
	Gets the TWiki pref cookie; creates a new cookie if it does not exist.
	@return The TWiki pref cookie.
	*/
	_getPrefCookie:function() {
		var cookieString = twiki.Pref.getCookie(twiki.Pref.TWIKI_PREF_COOKIE_NAME);
		if (cookieString == undefined) {
			cookieString = "";
		}
		return cookieString;
	},
	
	/**
	Strips reserved characters '|' and '=' from the input string.
	@return The stripped string.
	*/
	_getSafeString:function(inString) {
		var regex = new RegExp(/[|=]/);
		return inString.replace(regex, "");
	},
	
	/**
	Retrieves the decoded value of a cookie.
	@param inOffset : (Number) location of value in full cookie string.
	*/
	_getCookieVal:function(inOffset) {
		var endstr = document.cookie.indexOf (";", inOffset);
		if (endstr == -1) {
			endstr = document.cookie.length;
		}
		return unescape(document.cookie.substring(inOffset, endstr));
	},
	
	/**
	Function to correct for 2.x Mac date bug.  Call this function to
	fix a date object prior to passing it to setCookie.
	IMPORTANT:  This function should only be called *once* for
	any given date object!  See example at the end of this document.
	*/
	_fixCookieDate:function(inDate) {
		var base = new Date(0);
		var skew = base.getTime(); // dawn of (Unix) time - should be 0
		if (skew > 0) {	// Except on the Mac - ahead of its time
			inDate.setTime(inDate.getTime() - skew);
		}
	}
}

/**
Singleton class.
*/
var twiki;
if (!twiki) twiki = {};
twiki.JQueryTwistyPlugin = new function () {

	var self = this;

	/**
	Retrieves the name of the twisty from an HTML element id. For example 'demotoggle' will return 'demo'.
	@param inId : (String) HTML element id
	@return String
	@privileged
	*/
	this._getName = function (e) {
		var re = new RegExp("(.*)(hide|show|toggle)", "g");
                var inId = $(e).attr('id');
		var m = re.exec(inId);
		var name = (m && m[1]) ? m[1] : "";
    	return name;
	}
	
	/**
	Retrieves the type of the twisty from an HTML element id. For example 'demotoggle' will return 'toggle'.
	@param inId : (String) HTML element id
	@return String
	@privileged
	*/
	this._getType = function (inId) {
		var re = new RegExp("(.*)(hide|show|toggle)", "g");
		var m = re.exec(inId);
    	var type = (m && m[2]) ? m[2] : "";
    	return type;
	}
	
	/**
	Toggles the collapsed state. Calls _update().
	@privileged
	*/
	this._toggleTwisty = function (ref) {
		if (!ref) return;
		ref.state = (ref.state == twiki.JQueryTwistyPlugin.CONTENT_HIDDEN) ? twiki.JQueryTwistyPlugin.CONTENT_SHOWN : twiki.JQueryTwistyPlugin.CONTENT_HIDDEN;
		self._update(ref, true);
	}
	
	/**
	Updates the states of UI trinity 'show', 'hide' and 'content'.
	Saves new state in a cookie if one of the elements has CSS class 'twistyRememberSetting'.
	@param ref : (Object) twiki.JQueryTwistyPlugin.Storage object
	@privileged
	*/
	this._update = function (ref, inMaySave) {
		var showControl = ref.show;
		var hideControl = ref.hide;
		var contentElem = ref.toggle;
		if (ref.state == twiki.JQueryTwistyPlugin.CONTENT_SHOWN) {
			// show content
                        if (inMaySave) {
                          $(contentElem).show();
                        } else {
                          $(contentElem).show();

                        }
                        $(showControl).addClass("twistyHidden");
                        $(hideControl).removeClass("twistyHidden");
                        $(contentElem).removeClass("twistyHidden");
		} else {
			// hide content
                        if (inMaySave) {
                          $(contentElem).hide();
                        } else {
                          $(contentElem).hide();
                        }
                        $(showControl).removeClass("twistyHidden");
                        $(hideControl).addClass("twistyHidden");
                        $(contentElem).addClass("twistyHidden");
		}
		if (inMaySave && ref.saveSetting) {
	        twiki.Pref.setPref(twiki.JQueryTwistyPlugin.COOKIE_PREFIX + ref.name, ref.state);
		}
		if (ref.clearSetting) {
	        twiki.Pref.setPref(twiki.JQueryTwistyPlugin.COOKIE_PREFIX + ref.name, "");
		}
	}
	
	/**
	Stores a twisty HTML element (either show control, hide control or content 'toggle').
	@param e : (Object) HTMLElement
	@privileged
	*/
	this._register = function (e) {
		if (!e) return;
		var name = self._getName(e);
		var ref = self._storage[name];
		if (!ref) {
			ref = new twiki.JQueryTwistyPlugin.Storage();
		}
                var classValue = $(e).attr('class');
		if (classValue.match(/\btwistyRememberSetting\b/)) 
                  ref.saveSetting = true;
		if (classValue.match(/\btwistyForgetSetting\b/)) 
                  ref.clearSetting = true;
		if (classValue.match(/\btwistyStartShow\b/)) 
                  ref.startShown = true;
		if (classValue.match(/\btwistyStartHide\b/)) 
                  ref.startHidden = true;
		if (classValue.match(/\btwistyFirstStartShow\b/)) 
                  ref.firstStartShown = true;
		if (classValue.match(/\btwistyFirstStartHide\b/)) 
                  ref.firstStartHidden = true;

		ref.name = name;
		var type = self._getType(e.id);
		ref[type] = e;
		self._storage[name] = ref;
		switch (type) {
			case 'show': // fall through
			case 'hide':
				e.onclick = function() {
					self._toggleTwisty(ref);
					return false;
				}
				break;
		}
		return ref;
	}
	
	/**
	Key-value set of twiki.JQueryTwistyPlugin.Storage objects. The value is accessed by twisty id identifier name.
	@example var ref = self._storage["demo"];
	@privileged
	*/
	this._storage = {};
};

/**
Public constants.
*/
twiki.JQueryTwistyPlugin.CONTENT_HIDDEN = 0;
twiki.JQueryTwistyPlugin.CONTENT_SHOWN = 1;
twiki.JQueryTwistyPlugin.COOKIE_PREFIX = "JQueryTwistyPlugin_";

/**
The cached full TWiki cookie string so the data has to be read only once during init.
*/
twiki.JQueryTwistyPlugin.prefList;

/**
Initializes a twisty HTML element (either show control, hide control or content 'toggle') by registering and setting the visible state.
Calls _register() and _update().
@public
@param inId : (String) id of HTMLElement
@return The stored twiki.JQueryTwistyPlugin.Storage object.
*/
twiki.JQueryTwistyPlugin.initId = function(inId) {
	//twiki.JQueryTwistyPlugin.init(document.getElementById(inId));
}

twiki.JQueryTwistyPlugin.init = function(e) {
	if (!e) return;
	// check if already inited
        var name = this._getName(e);
	var ref = this._storage[name];
	if (ref && ref.show && ref.hide && ref.toggle) return ref;

	// else register
	ref = this._register(e);
	
	if (ref.show && ref.hide && ref.toggle) {
		// all Twisty elements present

         var classValue = $(e).attr('class');
		if (classValue.match(/\btwistyInited1\b/)) {
			ref.state = twiki.JQueryTwistyPlugin.CONTENT_SHOWN
			this._update(ref, false);
			return ref;
		}
		if (classValue.match(/\btwistyInited0\b/)) {
			ref.state = twiki.JQueryTwistyPlugin.CONTENT_HIDDEN
			this._update(ref, false);
			return ref;
		}

		if (twiki.JQueryTwistyPlugin.prefList == null) {
			// cache complete cookie string
			twiki.JQueryTwistyPlugin.prefList = twiki.Pref.getPrefList();
		}
		var cookie = twiki.Pref.getPrefValueFromPrefList(twiki.JQueryTwistyPlugin.COOKIE_PREFIX + ref.name, twiki.JQueryTwistyPlugin.prefList);
		if (ref.firstStartHidden) ref.state = twiki.JQueryTwistyPlugin.CONTENT_HIDDEN;
		if (ref.firstStartShown) ref.state = twiki.JQueryTwistyPlugin.CONTENT_SHOWN;
		// cookie setting may override  firstStartHidden and firstStartShown
		if (cookie && cookie == "0") ref.state = twiki.JQueryTwistyPlugin.CONTENT_HIDDEN;
		if (cookie && cookie == "1") ref.state = twiki.JQueryTwistyPlugin.CONTENT_SHOWN;
		// startHidden and startShown may override cookie
		if (ref.startHidden) ref.state = twiki.JQueryTwistyPlugin.CONTENT_HIDDEN;
		if (ref.startShown) ref.state = twiki.JQueryTwistyPlugin.CONTENT_SHOWN;

		this._update(ref, false);
	}
	return ref;	
}

twiki.JQueryTwistyPlugin.toggleAll = function(inState) {
	var i;
	for (var i in this._storage) {
		var e = this._storage[i];
		e.state = inState;
		this._update(e, true);
	}
}

/**
Storage container for properties of a twisty HTML element: show control, hide control or toggle content.
*/
twiki.JQueryTwistyPlugin.Storage = function () {
	this.name;										// String
	this.state = twiki.JQueryTwistyPlugin.CONTENT_HIDDEN;	// Number
	this.hide;										// HTMLElement
	this.show;										// HTMLElement
	this.toggle;									// HTMLElement (content element)
	this.saveSetting = false;						// Boolean; default not saved
	this.clearSetting = false;						// Boolean; default not cleared
	this.startShown;								// Boolean
	this.startHidden;								// Boolean
	this.firstStartShown;							// Boolean
	this.firstStartHidden;							// Boolean
}

/**
 * jquery init 
 */
$(function() {
  $(".twistyTrigger, .twistyContent").
    removeClass("twistyMakeHidden twikiMakeHidden twikiMakeVisible twikiMakeVisibleBlock twikiMakeVisibleInline").
    addClass("twistyHidden").
    each(function() {
      twiki.JQueryTwistyPlugin.init(this);
    });
  $(".twistyExpandAll").click(function() {
    twiki.JQueryTwistyPlugin.toggleAll(twiki.JQueryTwistyPlugin.CONTENT_SHOWN);
  });
  $(".twistyCollapseAll").click(function() {
    twiki.JQueryTwistyPlugin.toggleAll(twiki.JQueryTwistyPlugin.CONTENT_HIDDEN);
  });
});
