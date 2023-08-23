import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/bloc/documents_bloc/abstract_documents.dart';
import 'package:yiwucloud/models%20/product_filter_model.dart';

import '../../bloc/documents_bloc/documents_bloc.dart';
import 'document_page.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key? key}) : super(key: key);

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final _documentsBloc = DocumentsBloc();

  @override
  void initState() {
    super.initState();
    _documentsBloc.add(LoadDocuments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Мои документы'),
          centerTitle: false,
        ),
        body: BlocProvider<DocumentsBloc>(
          create: (context) => DocumentsBloc(),
          child: BlocBuilder<DocumentsBloc, DocumentsState>(
            bloc: _documentsBloc,
            builder: (context, state) {
              if (state is DocumentsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DocumentsLoaded) {
                return buildDocs(state.documents, state.types);
              } else if (state is DocumentLoadingFailure) {
                return Center(
                  child: Text(state.e.toString()),
                );
              }
              return const SizedBox();
            },
          ),
        ));
  }

  Widget buildDocs(List<DocumentModel> docs, ProductFilterModel type) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            title: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: const Text(
                  'Выберите документ',
                  style: TextStyle(color: Colors.black),
                ),
                value: type.initialValue != '0' ? type.initialValue : null,
                isExpanded: true,
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  padding: REdgeInsets.all(8),
                ),
                items: type.childData
                    .map((e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(e.text),
                        ))
                    .toList(),
                onChanged: (value) {
                  _documentsBloc
                      .add(ChangeDocumentType(type: value.toString(), context: context));
                  setState(() {
                    type.initialValue = value!;
                  });
                },
              ),
            )),
        SliverToBoxAdapter(
             child: docs.isNotEmpty ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DocumentPage(document: doc.link,)));
                      },
                      leading: const Icon(FontAwesomeIcons.file, size: 30),
                      title: Text(doc.name),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 15,),
                    );
                  },
               separatorBuilder: (BuildContext context, int index) {
                 return const Divider(height:  0,);
               },
                ) : const SizedBox(
               height: 100,
               child: Center(child: Text('Нет документов')),
             )
        )
      ],
    );
  }
}
