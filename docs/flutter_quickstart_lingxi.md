# Flutter 入门速成（基于 Lingxi AI App 项目）

## 1. 文档目标

这不是一份从 0 到精通的大全，而是一份适合你当前项目的短期上手文档。

你学完这份文档，目标是做到 4 件事：

- 看懂这个项目的目录结构
- 能独立新增一个页面
- 能写出常见 UI 和交互
- 能接 mock 数据、路由、网络请求

建议学习方式：

- 先完整读一遍
- 再一边对照项目一边修改代码
- 最后按文末练习题自己做 2 到 3 个小功能

---

## 2. 先认识这个项目

这个项目本质上是一个 Flutter 电商 App 骨架，已经包含了入门开发最常见的部分：

- 启动入口
- 页面路由
- 登录页
- 底部 Tab
- 首页商品展示
- mock 数据
- 本地存储
- 网络请求封装

### 2.1 你应该先看哪些文件

按这个顺序看，理解最快：

1. `lib/main.dart`
2. `lib/app/bootstrap.dart`
3. `lib/app/app.dart`
4. `lib/app/router/app_router.dart`
5. `lib/features/home/presentation/pages/main_tab_page.dart`
6. `lib/features/home/presentation/pages/home_page.dart`
7. `lib/features/home/data/mock/home_mock_data.dart`
8. `lib/core/network/api_client.dart`

### 2.2 这个项目的目录思路

```text
lib/
  app/                  应用级配置：启动、路由、全局服务
  core/                 通用基础能力：网络、存储、鉴权、消息提示
  features/             业务模块：home / auth / cart / product / profile
```

这是比较常见的 Flutter 分层方式。

你可以先把它理解成：

- `app`：整个应用怎么启动、怎么跳页面
- `core`：所有模块都会复用的公共能力
- `features`：每个业务页面和业务逻辑

---

## 3. Flutter 最重要的核心：一切都是 Widget

在 Flutter 里，页面上的几乎所有东西都是 Widget。

比如：

- 一个页面是 Widget
- 一个按钮是 Widget
- 一段文字是 Widget
- 一个输入框是 Widget
- 一块间距也是 Widget

你在 `home_page.dart` 里能看到很多典型例子：

- `Scaffold`：页面骨架
- `SafeArea`：避开刘海屏、安全区域
- `CustomScrollView`：可滚动区域
- `Padding`：内边距
- `Text`：文字
- `Container`：容器
- `GridView`：网格布局
- `InkWell`：点击效果

### 3.1 StatelessWidget 和 StatefulWidget

这是入门必须吃透的第一个概念。

#### `StatelessWidget`

适合“显示后基本不变”的组件。

例如：

- 搜索条 `SearchBarSection`
- 分类宫格 `CategoryGrid`
- 商品卡片

特点：

- 自己不保存变化状态
- 数据通常由外部传入

#### `StatefulWidget`

适合“界面会变化”的组件。

例如这个项目里的：

- `HomePage`：轮播图下标会变化
- `LoginPage`：密码是否可见、协议是否勾选会变化
- `MainTabPage`：底部 tab 当前索引会变化

特点：

- 有状态
- 调用 `setState()` 后会触发界面刷新

### 3.2 你现在就能理解的一个例子

在 `HomePageState` 里：

```dart
int bannerIndex = 0;
```

它表示当前轮播图的下标。

当页面切换时：

```dart
setState(() {
  bannerIndex = v;
});
```

这就是 Flutter 最基础的状态更新方式：

1. 状态变量变了
2. 调用 `setState`
3. `build()` 重新执行
4. 页面重新渲染

---

## 4. 先学会看 `build()` 方法

几乎所有 Flutter UI 开发，最终都落在 `build(BuildContext context)`。

你可以把 `build()` 理解成：

“告诉 Flutter，这一刻页面应该长什么样。”

例如首页的整体结构可以这样理解：

```text
Scaffold
  SafeArea
    CustomScrollView
      搜索栏
      轮播图
      分类宫格
      推荐商品标题
      商品双列网格
```

所以你看 Flutter 页面，不要一上来钻语法细节，先看结构树。

建议你训练自己：

- 先看最外层是什么
- 再看里面有哪些区块
- 最后再看每个区块的交互和数据来源

---

## 5. 这个项目里你需要掌握的常见 Widget

### 5.1 页面骨架

- `Scaffold`：页面基础结构
- `AppBar`：顶部导航栏
- `BottomNavigationBar`：底部导航

### 5.2 布局

- `Row`：横向排列
- `Column`：纵向排列
- `Expanded`：占据剩余空间
- `SizedBox`：固定间距/尺寸
- `Padding`：内边距
- `Center`：居中
- `Container`：带装饰的盒子

### 5.3 列表与滚动

- `ListView`
- `GridView`
- `CustomScrollView`
- `SliverToBoxAdapter`
- `SliverGrid`

你这个项目首页用了 `CustomScrollView + Sliver`，这比普通 `Column` 更适合复杂滚动页面。

### 5.4 输入与交互

- `TextField`
- `FilledButton`
- `TextButton`
- `IconButton`
- `Checkbox`
- `InkWell`

登录页几乎就是一份非常好的基础 UI 练习样例。

---

## 6. 先学会从入口跑通整个 App

### 6.1 启动流程

启动链路是：

`main.dart` -> `bootstrap.dart` -> `app.dart`

#### `main.dart`

这里只做一件事：启动 App。

#### `bootstrap.dart`

这里做初始化，比如：

- `WidgetsFlutterBinding.ensureInitialized()`
- `AppServices.instance.init()`

这说明一个重要意识：

Flutter 项目不是所有东西都堆在 `main()` 里，初始化逻辑应该单独拆出来。

#### `app.dart`

这里定义全局 App：

- `MaterialApp`
- 主题 `ThemeData`
- 初始路由
- 路由分发

---

## 7. 学会路由：页面是怎么跳转的

这个项目当前使用的是 Flutter 原生命名路由方式。

核心文件：

- `lib/app/router/app_routes.dart`
- `lib/app/router/app_router.dart`

### 7.1 路由怎么理解

你可以把路由看成：

- 页面名字
- 页面创建规则
- 页面跳转动作

### 7.2 这个项目里的跳转方式

比如登录成功：

```dart
Navigator.pushReplacementNamed(context, AppRoutes.home);
```

比如进入商品详情：

```dart
Navigator.pushNamed(
  context,
  AppRoutes.productDetail,
  arguments: 'recommend_${index + 1}',
);
```

说明你要掌握 3 个动作：

- `pushNamed`：压入新页面
- `pushReplacementNamed`：替换当前页面
- `pop`：返回上一页

### 7.3 你以后新增页面的标准动作

1. 创建页面文件
2. 在 `app_routes.dart` 增加路由常量
3. 在 `app_router.dart` 里注册页面
4. 在按钮点击处调用 `Navigator`

---

## 8. 学会看业务模块结构

以首页模块为例：

```text
features/home/
  data/mock/             mock 数据
  domain/entities/       数据实体
  presentation/pages/    页面
```

这是很适合新手理解的轻量分层：

- `domain/entities`：数据长什么样
- `data/mock`：数据先从哪里来
- `presentation/pages`：页面怎么显示

### 8.1 实体是什么

例如：

- `HomeCategory`
- `RecommendProduct`

它们本质就是 Dart 类，用来描述数据结构。

例如 `RecommendProduct` 表达的是：

- 商品标题
- 价格
- 原价
- 销量

### 8.2 mock 数据是什么

`home_mock_data.dart` 的作用是：

- 在没有后端接口时先把页面跑起来
- 让你先练 UI 和交互
- 后面再逐步替换成真实接口

这个开发节奏非常常见，你以后也应该这样做。

---

## 9. Dart 语法里你先掌握这些就够了

短期上手 Flutter，不需要把 Dart 所有语法都学完。

你先掌握下面这些：

### 9.1 类和构造函数

```dart
class HomeCategory {
  const HomeCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
```

要看懂：

- `class`：定义类
- `const` 构造函数：常量对象
- `final`：赋值后不可再改

### 9.2 命名参数

```dart
const SearchBarSection({super.key, required this.onTap});
```

要看懂：

- 花括号表示命名参数
- `required` 表示必传

### 9.3 匿名函数

```dart
onTap: () {
  setState(() {
    currentIndex = index;
  });
}
```

这在 Flutter 里极其常见，因为点击事件、构建列表、路由回调都会用到。

### 9.4 集合生成

```dart
List.generate(30, (i) => ...)
```

这常用于快速构造 mock 列表。

---

## 10. 学会状态管理的第一步：先用好 `setState`

很多新手一开始就想学 Provider、Bloc、Riverpod，其实不急。

你当前这个项目规模，先把 `setState` 用熟最重要。

### 10.1 什么时候用 `setState`

当以下数据变化，并且变化后要刷新 UI，就用：

- 当前 tab 下标
- 密码显隐
- 轮播图索引
- 复选框是否选中

### 10.2 一个简单判断标准

如果状态只影响当前页面，并且逻辑不复杂，优先 `StatefulWidget + setState`。

只有当状态：

- 跨页面共享
- 逻辑复杂
- 异步请求特别多

再考虑更正式的状态管理方案。

---

## 11. 学会写页面的基本套路

以后你写一个新页面，可以直接套这个流程。

### 11.1 第一步：先写静态 UI

先不要急着接接口，先把页面结构搭出来。

例如：

- 用 `Scaffold` 搭骨架
- 用 `Column` / `ListView` 排内容
- 用 `Text` / `Container` / `Image` 占位

### 11.2 第二步：再加交互

例如：

- 点击按钮
- 切换 tab
- 展开收起
- 输入框控制

### 11.3 第三步：接 mock 数据

先定义实体，再造假数据，把页面跑通。

### 11.4 第四步：最后接真实接口

这一步再接 `ApiClient`，开发体验会顺很多。

---

## 12. 学会网络请求层怎么接

这个项目已经有一个比较清楚的网络基础层：`lib/core/network/api_client.dart`

你现在不需要把它一次全啃完，只要先理解 4 件事。

### 12.1 它在做什么

`ApiClient` 封装了：

- `get`
- `post`
- `put`
- `delete`

这样业务页面不用每次都直接操作 `Dio`。

### 12.2 它为什么有价值

因为它统一处理了：

- 超时
- token 注入
- 错误提示
- 响应格式解析

这就是工程化开发和“页面里直接乱写请求”的差别。

### 12.3 token 是怎么加进去的

在请求拦截器里：

- 从 `TokenStore` 读 token
- 放到请求头 `Authorization`

这说明你还需要理解这条链路：

`AppStorage` -> `TokenStore` -> `ApiClient`

### 12.4 你以后怎么接接口

建议流程：

1. 先定义返回数据实体
2. 写一个 parser
3. 调 `apiClient.get()` 或 `post()`
4. 根据 `ApiResult` 渲染页面

---

## 13. 学会本地存储

这个项目用的是 `shared_preferences`。

对应封装：

- `AppStorage`
- `TokenStore`

### 13.1 新手要理解什么

你可以把它理解成轻量级本地键值存储。

适合存：

- token
- 用户信息的一小部分
- 是否首次打开
- 本地开关配置

### 13.2 不适合存什么

不适合存复杂关系型业务数据。

复杂数据一般：

- 用数据库
- 或直接走服务端

---

## 14. 你应该怎样阅读首页代码

你的当前活动文件 `home_page.dart` 很适合拿来做 Flutter 入门训练。

建议你按这个顺序拆：

### 14.1 先看页面状态

```dart
int bannerIndex = 0;
final List<HomeCategory> categories = HomeMockData.categories;
final List<RecommendProduct> recommendProducts = HomeMockData.recommendProducts;
```

先搞清楚：

- 哪些是状态
- 哪些是固定数据

### 14.2 再看页面结构

首页由 5 块组成：

1. 搜索栏
2. 轮播图
3. 分类宫格
4. 标题
5. 商品网格

### 14.3 再看组件拆分

这个页面已经做了很适合新手学习的拆分：

- `SearchBarSection`
- `BannerCarousel`
- `DotsIndicator`
- `CategoryGrid`
- `ProductCard`

这说明一个好习惯：

当一个页面越来越长时，要把区块拆成独立 Widget。

### 14.4 你应该从中学到什么

- 页面不是一次性写到底
- 可以先主页面搭结构，再把局部抽组件
- 数据通过构造函数传进去

---

## 15. 7 天速成学习路线

下面这套最适合你现在的目标：短期能上手开发。

### Day 1：理解项目结构

任务：

- 跑起项目
- 看 `main.dart`、`bootstrap.dart`、`app.dart`
- 看 `app_router.dart`

目标：

- 说清楚 App 是怎么启动的
- 说清楚页面是怎么跳转的

### Day 2：专攻 Widget 和布局

任务：

- 仿写一个简单登录页
- 熟悉 `Row`、`Column`、`Container`、`Padding`、`Expanded`

目标：

- 能独立搭出一个静态页面

### Day 3：专攻状态和交互

任务：

- 自己写一个密码显隐
- 自己写一个 tab 切换
- 自己写一个收藏按钮切换状态

目标：

- 熟练使用 `StatefulWidget` 和 `setState`

### Day 4：专攻列表和组件拆分

任务：

- 看懂 `home_page.dart`
- 自己新增一个“热门商品区域”

目标：

- 知道何时拆小组件
- 知道如何传参

### Day 5：专攻路由

任务：

- 新增一个页面
- 在路由里注册
- 从首页跳过去

目标：

- 熟练完成页面新增和跳转

### Day 6：专攻数据

任务：

- 新增一个实体类
- 新增一份 mock 数据
- 把数据渲染到页面上

目标：

- 明白“实体 -> 数据 -> UI”这条链路

### Day 7：专攻网络和存储

任务：

- 看懂 `ApiClient`
- 看懂 `TokenStore`
- 模拟一次登录后保存 token

目标：

- 建立工程化开发意识

---

## 16. 你接下来最该做的 5 个练手任务

不要只看文档，直接做。

### 练手 1：给首页搜索栏加点击跳转

目标：

- 新建一个搜索页
- 点击 `SearchBarSection` 进入搜索页

你会学到：

- 页面创建
- 路由注册
- 点击事件

### 练手 2：给商品卡片加“收藏”状态

目标：

- 点击收藏图标切换选中状态

你会学到：

- 局部状态
- 列表项交互

### 练手 3：把首页轮播图改成真实图片

目标：

- 用网络图片或本地图片替换纯色占位

你会学到：

- `Image.network`
- `Image.asset`
- 资源配置

### 练手 4：新增“订单页”

目标：

- 在 `features` 下新增一个 `orders` 模块
- 做一个简单订单列表页

你会学到：

- feature 模块化
- 列表页面开发

### 练手 5：模拟登录后保存 token

目标：

- 登录按钮点击后调用 `tokenStore.saveToken()`

你会学到：

- 本地存储
- 登录链路

---

## 17. 新手最容易踩的坑

### 17.1 页面写太大，不拆组件

后果：

- 文件越来越长
- 很难维护

建议：

- 一个区块一个组件
- 一个组件只负责一件事

### 17.2 一上来就接真实接口

后果：

- UI、数据、错误一起缠住

建议：

- 先 mock
- 再接接口

### 17.3 不理解约束就乱写布局

后果：

- 溢出
- 高度无限
- 列表嵌套报错

建议：

- 优先理解 `Column`、`Expanded`、`ListView`、`GridView`
- 看到报错先想“谁给谁约束”

### 17.4 状态到处乱放

建议：

- 局部状态先放当前页面
- 共享状态再往上提

### 17.5 只会抄，不会复盘

建议你每做完一个页面，都回答自己 3 个问题：

1. 页面结构是什么
2. 状态在哪里
3. 数据从哪里来

---

## 18. 短期上手时，不要贪多

你现在最该学的不是：

- 高级状态管理全家桶
- 动画底层原理
- 自定义渲染
- Flutter Engine

你现在最该学的是：

- Widget 组合
- 布局
- 状态更新
- 路由
- mock 数据驱动页面
- 网络和存储的基本接法

先把“能做页面、能跑功能”拿下，成长会非常快。

---

## 19. 一套最实用的学习方法

以后你学 Flutter，尽量按这个顺序：

1. 看现有页面
2. 模仿着改一个小需求
3. 自己独立做一个相似页面
4. 再回来看原代码
5. 总结你不懂的 Widget 和语法

对你当前项目来说，最好的学习方式不是换新教程，而是围绕这个仓库持续做小功能。

---

## 20. 给你的结论

如果你的目标是“短期之内学会 Flutter 开发”，那就不要把自己变成只学概念的人。

你现在这个项目已经足够当训练场了。

你只需要按下面这条路线执行：

1. 看懂入口和路由
2. 看懂首页和登录页
3. 学会 `StatefulWidget + setState`
4. 学会新增页面和路由
5. 学会 mock 数据驱动页面
6. 最后理解网络层和存储层

做到这一步，你已经具备基础 Flutter 开发能力了。

---

## 21. 下一步建议

建议你立刻开始做这 3 件事：

1. 给首页搜索栏接一个新页面
2. 自己新增一个“订单页”
3. 把首页 mock 商品改成你自己的数据结构

这 3 个练完，你对这个项目的掌控感会明显起来。

