part of 'documents_bloc.dart';

abstract class DocumentsState {}

class DocumentsInitial extends DocumentsState {}

class DocumentsLoading extends DocumentsState {}

class DocumentsLoaded extends DocumentsState {
  DocumentsLoaded({
    required this.types,
    required this.documents,
  });

  final List<DocumentModel> documents;
  final ProductFilterModel types;

  List<Object?> get props => [documents];
}

class DocumentLoadingFailure extends DocumentsState {
  DocumentLoadingFailure({
    required this.e,
  });

  final Object? e;

  List<Object?> get props => [e];
}
