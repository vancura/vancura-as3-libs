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

package org.vancura.vaclav.widgets.skin {
	import org.vancura.vaclav.widgets.constants.SkinType;
	import org.vancura.vaclav.widgets.interfaces.IButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabelButtonSkin;
	import org.vancura.vaclav.widgets.interfaces.ILabelSkin;

	public class LabelButtonSkin extends Skin implements ILabelButtonSkin {


		protected var _buttonSkin:IButtonSkin;
		protected var _labelOutSkin:ILabelSkin;
		protected var _labelHoverSkin:ILabelSkin;
		protected var _labelFocusSkin:ILabelSkin;



		public function LabelButtonSkin(id:String = null) {
			super(SkinType.LABEL_BUTTON, id);

			_buttonSkin = new ButtonSkin(id + '#button');
			_labelOutSkin = new LabelSkin(id + '#labelOut');
			_labelHoverSkin = new LabelSkin(id + '#labelHover');
			_labelFocusSkin = new LabelSkin(id + '#labelFocus');
		}



		//noinspection FunctionWithMoreThanThreeNegationsJS
		override public function parseConfig(source:Object):void {
			super.parseConfig(source);

			if(source.button != undefined) _buttonSkin.parseConfig(source.button);
			if(source.labelOut != undefined) _labelOutSkin.parseConfig(source.labelOut);
			if(source.labelHover != undefined) _labelHoverSkin.parseConfig(source.labelHover);
			if(source.labelFocus != undefined) _labelFocusSkin.parseConfig(source.labelFocus);
		}



		override public function revertConfig():void {
			super.revertConfig();

			_buttonSkin.revertConfig();
			_labelOutSkin.revertConfig();
			_labelHoverSkin.revertConfig();
			_labelFocusSkin.revertConfig();
		}



		public function get buttonSkin():IButtonSkin {
			return _buttonSkin;
		}



		public function set buttonSkin(source:IButtonSkin):void {
			_buttonSkin = source;
		}



		public function get labelOutSkin():ILabelSkin {
			return _labelOutSkin;
		}



		public function set labelOutSkin(source:ILabelSkin):void {
			_labelOutSkin = source;
		}



		public function get labelHoverSkin():ILabelSkin {
			return _labelHoverSkin;
		}



		public function set labelHoverSkin(source:ILabelSkin):void {
			_labelHoverSkin = source;
		}



		public function get labelFocusSkin():ILabelSkin {
			return _labelFocusSkin;
		}



		public function set labelFocusSkin(source:ILabelSkin):void {
			_labelFocusSkin = source;
		}
	}
}
