import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:yiwucloud/bloc/documents_bloc/abstract_documents.dart';
import 'package:yiwucloud/bloc/documents_bloc/documents_repo.dart';

import '../../models /product_filter_model.dart';

part 'documents_event.dart';
part 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentsBloc() : super(DocumentsInitial()) {
    final documentsRepo = DocumentsRepo();
    on<LoadDocuments>((event, emit) async {
      try {
        if (state is! DocumentsLoading) {
          emit(DocumentsLoading());
          final type = await documentsRepo.getType();
          final documents = await documentsRepo.getDocuments(type: type.initialValue, page: 1);
          emit(DocumentsLoaded(documents: documents, types: type));
        }
      } catch (e) {
        emit(DocumentLoadingFailure(e: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<ChangeDocumentType>((event, emit) async {
      event.context.loaderOverlay.show();
      try {
        if (state is DocumentsLoaded) {
          final documents = await documentsRepo.getDocuments(type: event.type, page: 1);
          emit(DocumentsLoaded(documents: documents, types: (state as DocumentsLoaded).types));
        }
      } catch (e) {
        emit(DocumentLoadingFailure(e: e));
      } finally {
        event.completer?.complete();
      }
      event.context.loaderOverlay.hide();
    });

  }
}
