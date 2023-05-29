import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/sales_comments_bloc/sales_comments_bloc.dart';

class SalesCommentsPage extends StatefulWidget {
  const SalesCommentsPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<SalesCommentsPage> createState() => _SalesCommentsPageState();
}

class _SalesCommentsPageState extends State<SalesCommentsPage> {
  final commentBloc = SalesCommentsBloc();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    commentBloc.id = widget.id;
    commentBloc.add(LoadCommentsEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Комментарии'),
      ),
      body: BlocProvider(
        create: (context) => SalesCommentsBloc(),
        child: BlocBuilder<SalesCommentsBloc, SalesCommentsState>(
          bloc: commentBloc,
          builder: (context, state) {
            if (state is SalesCommentsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SalesCommentsLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.salesComments.length,
                      itemBuilder: (BuildContext context, int index) {
                        final comment = state.salesComments[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: REdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Avatar(
                                      placeholderColors: const [
                                        Color.fromRGBO(232, 69, 69, 1)
                                      ],
                                      shape: AvatarShape.circle(20),
                                      name: comment.name,
                                      textStyle: const TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      margin: REdgeInsets.all(5),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      comment.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(
                                      comment.createdAt,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  comment.message,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    padding:
                        REdgeInsets.only(left: 8, right: 8, top: 8, bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) {
                              if (_textController.text.isNotEmpty) {
                                commentBloc.add(PostCommentEvent(
                                    id: widget.id,
                                    message: _textController.text));
                                _textController.clear();
                              }
                            },
                            controller: _textController,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Введите сообщение...',
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.blue)),
                              contentPadding:
                                  REdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (_textController.text.isNotEmpty) {
                                commentBloc.add(PostCommentEvent(
                                    id: widget.id,
                                    message: _textController.text));
                                _textController.clear();
                              }
                            },
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is SalesCommentsError) {
              return Center(child: Text(state.exception.toString()));
            } else {
              return const Center(child: Text('Ошибка'));
            }
          },
        ),
      ),
    );
  }
}
