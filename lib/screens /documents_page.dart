import 'package:flutter/material.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key? key}) : super(key: key);

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои документы'),
        centerTitle: false,
        bottom: TabBar(
          isScrollable: true,
          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.black, width: 2),
            insets: EdgeInsets.symmetric(horizontal: 38), // Indicator width
          ),
          controller: _tabController,
          tabs: const [
            Tab(text: 'Все'),
            Tab(text: 'Паспорт'),
            Tab(text: 'Резюме'),
            Tab(text: 'Диплом'),
            Tab(text: 'Мед.карта'),
            Tab(text: 'Фото'),
            Tab(text: 'Другое'),
          ],
        ),
      ),
      body: const Center(
        child: Text('Нет документов'),
      ),
    );
  }
}
