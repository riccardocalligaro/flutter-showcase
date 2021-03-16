import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:memos/core/core_container.dart';
import 'package:memos/feature/login/model/current_user.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:memos/feature/memos/domain/repository/memos_repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

class AddMemoPage extends StatefulWidget {
  const AddMemoPage({Key key}) : super(key: key);

  @override
  _AddMemoPageState createState() => _AddMemoPageState();
}

class _AddMemoPageState extends State<AddMemoPage> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _contentEditingController = TextEditingController();
  List<TagDomainModel> _items = [];

  @override
  void initState() {
    fetchTags();

    super.initState();
  }

  void fetchTags() async {
    final MemosRepository memosRepository = sl();
    final domainTags = await memosRepository.getTags();

    setState(() {
      _items = domainTags.getOrElse(() => null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fab(),
      appBar: AppBar(
        title: Text('Add memo'),
        brightness: Brightness.dark,
      ),
      body: _buildNoteDetail(),
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
          remindAt: DateTime.now().add(
            Duration(days: 1),
          ),
          tags: _items,
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
        Tags(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          horizontalScroll: true,
          key: _tagStateKey,
          textField: TagsTextField(
            autofocus: false,
            onSubmitted: (String str) {
              // Add item to the data source.
              setState(() {
                _items.add(TagDomainModel(
                  id: '',
                  title: str,
                  count: null,
                ));
              });
            },
          ),

          itemCount: _items.length, // required
          itemBuilder: (int index) {
            final item = _items[index];

            return ItemTags(
              key: Key(index.toString()),
              activeColor: Theme.of(context).primaryColor,
              index: index, // required
              title: item.title,
              removeButton: ItemTagsRemoveButton(
                onRemoved: () {
                  // Remove the item from the data source.
                  setState(() {
                    // required
                    _items.removeAt(index);
                  });
                  //required
                  return true;
                },
              ), // OR null,
              // onPressed: (item) => print(item),
              // onLongPressed: (item) => print(item),
              // onPressed: (item) => print(item),
              // onLongPressed: (item) => print(item),
            );
          },
        ),
        const SizedBox(
          height: 12,
        ),
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
        const SizedBox(
          height: 8,
        ),
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
        const SizedBox(
          height: 64,
        )
      ],
    );
  }
}
