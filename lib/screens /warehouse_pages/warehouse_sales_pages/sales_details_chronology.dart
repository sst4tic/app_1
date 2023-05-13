import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/util/chronology_model.dart';
import 'package:http/http.dart' as http;
import '../../../util/constants.dart';

class DetailsChronology extends StatefulWidget {
  const DetailsChronology({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DetailsChronology> createState() => _DetailsChronologyState();
}

class _DetailsChronologyState extends State<DetailsChronology> {
  late Future<List<ChronologyModel>> chronologyFuture;

  Future<List<ChronologyModel>> getChronology() async {
    var url =
        '${Constants.API_URL_DOMAIN}action=chronology_list&id=${widget.id}';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final List<dynamic> data = body['data'];
    final chronology =
        data.map((item) => ChronologyModel.fromJson(item)).toList();
    return chronology;
  }

  @override
  void initState() {
    super.initState();
    chronologyFuture = getChronology();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Хронология'),
        ),
        body: FutureBuilder<List<ChronologyModel>>(
          future: chronologyFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final chronology = snapshot.data![index];
                  return ListTile(
                    leading: chronology.status == 5
                        ? const Icon(FontAwesomeIcons.circleCheck,
                            color: Colors.green)
                        : chronology.status == 6
                            ? const Icon(FontAwesomeIcons.circleXmark,
                                color: Colors.red)
                            : chronology.status == 7
                                ? const Icon(FontAwesomeIcons.pen,
                                    color: Colors.grey)
                                : const Icon(FontAwesomeIcons.pen,
                                    color: Colors.grey),
                    title: Text(chronology.name),
                    subtitle:
                        Text('${chronology.createdAt}\n${chronology.message}'),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(height: 0);
                }
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
