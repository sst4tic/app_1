part of 'documents_bloc.dart';

abstract class DocumentsEvent {}

class LoadDocuments extends DocumentsEvent {
  LoadDocuments({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class ChangeDocumentType extends DocumentsEvent {
  ChangeDocumentType({
    this.completer,
    required this.context,
    required this.type,
  });

  final Completer? completer;
  final String type;
  final BuildContext context;
  List<Object?> get props => [completer, type, context];
}

class LoadMore extends DocumentsEvent {
  LoadMore({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}


