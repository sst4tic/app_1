import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/util/styles.dart';

Future showFilter(context) => showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: REdgeInsets.symmetric(horizontal: 8, vertical: 12),
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Фильтр',
                  style: TextStyles.bodyStyle,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              'Категории'.toUpperCase(),
              style: TextStyles.editStyle,
            ),
            SizedBox(height: 10.h),
            DropdownButtonFormField(
              value: 1,
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text('Категория 1'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('Категория 2'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('Категория 3'),
                ),
              ],
              menuMaxHeight: 200,
              borderRadius: BorderRadius.circular(20),
              onChanged: (value) {},
              decoration: Decorations.dropdownDecoration,
              elevation: 1,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SelectableContainer(
            //       text: 'Фильтр 1',
            //       onSelected: (bool) {},
            //     ),
            //     SelectableContainer(
            //       text: 'Фильтр 2',
            //       onSelected: (bool) {},
            //     ),
            //     SelectableContainer(
            //       text: 'Фильтр 3',
            //       onSelected: (bool) {},
            //     ),
            //     SelectableContainer(
            //       text: 'Фильтр 3',
            //       onSelected: (bool) {},
            //     ),
            //     SelectableContainer(
            //       text: 'Фильтр 3',
            //       onSelected: (bool) {},
            //     ),
            //   ],
            // ),
            const Spacer(),
            ElevatedButton(onPressed: () {}, child: const Text('Применить')),
          ],
        ),
      );
    });
