import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/model/album.dart';
import 'package:netease_cloud_music/model/banner.dart' as prefix0;
import 'package:netease_cloud_music/model/mv.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_banner.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';
import 'package:netease_cloud_music/widgets/widget_play_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttentionPage extends StatefulWidget{
  @override
  _AttentionPageState createState() => _AttentionPageState();

}

class _AttentionPageState extends State<AttentionPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget _buildRecommendPlayList() {
    return CustomFutureBuilder<RecommendData>(
      futureFunc: NetUtils.getRecommendData,
      builder: (context, snapshot) {
        var data = snapshot.recommend;
        return Container(
            height: ScreenUtil().setWidth(300),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return HEmptyView(ScreenUtil().setWidth(30));
              },
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(15)),
              itemBuilder: (context, index) {
                return PlayListWidget(
                  text: data[index].name,
                  picUrl: data[index].picUrl,
                  playCount: data[index].playcount,
                  maxLines: 2,
                  onTap: (){
                    NavigatorUtil.goPlayListPage(context, data: data[index]);
                  },
                );
              },
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
            ));
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  VEmptyView(40),
                  VEmptyView(20),
                  Text(
                    '关注',
                    style: commonTextStyle,
                  ),
                ],
              ),
            ),
            VEmptyView(20),
            _buildRecommendPlayList(),
            //VEmptyView(30),
            //Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: ScreenUtil().setWidth(15),
            //   ),
            //   child: Text(
            //     '新碟上架',
            //     style: commonTextStyle,
            //   ),
            //  ),
            //  VEmptyView(20),
            //_buildNewAlbum(),
            //VEmptyView(30),
            // Padding(
            //padding: EdgeInsets.symmetric(
            //   horizontal: ScreenUtil().setWidth(15),
            //  ),
            //  child: Text(
            //    'MV 排行',
            //    style: commonTextStyle,
            //  ),
            // ),
            // VEmptyView(20),
            //_buildTopMv(),
          ],
        ),
      ),
    );
  }




  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}