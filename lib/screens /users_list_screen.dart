import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/models%20/search_model.dart';
import 'package:yiwucloud/models%20/users_list_model.dart';
import 'package:yiwucloud/screens%20/user_list_edit_page.dart';

import '../bloc/users_list_bloc/users_list_bloc.dart';
import '../models /build_product_filter.dart';
import '../models /product_filter_model.dart';
import '../util/function_class.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final ScrollController _sController = ScrollController();
  final _usersListBloc = UsersListBloc();
  late final List<ProductFilterModel> filterData;
  bool isFilter = false;

  @override
  void initState() {
    super.initState();
    _usersListBloc.add(LoadUsersList());
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        _usersListBloc.add(LoadMore());
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    filterData = await Func().getUserFilters();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UsersListBloc>(
      create: (context) => UsersListBloc(),
      child: BlocBuilder<UsersListBloc, UsersListState>(
        bloc: _usersListBloc,
        builder: (context, state) {
          if (state is UsersListLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is UsersListLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Сотрудники'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: searchModel(
                      context: context,
                      onSubmitted: (val) {
                        _usersListBloc.add(LoadUsersList(query: val));
                      }),
                ),
                actions: [
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          showProductFilter(
                              context: context,
                              onSubmitted: (value) {
                                _usersListBloc
                                    .add(LoadUsersList(filters: value));
                              },
                              isFilter: (val) => setState(() => isFilter = val),
                              filterData: filterData,
                              type: 'users');
                        },
                        icon: const Icon(Icons.filter_alt),
                      ),
                      if (isFilter)
                        Positioned(
                          right: 10,
                          bottom: 27,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 9,
                              minHeight: 9,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              body: buildUsersList(state.usersListModel.users, state.hasMore),
            );
          } else if (state is UsersListError) {
            return Text(state.e.toString());
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget buildUsersList(List<Users> users, bool hasMore) {
    return RefreshIndicator(
      onRefresh: () async {
        _usersListBloc.add(LoadUsersList());
      },
      child: CustomScrollView(
        controller: _sController,
        slivers: [
          SliverToBoxAdapter(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  contentPadding: REdgeInsets.symmetric(horizontal: 8),
                  leading: Stack(
                    children: [
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: Avatar(
                          loader: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                          ),
                          useCache: true,
                          sources: user.photo != null
                              ? [NetworkSource(user.photo!)]
                              : null,
                          placeholderColors: const [
                            Colors.teal,
                            Colors.lightBlueAccent,
                            Colors.orange
                          ],
                          shape: AvatarShape.circle(100),
                          name:
                              user.surname != null ? user.fullName : user.name,
                          textStyle: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: user.isOnline ? Colors.green : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    user.fullName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(user.role),
                  trailing: user.editUrl != null
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserListEditPage(url: user.editUrl!)));
                          },
                          icon: const Icon(Icons.edit),
                        )
                      : const SizedBox(),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
                child: users.length <= 10 || hasMore == false
                    ? const Text('Больше нет данных')
                    : const CircularProgressIndicator()),
          ),
          SliverToBoxAdapter(
              child: SizedBox(
            height: 20.h,
          )),
        ],
      ),
    );
  }
}
