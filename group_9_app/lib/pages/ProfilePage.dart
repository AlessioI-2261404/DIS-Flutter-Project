import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 69, 159, 237),
        title: const Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Handle Edit action here
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle Settings action here
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Text('Jouw interesses', style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                _buildInterestIcon(Icons.movie, 'Disney'),
                _buildInterestIcon(Icons.videogame_asset, 'PlayStation'),
                _buildInterestIcon(Icons.gamepad, 'Switch'),
              ],
            ),
            const SizedBox(height: 40),
            Text('Your Selected Categories', style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                _buildInterestIcon(Icons.book, 'Books'),
                _buildInterestIcon(Icons.music_note, 'Music'),
                _buildInterestIcon(Icons.landscape, 'Nature'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
