import 'package:flutter/material.dart';
import 'package:ponymapscross/providers/SearchQueryProvider.dart';
import 'package:ponymapscross/screens/eventos.dart';
import 'package:ponymapscross/screens/horarios.dart';
import 'package:ponymapscross/screens/mapa.dart';
import 'package:ponymapscross/settings/testData.dart';
import 'package:provider/provider.dart';
import 'settings/colors.dart';
import 'screens/ubicaciones.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Sizer(
        builder: (context, orientation, deviceType) {
          return ChangeNotifierProvider(
            create: (_) => SearchQueryProvider(),
            child: MaterialApp(
              title: 'PonyMaps',
              theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
              darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
              home: const MyHomePage(title: 'PONYMAPS'),
            ),
          );
        },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  ValueNotifier<String> place = ValueNotifier<String>('');

  final List<String> _titles = [
    'Campus I',
    'Campus II'
  ];

  late String appTitle;

  @override
  void initState() {
    super.initState();

    appTitle = _titles[0];
  }

  void _openAndFindLocation(int index, String location) {
    setState(() {
      place.value = location;
    });
    _onItemTapped(index);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _isSearchBarVisible = false;

  void _toggleSearchBarVisibility() {
    setState(() {
      _isSearchBarVisible = !_isSearchBarVisible;
      Provider.of<SearchQueryProvider>(context, listen: false).setSearchQuery('');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_work_outlined),
          onPressed: (){

          if(appTitle == _titles[0]){
            print("fuuuu");
            print(appTitle);
            setState(() {
              appTitle = _titles[1];
            });

          }
          else{
            print("2222222");
            print(appTitle);
            print(_titles[0]);
            print(_titles[1]);
            setState(() {
              appTitle = _titles[0];
            });
          }
        },
        ),
        centerTitle: true,
        title: _isSearchBarVisible
            ? TextField(
                //style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Buscar...',
                  //hintStyle: TextStyle(color: Colors.white70),
                ),
          onSubmitted: (query) {
            Provider.of<SearchQueryProvider>(context, listen: false).setSearchQuery(query);
          },
              )
            : Text(appTitle),
        actions: [
          _selectedIndex != 0 ? IconButton(
            onPressed: _toggleSearchBarVisibility,
            icon: _isSearchBarVisible ? const Icon(Icons.close) : const Icon(Icons.search),
          ) : Container(),
        ],

      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        //child: _widgetOptions.elementAt(_selectedIndex),
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            PageStorage(
                bucket: PageStorageBucket(),
                child: Mapa(location: place),
            ),
            PageStorage(
              bucket: PageStorageBucket(),
              child: Ubicaciones(items: buildings, onOpenLocation: _openAndFindLocation),
            ),
            PageStorage(
              bucket: PageStorageBucket(),
              child: const Eventos(items: schoolEvents),
            )/*,
            PageStorage(
              bucket: PageStorageBucket(),
              child: const Horarios(),
            )*/
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Ubicaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Eventos',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Horarios',
          ),*/
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        //backgroundColor: Theme.of(context).colorScheme.tertiary,
        onTap: _onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
