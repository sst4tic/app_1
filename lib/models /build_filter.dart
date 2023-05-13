import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/bloc/products_bloc/products_bloc.dart';
import 'package:yiwucloud/util/styles.dart';

showFilter({required BuildContext context, required ProductsBloc productBloc}) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
       String orderVal = '';
       String availableVal = '';
       String mediaVal = '';
       final orderbyMap = {
          'price_asc': 'Цена по возрастанию',
          'price_desc': 'Цена по убыванию',
        };
        final availableMap = {
          '': 'Все',
          'in_stock': 'В наличии',
          'out_of_stock': 'Нет в наличии',
        };
        final mediaMap = {
          '': 'Все',
          'with_photo': 'С фото',
          'without_photo': 'Без фото',
        };
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
                'цена'.toUpperCase(),
                style: TextStyles.editStyle,
              ),
              SizedBox(height: 10.h),
              DropdownButtonFormField(
                value: 'price_asc',
                items: orderbyMap.keys.map((e) => DropdownMenuItem(value: e, child: Text(orderbyMap[e]!))).toList(),
                menuMaxHeight: 200,
                borderRadius: BorderRadius.circular(20),
                onChanged: (value) {
                  orderVal = value.toString();
                },
                decoration: Decorations.dropdownDecoration,
                elevation: 1,
              ),
              SizedBox(height: 10.h),
              Text(
                'медиа'.toUpperCase(),
                style: TextStyles.editStyle,
              ),
              SizedBox(height: 10.h),
              DropdownButtonFormField(
                value: '',
                items: mediaMap.keys.map((e) => DropdownMenuItem(value: e, child: Text(mediaMap[e]!))).toList(),
                menuMaxHeight: 200,
                borderRadius: BorderRadius.circular(20),
                onChanged: (value) {
                  mediaVal = value.toString();
                },
                decoration: Decorations.dropdownDecoration,
                elevation: 1,
              ),
              SizedBox(height: 10.h),
              Text(
                'наличие'.toUpperCase(),
                style: TextStyles.editStyle,
              ),
              SizedBox(height: 10.h),
              DropdownButtonFormField(
                value: '',
                items: availableMap.keys.map((e) => DropdownMenuItem(value: e, child: Text(availableMap[e]!))).toList(),
                menuMaxHeight: 200,
                borderRadius: BorderRadius.circular(20),
                onChanged: (value) {
                  availableVal = value.toString();
                },
                decoration: Decorations.dropdownDecoration,
                elevation: 1,
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    productBloc.add(LoadProducts(
                      availability: availableVal,
                      media: mediaVal,
                      orderby: orderVal,
                    ));
                  },
                  child: const Text('Применить')),
            ],
          ),
        );
      },
    );

