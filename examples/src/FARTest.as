/***********************************************************************************************************************
 * Copyright (c) 2009. Vaclav Vancura.
 * Contact me at vaclav@vancura.org or see my homepage at vaclav.vancura.org
 * Project's GIT repo: http://github.com/vancura/vancura-as3-libs
 * Documentation: http://doc.vaclav.vancura.org/vancura-as3-libs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions
 * of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 **********************************************************************************************************************/

package {
	import br.com.stimuli.string.printf;

	import com.greensock.TweenNano;

	import org.vancura.vaclav.core.Stats;
	import org.vancura.vaclav.far.FarHelper;
	import org.vancura.vaclav.far.FarHelperItem;
	import org.vancura.vaclav.far.events.FarHelperEvent;
	import org.vancura.vaclav.widgets.constants.DebugLevel;
	import org.vancura.vaclav.widgets.events.ButtonEvent;
	import org.vancura.vaclav.assets.providers.SWFLibraryProvider;
	import org.vancura.vaclav.widgets.globals.SkinManager;
	import org.vancura.vaclav.widgets.skin.LabelButtonSkin;
	import org.vancura.vaclav.widgets.widgets.LabelButton;

	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;

	[SWF(width="1000",height="400",frameRate="60",backgroundColor="#FFFFFF")]



	public class FARTest extends MovieClip {



		private var _buttonTest:LabelButton;
		private var _skinManager:SkinManager;
		private var _skin:LabelButtonSkin;
		private var _stressRemove:int;
		private var _stressList:Array = new Array();
		private var _farHelper:FarHelper;



		public function FARTest() {
			SkinManager.debugLevel = DebugLevel.HOVER;
			SkinManager.debugColor = 0x123456;

			var skinProvider:SWFLibraryProvider;

			try {
				skinProvider = new SWFLibraryProvider('test-skin.swf', null, null, true);
//				skinProvider.addEventListener(Event.COMPLETE, _onSkinComplete, false, 0, true);
//				skinProvider.addEventListener(ErrorEvent.ERROR, _onSkinError, false, 0, true);

//				_skinManager.attach(skinProvider);
			}
			catch(err:Error) {
				trace(printf('Skin could not be attached (%s)', err.message));
				return;
			}




			_farHelper = new FarHelper();
			_farHelper.addEventListener(FarHelperEvent.STREAM_IO_ERROR, _onFarIOError, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.STREAM_SECURITY_ERROR, _onFarSecurityError, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_NOT_FOUND, _onItemNotFound, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_LOAD_COMPLETE, _onItemLoadComplete, false, 0, true);
			_farHelper.addEventListener(FarHelperEvent.ITEM_LOAD_FAILED, _onItemLoadFailed, false, 0, true);
			_farHelper.load('test-skin.far');
		}



		private function _onSkinError(event:ErrorEvent):void {
			trace(printf('Error: %s', event.text));
		}



		private function _onSkinComplete(event:Event):void {
			trace('Skin loaded');
//			trace(_skinManager.toString());

			// --------
//			var skin:LabelButtonSkin = _skinManager.getSkin('label_button');

//			_buttonTest = new LabelButton(skin, {x:10, y:100, width:200}, 'Lorem ipsum', this);

//			_buttonTest.addEventListener(ButtonEvent.RELEASE_INSIDE, _onTest);

			// --------
			var stats:Stats = new Stats();
			addChild(stats);
		}



		private function _onTest(event:ButtonEvent):void {
//			_skin = _skinManager.getSkin('label_button');
			_stressRemove = -50;

			_buttonTest.morph({width:400, morphDuration:2});
			_stressTest();
		}



		private function _stressTest():void {
			var mw:int = Math.random() * 200;
			var mh:int = Math.random() * 200;
			var mx:int = Math.random() * (stage.stageWidth - mw);
			var my:int = Math.random() * (stage.stageHeight - mh);
			var newBtn:LabelButton = new LabelButton(_skin, {x:mx, y:my, width:mw, height:mh}, 'Lorem ipsum', this);

			_stressList.push(newBtn);
			_stressRemove++;

			var oldBtn:LabelButton = _stressList[_stressRemove] as LabelButton;
			if(oldBtn != null) {
				oldBtn.destroy();
				removeChild(oldBtn);
			}
			_stressList[_stressRemove] = null;

			TweenNano.delayedCall(.001, _stressTest);
		}



		private function _onFarSecurityError(event:FarHelperEvent):void {
//			sendNotification(ApplicationFacade.SYSTEM_FAILED, printf('Security error loading map FAR: %s', event.text));
		}



		private function _onFarIOError(event:FarHelperEvent):void {
//			sendNotification(ApplicationFacade.SYSTEM_FAILED, printf('IO error loading map FAR: %s', event.text));
		}



		private function _onItemNotFound(event:FarHelperEvent):void {
			trace(printf('Map item "%s" not found', event.helperItem.index));
		}



		private function _onItemLoadFailed(event:FarHelperEvent):void {
			trace(printf('Map item "%s" loading failed (%s)', event.helperItem.index, event.text));
		}



		private function _onItemLoadComplete(event:FarHelperEvent):void {
			trace('SLAPE');

			var itemHelper:FarHelperItem = event.helperItem as FarHelperItem;

//			if(itemHelper.index == _CONFIG_XML) {
//				var configXML:XML = new XML(itemHelper.farItem.data);
//				var blockCounter:uint = 0;
//				var segmentCounter:uint = 0;
//
//				_segmentStepX = configXML.segments.@step_x;
//				_segmentStepY = configXML.segments.@step_y;
//				_segmentOffsX = configXML.segments.@offs_x;
//				_segmentOffsY = configXML.segments.@offs_y;
//				_blockStepX = configXML.blocks.@step_x;
//				_blockStepY = configXML.blocks.@step_y;
//				_blockOffsX = configXML.blocks.@offs_x;
//				_blockOffsY = configXML.blocks.@offs_y;
//
//				for each(var segmentConfig:XML in configXML.segments.segment) {
//					var index:String = segmentConfig.@index;
//					var x:int = segmentConfig.@x;
//					var y:int = segmentConfig.@y;
//					var zIndex:int = segmentConfig.@z_index;
//					var segmentData:SegmentDataVO = new SegmentDataVO(index, x, y, zIndex);
//
//					sendNotification(ApplicationFacade.ADD_SEGMENT_COMMAND, segmentData);
//
//					segmentCounter++;
//				}
//
//				for each(var blockConfig:XML in configXML.blocks.block) {
//					var idx:int = blockConfig.@idx;
//					var town:String = blockConfig.@town;
//					var modalAction:String = blockConfig.modal.@action;
//					var blockX:int = blockConfig.block.@x;
//					var blockY:int = blockConfig.block.@y;
//					var avatarX:int = blockConfig.avatar.@x;
//					var avatarY:int = blockConfig.avatar.@y;
//					var avatarDir:int = blockConfig.avatar.@dir;
//					var segmentArea:Array = blockConfig.segment.@area.split(',');
//					var infoX:int = blockConfig.info.@x;
//					var infoY:int = blockConfig.info.@y;
//					var staticInfoLevels:Array = _getBlockLevels(blockConfig.levels);
//					var blockData:BlockDataVO = new BlockDataVO(idx, town, modalAction, blockX, blockY, avatarX, avatarY, avatarDir, segmentArea, infoX, infoY, staticInfoLevels);
//
//					sendNotification(ApplicationFacade.ADD_BLOCK_COMMAND, blockData);
//
//					blockCounter++;
//				}
//
//				Logger.debug(printf('Initialized %d map segments and %d blocks', segmentCounter, blockCounter));
//
//				sendNotification(ApplicationFacade.FINISH_SEGMENTS_ATTACHMENT_COMMAND);
//
//				// invoke map refresh command
//				sendNotification(ApplicationFacade.REFRESH_MAP_COMMAND);
//			}
//
//			if(itemHelper.index == _MASK_SWF) {
//				TweenMax.delayedCall(.05, function():void {
//					itemHelper.addEventListener(FarHelperAssignEvent.ITEM_READY, _onMaskAssigned, false, 0, true);
//					itemHelper.getSprite();
//				});
//			}
		}
	}
}
