import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:museo_zuccante/core/presentation/customization/mz_image.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:share/share.dart';

class CompanyPage extends StatefulWidget {
  final CompanyDomainModel company;

  CompanyPage({
    Key key,
    @required this.company,
  }) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    final company = widget.company;

    return Scaffold(
      appBar: AppBar(
        title: Text(company.title),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                'Scopri ${company.title}\nScarica gratuitamente museo Zuccante per leggere l\'articolo completo!',
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: MzImage(
              widget.company.poster,
              fit: BoxFit.fitWidth,
            ),
          ),
          ListTile(
            leading: Icon(Icons.store),
            title: Text(
                '${company.stillActive ? "Ancora attiva" : "Non più attiva"} '),
          ),
          const SizedBox(
            height: 8,
          ),
          Markdown(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            data: company.body,
          )
        ],
      ),
    );
  }
}
