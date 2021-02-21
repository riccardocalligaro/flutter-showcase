import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'memos_filter.dart';

/// Navigation drawer for the app.
class MDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<MemoFilter>(
        builder: (context, filter, _) => Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _drawerHeader(context),
              _DrawerFilterItem(
                icon: Icons.notes,
                title: 'Notes',
                isChecked: filter.memoState == MemoState.unspecified,
                onTap: () {
                  filter.memoState = MemoState.unspecified;
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              _DrawerFilterItem(
                icon: Icons.archive,
                title: 'Archive',
                isChecked: filter.memoState == MemoState.archived,
                onTap: () {
                  filter.memoState = MemoState.archived;
                  Navigator.pop(context);
                },
              ),
              _DrawerFilterItem(
                icon: Icons.delete,
                title: 'Trash',
                isChecked: filter.memoState == MemoState.deleted,
                onTap: () {
                  filter.memoState = MemoState.deleted;
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              _DrawerFilterItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  // TODO: change to route
                  Navigator.popAndPushNamed(context, '/settings');
                },
              ),
              // _DrawerFilterItem(
              //   icon: Icons.help_outline,
              //   title: 'About',
              //   onTap: () => launch('https://github.com/xinthink/flutter-keep'),
              // ),
            ],
          ),
        ),
      );

  Widget _drawerHeader(BuildContext context) => SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w300,
                letterSpacing: -2.5,
              ),
              children: [
                const TextSpan(
                  text: 'Flt',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const TextSpan(text: ' Keep'),
              ],
            ),
          ),
        ),
      );
}

class _DrawerFilterItem extends StatelessWidget {
  /// Build an instance of [_DrawerFilterItem].
  ///
  /// Given a required [title], an optional leading [icon],
  /// and whether the item [isChecked].
  const _DrawerFilterItem({
    Key key,
    this.icon,
    this.iconSize = 26,
    @required this.title,
    this.isChecked = false,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final double iconSize;
  final String title;
  final bool isChecked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 12),
        child: InkWell(
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(30)),
          child: Container(
            decoration: ShapeDecoration(
              color: isChecked ? Colors.grey : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
            ),
            padding: const EdgeInsetsDirectional.only(
                top: 12.5, bottom: 12.5, start: 30, end: 18),
            child: _content(),
          ),
          onTap: onTap,
        ),
      );

  Widget _content() => Row(
        children: <Widget>[
          if (icon != null)
            Icon(
              icon,
              size: iconSize,
              color: isChecked ? Colors.green : Colors.green,
            ),
          if (icon != null) SizedBox(width: 24),
          Text(
            title,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 16,
            ),
          ),
        ],
      );
}
