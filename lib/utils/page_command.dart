abstract class PageCommand {}

class PageCommandNavigatorPage extends PageCommand {
  String? page;
  dynamic argument;

  PageCommandNavigatorPage({this.page, this.argument});
}
