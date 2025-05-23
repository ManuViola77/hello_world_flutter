import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BottomTabs(),
    );
  }
}

class BottomTabs extends StatefulWidget {
  const BottomTabs({Key? key}) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(scaffoldKey: _scaffoldKey),
      SearchPage(scaffoldKey: _scaffoldKey),
      FavoritesPage(scaffoldKey: _scaffoldKey),
      ProfilePage(scaffoldKey: _scaffoldKey),
    ];

    return Scaffold(
      key: _scaffoldKey,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.grey[200],
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.black,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 30),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 30),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('assets/images/profile.jpeg'),
              ),
              label: 'Perfil',
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(),
            _buildItem(icon: Icons.home, title: 'Inicio', onTap: () => _handlerDrawerItemTap(0)),
            _buildItem(icon: Icons.search, title: 'Buscar', onTap: () => _handlerDrawerItemTap(1)),
            _buildItem(icon: Icons.favorite, title: 'Favoritos', onTap: () => _handlerDrawerItemTap(2)),
            _buildItem(icon: Icons.person, title: 'Perfil', onTap: () => _handlerDrawerItemTap(3)),
             const Divider(),
            _buildItem(icon: Icons.settings, title: 'Configuración', onTap: () => Navigator.pop(context)),
            _buildItem(icon: Icons.logout, title: 'Cerrar Sesión', onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.purple,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/profile.jpeg'),
          ),
          SizedBox(height: 10),
          Text(
            'Mi Aplicación',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  _buildItem({required IconData icon, required String title, required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  _handlerDrawerItemTap(int index) {
     Navigator.pop(context);
    _onItemTapped(index);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomePage({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Inicio',
        backgroundColor: Colors.red,
        scaffoldKey: scaffoldKey,
      ),
      body: DefaultTabController(
        length: 10,
        child: Column(
          children: [
            Container(
              color: Colors.red,
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(icon: Icon(Icons.today)),
                  Tab(icon: Icon(Icons.format_list_numbered)),
                  Tab(icon: Icon(Icons.notes)),
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                  Tab(icon: Icon(Icons.directions_car)),
                ],
                isScrollable: true,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CalendarPage(),
                  StepperPage(),
                  DismissibleList(),
                  Container(color: Colors.indigo),
                  Container(color: Colors.blue),
                  Container(color: Colors.green),
                  Container(color: Colors.lightBlue),
                  Container(color: Colors.blue),
                  Container(color: Colors.green),
                  Container(color: Colors.cyan),
                ]
              )
            )
          ],
        )
      ),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${_timeOfDay.hour.toString().padLeft(2, '0')}:${_timeOfDay.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () => _selectTime(context),
              height: 50,
              color: Colors.purple,
              child: const Text(
                'Mostrar Time Picker',
                style: TextStyle(color: Colors.white)
              ),
            )
          ]
        )
      )
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    
    if(pickedTime != null) {
      setState(() {
        _timeOfDay = pickedTime;
      });
    }
  }
}

class StepperPage extends StatefulWidget {
  const StepperPage({super.key});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  int _currentStep = 0;
  
  List<Step> stepList() => [
    Step(
      isActive: _currentStep >= 0, 
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
      title: const Text('Step 1'), 
      content: Column(
        children: [
          Text('Step 1 content'),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Apellido',
              border: OutlineInputBorder(),
            ),
          ),
        ]
      )
    ),
    Step(
      isActive: _currentStep >= 1, 
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
      title: const Text('Step 2'), 
      content: Column(
        children: [
          Text('Step 2 content'),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Direccion',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Telefono',
              border: OutlineInputBorder(),
            ),
          ),
        ]
      )
    ),
    Step(
      isActive: _currentStep >= 2, 
      state:  _currentStep <= 2 ? StepState.editing : StepState.complete,
      title: const Text('Step 3'), 
      content: const Center(child: Text('Step 3 content'))
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.lightBlue,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: Stepper(
          steps: stepList(),
          type: StepperType.horizontal,
          elevation: 0, // la raya de abajo que no se muestre
          currentStep: _currentStep,
          onStepContinue: () {
            if(_currentStep < (stepList().length - 1)) {
              setState(() => _currentStep++);
            }
          },
          onStepCancel: () {
            if(_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
          onStepTapped: (step) => setState(() => _currentStep = step),
        ),
      ),
    );
  }
}

class DismissibleList extends StatefulWidget {
  const DismissibleList({super.key});

  @override
  State<DismissibleList> createState() => _DismissibleListState();
}

class _DismissibleListState extends State<DismissibleList> {
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: ListView.builder(
        itemCount: _items.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (direction) {
              setState(() {
                _items.removeAt(index);
              });
            },
            confirmDismiss: (direction) async {
              if(direction == DismissDirection.startToEnd) {
                return await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Eliminar'),
                    content: Text('¿Estás seguro de querer eliminar este item?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Si')),
                      TextButton(onPressed: () => Navigator.pop(context, false), child: Text('No')),
                    ],
                  )
                );
              } else {
                return await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Guardar'),
                    content: Text('¿Estás seguro de querer guardar este item?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Si')),
                      TextButton(onPressed: () => Navigator.pop(context, false), child: Text('No')),
                    ],
                  )
                );
              }
            },
            background: Container(
              color: Colors.red,
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.pink,
              height: 50,
              margin: const EdgeInsets.only(top: 10),
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.check, color: Colors.white),
                ),
              ),
            ),
            key: ValueKey<String>(_items[index]),
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 10),
              height: 50,
              child: Center(
                child: Text(
                  _items[index],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              )
            )
          );
        },
      )
    );
  }
}

class SearchPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SearchPage({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Buscar',
        backgroundColor: Colors.blue,
        scaffoldKey: scaffoldKey,
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: MaterialButton(
            onPressed: () => _openAnimatedDialog(context),
            height: 50,
            color: Colors.purple,
            child: const Text('Mostrar Dialogo', style: TextStyle(color: Colors.white)),
          )
        )
      ),
    );
  }

  void _openAnimatedDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black87.withOpacity(0.25),
      barrierDismissible: true,
      barrierLabel: 'Dialogo',
      pageBuilder: (context, animation, secondaryAnimation) => Container(),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, a1, a2, widget) => ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: AlertDialog(
          backgroundColor: Colors.deepPurple,
          titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          contentTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          title: Text('Hola'),
          content: Text('Soy Manu Genia'),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        )
      )
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const FavoritesPage({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favoritos',
        backgroundColor: Colors.green,
        scaffoldKey: scaffoldKey,
      ),
      body: Container(
        color: Colors.green,
        child: Center(
          child: MaterialButton(
            onPressed: () => _displayBottomSheet(context),
            height: 50,
            color: Colors.purple,
            child: const Text('Mostrar BottomSheet', style: TextStyle(color: Colors.white)),
          )
        )
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.black87.withOpacity(0.25),
      // isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Manu Genia',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ProfilePage({super.key, required this.scaffoldKey});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  String _dropdownValue = '1';
  var _items = ['1', '2', '3', '4', '5'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Perfil',
        backgroundColor: Colors.purple,
        scaffoldKey: widget.scaffoldKey,
      ),
      body: Container(
        color: Colors.purple,
        child:Center(
          child: Container(
            width: 150,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xffEBEDFE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: DropdownButton<String>(
                items: _items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                value: _dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    _dropdownValue = newValue!;
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 50,
                iconEnabledColor: Colors.purple,
                iconDisabledColor: Colors.purple.withOpacity(0.5),
                style: const TextStyle(
                  color: Colors.purple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                underline: Container(),
              )
            )
          )
        )
      )
    );
  }
}
