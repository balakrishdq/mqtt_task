import '../../imports/index.dart';

extension DoubleExtensions on double {
  Widget get hGap => SizedBox(height: this);
  Widget get wGap => SizedBox(width: this);
}
