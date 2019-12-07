// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/model/hot_search.dart';
import 'package:netease_cloud_music/pages/search/search_multiple_result_page.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';

import 'new_search_song_page.dart';

class NewSearchPage extends StatefulWidget {
  @override
  _NewSearchPageState createState() => _NewSearchPageState();
}

class _NewSearchPageState extends State<NewSearchPage> with TickerProviderStateMixin{
  List<String> historySearchList;
  TextEditingController _searchController = TextEditingController();
  FocusNode _blankNode = FocusNode();
  bool _isSearching = false;
  List<String> _searchingTabKeys = ['单曲'];
  TabController _searchingTabController;
  String searchText;

  @override
  void initState() {
    super.initState();
    //historySearchList = Application.sp.getStringList("search_history") ?? [];
    //_searchingTabKeys.addAll(_searchingTabMap.keys.toList());
    _searchingTabController =
        TabController(length: _searchingTabKeys.length, vsync: this);
  }
  // 热搜
  void _search() {
    FocusScope.of(context).requestFocus(_blankNode);
    setState(() {
      _isSearching = true;
      _searchController.text = searchText;
    });
  }
  Widget _buildUnSearchingLayout() {
    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(40),
          vertical: ScreenUtil().setWidth(30)),
      children: <Widget>[
        //_buildHistorySearch(),
        //_buildHotSearch(),
      ],
    );
  }
  Widget _buildSearchingLayout() {
    return Column(
      children: <Widget>[
        TabBar(
          isScrollable: true,
          indicatorColor: Colors.red,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black87,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _searchingTabKeys.map((key) => Tab(text: key,)).toList(),
          controller: _searchingTabController,
        ),
        Expanded(
          child: TabBarView(
            children:[
              NewSearchSongPage(searchText)
            ],
            controller: _searchingTabController,
          ),
        ),
      ],
    );
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Theme(
            child: TextField(
              controller: _searchController,
              cursorColor: Colors.red,
              textInputAction: TextInputAction.search,
              onEditingComplete: () {
                searchText = _searchController.text.isEmpty
                    ? '林俊杰'
                    : _searchController.text;
                _search();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "林俊杰",
                hintStyle: commonGrayTextStyle,
                suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      if (_searchController.text.isNotEmpty)
                        setState(() {
                          _searchController.text = "";
                        });
                    }),
              ),
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black54),
          ),
        ),
        body: Listener(
          onPointerDown: (d) {
            FocusScope.of(context).requestFocus(_blankNode);
          },
          child: _isSearching
              ? _buildSearchingLayout()
              : _buildUnSearchingLayout(),
        ),
      ),
      onWillPop: () async {
        if (_isSearching) {
          // 如果是搜索的状态，则不返回，并且清空输入框
          setState(() {
            _searchController.text = "";
            _isSearching = false;
          });
          return false;
        }
        return true;
      },
    );
  }
}