class GetTime {

  String calculateTime(String creation){
    Duration diff = DateTime.now().difference(DateTime.parse(creation));
    int diffyears1 = diff.inDays ~/ 365;
    int diffmonths1 = diff.inDays ~/ 30;
    int diffweeks1 = diff.inDays ~/ 7;
    int diffhours1 = diff.inDays ~/ 24;
    if(diffyears1 > 0){
      return '$diffyears1 years ago';
    } else if(diffmonths1 > 0){
      return '$diffmonths1 months ago';
    } else if(diffweeks1 > 0) {
      return '$diffweeks1 weeks ago';
    }else if(diffhours1 > 0){
      return '$diffhours1 hours ago';
    }else {
      return 'Just now';
    }
  }
}