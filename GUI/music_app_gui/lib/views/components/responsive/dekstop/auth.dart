import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_app_gui/models/user.dart';
import 'package:music_app_gui/utils/dio_client.dart';
import 'package:music_app_gui/utils/http_api_client.dart';
import 'package:music_app_gui/views/auth/login_view.dart';
import 'package:music_app_gui/views/forms/albums/album_lists.dart';
import 'package:music_app_gui/views/forms/music/music_list.dart';
import 'package:music_app_gui/views/forms/musicians/musicians_list.dart';

class AuthBar extends StatefulWidget {
  const AuthBar({super.key});

  @override
  State<AuthBar> createState() => _AuthBarState();
}

class _AuthBarState extends State<AuthBar> {
  late Future<User> user;
  HttpApiClient apiClient = HttpApiClient();

  Future<User> getUser() async {
    var response = await DioClient.dio.get('${dotenv.env['SERVER']}/user');
    return User.fromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    snapshot.data!.username,
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showDropdown(context);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          '${dotenv.env['404']}'), // Replace with your avatar image
                    ),
                  ),
                ],
              );
            }
            return const Text('loading...');
          },
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay) +
            const Offset(0, 50), // Move slightly below the avatar
        button.localToGlobal(button.size.bottomRight(Offset.zero),
                ancestor: overlay) +
            const Offset(100, 100), // Move 100 pixels to the right
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      // Todo add the from pages
      context: context,
      position: position,
      color: Colors.grey[850],
      items: [
        PopupMenuItem(
          onTap: () {
            if (!mounted) return;
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MusicsList()));
          },
          child: Text(
            'Musics',
            style: TextStyle(color: Colors.grey[300]),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const MusiciansList())));
          },
          child: Text('Musicians', style: TextStyle(color: Colors.grey[300])),
        ),
        PopupMenuItem(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const AlbumList())));
          },
          child: Text('Albums', style: TextStyle(color: Colors.grey[300])),
        ),
        PopupMenuItem(
          onTap: () async {
            var response =
                await DioClient.dio.post('${dotenv.env['SERVER']}/logout');
            if (response.statusCode == 200) {
              if (!mounted) return;
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            }
          },
          child: Text('Logout', style: TextStyle(color: Colors.grey[300])),
        ),
      ],
    );
  }
}
