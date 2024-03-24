import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = [
    HistoryPage(),
    HomePageContent(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Medical',
                  style: TextStyle(
                    color: Color(0xFF60A8C4),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Intelligence',
                  style: TextStyle(
                    color: Color(0xFF60A8C4),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Ammar'),
              accountEmail: Text('Ammar@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://example.com/photo.jpg'),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Account'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            tableCellContent('X-ray', isHeader: true),
            tableCellContent('PDF', isHeader: true),
          ]),
          for (int i = 0; i < 3; i++) // Creates 3 rows
            TableRow(children: [
              tableCellContent(Icons.photo),
              tableCellContent('Download PDF',
                  isButton: true, context: context),
            ]),
        ],
      ),
    );
  }

  Widget tableCellContent(dynamic content,
      {bool isHeader = false, bool isButton = false, BuildContext? context}) {
    if (isHeader) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(content, style: TextStyle(fontWeight: FontWeight.bold)),
      );
    } else if (isButton) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Placeholder for your download PDF functionality
          },
          child: Text(content),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(content), // Assuming content is an IconData for icons
      );
    }
  }
}

class HomePageContent extends StatelessWidget {
  final List<String> imageUrls = [
    'https://www.uab.edu/news/images/2018/Breast_cancer_Month.png',
    'https://static.euronews.com/articles/stories/07/64/91/80/1200x675_cmsv2_81da5980-bc5e-5def-bdf0-005225bdfc61-7649180.jpg',
    'https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2020/8/shutterstock_47781766.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: imageUrls.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UploadPhotoPage()),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 9, // Maintain a consistent aspect ratio
                child: Image.network(imageUrls[index], fit: BoxFit.cover),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: 16), // Space between photos
    );
  }
}

class InfoPage extends StatelessWidget {
  final String imageUrl;
  final String infoText;

  InfoPage({required this.imageUrl, required this.infoText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$infoText Cancer Information'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Information about $infoText Cancer'),
            ElevatedButton(
              onPressed: () {
                // Placeholder for upload functionality
              },
              child: Text('Upload a Photo'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Ammar'),
            accountEmail: Text('Ammar@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://example.com/photo.jpg'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class UploadPhotoPage extends StatefulWidget {
  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  XFile? _imageFile;

  void galleryPicker() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Photo'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 75,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: _imageFile != null
                    ? FileImage(File(_imageFile!.path))
                    : null,
                child: _imageFile == null
                    ? Icon(Icons.photo_library, size: 125, color: Colors.white)
                    : null,
                radius: 100,
                backgroundColor: Color(0xff21385A),
              ),
            ],
          ),
          Spacer(
            flex: 3,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                  onPressed: () {
                    galleryPicker();
                  },
                  child: Text(
                    'Upload Image',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff21385A),
                    minimumSize: Size(100, 50),
                  )),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 170),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Show Result',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff21385A),
                    minimumSize: Size(100, 50),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
