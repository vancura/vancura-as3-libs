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

package org.vancura.vaclav.far {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;

	import org.vancura.vaclav.far.events.FarHelperAssignEvent;
	import org.vancura.vaclav.far.events.FarHelperEvent;
	import org.vancura.vaclav.far.events.FarHelperProgressEvent;
	import org.vanrijkom.far.FarItem;
	import org.vanrijkom.far.FarStream;

	/**
	 * FAR helper item.
	 *
	 * @author Vaclav Vancura (http://vaclav.vancura.org)
	 */
	public class FarHelperItem extends EventDispatcher {


		private var _index:String;
		private var _stream:FarStream;
		private var _farItem:FarItem;
		private var _getSpriteLoader:Loader;
		private var _assignChildSpriteLoader:Loader;
		private var _assignChildSpriteOutput:Sprite;
		private var _assignBitmapLoader:Loader;
		private var _assignBitmapOutput:Bitmap;
		private var _isLoaded:Boolean;



		/**
		 * Constructor.
		 *
		 * @param stream FAR stream
		 */
		public function FarHelperItem(stream:FarStream) {
			// attach the stream
			_stream = stream;

			// create loaders
			_getSpriteLoader = new Loader();
			_assignChildSpriteLoader = new Loader();
			_assignBitmapLoader = new Loader();

			// add event listeners
			_getSpriteLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onGetSpriteDone, false, 0, true);
			_assignChildSpriteLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onAssignChildSpriteDone, false, 0, true);
			_assignBitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onAssignBitmapDone, false, 0, true);
		}



		/**
		 * Destructor.
		 */
		public function destroy():void {
			_removeItemEvents();

			_getSpriteLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onGetSpriteDone);
			_assignChildSpriteLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onAssignChildSpriteDone);
			_assignBitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onAssignBitmapDone);
		}



		/**
		 * Get data from the FAR.
		 *
		 * @param index
		 */
		//noinspection FunctionWithMultipleReturnPointsJS
		public function getData(index:String):void {
			_index = index;

			if(_farItem == null) {
				//noinspection UnusedCatchParameterJS
				try {
					_farItem = _stream.item(_index);
				}
				catch(err:Error) {
					var e:FarHelperEvent = new FarHelperEvent(FarHelperEvent.ITEM_NOT_FOUND, false, false, null, _index);
					dispatchEvent(e);
					return;
				}

				if(_farItem.loaded) {
					_itemLoadComplete();
				}
				else {
					_farItem.addEventListener(Event.COMPLETE, _onItemLoadComplete, false, 0, true);
					_farItem.addEventListener(ProgressEvent.PROGRESS, _onItemLoadProgress, false, 0, true);
					_farItem.addEventListener(IOErrorEvent.IO_ERROR, _onItemLoadIOError, false, 0, true);
				}
			}

			else {
				if(_farItem.loaded) {
					_itemLoadComplete();
				}
			}
		}



		public function assignBitmap(output:Bitmap):void {
			var b:ByteArray = _stream.item(_index).data;

			_assignBitmapOutput = output;
			_assignBitmapLoader.loadBytes(b);
		}



		public function assignChildSprite(output:Sprite):void {
			var b:ByteArray = _stream.item(_index).data;

			_assignChildSpriteOutput = output;
			_assignChildSpriteLoader.loadBytes(b);
		}



		public function getSprite():void {
			var b:ByteArray = _stream.item(_index).data;

			_getSpriteLoader.loadBytes(b);
		}



		public function get index():String {
			return _index;
		}



		public function get farItem():FarItem {
			return _farItem;
		}



		public function get isLoaded():Boolean {
			return _isLoaded;
		}



		private function _itemLoadComplete():void {
			_removeItemEvents();
			_isLoaded = true;

			var e1:FarHelperEvent = new FarHelperEvent(FarHelperEvent.ITEM_LOAD_COMPLETE, false, false, this);
			var e2:Event = new Event(Event.COMPLETE);

			dispatchEvent(e1);
			dispatchEvent(e2);
		}



		private function _onItemLoadIOError(event:IOErrorEvent):void {
			_removeItemEvents();

			var e1:FarHelperEvent = new FarHelperEvent(FarHelperEvent.ITEM_LOAD_FAILED, false, false, this, event.text);
			var e2:Event = event.clone();

			dispatchEvent(e1);
			dispatchEvent(e2);
		}



		private function _onItemLoadProgress(event:ProgressEvent):void {
			var p:Number = 1 / (event.bytesTotal / event.bytesLoaded);

			var e1:FarHelperProgressEvent = new FarHelperProgressEvent(FarHelperProgressEvent.ITEM_LOAD_PROGRESS, false, false, this, p);
			var e2:Event = event.clone();

			dispatchEvent(e1);
			dispatchEvent(e2);
		}



		private function _onItemLoadComplete(event:Event):void {
			_itemLoadComplete();
		}



		private function _removeItemEvents():void {
			_farItem.removeEventListener(Event.COMPLETE, _onItemLoadComplete);
			_farItem.removeEventListener(ProgressEvent.PROGRESS, _onItemLoadProgress);
			_farItem.removeEventListener(IOErrorEvent.IO_ERROR, _onItemLoadIOError);
		}



		private function _onGetSpriteDone(event:Event):void {
			var displayObject:Sprite = _getSpriteLoader.content as Sprite;
			var e:FarHelperAssignEvent = new FarHelperAssignEvent(FarHelperAssignEvent.ITEM_READY, false, false, this, displayObject);

			dispatchEvent(e);
		}



		private function _onAssignChildSpriteDone(event:Event):void {
			var displayObject:Sprite = _assignChildSpriteLoader.content as Sprite;
			var e:FarHelperAssignEvent = new FarHelperAssignEvent(FarHelperAssignEvent.ITEM_READY, false, false, this, displayObject);

			_assignChildSpriteOutput.addChildAt(displayObject, 0);

			dispatchEvent(e);
		}



		private function _onAssignBitmapDone(event:Event):void {
			var e:FarHelperAssignEvent = new FarHelperAssignEvent(FarHelperAssignEvent.ITEM_READY, false, false, this, _assignBitmapOutput);

			_assignBitmapOutput.bitmapData = (_assignBitmapLoader.content as Bitmap).bitmapData;

			dispatchEvent(e);
		}
	}
}
