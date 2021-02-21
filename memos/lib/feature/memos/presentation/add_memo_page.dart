import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:memos/core/core_container.dart';
import 'package:memos/feature/login/model/current_user.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:memos/feature/memos/domain/repository/memos_repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddMemoPage extends StatefulWidget {
  const AddMemoPage({Key key}) : super(key: key);

  @override
  _AddMemoPageState createState() => _AddMemoPageState();
}

class _AddMemoPageState extends State<AddMemoPage> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _contentEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fab(),
      appBar: AppBar(
        title: Text('Add note'),
      ),
      body: _buildNoteDetail(),
      // bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _fab() {
    return FloatingActionButton(
      child: Icon(Icons.save),
      onPressed: () async {
        final newMemo = MemoDomainModel(
          id: Uuid().v4(),
          title: _titleEditingController.text,
          content: _contentEditingController.text,
          color: Colors.red,
          state: MemoState.all,
          createdAt: DateTime.now(),
          remindAt: DateTime.now().add(Duration(days: 1)),
          tags: [],
          creator: Provider.of<CurrentUser>(context, listen: false).data.email,
        );

        final MemosRepository memosRepository = sl();
        await memosRepository.insertMemo(newMemo);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildNoteDetail() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        TextField(
          controller: _titleEditingController,
          // style: kNoteTitleLight,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            labelText: 'Titolo',
            counter: SizedBox(),
            prefixIcon: const Icon(
              Icons.title,
            ),
          ),
          maxLines: null,
          maxLength: 1024,
          textCapitalization: TextCapitalization.sentences,
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _contentEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            labelText: 'Contenuto',
            alignLabelWithHint: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 365.0),
              child: const Icon(
                Icons.subject,
              ),
            ),
          ),
          maxLength: 2048,
          maxLines: 20,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }

  // Widget _buildBottomAppBar(BuildContext context) {
  //   return BottomAppBar(
  //     child: Container(
  //       height: kBottomBarSize,
  //       padding: const EdgeInsets.symmetric(horizontal: 9),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: <Widget>[
  //           IconButton(
  //             icon: const Icon(AppIcons.add_box),
  //             color: kIconTintLight,
  //           ),
  //           Text('Edited ${_note.strLastModified}'),
  //           IconButton(
  //             icon: const Icon(Icons.more_vert),
  //             color: kIconTintLight,
  //             onPressed: () => _showNoteBottomSheet(context),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
