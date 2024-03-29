import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:memos/feature/memos/presentation/add_memo_page.dart';

class MemoPage extends StatelessWidget {
  final MemoDomainModel memo;
  const MemoPage({
    Key key,
    @required this.memo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memo.title),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AddMemoPage(
                    editMode: true,
                    memo: memo,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Tags(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            horizontalScroll: true,

            itemCount: memo.tags.length, // required
            itemBuilder: (int index) {
              final item = memo.tags[index];

              return ItemTags(
                key: Key(index.toString()),
                activeColor: Theme.of(context).primaryColor,
                index: index, // required
                title: item.title,
                // removeButton: null,
                pressEnabled: false,
              );
            },
          ),
          Markdown(
            physics: NeverScrollableScrollPhysics(),
            data: memo.content,
            shrinkWrap: true,
            padding: EdgeInsets.all(6.0),
          ),
        ],
      ),
    );
  }
}
