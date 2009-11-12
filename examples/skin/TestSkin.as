package skin {
	import flash.display.MovieClip;
	import flash.filters.DropShadowFilter;

	
	
	public class TestSkin extends MovieClip {



		public function getSkinConfig():Object {
			return {
				debugLevel:'none', debugColor:0x6789ab,
				skins:[
					{id:'h1_label', type:'label', font:'helvetica_neue_bold', size:25, sharpness:0, thickness:0, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingTop:40, paddingLeft:47, paddingBottom:24},

					{id:'h2_label', type:'label', font:'helvetica_neue_bold', size:15, sharpness:0, thickness:0, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:48, paddingRight:48},

					{id:'h3_label', type:'label', font:'helvetica_neue_bold', size:13, sharpness:0, thickness:0, color:0x0572a6, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:48, paddingRight:48},

					{id:'h2_label_centered', type:'label', font:'helvetica_neue_bold', hAlign:'center', size:15, sharpness:0, thickness:0, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)]},

					{id:'h3_label_centered', type:'label', font:'helvetica_neue_bold', hAlign:'center', size:13, sharpness:0, thickness:0, color:0x0572a6, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)]},

					{id:'form_label', type:'label', font:'helvetica_neue_bold', size:13, sharpness:0, thickness:0, color:0x0572a6, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:48, paddingRight:48},
					
					{id:'checkbox_label', type:'label', font:'helvetica_neue_bold', size:12, sharpness:-30, thickness:100, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingTop:-2},
					
					{id:'label_button', type:'label_button', button:{symbol:'Button'}, label:{
						font:'helvetica_neue_bold', size:12, sharpness:-30, thickness:100, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingTop:-4}
					},
					
					{id:'label_dropdown', type:'label_button', button:{symbol:'Dropdown'}, label:{
						font:'helvetica_neue_bold', size:12, sharpness:-30, thickness:100, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingTop:-4}
					},
					
					{id:'label_blutton', type:'label_button', button:{symbol:'Blutton'}, label:{
						font:'helvetica_neue_bold', size:12, sharpness:0, thickness:0, color:0xFFFFFF, filters:[new DropShadowFilter(1, 45, 0x000000, .8, 0, 0)], paddingTop:-6}
					},
					
					{id:'label_blackdown', type:'label_button', button:{symbol:'Blackdown'}, label:{
						font:'helvetica_neue_bold', size:12, sharpness:0, thickness:0, color:0xFFFFFF, filters:[new DropShadowFilter(1, 45, 0x000000, .8, 0, 0)], paddingTop:-6}
					},
					
					{id:'check_button', type:'check_button', buttonOff:{
						symbol:'CheckButtonOff'
					}, buttonOn:{
						symbol:'CheckButtonOn'
					}},
					
					{id:'input_bar', type:'input_bar', bar:{
						symbol:'InputBar'
					}, label:{
						font:'helvetica_neue_bold', size:11, sharpness:-30, thickness:100, color:0x161616, paddingTop:2, paddingLeft:3, paddingRight:3
					}},
					
					{id:'scroll_box_back_bar', type:'bar', symbol:'ScrollBoxBackBar'},
					
					{id:'scroll_roll_back_bar', type:'bar', symbol:'ScrollRollBackBar'},
					
					{id:'scroll_box_row_button', type:'button', symbol:'ScrollBoxRowButton', hoveredInDuration:0, hoveredOutDuration:0},
					
					{id:'scroll_box_row_selected_bar', type:'bar', symbol:'ScrollBoxRowSelectedBar'},
					
					{id:'scroll_box_header_label', type:'label', font:'helvetica_neue_roman', size:11, sharpness:-30, thickness:100, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .3, 0, 0)], paddingTop:2, paddingLeft:3},
					
					{id:'scroll_box_row_label', type:'label', font:'helvetica_neue_bold', size:12, sharpness:-30, thickness:100, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:2, paddingRight:2, paddingBottom:9, paddingTop:2},
					
					{id:'scroll_box_row_label_centered', type:'label', font:'helvetica_neue_bold', hAlign:'center', size:12, sharpness:-30, thickness:100, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:2, paddingRight:2, paddingBottom:9, paddingTop:2},
					
					{id:'scroll_thumb_button', type:'button', symbol:'ScrollThumbButton'},
				
					{id:'welcome_logo_image', type:'image', symbol:'WelcomeLogoImage', paddingTop:-197},
					
					{id:'welcome_back_image', type:'image', symbol:'WelcomeBackImage'},
					
					{id:'welcome_div_image', type:'image', symbol:'WelcomeDivImage'},
					
					{id:'new_aid_dialog_back_image', type:'image', symbol:'NewAidDialogBackImage'},
					
					{id:'review_aid_dialog_back_image', type:'image', symbol:'ReviewAidDialogBackImage'},
					
					{id:'questions_dialog_back_image', type:'image', symbol:'QuestionsDialogBackImage'},
					
					{id:'editor_logo_image', type:'image', symbol:'EditorLogoImage'},
					
					{id:'editor_panel_back_bar', type:'bar', symbol:'EditorPanelBackBar'},
					
					{id:'editor_panel_title_label', type:'label', font:'helvetica_neue_bold', size:15, sharpness:0, thickness:0, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:16, paddingTop:15, paddingRight:16},
					
					{id:'editor_panel_body_label', type:'label', font:'helvetica_neue_roman', size:10, sharpness:-30, thickness:100, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:17, paddingRight:17, paddingTop:5, paddingBottom:5},
					
					{id:'editor_panel_h3_label', type:'label', font:'helvetica_neue_bold', size:11, sharpness:0, thickness:0, color:0x0572a6, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:17, paddingRight:17, paddingTop:4},
					
					{id:'editor_page_back_image', type:'image', symbol:'EditorPagerBackImage'},
					
					{id:'editor_pager_prev_button', type:'button', symbol:'EditorPagerPrevButton'},
					
					{id:'editor_pager_next_button', type:'button', symbol:'EditorPagerNextButton'},
					
					{id:'editor_pager_zoom_in_button', type:'button', symbol:'EditorPagerZoomInButton'},
					
					{id:'editor_pager_zoom_out_button', type:'button', symbol:'EditorPagerZoomOutButton'},
					
					{id:'editor_selector_back_bar', type:'bar', symbol:'EditorSelectorBackBar'},
					
					{id:'editor_selector_hover_back_bar', type:'bar', symbol:'EditorSelectorHoverBackBar'},
					
					{id:'editor_selector_hover_pointer_image', type:'image', symbol:'EditorSelectorHoverPointerImage'},
					
					{id:'editor_selector_title_div_image', type:'image', symbol:'EditorSelectorTitleDivImage'},
					
					{id:'editor_selector_snippet_available_glyph_image', type:'image', symbol:'EditorSelectorSnippetAvailableGlyphImage'},
					
					{id:'editor_selector_snippet_taken_glyph_image', type:'image', symbol:'EditorSelectorSnippetTakenGlyphImage'},
					
					{id:'editor_selector_group_title_label', type:'label', font:'helvetica_neue_bold', size:15, sharpness:0, thickness:0, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:6, paddingTop:4, paddingRight:18},
					
					{id:'editor_selector_snippet_available_button', type:'button', symbol:'EditorSelectorSnippetAvailableButton', pressedOutDuration:.5},
					
					{id:'editor_selector_snippet_taken_button', type:'button', symbol:'EditorSelectorSnippetTakenButton', pressedOutDuration:.5},
					
					{id:'editor_selector_page_button', type:'label_button', button:{symbol:'EditorSelectorSnippetPageButton'}, label:{
						font:'helvetica_neue_bold', size:11, sharpness:0, thickness:0, color:0xFFFFFF, filters:[new DropShadowFilter(1, 45, 0x000000, .8, 0, 0)], paddingTop:-2}
					},
					
					{id:'editor_selector_snippet_title_label', type:'label', font:'helvetica_neue_bold', size:13, sharpness:0, thickness:0, color:0x161616, filters:[new DropShadowFilter(1, 45, 0xffffff, .8, 0, 0)], paddingLeft:34, paddingTop:8, paddingRight:34},
					
					{id:'editor_asset_divider_off_image', type:'image', symbol:'EditorAssetDividerOffImage'},
					
					{id:'editor_asset_divider_on_image', type:'image', symbol:'EditorAssetDividerOnImage'},
					
					{id:'editor_asset_eraser_off_image', type:'image', symbol:'EditorAssetEraserOffImage'},
					
					{id:'editor_asset_eraser_on_image', type:'image', symbol:'EditorAssetEraserOnImage'},
					
					{id:'editor_middle_down_image', type:'image', symbol:'EditorMiddleDownImage'},
					
					{id:'editor_middle_up_bar', type:'bar', symbol:'EditorMiddleUpBar'},
					
					{id:'editor_middle_up_label', type:'label', font:'helvetica_neue_roman', size:10, sharpness:0, thickness:0, color:0x000000, filters:[new DropShadowFilter(1, 45, 0xffffff, .3, 0, 0)], paddingLeft:23, paddingRight:23},
					
					{id:'load_aid_dialog_next_button', type:'button', symbol:'LoadAidDialogNextButton'},
					
					{id:'load_aid_dialog_prev_button', type:'button', symbol:'LoadAidDialogPrevButton'},
					
					{id:'load_aid_dialog_zoom_in_button', type:'button', symbol:'LoadAidDialogZoomInButton'},
					
					{id:'load_aid_dialog_zoom_out_button', type:'button', symbol:'LoadAidDialogZoomOutButton'},
					
					{id:'load_aid_dialog_page_dot_image', type:'image', symbol:'LoadAidDialogPageDotImage'},
					
					{id:'load_aid_dialog_page_selection_image', type:'image', symbol:'LoadAidDialogPageSelectionBackImage'},
					
					{id:'load_aid_dialog_page_selection_label', type:'label', font:'helvetica_neue_bold', hAlign:'center', size:10, sharpness:0, thickness:0, color:0x000000},
					
				]
			};
		};
	}
}
