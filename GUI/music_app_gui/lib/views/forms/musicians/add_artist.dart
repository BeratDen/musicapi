import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app_gui/utils/cloud_api.dart';
import 'package:music_app_gui/utils/http_api_client.dart';

class AddArtist extends StatefulWidget {
  const AddArtist({super.key});

  @override
  State<AddArtist> createState() => _AddArtistState();
}

class _AddArtistState extends State<AddArtist> {
  late CloudApi api;
  final _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  HttpApiClient apiClient = HttpApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Color(Colors.grey[850]?.value ?? 0xFF000000),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    BackButton(
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
              Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Add Artist',
                              style: GoogleFonts.lato(
                                  color: Colors.grey[200], fontSize: 24),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
