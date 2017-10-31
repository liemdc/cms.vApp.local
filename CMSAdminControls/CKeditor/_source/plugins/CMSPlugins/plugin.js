// CMS plugins
var CMSPlugin = {
	window : this.window,
	requires : ['iframedialog', 'fakeobjects'],
	currentEditor : null,
	currentDialog : null,
	lang : ['en'],
	regNumber : /^\d+(?:\.\d+)?$/,
	regFlashFilename : /\.swf(?:$|\?)/i,

	cssifyLength : function cssifyLength(length) {
		if(CMSPlugin.regNumber.test(length)) {
			return length + 'px';
		}
		return length;
	},
	createFakeControl : function(realElement, editor) {
		if(realElement !== null) {
			var fakeElement = null, elementType = realElement.attributes.type.toLowerCase();

			switch (elementType) {
				case 'youtubevideo':
					fakeElement = editor.createFakeParserElement(realElement, 'cke_youtube', 'object', true);
					fakeElement.attributes.cms_youtube = 'true';
					// Disable media context menu
					fakeElement.attributes.cms_disable_media = 'true';
					break;

				case 'flash':
				case 'media':
					mediaType = this.getMediaType(realElement, editor);
					if((mediaType === 'flash') || (elementType === 'flash')) {
						fakeElement = editor.createFakeParserElement(realElement, 'cke_flash', 'object', true);
						fakeElement.attributes.cms_media = 'true';
					} else {
						fakeElement = editor.createFakeParserElement(realElement, 'cke_media', 'object', true);
						fakeElement.attributes.cms_media = 'true';
					}
					break;

				// Old media inline control
				case 'mediafilecontrol':
					fakeElement = editor.createFakeParserElement(realElement, 'cke_old_media', 'object', true);
					fakeElement.attributes.cms_media = 'true';
					break;

				case 'image':
					fakeElement = editor.createFakeParserElement(realElement, 'cke_image', 'object', true);
					fakeElement.attributes.cms_media = 'true';
					realUrl = this.getImageUrl(realElement, editor);
					if(realUrl) {
						fakeElement.attributes.src = realUrl;
					}
					break;

				case 'widget':
					var obj = this.getElementObject(realElement);
					fakeElement = editor.createFakeParserElement(realElement, 'cke_widget', 'object', true);
					fakeElement.attributes.cms_disable_media = 'true';
					fakeElement.attributes.cke_widget = 'true';
					// Widget image and tooltip
					if(obj.image_guid) {
						fakeStyle = fakeElement.attributes.style || '';
						fakeElement.attributes.style = fakeStyle + 'background-image:url(' + editor.config.ApplicationPath + 'CMSPages/GetMetaFile.aspx?fileguid=' + obj.image_guid + '&maxsidesize=32);';
					}

					if(obj.widget_displayname) {
						fakeElement.attributes.title = obj.widget_displayname.replace(/\+/g, " ");
					}
					break;

				default:
					fakeElement = editor.createFakeParserElement(realElement, 'cke_inlinecontrol', 'object', false);
					// Disable media context menu
					fakeElement.attributes.cms_disable_media = 'true';
					break;
			}

			fakeElement.attributes.cms_inline = 'true';
			fakeElement.attributes.alt = '';

			var fakeStyle = fakeElement.attributes.style || '', width = realElement.attributes.width, height = realElement.attributes.height;

			if(elementType.toLowerCase() != 'widget') {
				fakeElement.attributes.title = '';
				if( typeof width != 'undefined') {
					fakeStyle = fakeElement.attributes.style = fakeStyle + 'width:' + this.cssifyLength(width) + ';';
				}
				if( typeof height != 'undefined') {
					fakeStyle = fakeElement.attributes.style = fakeStyle + 'height:' + this.cssifyLength(height) + ';';
				}
			}
			return fakeElement;
		} else {
			return null;
		}
	},
	getNodeList : function(nodes) {
		return new CKEDITOR.dom.nodeList(nodes);
	},
	getElementObject : function(realElement) {
		var obj = {}, name = null, value = null;
		if(realElement !== null) {
			// If CK editor object
			if(realElement._) {
				for( i = 0; i < realElement.children.length; i++) { name = realElement.children[i].attributes.name, value = realElement.children[i].attributes.value;
					obj[name] = value;
				}
			}
			// DOM object
			else {
				for( i = 0; i < realElement.children.length; i++) { name = realElement.children[i].getAttribute('name'), value = realElement.children[i].getAttribute('value');
					obj[name] = value;
				}
			}
		}
		return obj;
	},
	getCurrentEditor : function() {
		if(this.currentEditor !== null) {
			return this.currentEditor;
		} else {
			if(CKEDITOR.currentInstance !== null) {
				return CKEDITOR.currentInstance;
			}
		}
		return null;
	},
	getImageUrl : function(realElement, editor) {
		var url = null, editor = editor || this.getCurrentEditor(), obj = CMSPlugin.getElementObject(realElement);
		if(obj.url) {
			url = obj.url;
			if(url.indexOf('~/') === 0) {
				// Resolve url
				url = url.replace('~/', editor.config.ApplicationPath);
			}
		}

		return url;
	},
	getMediaType : function(realElement, editor) {
		var obj = this.getElementObject(realElement);
		if(obj.cms_type) {
			return obj.cms_type.toLowerCase();
		}
		// Handle flash media type
		if(((obj.ext) && (obj.ext.toLowerCase() === '.swf')) || CMSPlugin.isFlashEmbed(realElement)) {
			return 'flash';
		}

		return 'audiovideo';
	},
	isFlashEmbed : function(element) {
		var attributes = element.attributes;
		return (attributes.type == 'application/x-shockwave-flash' || attributes.type == 'flash' || CMSPlugin.regFlashFilename.test(attributes.src || ''));
	},
	// Initialize all css definitions
	initCss : function(editor) {
		// Ensure full size of editing area
		editor.addCss('html, body { height: 100%; padding: 0; margin: 0; }');

		var defaultStyle = 'background-position: center center;' + 'background-repeat: no-repeat;' + 'border: 1px solid #CCC;' + 'width: 80px;' + 'height: 80px;';

		editor.addCss('img.cke_inlinecontrol { background-image: url(' + CKEDITOR.getUrl(editor.config.CMSPluginUrl + 'images/CMSInline_bg.gif') + ');' + defaultStyle + '}');
		editor.addCss('img.cke_youtube { background-image: url(' + CKEDITOR.getUrl(editor.config.CMSPluginUrl + 'images/InsertYouTube_bg.gif') + ');' + defaultStyle + '}');
		editor.addCss('img.cke_media { background-image: url(' + CKEDITOR.getUrl(editor.config.CMSPluginUrl + 'images/InsertImageOrMedia_bg.gif') + ');' + defaultStyle + '}');
		editor.addCss('img.cke_image { background-image: url(' + CKEDITOR.getUrl(editor.config.CMSPluginUrl + 'images/InsertImage_bg.gif') + ');' + defaultStyle + 'border:0px none;}');
		editor.addCss('img.cke_flash { background-image: url(' + CKEDITOR.getUrl(editor.config.CMSPluginUrl + 'images/InsertFlash_bg.gif') + ');' + defaultStyle + '}');
		editor.addCss('img.cke_widget { background-image: url(' + CKEDITOR.getUrl(editor.config.CMSPluginUrl + 'images/InsertWidget_bg.gif') + ');' + defaultStyle + 'width: 32px;' + 'height: 32px;' + '}');
		editor.addCss('img.cke_old_media { background-image: url(' + CKEDITOR.getUrl(editor.config.CMSPluginUrl + 'images/InsertImageOrMediaOld_bg.gif') + ');' + defaultStyle + '}');
	},
	openWidget : function(editor, urlPart, widgetType, width, height) {
		this.currentEditor = editor;
		var url = '', selElem = editor.getSelection().getSelectedElement();
		if(editor.config.IsLiveSite) {
			url = editor.config.ApplicationPath + 'CMSModules/Widgets/LiveDialogs/' + urlPart;
		} else {
			url = editor.config.ApplicationPath + 'CMSModules/Widgets/Dialogs/' + urlPart;
		}
		if((selElem != null) && selElem.hasAttribute('cms_inline')) {
			var realElem = editor.restoreRealElement(selElem), obj = this.getInline(realElem.$);
			if((obj.cms_type === 'widget') && ((widgetType === null) || (widgetType === obj.name))) {
				if(editor.config.IsLiveSite) {
					url = editor.config.ApplicationPath + 'CMSModules/Widgets/LiveDialogs/WidgetProperties.aspx?inline=true';
				} else {
					url = editor.config.ApplicationPath + 'CMSModules/Widgets/Dialogs/WidgetProperties.aspx?inline=true';
				} width = 715, height = 550;
			}
		}
		if(editor.config.CurrentGroupID) {
			url += '&groupid=' + editor.config.CurrentGroupID;
		}

		CMSPlugin.openModalDialog(url, widgetType, width, height);
	},
	// Insert forms plugin
	pluginInsertForms : function(editor) {
		var pluginName = 'InsertForms',
		// Command
		insertFormCommand = {
			exec : function(editor) {
				CMSPlugin.openWidget(editor, 'WidgetProperties.aspx?inline=true&isnew=1&widgetname=BizForm', 'BizForm', '715', '550');
			}
		},
		// Button
		insertFormButton = {
			label : editor.lang[pluginName].button,
			command : pluginName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
		};

		editor.ui.addButton(pluginName, insertFormButton);
		editor.addCommand(pluginName, insertFormCommand);
	},
	// Insert inline controls plugin
	pluginInsertInlineControls : function(editor) {
		var pluginName = 'InsertInlineControls';
		editor.addCommand(pluginName, new CKEDITOR.dialogCommand(pluginName));
		editor.ui.addButton(pluginName, {
			label : editor.lang[pluginName].button,
			command : pluginName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
		});

		CKEDITOR.dialog.add(pluginName, function(editor) {
			return {
				title : editor.lang[pluginName].title,
				resizable : CKEDITOR.DIALOG_RESIZE_NONE,
				minWidth : 420,
				minHeight : 300,
				contents : [{
					id : 'tab1',
					label : '',
					title : '',
					expand : true,
					padding : 0,
					elements : [{
						type : 'iframe',
						src : editor.config.ApplicationPath + 'CMSModules/InlineControls/Controls/CKEditor/InsertInlineControls.aspx?' + editor.config.DialogParameters,
						width : 420,
						height : 300,
						onContentLoad : function() {
							CMSPlugin.currentEditor = editor;
							CMSPlugin.currentDialog = this._.dialog;
						}
					}]
				}],
				buttons : []
			};
		});
	},
	// Insert polls plugin
	pluginInsertPolls : function(editor) {
		var pluginName = 'InsertPolls',
		// Command
		insertPollCommand = {
			exec : function(editor) {
				url = 'WidgetProperties.aspx?inline=true&isnew=1&widgetname=Poll';
				CMSPlugin.openWidget(editor, url, 'Poll', '715', '550');
			}
		},
		// Button
		insertPollButton = {
			label : editor.lang[pluginName].button,
			command : pluginName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
		};

		editor.ui.addButton(pluginName, insertPollButton);
		editor.addCommand(pluginName, insertPollCommand);
	},
	// Insert group polls plugin
	pluginInsertGroupPolls : function(editor) {
		var pluginName = 'InsertGroupPolls',
		// Command
		insertPollCommand = {
			exec : function(editor) {
				url = 'WidgetProperties.aspx?inline=true&isnew=1&widgetname=GroupPoll';
				CMSPlugin.openWidget(editor, url, 'GroupPoll', '715', '550');
			}
		},
		// Button
		insertPollButton = {
			label : editor.lang[pluginName].button,
			command : pluginName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
		};

		editor.ui.addButton(pluginName, insertPollButton);
		editor.addCommand(pluginName, insertPollCommand);
	},
	// Insert rating plugin
	pluginInsertRating : function(editor) {
		var pluginName = 'InsertRating',
		// Command
		insertRatinCommand = {
			exec : function(editor) {
				CMSPlugin.openWidget(editor, 'WidgetProperties.aspx?inline=true&isnew=1&widgetname=ContentRating_1', 'ContentRating_1', '715', '550');
			}
		},
		// Button
		insertRatingButton = {
			label : editor.lang[pluginName].button,
			command : pluginName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
		};

		editor.ui.addButton(pluginName, insertRatingButton);
		editor.addCommand(pluginName, insertRatinCommand);
	},
	pluginShortcutSave : function(editor) {
		editor.on('instanceReady', function(e) {
			var saveFunction = function(event) {
				// The DOM event object is passed by the "data" property.
				keyCombination = event.data.getKeystroke();
				if(keyCombination == (CKEDITOR.CTRL + 83)) {
					//The try statement fixes a weird IE error.
					try {
						event.data.$.preventDefault();
					} catch (err) {
					}

					if(window.SaveDocument) {
						SaveDocument();
					} else if((window.parent != null) && window.parent.SaveDocument) {
						window.parent.SaveDocument();
					}
					return false;
				}
			};
			e.editor.document.on('keydown', saveFunction);
			
			// Ensure onKeyDown after mode changes
			e.editor.on('mode', function(e) {
				var editor = e.editor;
				if(editor.mode == 'source') {
					editor.textarea.on('keydown', saveFunction);
				} else {
					editor.document.on('keydown', saveFunction);
				}
			});
		});
		// Prevent default browser behavior an ckeditor keystroke
		CKEDITOR.config.blockedKeystrokes.push(CKEDITOR.CTRL + 83);
	},
	// Insert youtube plugin
	pluginInsertYouTube : function(editor) {
		var pluginName = 'InsertYouTubeVideo',
		// Command
		insertYouTubeCommand = {
			exec : function(editor) {
				CMSPlugin.currentEditor = editor;
				if(editor.config.IsLiveSite) {
					url = editor.config.ApplicationPath + 'CMSFormControls/LiveSelectors/InsertYouTubeVideo/Default.aspx';
				} else {
					url = editor.config.ApplicationPath + 'CMSFormControls/Selectors/InsertYouTubeVideo/Default.aspx';
				}
				CMSPlugin.openModalDialog(url, 'youtube', 1024, 660);
			}
		},
		// Button
		insertYouTubeButton = {
			label : editor.lang[pluginName].button,
			command : pluginName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
		},
		// Double click
		insertYouTubeDoubleClick = function(evt) {
			var element = evt.data.element;
			if(element.is('img') && element.getAttribute('cms_youtube') == 'true') {
				evt.editor.execCommand(pluginName);
			}
		},
		// Menu
		insertYouTubeMenu = {
			youtube : {
				label : editor.lang[pluginName].menu,
				command : pluginName,
				group : pluginName,
				icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
			}
		};

		editor.addCommand(pluginName, insertYouTubeCommand);
		editor.ui.addButton(pluginName, insertYouTubeButton);
		editor.on('doubleclick', insertYouTubeDoubleClick);

		// If the "menu" plugin is loaded, register the menu items.
		if(editor.addMenuItems) {
			editor.addMenuGroup(pluginName);
			editor.addMenuItems(insertYouTubeMenu);
		}

		// If the "contextmenu" plugin is loaded, register the listeners.
		if(editor.contextMenu) {
			editor.contextMenu.addListener(function(element, selection) {
				if(element && element.is('img') && element.getAttribute('cms_youtube') == 'true') {
					return {
						youtube : CKEDITOR.TRISTATE_OFF
					};
				}
			});
		}
	},
	// Insert widget plugin
	pluginInsertWidget : function(editor) {
		var pluginName = 'InsertWidget',
		// Command
		insertWidgetCommand = {
			exec : function(editor) {
				CMSPlugin.openWidget(editor, 'WidgetSelector.aspx?isnew=true&inline=true', null, '90%', '85%');
			},
			open : function(value, editor) {
				editor = editor || CMSPlugin.currentEditor;
				var url = '';
				if(editor.config.IsLiveSite) {
					url = editor.config.ApplicationPath + 'CMSModules/Widgets/LiveDialogs/WidgetProperties.aspx?inline=true&isnew=1&widgetid=' + value;
				} else {
					url = editor.config.ApplicationPath + 'CMSModules/Widgets/Dialogs/WidgetProperties.aspx?inline=true&isnew=1&widgetid=' + value;
				}
				if(editor.config.CurrentGroupID) {
					url += '&groupid=' + editor.config.CurrentGroupID;
				}
				CMSPlugin.openModalDialog(url, 'widget', 715, 550);
			}
		},
		// Button
		insertWidgetButton = {
			label : editor.lang[pluginName].button,
			command : pluginName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
		},
		// Double click
		insertWidgetDoubleClick = function(evt) {
			var element = evt.data.element;
			if(element.is('img') && element.getAttribute('cke_widget') == 'true') {
				evt.editor.execCommand(pluginName);
			}
		},
		// Menu
		insertWidgetMenu = {
			widget : {
				label : editor.lang[pluginName].menu,
				command : pluginName,
				group : pluginName,
				icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
			}
		};

		editor.addCommand(pluginName, insertWidgetCommand);
		editor.ui.addButton(pluginName, insertWidgetButton);
		editor.on('doubleclick', insertWidgetDoubleClick);

		// If the "menu" plugin is loaded, register the menu items.
		if(editor.addMenuItems) {
			editor.addMenuGroup(pluginName);
			editor.addMenuItems(insertWidgetMenu);
		}

		// If the "contextmenu" plugin is loaded, register the listeners.
		if(editor.contextMenu) {
			editor.contextMenu.addListener(function(element, selection) {
				if(element && element.is('img') && element.getAttribute('cke_widget') == 'true') {
					return {
						widget : CKEDITOR.TRISTATE_OFF
					};
				}
			});
		}
	},
	// Insert image or media plugin
	pluginInsertImageOrMedia : function(editor) {
		var pluginName = 'InsertImageOrMedia',
		// Command
		insertImageOrMediaCommand = {
			exec : function(editor) {
				width = unescape(editor.config.MediaDialogWidth);
				height = unescape(editor.config.MediaDialogHeight);
				CMSPlugin.currentEditor = editor;
				CMSPlugin.openModalDialog(editor.config.MediaDialogURL, 'imageormedia', width, height);
			}
		},
		// Button
		insertImageOrMediaButton = {
			label : editor.lang[pluginName].button,
			command : pluginName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
		},
		// Double click
		insertImageOrMediaDoubleClick = function(evt) {
			var element = evt.data.element, i = 0;
			// Disable doubleclick if plugin is in buttons to remove
			if(evt.editor.config.removeButtons) {
				for(i in evt.editor.config.removeButtons) {
					if(evt.editor.config.removeButtons[i] === 'InsertImageOrMedia') {
						evt.cancel();
						return;
					}
				}
			}

			if(element.is('img') && ((element.getAttribute('cms_media') === 'true') || !element.data('cke-realelement'))) {
				evt.editor.execCommand(pluginName);
				evt.cancel();
			}
		},
		// Menu
		insertImageOrMediaMenu = {
			imageormedia : {
				label : editor.lang[pluginName].menu,
				command : pluginName,
				group : pluginName,
				icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
			}
		};

		editor.addCommand(pluginName, insertImageOrMediaCommand);
		editor.ui.addButton(pluginName, insertImageOrMediaButton);
		editor.on('doubleclick', insertImageOrMediaDoubleClick, null, null, 1);

		// If the "menu" plugin is loaded, register the menu items.
		if(editor.addMenuItems) {
			editor.addMenuGroup(pluginName);
			editor.addMenuItems(insertImageOrMediaMenu);
		}

		// If the "contextmenu" plugin is loaded, register the listeners.
		if(editor.contextMenu) {
			editor.contextMenu.addListener(function(element, selection) {
				// Exclude anchors and cms objects with disabled media context
				if(element && element.is('img') && (element.getAttribute('class') != 'cke_anchor') && (element.data('cke-real-element-type') != 'flash') && ((element.getAttribute('cms_media') == 'true') || (element.getAttribute('cms_disable_media') != 'true'))) {
					return {
						imageormedia : CKEDITOR.TRISTATE_OFF
					};
				}
			});
		}
	},
	// Insert image or media plugin
	pluginInsertLink : function(editor) {
		var pluginName = 'InsertLink',
		// Command
		insertLinkCommand = {
			exec : function(editor) {
				width = unescape(editor.config.LinkDialogWidth);
				height = unescape(editor.config.LinkDialogHeight);
				CMSPlugin.currentEditor = editor;
				CMSPlugin.openModalDialog(editor.config.LinkDialogURL, 'imageormedia', width, height);
			}
		},
		// Button
		insertLinkButton = {
			label : editor.lang[pluginName].button,
			command : pluginName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
		},
		// Double click
		insertLinkDoubleClick = function(evt) {
			var element = null, i = 0;
			try {
				element = CKEDITOR.plugins.link.getSelectedLink(editor) || evt.data.element
			} catch (e) {
			}
			// Disable doubleclick if plugin is in buttons to remove
			if(evt.editor.config.removeButtons) {
				for(i in evt.editor.config.removeButtons) {
					if(evt.editor.config.removeButtons[i] === 'InsertLink') {
						evt.cancel();
						return;
					}
				}
			}

			if(element) {
				if(!element.isReadOnly() && (evt.editor.config.toolbar != "Disabled")) {
					if(element.is('a')) {
						if(element.getAttribute('name') && !element.getAttribute('href')) {
							evt.data.dialog = 'anchor';
						} else {
							evt.editor.execCommand(pluginName);
							evt.cancel();
						}
					} else {
						if(element.is('img') && element.data('cke-real-element-type') == 'anchor') {
							evt.data.dialog = 'anchor';
						}
					}
				} else {
					evt.stop();
				}
			}
		},
		// Menu
		insertLinkMenu = {
			insertLink : {
				label : editor.lang[pluginName].menu,
				command : pluginName,
				group : pluginName,
				icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif'
			}
		};

		editor.addCommand(pluginName, insertLinkCommand, 1);
		editor.ui.addButton(pluginName, insertLinkButton);
		editor.on('doubleclick', insertLinkDoubleClick, null, null, 1);

		// If the "menu" plugin is loaded, register the menu items.
		if(editor.addMenuItems) {
			editor.addMenuGroup(pluginName);
			editor.addMenuItems(insertLinkMenu);
		}

		// If the "contextmenu" plugin is loaded, register the listeners.
		if(editor.contextMenu) {
			editor.contextMenu.addListener(function(element, selection) {
				if(!element || element.isReadOnly())
					return null;

				var isAnchor = (element.is('img') && element.data('cke-real-element-type') == 'anchor');

				if(!isAnchor) {
					if(!( element = CKEDITOR.plugins.link.getSelectedLink(editor)))
						return null;
					isAnchor = (element.getAttribute('name') && !element.getAttribute('href'));
				}

				if(!isAnchor) {
					return {
						insertLink : CKEDITOR.TRISTATE_OFF
					};
				}
			});
		}
	},
	// Quickly insert media plugin
	pluginQuicklyInsertMedia : function(editor) {
		var pluginName = 'QuicklyInsertImage', quicklyInsertMediaCommand = {
			exec : function(editor) {
				CMSPlugin.currentEditor = editor;
			}
		};

		editor.addCommand(pluginName, quicklyInsertMediaCommand);
		editor.ui.addButton(pluginName, {
			label : editor.lang[pluginName].button,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif',
			onRender : function() {
				// Create QIM ids array
				if(!editor.config.qimId) {
					editor.config.qimId = [];
				}
				editor.config.qimId.push(this._.id);
				editor.on('instanceReady', function(e) {

					// Register global insert image or media function
					window.InsertImageOrMedia = function(url, name, width, height, obj) {
						CMSPlugin.insert(obj);
					};
					function isDocument(url) {
						if(url != null) {
							var formGuid = url.match(/(?:formGuid=)([a-z\d-]+)/i), documentId = url.match(/(?:documentid=)([\d]+)/i), parentId = url.match(/(?:parentid=)([\d]+)/i);

							if((formGuid != null) && (parentId != null) && (/^[a-f\d]{8}-[a-f\d]{4}-[a-f\d]{4}-[a-f\d]{4}-[a-f\d]{12}$/i.test(formGuid[1])) && (parseInt(parentId[1], 10) >= 0)) {
								return true;
							}
							if((documentId != null) && (parseInt(documentId[1], 10) >= 0)) {
								return true;
							}
						}
						return false;
					}

					for( i = 0; i < editor.config.qimId.length; i++) { qimId = editor.config.qimId[i], qimButton = document.getElementById(qimId);
						if((qimButton !== null) && (!qimButton.QIM_set)) {
							qimButton.QIM_set == true;
							if(isDocument(this.config.QuickInsertURL) && !window.disableQim) {
								qimButton.className += ' CMS_QIM';
								qimButton.onmousemove = function() {
									CMSPlugin.currentEditor = editor;
								};
								elements = qimButton.getElementsByTagName('span');
								for(var i = 0; i < elements.length; i++) {
									if(elements[i].className === 'cke_icon') {
										qimWrapper = elements[i]
									}
								}
								if( typeof (qimWrapper) !== 'undefined') {
									qimWrapper.style.position = 'relative';
									qimWrapper.style.background = '';
									innerDiv = document.createElement('div');
									innerDiv.className = 'InnerDiv';
									innerDiv.style.position = 'absolute';
									innerDiv.style.top = '0px';
									innerDiv.style.left = '0px';
									innerDiv.style.display = 'inline-block';
									innerDiv.innerHTML = '<img src="' + editor.config.CMSPluginUrl + 'images/' + pluginName + '.gif" style="width:16px; height:18px;" />';
									qimWrapper.appendChild(innerDiv);
									uploaderDiv = document.createElement('div');
									uploaderDiv.className = 'UploaderDiv';
									uploaderDiv.style.position = 'absolute';
									uploaderDiv.style.top = '0px';
									uploaderDiv.style.width = '16px';
									uploaderDiv.style.height = '18px';
									uploaderDiv.style.visibility = 'visible';
									uploaderDiv.style.opacity = '1';
									uploaderDiv.innerHTML = '<iframe name="QuickInsertImage" src="' + editor.config.QuickInsertURL + '&containerid=' + qimId + '" frameborder="0" marginWidth="0" marginHeight="0" scrolling="no" border="0" style="width:16px; height:18px; overflow:hidden;" allowtransparency="true" ></iframe>';
									qimWrapper.appendChild(uploaderDiv);
									loadingDiv = document.createElement('div');
									loadingDiv.className = 'LoadingDiv';
									loadingDiv.style.position = 'absolute';
									loadingDiv.style.opacity = '1';
									loadingDiv.style.display = 'none';
									loadingDiv.style.top = '0px';
									loadingDiv.style.left = '0px';
									loadingDiv.innerHTML = '<img src="' + editor.config.ApplicationPath + 'App_Themes/Default/Images/Design/Preloaders/preload16.gif" style="width:16px; height:16px;" />';
									qimWrapper.appendChild(loadingDiv);

									// Append DFU script for propper handling
									dfuScript = document.createElement('script');
									dfuScript.type = 'text/javascript';
									dfuScript.src = editor.config.ApplicationPath + 'CMSModules/Content/Controls/Attachments/DirectFileUploader/DirectFileUploader.js';
									qimButton.appendChild(dfuScript);
								}
							} else {
								qimButton.parentNode.removeChild(qimButton);
							}
						}
					}
				});
			}
		});
		editor.on('mode', function(e) {
			// If QIM is pressent
			if(editor.config.qimId) {
				for( i = 0; i < editor.config.qimId.length; i++) {
					var qimId = editor.config.qimId[i], qimButton = document.getElementById(qimId);
					if(qimButton !== null) {
						frameElem = qimButton.getElementsByTagName('iframe');
						if(editor.mode == 'source') {
							qimButton.className += ' cke_disabled';
							if((frameElem != null) && (frameElem.length === 1)) {
								frameElem[0].style.display = 'none';
							}
						} else {
							qimButton.className = qimButton.className.replace(/\s+cke_disabled/ig, '');
							if((frameElem != null) && (frameElem.length === 1)) {
								frameElem[0].style.display = '';
							}
						}
					}
				}
			}
		});
	},
	// Quickly insert media plugin
	pluginForumButtons : function(editor) {
		var pluginQuoteName = 'InsertQuote',
		// Command
		insertQuoteCommand = {
			exec : function(editor) {
				editor.insertHtml('[quote=][/quote]');
			}
		},
		// Button
		insertQuoteButton = {
			label : editor.lang[pluginQuoteName].button,
			command : pluginQuoteName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginQuoteName + '.gif'
		}, pluginImageName = 'InsertImage',
		// Command
		insertImageCommand = {
			exec : function(editor) {
				var url = prompt(editor.lang[pluginImageName].prompturl, 'http://');
				if(url != null) {
					editor.insertHtml('[img]' + url + '[/img]');
				}
			}
		},
		// Button
		insertImageButton = {
			label : editor.lang[pluginImageName].button,
			command : pluginImageName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginImageName + '.gif'
		}, pluginInserUrlName = 'InsertUrl',
		// Command
		insertInserUrlCommand = {
			exec : function(editor) {
				var url = prompt(editor.lang[pluginInserUrlName].prompturl, 'http://');
				if(url != null) {
					desc = prompt(editor.lang[pluginInserUrlName].promptdesc, '');
					if(desc == null) {
						desc = ''
					}
					editor.insertHtml('[url=' + url + ']' + desc + '[/url]');
				}
			}
		},
		// Button
		insertInserUrlButton = {
			label : editor.lang[pluginInserUrlName].button,
			command : pluginInserUrlName,
			icon : editor.config.CMSPluginUrl + 'images/' + pluginInserUrlName + '.gif'
		};
		editor.ui.addButton(pluginQuoteName, insertQuoteButton);
		editor.addCommand(pluginQuoteName, insertQuoteCommand);
		editor.ui.addButton(pluginImageName, insertImageButton);
		editor.addCommand(pluginImageName, insertImageCommand);
		editor.ui.addButton(pluginInserUrlName, insertInserUrlButton);
		editor.addCommand(pluginInserUrlName, insertInserUrlCommand);
	},
	disableAutoFocus : function(editor) {
		editor.on('instanceReady', function(e) {
			// Disable auto focus
			if(editor && editor.document) {
				editor.document.getDocumentElement().on('mousedown', function(e) {
					e.stop();
				}, null, null, 1);
			}
		});
	},
	initMaximalization : function(editor) {
		editor.on('afterCommandExec', function(e) {
			function afterResizeHandler() {
				var header = null, footer = null,
				// Get view size
				viewPaneSize = CKEDITOR.document.getWindow().getViewPaneSize(), container = editor.container.getChild(1), height = 0;

				if(e.editor.sharedSpaces.top) {
					header = e.editor.sharedSpaces.top.getPositionedAncestor();
				}
				if(e.editor.sharedSpaces.bottom) {
					footer = e.editor.sharedSpaces.bottom.getPositionedAncestor();
				}
				// Calculate new height
				height = viewPaneSize.height - ( header ? header.$.offsetHeight : 0) - ( footer ? footer.$.offsetHeight : 0);

				// Set header padding and resize editor
				if(header) {
					container.$.style.top = header.$.offsetHeight + 'px';
				}
				e.editor.resize(viewPaneSize.width, height, null, true);
			}

			// Only maximize command
			if(e.data.name === 'maximize') {
				if(e.editor.sharedSpaces) {
					var mainWindow = CKEDITOR.document.getWindow();
					// Maximalize
					if(e.data.command.state == CKEDITOR.TRISTATE_ON) {
						window.CK_Maximized = true;
						afterResizeHandler(e);
						// Add event handler for resizing.
						mainWindow.on('resize', afterResizeHandler);
					} else {
						// Restore
						if(e.data.command.state == CKEDITOR.TRISTATE_OFF) {
							window.CK_Maximized = false;
							// Remove event handler for resizing.
							mainWindow.removeListener('resize', afterResizeHandler);
						}
					}
					if(window.EnsureToolbarWidth) {
						window.EnsureToolbarWidth();
					}
				}
			}
			if(e.data.name === 'toolbarCollapse') {
				if(window.CK_Maximized) {
					// Resize after toolbar is collapsed
					afterResizeHandler(e);
				}
			}
		});
	},
	initPopupOpener : function(editor) {
		// Override editor default popup opener
		editor.popup = function(url, width, height, features) {
			var hashReg = /hash=[a-fA-F0-9]+/i, functionReg = /CKEditorFuncNum=[\d]+/i, functionNum, functionMatch = url.match(functionReg), hashMatch = url.match(hashReg);

			if(functionMatch && functionMatch.index > 0) {
				functionNum = functionMatch[0].substr(16);
				// Function to insert selected URL to CKEditor dialog
				window.SetUrl = function(url, width, height) {
					CKEDITOR.tools.callFunction(functionNum, url);
				};
			}

			if(hashMatch && hashMatch.index > 0) {
				// Remove additional query parameters
				url = url.substr(0, hashMatch.index + hashMatch[0].length);
			}

			CMSPlugin.openModalDialog(url, 'CKEditorPopup', width, height, features);
		};
	},
	initDropdownLists : function(editor) {
		if(document.getElementById('CMSHeaderPad') && editor.config.sharedSpaces && editor.config.sharedSpaces.top) {
			editor.on('instanceReady', function(e) {

				var toolbarClick = function(elem, editor) {
					var scrollTop = jQuery(window).scrollTop(), dropElem = jQuery(elem), dropPosition = dropElem.offset();
					jQuery('.cke_panel:hidden').each(function() {
						jQuery(this).css({
							'position' : 'relative',
							'left' : 0,
							'top' : 0
						});
					});
					jQuery('.cke_panel:visible').each(function() {
						panel = jQuery(this);
						panel.css({
							'position' : 'fixed',
							'top' : (panel.offset().top - scrollTop)
						});
						// Check left position and correct it if necessary
						if(editor.config.ContentsLangDirection === 'rtl') {
							leftPos = dropPosition.left + dropElem.width() - panel.width();
							if(leftPos != panel.offset().left) {
								panel.css('left', leftPos);
							}
						} else {
							if(dropPosition.left != panel.offset().left) {
								panel.css('left', dropPosition.left);
							}
						}
					});
					// Ensure correct position after panel is closed
					window.CKEDITOR.DropdownOpened = true;
					window.CKEDITOR.DropdownCleaner = setInterval(function() {
						if(window.CKEDITOR.DropdownOpened) {
							jQuery('.cke_panel:hidden').each(function() {
								jQuery(this).css({
									'position' : 'relative',
									'left' : 0,
									'top' : 0
								});
							});
							if(jQuery('.cke_panel:visible').length == 0) {
								window.CKEDITOR.DropdownOpened = false;
								clearInterval(window.CKEDITOR.CK_DropdownCleaner);
							}
						}
					}, 50);
				}
				jQuery('.cke_openbutton, .cke_buttonarrow').parent('a').unbind('click', function() {
					toolbarClick(this, e.editor)
				}).click(function() {
					toolbarClick(this, e.editor)
				});
			});
		}
	},
	// Personalization - remove disabled buttons
	initPersonalization : function(editor) {
		editor.on('themeSpace', function(e) {
			var removeButtons = editor.config.removeButtons;
			if(removeButtons) {

				function contains(array, name) {
					name = name.toLowerCase();
					for( c = 0; c < array.length; c++) {
						if((array[c] !== null) && (array[c].toLowerCase() === name)) {
							return true;
						}
					}
					return false;
				}

				toolbar = (editor.config.toolbar instanceof Array) ? editor.config.toolbar : editor.config['toolbar_' + editor.config.toolbar];
				for( r = 0; r < toolbar.length; r++) {
					var row = toolbar[r], empty = true;
					if(row) {
						for( i = 0; i < row.length; i++) {
							itemName = row[i];
							if(itemName && (itemName != '-')) {
								// Set null if item is in remove buttons array
								if(contains(removeButtons, itemName)) {
									row[i] = null;
								} else {
									empty = false;
								}
							}
						}
						// remove empty row
						if(empty) {
							toolbar[r] = null;
						}
					}
				}

				editor.config.toolbar = toolbar;
			}
		}, null, null, 1);
	},
	initContextMenu : function(editor) {
		// Remove the default context menu for elements that aren't being used in the toolbar.
		// This object is composed of the button name and the name of the context menu entry
		var removableEntries = {
			Image : 'image',
			Link : 'link',
			Unlink : 'unlink',
			Flash : 'flash',
			Table : 'table'
		},
		// Get the data that is being used for the toolbar, we end with an array of arrays.
		toolbar = (editor.config.toolbar instanceof Array) ? editor.config.toolbar : editor.config['toolbar_' + editor.config.toolbar];

		// Loop the main array (composed of groups of commands)
		for( i = 0; i < toolbar.length; i++) {
			items = toolbar[i];
			if(!items) {
				continue;
			}
			for( j = 0; j < items.length; j++) {
				buttonName = items[j];
				// If it was marked at our check object remove it because it's in use
				if(removableEntries[buttonName]) {
					delete removableEntries[buttonName];
				}
			}
		}

		// Remove all the entries that aren't used in the toolbar
		for(command in removableEntries) {
			delete editor._.menuItems[removableEntries[command]];
		}
	},
	initDataProcesor : function(editor) {
		var dataProcessor = editor.dataProcessor, dataFilter = dataProcessor && dataProcessor.dataFilter;

		if(dataFilter) {
			dataFilter.addRules({
				elements : {
					'cke:object' : function(element) {
						fakeElem = null;
						if(element.attributes.codetype && (element.attributes.codetype.toLowerCase() == 'cmsinlinecontrol')) {
							return CMSPlugin.createFakeControl(element, editor);
						} else {
							// Handle flash objects
							attributes = element.attributes, classId = attributes.classid && String(attributes.classid).toLowerCase();

							if(!classId && !CMSPlugin.isFlashEmbed(element)) {
								// Look for the inner <embed>
								for( i = 0; i < element.children.length; i++) {
									if(element.children[i].name == 'cke:embed') {
										if(!CMSPlugin.isFlashEmbed(element.children[i])) {
											return null;
										}

										element.attributes.type = 'flash';
										return CMSPlugin.createFakeControl(element, editor);

									}
								}
								return null;
							}

							element.attributes.type = 'flash';
							return CMSPlugin.createFakeControl(element, editor);
						}
					},
					'cke:embed' : function(element) {
						if(CMSPlugin.isFlashEmbed(element)) {
							element.attributes.type = 'flash';
							fakeElem = CMSPlugin.createFakeControl(element, editor);
						}
						return fakeElem;
					}
				}
			}, 3);
		}
	},
	getInline : function(element, originalElement) {
		var obj = {};
		if(element) {
			var type = element.getAttribute('type'), width = element.getAttribute('width'), height = element.getAttribute('height');
			if(type) {
				if(type.toLowerCase() == 'media') {
					type = this.getMediaType(element);
				}
				obj['cms_type'] = type;
			}
			if(element.childNodes) {
				var prefix = this.getPropertyPrefix(type), child = null, name = null, value = null, count = element.childNodes.length;

				// Handle width and height
				if(width) {
					obj[prefix + 'width'] = width;
				}
				if(height) {
					obj[prefix + 'height'] = height;
				}

				// Loop trough all child nodes for all attributes
				for( i = 0; i < count; i++) {
					child = element.childNodes[i];
					name = child.getAttribute('name');
					value = child.getAttribute('value');
					if(name) {
						obj[prefix + name] = value;

						// Special handling for old CKEditor dialogs
						if((prefix + name) === 'flash_movie') {
							obj['flash_url'] = value;
						}
					}
				}
			}
			// Find link element for original element
			try {
				element = CKEDITOR.dom.element.get(originalElement);
				if(element) {
					linkObject = element.getAscendant('a', true);
					if(linkObject) {
						obj[prefix + 'link'] = linkObject.getAttribute('data-cke-saved-href') || linkObject.getAttribute('href');
						obj[prefix + 'target'] = linkObject.getAttribute('target');
					}
				}
			} catch (e) {
			}
		}
		return obj;
	},
	getPropertyPrefix : function(type) {
		var prefix = null;

		// Get property prefix for object definition
		switch (type.toLowerCase()) {
			case 'youtubevideo':
				prefix = 'youtube_';
				break;

			case 'image':
				prefix = 'img_';
				break;

			case 'audiovideo':
				prefix = 'av_';
				break;

			case 'flash':
				prefix = 'flash_';
				break;

			default:
				prefix = '';
				break;
		}

		return prefix;
	},
	getInlineType : function(type) {
		var inlineType = null;

		// Get inline type for object definition
		switch (type.toLowerCase()) {
			case 'youtubevideo':
				inlineType = 'YouTubeVideo';
				break;

			case 'image':
				inlineType = 'Image';
				break;

			case 'audiovideo':
			case 'flash':
				inlineType = 'Media';
				break;

			case 'widget':
				inlineType = 'Widget';
				break;

			default:
				inlineType = '';
				break;
		}

		return inlineType;
	},
	createCKElement : function(tagName) {
		var editor = this.getCurrentEditor();
		if(editor) {
			return editor.document.createElement(tagName);
		}
		return null;
	},
	insertInline : function(type, obj) {
		if(type) {
			var inlineType = this.getInlineType(type), prefix = this.getPropertyPrefix(type), editor = this.getCurrentEditor(), output = '<object codetype="CMSInlineControl" type="' + inlineType + '" ', excludeParams = {
				'img_link' : 1,
				'img_target' : 1
			}, defaultValues = {
				'img_hspace' : -1,
				'img_vspace' : -1,
				'img_borderwidth' : -1,
				'flash_loop' : 'False',
				'flash_autoplay' : 'False',
				'flash_menu' : 'False',
				'av_autoplay' : 'False',
				'av_loop' : 'False',
				'av_controls' : 'True'
			};

			if(obj[prefix + 'width']) {
				output += 'width="' + obj[prefix + 'width'] + '" ';
				obj[prefix + 'width'] = null;
			}
			if(obj[prefix + 'height']) {
				output += 'height="' + obj[prefix + 'height'] + '" ';
				obj[prefix + 'height'] = null;
			}
			output += '>';

			for(param in obj) {
				if(!excludeParams[param] && obj[param] && (obj[param] != defaultValues[param])) {
					output += '<param name="' + param.replace(prefix, '') + '" value="' + obj[param] + '" />';
				}
			}
			output += "</object>";

			// Handle link properties
			if(obj['img_link']) {
				try {
					editor.focus();
					selection = editor.getSelection();
					if(selection.getType() == CKEDITOR.SELECTION_ELEMENT) {
						preSelectedElement = selection.getSelectedElement();
						if(preSelectedElement.is('a')) {
							selectedElement = preSelectedElement;
						}
					}
					range = selection.getRanges(true)[0];
					range.shrink(CKEDITOR.SHRINK_TEXT);
					root = range.getCommonAncestor();
					selectedElement = root.getAscendant('a', true);
				} catch (e) {
				}

				if(!selectedElement) {
					linkHtml = '<a href="' + obj['img_link'] + '" ';
					if(obj['img_target']) {
						linkHtml += 'target="' + obj['img_target'] + '" ';
					}
					linkHtml += '>';
					output = linkHtml + output + '</a>';
				} else { attributes = {
						href : 'javascript:void(0)/*' + CKEDITOR.tools.getNextNumber() + '*/'
					}, removeAttributes = [];

					attributes['data-cke-saved-href'] = obj['img_link']
					if(obj['img_target']) {
						attributes['target'] = obj['img_target'];
					} else {
						removeAttributes.push('target');
					}
					// Set new and remove old link attributes
					selectedElement.setAttributes(attributes);
					selectedElement.removeAttributes(removeAttributes);
				}
			} else {
				// Unlink if no link url is set
				editor.document.$.execCommand('unlink', false, null);
			}

			// Insert object html
			this.insertHtml(output);
		}
	},
	insertLink : function(obj) {

		var attributes = {
			href : 'javascript:void(0)/*' + CKEDITOR.tools.getNextNumber() + '*/'
		}, removeAttributes = [], editor = this.getCurrentEditor(), selectedElement = null, name = null, custom = null, id = null;
		try {
			editor.focus();
			selection = editor.getSelection();
			if(selection.getType() == CKEDITOR.SELECTION_ELEMENT) {
				preSelectedElement = selection.getSelectedElement();
				if(preSelectedElement.is('a')) {
					selectedElement = preSelectedElement;
				}
			}
			range = selection.getRanges(true)[0];
			range.shrink(CKEDITOR.SHRINK_TEXT);
			root = range.getCommonAncestor();
			selectedElement = root.getAscendant('a', true);
		} catch (e) {
		}

		// Compose the URL.
		if(obj.link_url) { protocol = obj.link_protocol || '', url = obj.link_url || '';
			attributes['data-cke-saved-href'] = (url.indexOf('/') === 0) ? url : protocol + url;
		} else if(obj.anchor_name) { name = obj.anchor_name || '', custom = obj.anchor_custom || '', id = obj.anchor_id || '';
			attributes['data-cke-saved-href'] = '#' + (name || custom || id || '');

		} else if(obj.email_to) { cc = obj.email_cc, bcc = obj.email_bcc, subject = obj.email_subject, body = obj.email_body, argList = [];
			cc && argList.push('cc=' + cc);
			bcc && argList.push('bcc=' + bcc);
			subject && argList.push('subject=' + subject);
			body && argList.push('body=' + body);
			argList = argList.length ? '?' + argList.join('&') : '';

			attributes['data-cke-saved-href'] = 'mailto:' + obj.email_to + argList;
		}

		// Popups and target.
		if(obj.link_target) {
			attributes.target = obj.link_target;
		} else {
			removeAttributes.push('target');
		}

		// Advanced attributes.
		if(obj.link_url) {
			processAttr = function(obj, inputName, attrName) {
				value = obj[inputName];
				if(value) {
					attributes[attrName] = value;
				} else {
					removeAttributes.push(attrName);
				}
			};
			processAttr(obj, 'link_url', 'href');
			processAttr(obj, 'link_id', 'id');
			processAttr(obj, 'link_target', 'target');
			processAttr(obj, 'link_class', 'class');
			processAttr(obj, 'link_tooltip', 'title');
			processAttr(obj, 'link_style', 'style');

			if(obj.link_name) {
				attributes['name'] = attributes['data-cke-saved-name'] = obj.link_name;
				attributes['class'] = (attributes['class'] ? attributes['class'] + ' ' : '') + 'cke_anchor';
			} else {
				removeAttributes = removeAttributes.concat(['data-cke-saved-name', 'name']);
			}
		}

		if(!selectedElement) {
			// Create element if current selection is collapsed.
			selection = editor.getSelection(), ranges = selection.getRanges(true);
			if(ranges.length == 1 && ranges[0].collapsed) {
				// Short mailto link text view
				text = new CKEDITOR.dom.text(obj.email_linktext ? obj.email_linktext : obj.email_to ? obj.email_to : obj.anchor_linktext ? obj.anchor_linktext : obj.anchor_name ? obj.anchor_name : obj.link_text ? obj.link_text : obj.link_url, editor.document);
				ranges[0].insertNode(text);
				ranges[0].selectNodeContents(text);
				selection.selectRanges(ranges);
			}

			// Apply style.
			style = new CKEDITOR.style({
				element : 'a',
				attributes : attributes
			});
			style.type = CKEDITOR.STYLE_INLINE;
			style.apply(editor.document);

			// Id. Apply only to the first link.
			if(obj.link_id) {
				links = editor.document.$.getElementsByTagName('a');
				for( i = 0; i < links.length; i++) {
					if(links[i].getAttribute('href') == attributes.href) {
						links[i].id = obj.link_id;
						break;
					}
				}
			}
		} else {
			// We're only editing an existing link, so just overwrite the attributes.
			element = selectedElement, href = element.data('data-cke-saved-href'), textView = element.getHtml();

			// IE BUG: Setting the name attribute to an existing link doesn't work.
			// Must re-create the link from weired syntax to workaround.
			if(CKEDITOR.env.ie && (attributes.name || element.getAttribute('name')) && attributes.name != element.getAttribute('name')) {
				newElement = new CKEDITOR.dom.element('<a name="' + CKEDITOR.tools.htmlEncode(attributes.name) + '">', editor.document);
				selection = editor.getSelection();

				element.moveChildren(newElement);
				element.copyAttributes(newElement, {
					name : 1
				});
				newElement.replace(element);
				element = newElement;

				selection.selectElement(element);
			}

			element.setAttributes(attributes);
			element.removeAttributes(removeAttributes);
			// Make the element display as an anchor if a name has been set.
			if(element.getAttribute('name')) {
				element.addClass('cke_anchor');
			} else {
				element.removeClass('cke_anchor');
			}

			if(this.fakeObj) {
				editor.createFakeElement(element, 'cke_anchor', 'anchor').replace(this.fakeObj);
			}
			delete selectedElement;
		}
	},
	insertImage : function(obj) {
		var imgOut = this.createCKElement('img');
		if(imgOut != null) {
			if(obj.img_id) {
				imgOut.$.id = obj.img_id;
			}
			if(obj.img_url) {
				imgOut.$.src = obj.img_url;
				imgOut.$.setAttribute("data-cke-saved-src", obj.img_url);
			}
			if(obj.img_alt) {
				imgOut.$.alt = obj.img_alt;
			} else {
				if(obj.img_tooltip) {
					imgOut.$.alt = obj.img_tooltip;
				} else {
					imgOut.$.alt = "";
				}
			}
			if(obj.img_tooltip) {
				imgOut.$.title = obj.img_tooltip;
			}
			if(obj.img_class) {
				imgOut.$.setAttribute("class", obj.img_class);
			}
			if(obj.img_dir) {
				imgOut.$.dir = obj.img_dir;
			}
			if(obj.img_usemap) {
				imgOut.$.useMap = obj.img_usemap;
			}
			if(obj.img_longdescription) {
				imgOut.$.setAttribute('longdesc', obj.img_longdescription);
			}
			if(obj.img_lang) {
				imgOut.$.lang = obj.img_lang;
			}
			if(obj.img_style) {
				imgOut.setAttribute('style', obj.img_style);
				if(imgOut.$.style.cssStyle != undefined) {
					imgOut.$.style.cssStyle = obj.img_style;
				}
				if(imgOut.$.style.cssText != undefined) {
					imgOut.$.style.cssText = obj.img_style;
				}
			}
			if((obj.img_width) && (parseInt(obj.img_width, 10) >= 0)) {
				imgOut.$.style.width = parseInt(obj.img_width, 10) + 'px';
			}
			if((obj.img_height) && (parseInt(obj.img_height, 10) >= 0)) {
				imgOut.$.style.height = parseInt(obj.img_height, 10) + 'px';
			}
			if((obj.img_borderwidth) && (parseInt(obj.img_borderwidth, 10) >= 0)) {
				imgOut.$.style.borderWidth = obj.img_borderwidth + 'px';
				imgOut.$.style.borderStyle = 'solid';
			}
			if(obj.img_bordercolor) {
				try {
					imgOut.$.style.borderColor = obj.img_bordercolor;
				} catch (e) {
					imgOut.$.style.borderColor = '';
				}
			}
			if(obj.img_align) {
				if((obj.img_align == 'left') || (obj.img_align == 'right')) {
					if(imgOut.$.style.cssFloat != undefined) {
						imgOut.$.style.cssFloat = obj.img_align;
					}
					if(imgOut.$.style.styleFloat != undefined) {
						imgOut.$.style.styleFloat = obj.img_align;
					}
				} else {
					if(imgOut.$.style.verticalAlign != undefined) {
						imgOut.$.style.verticalAlign = obj.img_align;
					}
					if(imgOut.$.style['vartical-align'] != undefined) {
						imgOut.$.style['vartical-align'] = obj.img_align;
					}
				}
			}

			if((obj.img_vspace) || (obj.img_hspace)) {
				var vspace = parseInt(obj.img_vspace, 10), hspace = parseInt(obj.img_hspace, 10);
				if((vspace == hspace) && (vspace >= 0)) {
					imgOut.$.style.margin = hspace + 'px';
				} else {
					if((vspace == hspace) && (vspace == -1)) {
						// No margin will be inserted
					} else {
						imgOut.$.style.margin = (vspace >= 0 ? vspace + 'px ' : 'auto ') + (hspace >= 0 ? hspace + 'px' : 'auto');
					}
				}
			}

			// Create link if definition exists
			if(obj.img_link || obj.img_behavior) {
				var imgLink = this.createCKElement('a');
				if(obj.img_link) {
					imgLink.$.href = obj.img_link;
					imgLink.$.setAttribute('data-cke-saved-href', obj.img_link);
				}
				if(obj.img_target) {
					imgLink.$.setAttribute('target', obj.img_target);
				} else if(obj.img_behavior) {
					imgLink.$.setAttribute('target', obj.img_behavior);
				}
				imgLink.append(imgOut);
				this.insertElement(imgLink);
			} else {
				this.insertElement(imgOut);
			}
		}
	},
	insertHtml : function(html) {
		var editor = this.getCurrentEditor();
		if(editor) {
			editor.focus();
			editor.insertHtml(html);
		}
	},
	insertElement : function(element) {
		var editor = this.getCurrentEditor();
		if(editor) {
			editor.focus();
			editor.insertElement(element);
		}
	},
	insert : function(obj) {
		if(obj !== null) {
			var type = obj.cms_type;
			if(type) {
				this.insertInline(type, obj);
			} else {
				if(obj.link_url || obj.email_to || obj.anchor_name) {
					this.insertLink(obj);
				} else {
					if(obj.img_url) {
						this.insertImage(obj);
					}
				}
			}
		}
	},
	openModalDialog : function(url, name, width, height, otherParams) {
		window.CMSModalDialog(url, name, width, height, otherParams, null, CKEDITOR.env.ie9Compat);
	},
	beforeInit : function(editor) {
		this.pluginShortcutSave(editor);
	},
	init : function(editor) {
		// Helper methods
		this.initCss(editor);
		this.disableAutoFocus(editor);
		this.initPersonalization(editor);
		this.initMaximalization(editor);

		// Load CMS plugins
		this.pluginInsertForms(editor);
		this.pluginInsertInlineControls(editor);
		this.pluginInsertPolls(editor);
		this.pluginInsertGroupPolls(editor);
		this.pluginInsertRating(editor);
		this.pluginInsertYouTube(editor);
		this.pluginInsertWidget(editor);
		this.pluginInsertImageOrMedia(editor);
		this.pluginInsertLink(editor);
		this.pluginQuicklyInsertMedia(editor);
		this.pluginForumButtons(editor);
	},
	afterInit : function(editor) {
		this.initContextMenu(editor);
		this.initDataProcesor(editor);
		this.initPopupOpener(editor);
		this.initDropdownLists(editor);
	}
};

CKEDITOR.plugins.add('CMSPlugins', CMSPlugin);

CKEDITOR.on('instanceReady', function(e) {
	if(CKeditor_OnComplete) {
		CKeditor_OnComplete(e.editor);
	}
});
// Register script displaying safe modal page dialog
function CMSModalDialog(url, name, width, height, otherParams, noWopener, forceWindow) {
	win = window;
	var dHeight = height;
	var dWidth = width;
	if(width.toString().indexOf('%') != -1) {
		dWidth = Math.round(screen.width * parseInt(width, 10) / 100);
	}
	if(height.toString().indexOf('%') != -1) {
		dHeight = Math.round(screen.height * parseInt(height, 10) / 100);
	}
	var s = navigator.userAgent.toLowerCase();
	if(document.all && (navigator.appName != 'Opera') && (parseInt(s.match(/msie (\d+)/)[1], 10) < 9) && !forceWindow) {
		if(otherParams == undefined) {
			otherParams = 'resizable: yes; scroll: no;';
		}
		var vopenwork = true;
		if(!noWopener) {
			try {
				win = wopener.window;
			} catch (e) {
				vopenwork = false;
			}
		}
		if(parseInt(navigator.appVersion.substr(22, 1)) < 7) {
			dWidth += 4;
			dHeight += 58;
		}
		var pars = 'dialogWidth: ' + dWidth + 'px; dialogHeight: ' + dHeight + 'px; ' + otherParams;
		try {
			win.showModalDialog(url, window, pars);
		} catch (e) {
			if(vopenwork) {
				window.showModalDialog(url, window, pars);
			}
		}
	} else {
		if(otherParams == undefined) {
			otherParams = 'toolbar=no,directories=no,menubar=no,modal=yes,dependent=yes,resizable=yes';
		}
		oWindow = win.open(url, name, 'width=' + dWidth + ',height=' + dHeight + ',' + otherParams);
		if(oWindow) {
			oWindow.opener = this;
			oWindow.focus();
		}
	}
};