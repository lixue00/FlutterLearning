import 'package:flutter/material.dart';
import '../Service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 828, height: 1792)..init(context);

    print('设备的像素密度${ScreenUtil.pixelRatio}');
    print('设备的高${ScreenUtil.screenHeight}');
    print('设备的宽度${ScreenUtil.screenWidth}');

    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      // 异步请求在渲染，不需要改变状态
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 有值就返回true
            // var data = json.decode(snapshot.data.toString());
            // cast是什么意思？？？
            List<Map> swiper =
                (snapshot.data['data']['homeBanner'] as List).cast();
            List<Map> navigatorList =
                (snapshot.data['data']['findBanner'] as List).cast();
            List<Map> navigatorList2 =
                (snapshot.data['data']['findIntegralConsume'] as List).cast();

            /// TODO: 待处理 数组的基本操作 合并两个数组
            navigatorList.addAll(navigatorList2);
            print('navigatorList === ${navigatorList.length}');

            return Column(
              children: <Widget>[
                SwiperDiy(
                  swiperDataList: swiper,
                ),
                TopNavigator(
                  navigatorList: navigatorList,
                )
              ],
            );
          } else {
            return Center(
              child: Text('加载中。。。。'),
            );
          }
        },
      ),
      // body: SingleChildScrollView(
      //   //
      //   child: Text(homePageContent),
      // ),
    );
  }
}

/// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  final Widget child;

  SwiperDiy({Key key, this.child, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.lightBlueAccent,
      height: 196,
      width: ScreenUtil().setWidth(1080),
      child: Swiper(
        itemBuilder: ((BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['imgUrl']}");
        }),
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _grideViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了盗号');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['imgUrl'],
            width: ScreenUtil().setWidth(200),
          ),
          Text(
            item['title'],
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _grideViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}