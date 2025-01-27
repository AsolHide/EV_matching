import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.blue, // ダークテーマのプライマリカラーを紫に設定。
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.blue, // ダークテーマのプライマリカラーを紫に設定。
        ),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/':(context)=>InitPage(title: 'Demo'),
        '/Main':(context)=>MainPage(),
        '/Menu':(context)=>Menu(),
      },
      //home: const InitPage(title: 'Demo'),
    );
  }
}

class InitPage extends StatefulWidget {
  const InitPage({super.key, required this.title});

  final String title;

  @override
  State<InitPage> createState() => InitPageState();
}

class InitPageState extends State<InitPage> {

  bool _process=false;


  void _toggleProcess(_bool) {
    setState(() {
      _process = _bool; // 状態を切り替え
    });
  }

  Future InitProcess() async{
    await Future.delayed(Duration(seconds: 3));
    return true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //ここにアプリ起動時の処理を書く
      var result = await InitProcess();
      if (result){
        Navigator.pushNamed(context, '/Main');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          children: [
            _process
            ?const Text(
                    'Loading',
                    style: TextStyle(fontSize: 24),
                  )
            :Image.asset('image/icon.png',scale: 8.0,)
          ],
          mainAxisAlignment:MainAxisAlignment.center,),//Image.asset('image/icon.png',scale: 8.0,),
        ),
      );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.fromLTRB(16,0,8,0), // 横方向の余白
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 左右に配置
                children: [
                  Text(
                    '左端のテキスト', // 左端に表示するテキスト
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.charging_station), // 1つ目のアイコン
                        onPressed: () {
                          print('Favorite button pressed');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.dehaze), // 2つ目のアイコン
                        onPressed: () {
                          Navigator.pushNamed(context, '/Menu');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}


class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
        title: Text("メニュー",style: TextStyle(fontSize: 24.0),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.help_outline))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Test"),
          ],
        )
      ),
    );
  }
}