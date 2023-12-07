

import 'login.dart' as login;
import 'index.dart' as index;

final Map<String, String> lang = {
  "app_name": "摸鱼派",
  "Login title": "登录",
  'Pull to load': '上拉加载',
  'Release ready': '释放开始',
  'Loading...': '加载中...',
  'Succeeded': '成功',
  'No more': '没有更多',
  'Failed': '失败了',
  'Last updated at %T': '最后更新于 %T',
  'Pull to refresh': '下拉刷新',
  'Refreshing...': '刷新中...',
  ...login.lang.map((key, value) => MapEntry('login.$key', value)),
  ...index.lang.map((key, value) => MapEntry('index.$key', value)),
};
