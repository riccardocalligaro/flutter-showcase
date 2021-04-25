import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:museo_zuccante/core/presentation/customization/mz_image.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/item/presentation/company_page.dart';
import 'package:share/share.dart';

class ItemPage extends StatefulWidget {
  final ItemDomainModel item;
  final bool fromHome;

  ItemPage({
    Key key,
    @required this.item,
    this.fromHome = true,
  }) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  double top = 0.0;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                '${item.title}\n${item.subtitle}\nScarica gratuitamente museo Zuccante per leggere l\'articolo completo!',
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Hero(
              tag: widget.fromHome
                  ? 'item${widget.item.id}'
                  : 'item-list${widget.item.id}',
              child: Container(
                height: 300,
                padding: EdgeInsets.only(top: max(top, 0)),
                width: double.infinity,
                child: MzImage(
                  widget.item.poster,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Scritto da ${item.author}'),
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('${item.company.title}'),
            subtitle: Text('Premi per scoprire di più'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return CompanyPage(company: item.company);
                }),
              );
            },
          ),
          Markdown(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            data: item.body,
          )
        ],
      ),
    );
  }
}
