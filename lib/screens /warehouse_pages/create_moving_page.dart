import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/styles.dart';

class CreateMovingPage extends StatefulWidget {
  const CreateMovingPage({Key? key}) : super(key: key);

  @override
  State<CreateMovingPage> createState() => _CreateMovingPageState();
}

class _CreateMovingPageState extends State<CreateMovingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Запрос на перемещение'),
      ),
      body: Container(
        margin: REdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
          padding: REdgeInsets.all(8),
          children: [
            const Center(
              child: Text(
                'Добавление товара',
                style: TextStyles.loginTitle,
              ),
            ),
            const Divider(
              height: 10,
            ),
            const Text(
              'Тип *',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.h),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Введите артикул...',
              ),
            ),
            SizedBox(height: 10.h),
            const Text('Откуда *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 5.h),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Введите артикул...',
              ),
            ),
            SizedBox(height: 10.h),
            const Text('Куда *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 5.h),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Введите артикул...',
              ),
            ),
            SizedBox(height: 10.h),
            const Text('Срочная доставка *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 5.h),
            // create Radio with 2 options (Yes/No)
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                const Text('Да'),
                Radio(
                  value: 2,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                const Text('Нет'),
              ],
            ),
            SizedBox(height: 10.h),
            const Text('Товар *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 5.h),

            const Text('Комментарий *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 5.h),
            TextField(
              decoration: InputDecoration(
                contentPadding:
                REdgeInsets.symmetric(vertical: 8, horizontal: 20),
                hintText: 'Введите комментарии',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.center,
              minLines: 3,
              maxLines: null,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 30.h),
              ),
              child: const Text(
                'Создать перемещение',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
