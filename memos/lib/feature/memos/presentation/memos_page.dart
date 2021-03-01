import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memos/core/core_container.dart';
import 'package:memos/core/presentation/m_custom_placeholder.dart';
import 'package:memos/core/presentation/no_glow.dart';
import 'package:memos/feature/login/model/current_user.dart';
import 'package:memos/feature/memos/domain/model/memo_domain_model.dart';
import 'package:memos/feature/memos/domain/repository/memos_repository.dart';
import 'package:memos/feature/memos/presentation/add_memo_page.dart';
import 'package:memos/feature/memos/presentation/bloc/memos/memos_watcher_bloc.dart';
import 'package:memos/feature/memos/presentation/custom/email_alert.dart';
import 'package:memos/feature/memos/presentation/memo_page.dart';
import 'package:memos/feature/settings/settings_page.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>
    with SingleTickerProviderStateMixin {
  MemoState _filterState;
  TagDomainModel _filterTag;

  int _selectedCategoryIndex = -1;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _filterState = MemoState.values[_tabController.index];
      });

      BlocProvider.of<MemosWatcherBloc>(context).add(
        FilterMemos(
          filter: MemoState.values[_tabController.index],
          tag: _filterTag,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fab(),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 32,
          ),
          _TopAppBar(),
          BlocBuilder<MemosWatcherBloc, MemosWatcherState>(
            builder: (context, state) {
              if (state is MemosWatcherLoadSuccess) {
                return Column(
                  children: [
                    if (state.memosPageData.tags.isEmpty)
                      Container(
                        height: 280.0,
                        child: MCustomPlaceHolder(
                          text: 'No tags',
                          icon: Icons.tag,
                          showUpdate: false,
                        ),
                      ),
                    if (state.memosPageData.tags.isNotEmpty)
                      Container(
                        height: 280.0,
                        child: ScrollConfiguration(
                          behavior: NoGlowBehavior(),
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.memosPageData.tags.length,
                            itemBuilder: (BuildContext context, int index) {
                              final tag = state.memosPageData.tags[index];
                              return _buildCategoryCard(index, tag);
                            },
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey.withOpacity(0.8),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 4.0,
                        isScrollable: true,
                        unselectedLabelStyle: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.w500,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Product Sans',
                        ),
                        tabs: <Widget>[
                          Tab(child: Text('All')),
                          Tab(child: Text('Shared')),
                          Tab(child: Text('Archived')),
                          Tab(child: Text('Pinned')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    if (state.memosPageData.memos.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: MCustomPlaceHolder(
                          text: 'No notes',
                          icon: Icons.note,
                          showUpdate: true,
                          updateMessage: 'Add note',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddMemoPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    if (state.memosPageData.memos.isNotEmpty)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.memosPageData.memos.length,
                        itemBuilder: (context, index) {
                          final memo = state.memosPageData.memos[index];

                          final DateFormat _dateFormatter =
                              DateFormat('dd MMMM yyyy');

                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MemoPage(memo: memo),
                                  ),
                                );
                              },
                              onLongPress: () async {
                                final MemosRepository memosRepository = sl();
                                await memosRepository.deleteMemo(memo);
                              },
                              title: Text('${memo.title}'),
                              subtitle: Text(
                                _dateFormatter.format(
                                  memo.createdAt,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.share),
                                onPressed: () {
                                  MemosRepository memosRepository = sl();
                                  showDialog(
                                      context: context,
                                      builder: (context) => EmailAlert(
                                            memoId: memo.id,
                                          ));
                                  // memosRepository.shareMemo(memo.id, email);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    const SizedBox(
                      height: 64,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _fab() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddMemoPage(),
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(int index, TagDomainModel tag) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index != _selectedCategoryIndex) {
            _selectedCategoryIndex = index;
            BlocProvider.of<MemosWatcherBloc>(context).add(
              FilterMemos(
                filter: _filterState,
                tag: _filterTag,
              ),
            );
            _filterTag = tag;
          } else {
            _selectedCategoryIndex = -1;
            _filterTag = null;
            BlocProvider.of<MemosWatcherBloc>(context).add(
              FilterMemos(
                filter: _filterState,
                tag: null,
              ),
            );
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        height: 240.0,
        width: 175.0,
        decoration: BoxDecoration(
          color: _selectedCategoryIndex == index
              ? Color(0xFF417BFB)
              : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            _selectedCategoryIndex == index
                ? const BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 10.0,
                  )
                : BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 10.0,
                  ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                tag.title,
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Color(0xFFAFB4C6),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '${tag.count}',
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopAppBar extends StatelessWidget {
  const _TopAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = Provider.of<CurrentUser>(context)?.data?.photoURL;
    final username = Provider.of<CurrentUser>(context)?.data?.displayName;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            child: CircleAvatar(
              backgroundImage: url != null ? NetworkImage(url) : null,
              child: url == null ? const Icon(Icons.face) : null,
              radius: 19,
            ),
          ),
          const SizedBox(width: 16.0),
          Text(
            username,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () async {
              final MemosRepository memosRepository = sl();
              final response = await memosRepository.syncWithRemote();
              response.fold(
                (l) => Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Errore aggiornamento')),
                ),
                (r) => Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Aggiornato con successo')),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
