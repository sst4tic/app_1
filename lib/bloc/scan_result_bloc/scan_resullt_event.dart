part of 'scan_resullt_bloc.dart';

abstract class ScanResultEvent {}

class CheckScanResult extends ScanResultEvent {
  final String code;
  final BuildContext context;

  CheckScanResult(this.code, this.context);
}
