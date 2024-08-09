import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'dart:convert';

class rich_text_editor_type_1 extends StatefulWidget {
  final QuillEditorController controller;
  final double height;
  const rich_text_editor_type_1({super.key, required this.controller, required this.height});

  @override
  State<rich_text_editor_type_1> createState() => _rich_text_editor_type_1State();
}

class _rich_text_editor_type_1State extends State<rich_text_editor_type_1> {
  final customToolBarList = [
    // ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = Colors.white70;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'muli');
  final _hintTextStyle = const TextStyle(
      fontSize: 14, color: Colors.black38, fontWeight: FontWeight.normal);

  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            ToolBar(
              toolBarColor: _toolbarColor,
              padding: const EdgeInsets.all(8),
              iconSize: 20,
              iconColor: _toolbarIconColor,
              controller: widget.controller,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              customButtons: [
                // Container(
                //   width: 25,
                //   height: 25,
                //   decoration: BoxDecoration(
                //       color: _hasFocus ? Colors.green : Colors.grey,
                //       borderRadius: BorderRadius.circular(15)),
                // ),
                // InkWell(
                //     onTap: () => unFocusEditor(),
                //     child: const Icon(
                //       Icons.favorite,
                //       color: Colors.black,
                //     )),
                // InkWell(
                //     onTap: () async {
                //       var selectedText = await widget.controller.getSelectedText();
                //       debugPrint('selectedText $selectedText');
                //       var selectedHtmlText =
                //       await widget.controller.getSelectedHtmlText();
                //       debugPrint('selectedHtmlText $selectedHtmlText');
                //     },
                //     child: const Icon(
                //       Icons.add_circle,
                //       color: Colors.black,
                //     )),
              ],
            ),
            Expanded(
              child: QuillHtmlEditor(
                hintText: 'Hint text goes here',
                controller: widget.controller,
                isEnabled: true,
                ensureVisible: true,
                minHeight: widget.height,
                autoFocus: false,
                textStyle: _editorTextStyle,
                hintTextStyle: _hintTextStyle,
                hintTextAlign: TextAlign.start,
                padding: const EdgeInsets.only(left: 5, top: 5),
                hintTextPadding: const EdgeInsets.only(left: 5),
                backgroundColor: _backgroundColor,
                inputAction: InputAction.newline,
                onEditingComplete: (s) => debugPrint('Editing completed $s'),
                loadingBuilder: (context) {
                  return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: Colors.transparent,
                      ));
                },
                onFocusChanged: (focus) {
                  setState(() {
                    _hasFocus = focus;
                  });
                },
                onEditorCreated: () {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: _toolbarIconColor,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: _toolbarColor),
          )),
    );
  }

  void getHtmlText() async {
    String? htmlText = await widget.controller.getText();
    debugPrint(htmlText);
  }

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await widget.controller.setText(text);
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await widget.controller.embedImage(url);
  }

  ///[insertVideoURL] to set the video url to editor
  ///this method recognises the inserted url and sanitize to make it embeddable url
  ///eg: converts youtube video to embed video, same for vimeo
  void insertVideoURL(String url) async {
    await widget.controller.embedVideo(url);
  }

  /// to set the html text to editor
  /// if index is not set, it will be inserted at the cursor postion
  void insertHtmlText(String text, {int? index}) async {
    await widget.controller.insertText(text, index: index);
  }

  /// to clear the editor
  void clearEditor() => widget.controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => widget.controller.enableEditor(enable);

  /// method to un focus editor
  void unFocusEditor() => widget.controller.unFocus();
}
