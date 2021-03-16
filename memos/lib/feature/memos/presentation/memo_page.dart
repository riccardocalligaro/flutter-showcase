import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';

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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Tags(
          //   alignment: WrapAlignment.start,
          //   runAlignment: WrapAlignment.start,
          //   horizontalScroll: true,

          //   itemCount: memo.tags.length, // required
          //   itemBuilder: (int index) {
          //     final item = memo.tags[index];

          //     return ItemTags(
          //       key: Key(index.toString()),
          //       activeColor: Theme.of(context).primaryColor,
          //       index: index, // required
          //       title: item.title,
          //       // removeButton: null,
          //       pressEnabled: false,
          //     );
          //   },
          // ),
          Text(memo.tags.toString()),
          Text(memo.state.toString()),

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
