import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:yiwucloud/util/function_class.dart';
import '../util/styles.dart';
import '../util/user.dart';

Widget buildUser(User user,
    VoidCallback onRefresh,
    ) => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        final users = user;
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.only(left: 5, right: 5),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Avatar(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          height: 200.h,
                          padding: REdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Изменить фото профиля',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  IconButton(
                                    iconSize: 15,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.clear_circled_solid,
                                      size: 30,
                                    ),
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 8.h,
                              ),
                              ListTile(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                trailing:
                                    const Icon(CupertinoIcons.camera),
                                title: Text(
                                  'Сделать фото',
                                  style: TextStyles.editStyle
                                      .copyWith(fontSize: 14),
                                ),
                                onTap: () async {
                                  var img = await takeImageFromCamera();
                                  // ignore: use_build_context_synchronously
                                  await uploadImg(img, context).then((value) => onRefresh.call());
                                },
                              ),
                              const Divider(height: 0,),
                              ListTile(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                trailing:
                                const Icon(CupertinoIcons.photo),
                                title: Text(
                                  'Выбрать из галереи',
                                  style: TextStyles.editStyle
                                      .copyWith(fontSize: 14),
                                ),
                                onTap: () async {
                                  var img = await getImageFromGallery();
                                  // ignore: use_build_context_synchronously
                                  await uploadImg(img, context).then((value) => onRefresh.call());
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                sources: user.avatar != null ? [
                  NetworkSource(
                    Constants.BASE_URL_DOMAIN+user.avatar!
                  )
                ] : null,
                placeholderColors: const [Color.fromRGBO(232, 69, 69, 1)],
                shape: AvatarShape.circle(28),
                name: users.surname != null
                    ? users.fullName
                    : users.fullName.substring(0, 1),
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                margin: const EdgeInsets.all(5),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        users.fullName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorLight,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      users.roleName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
