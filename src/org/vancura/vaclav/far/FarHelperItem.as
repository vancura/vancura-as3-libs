package org.vancura.vaclav.far {
	import org.vancura.vaclav.far.events.FarHelperAssignEvent;
	import org.vancura.vaclav.far.events.FarHelperEvent;
	import org.vancura.vaclav.far.events.FarHelperProgressEvent;
	import org.vanrijkom.far.FarItem;
	import org.vanrijkom.far.FarStream;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	
	
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

		
		
		public function FarHelperItem(stream:FarStream) {
			_stream = stream;
			_getSpriteLoader = new Loader();
			_assignChildSpriteLoader = new Loader();
			_assignBitmapLoader = new Loader();
			
			_getSpriteLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onGetSpriteDone, false, 0, true);
			_assignChildSpriteLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onAssignChildSpriteDone, false, 0, true);			_assignBitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onAssignBitmapDone, false, 0, true);
		}

		
		
		public function destroy():void {
			_removeItemEvents();
			
			_getSpriteLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onGetSpriteDone);
			_assignChildSpriteLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onAssignChildSpriteDone);			_assignBitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onAssignBitmapDone);
		}
		
		
		
		public function getData(index:String):void {
			_index = index;
			
			if(_farItem == null) {
				try {
					_farItem = _stream.item(_index);
				}
				catch(err:Error) {
					dispatchEvent(new FarHelperEvent(FarHelperEvent.ITEM_NOT_FOUND, false, false, null, _index));
					return;
				}
				
				if(!_farItem.loaded) {
					_farItem.addEventListener(Event.COMPLETE, _onItemLoadComplete, false, 0, true);
					_farItem.addEventListener(ProgressEvent.PROGRESS, _onItemLoadProgress, false, 0, true);
					_farItem.addEventListener(IOErrorEvent.IO_ERROR, _onItemLoadIOError, false, 0, true);
				}
				else {
					_itemLoadComplete();
				}
			}
			
			else {
				if(_farItem.loaded) {
					_itemLoadComplete();
				}
			}
		}

		
		
		public function assignBitmap(output:Bitmap):void {
			_assignBitmapOutput = output;
			_assignBitmapLoader.loadBytes(_stream.item(_index).data);
		}

		
		
		public function assignChildSprite(output:Sprite):void {
			_assignChildSpriteOutput = output;
			_assignChildSpriteLoader.loadBytes(_stream.item(_index).data);
		}

		
		
		public function getSprite():void {
			_getSpriteLoader.loadBytes(_stream.item(_index).data);
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
			
			dispatchEvent(new FarHelperEvent(FarHelperEvent.ITEM_LOAD_COMPLETE, false, false, this));
			dispatchEvent(new Event(Event.COMPLETE));
		}

		
		
		private function _onItemLoadIOError(event:IOErrorEvent):void {
			_removeItemEvents();
			
			dispatchEvent(new FarHelperEvent(FarHelperEvent.ITEM_LOAD_FAILED, false, false, this, event.text));
			dispatchEvent(event.clone());
		}

		
		
		private function _onItemLoadProgress(event:ProgressEvent):void {
			var p:Number = 1 / (event.bytesTotal / event.bytesLoaded);
			
			dispatchEvent(new FarHelperProgressEvent(FarHelperProgressEvent.ITEM_LOAD_PROGRESS, false, false, this, p));
			dispatchEvent(event.clone());
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
				
			dispatchEvent(new FarHelperAssignEvent(FarHelperAssignEvent.ITEM_READY, false, false, this, displayObject));
		}
		
		
		
		private function _onAssignChildSpriteDone(event:Event):void {
			var displayObject:Sprite = _assignChildSpriteLoader.content as Sprite;
			
			_assignChildSpriteOutput.addChildAt(displayObject, 0);
				
			dispatchEvent(new FarHelperAssignEvent(FarHelperAssignEvent.ITEM_READY, false, false, this, displayObject));
		}

		
		
		private function _onAssignBitmapDone(event:Event):void {
			_assignBitmapOutput.bitmapData = (_assignBitmapLoader.content as Bitmap).bitmapData;
				
			dispatchEvent(new FarHelperAssignEvent(FarHelperAssignEvent.ITEM_READY, false, false, this, _assignBitmapOutput));
		}
	}
}
