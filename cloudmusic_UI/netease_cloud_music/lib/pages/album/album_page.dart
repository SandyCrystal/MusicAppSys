
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/album.dart';

import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_album_detail.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';



class AlbumPage extends StatefulWidget {
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> with TickerProviderStateMixin,  AutomaticKeepAliveClientMixin{
  Widget _buildRecommendAlbumList() {
    return CustomFutureBuilder<AlbumData>(
      futureFunc: NetUtils.getAlbumData,
      builder: (context, snapshot) {
        var data = snapshot.albums;
        return Container(
            height: ScreenUtil().setWidth(900),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                //childAspectRatio: 50,
              ),
              itemBuilder: (context, index) {
                return AlbumDetailWidget(
                  text: data[index].name,
                  picUrl: data[index].picUrl,
                  maxLines: 1,
                  onTap: (){
                    NavigatorUtil.goAlbumDetailsPage(context, data: data[index]);
                  },
                );
              },
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.total,
            ));
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("专辑"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){Navigator.pop(context);},
        ),
      ),
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
                  VEmptyView(20),
                  _buildRecommendAlbumList(),
                ],
              ),
            ),
            VEmptyView(20),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
