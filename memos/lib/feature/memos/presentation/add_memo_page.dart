import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:memos/core/core_container.dart';
import 'package:memos/core/infrastructure/m_notifications.dart';
import 'package:memos/feature/login/model/current_user.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:memos/feature/memos/domain/repository/memos_repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:timezone/timezone.dart' as tz;

import 'custom/date_alert.dart';
import 'custom/time_alert.dart';

final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

class AddMemoPage extends StatefulWidget {
  final bool editMode;
  final MemoDomainModel memo;

  const AddMemoPage({
    Key key,
    this.editMode = false,
    this.memo,
  }) : super(key: key);

  @override
  _AddMemoPageState createState() => _AddMemoPageState();
}

class _AddMemoPageState extends State<AddMemoPage> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _contentEditingController = TextEditingController();
  List<TagDomainModel> _items = [];
  DateTime _selectedDate;

  Duration _beforeNotify = Duration(minutes: 30);
  bool _notifyEvent = false;

  @override
  void initState() {
    if (widget.editMode) {
      setInitialValues();
    } else {
      fetchTags();
    }

    super.initState();
  }

  void setInitialValues() {
    setState(() {
      _titleEditingController.text = widget.memo.title;
      _contentEditingController.text = widget.memo.content;
      _items = widget.memo.tags;
    });
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
        title: Text(widget.editMode ? 'Add memo' : 'Edit memo'),
        brightness: Brightness.dark,
      ),
      body: _buildNoteDetail(),
    );
  }

  Widget _fab() {
    return FloatingActionButton(
      child: Icon(Icons.save),
      onPressed: () async {
        final MemosRepository memosRepository = sl();

        if (!widget.editMode) {
          final newMemo = MemoDomainModel(
            id: Uuid().v4(),
            title: _titleEditingController.text,
            content: _contentEditingController.text,
            color: Colors.red,
            state: MemoState.all,
            createdAt: DateTime.now(),
            remindAt:
                _notifyEvent ? _selectedDate.subtract(_beforeNotify) : null,
            tags: _items,
            creator:
                Provider.of<CurrentUser>(context, listen: false).data.email,
          );
          await memosRepository.insertMemo(newMemo);

          if (_notifyEvent) {
            final MNotifications mNotifications = sl();

            mNotifications.scheduleNotification(
              eventId: 1,
              title: _titleEditingController.text,
              message: 'Rembeber this.',
              scheduledTime: tz.TZDateTime.from(
                _selectedDate.subtract(_beforeNotify),
                tz.local,
              ),
            );
          }
        } else {
          final updatedMemo = MemoDomainModel(
            id: widget.memo.id,
            title: _titleEditingController.text,
            content: _contentEditingController.text,
            color: widget.memo.color,
            state: widget.memo.state,
            createdAt: widget.memo.createdAt,
            remindAt: widget.memo.remindAt,
            tags: _items,
            creator: widget.memo.creator,
          );

          await memosRepository.updateMemo(updatedMemo);
        }

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
        const SizedBox(
          height: 12,
        ),
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
        if (!widget.editMode)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Notifica evento'),
            value: _notifyEvent,
            onChanged: (bool value) {
              if (value != null) {
                setState(() {
                  _notifyEvent = value;
                });
              }
            },
          ),
        if (_notifyEvent)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.today),
            title: Text('Date'),
            trailing: Text(_selectedDate != null
                ? _selectedDate.toLocal().toString()
                : 'Nessuna data selezionata'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => SelectDateDialog(),
              ).then((date) {
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                }
              });
            },
          ),
        if (_notifyEvent)
          Row(
            children: [
              Row(
                children: <Widget>[
                  Icon(
                    Icons.notifications_none,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(getBeforeNotifyTimeMessage(_beforeNotify, context)),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => SelectNotificationsTimeAlertDialog(
                      beforeNotification: _beforeNotify,
                    ),
                  ).then((duration) {
                    if (duration != null) {
                      setState(() {
                        _beforeNotify = duration;
                      });
                    }
                  });
                },
                child: Container(
                  child: Text('Aggiungi notifica'),
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 16,
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

  getBeforeNotifyTimeMessage(Duration d, BuildContext context) {
    if (d.inMilliseconds == 0) {
      return 'Al momento';
    } else if (d.inMinutes == 1) {
      return '{m} minuto prima'.replaceAll('{m}', '1');
    } else if (d.inMinutes < 60) {
      return '{m} minuti prima'.replaceAll('{m}', d.inMinutes.toString());
    } else if (d.inHours < 24) {
      if (d.inHours == 1) {
        return '{m} ora prima'.replaceAll('{m}', '1');
      }
      return '{m} ore prima'.replaceAll('{m}', d.inHours.toString());
    } else {
      return 'Un giorno prima';
    }
  }
}
