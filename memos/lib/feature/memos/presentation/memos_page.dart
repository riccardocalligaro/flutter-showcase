import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memos/feature/login/model/current_user.dart';
import 'package:memos/feature/memos/presentation/bloc/memos/memos_watcher_bloc.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>
    with SingleTickerProviderStateMixin {
  int _selectedCategoryIndex = 0;
  TabController _tabController;
  final DateFormat _dateFormatter = DateFormat('dd MMM');
  final DateFormat _timeFormatter = DateFormat('h:mm');

  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 32,
          ),
          _TopAppBar(),
          BlocBuilder<MemosWatcherBloc, MemosWatcherState>(
            builder: (context, state) {
              if (state is MemosWatcherLoadSuccess) {
                // return Text(state.toString());
                return Column(
                  children: [
                    if (state.memosPageData.tags.isEmpty)
                      Container(
                        height: 280.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.tag,
                                color: Theme.of(context).primaryColor,
                                size: 81,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text('No tags')
                            ],
                          ),
                        ),
                      ),
                    if (state.memosPageData.tags.isNotEmpty)
                      Container(
                        height: 280.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.memosPageData.tags.length,
                          itemBuilder: (BuildContext context, int index) {
                            final tag = state.memosPageData.tags[index];
                            return _buildCategoryCard(
                              index,
                              tag.title,
                              0,
                            );
                          },
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
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: <Widget>[
                          Tab(child: Text('All')),
                          Tab(child: Text('Shared')),
                          Tab(child: Text('Archived')),
                          Tab(child: Text('Pinned')),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.memosPageData.memos.length,
                      itemBuilder: (context, index) {
                        return _MemoCard();
                      },
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

  Widget _buildCategoryCard(int index, String title, int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        height: 240.0,
        width: 175.0,
        decoration: BoxDecoration(
          color: _selectedCategoryIndex == index
              ? Color(0xFF417BFB)
              : Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            _selectedCategoryIndex == index
                ? BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 10.0)
                : BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                title,
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
              padding: EdgeInsets.all(20.0),
              child: Text(
                count.toString(),
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
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class _MemoCard extends StatelessWidget {
  const _MemoCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormatter = DateFormat('dd MMM');
    final DateFormat _timeFormatter = DateFormat('h:mm');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'notes[0].title',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _timeFormatter.format(DateTime.now()),
                style: TextStyle(
                  color: Color(0xFFAFB4C6),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text(
            'notes[0].content',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                _dateFormatter.format(DateTime.now()),
                style: TextStyle(
                  color: Color(0xFFAFB4C6),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: Color(0xFF417BFB),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
