import 'models.dart';
import 'widgets/RemainingPeriods.dart';
import 'widgets/CurrentPeriod.dart';
import 'widgets/TodayText.dart';

List<Period> timeTable = List();
DateTime now = DateTime.now();

bool displayTimer = false;
DateTime relativeEnding;
String today;

final DateTime collegeStart = DateTime(now.year, now.month, now.day, 10, 0, 0, 0, 0);
DateTime collegeEnd = DateTime(now.year, now.month, now.day, 16, 40, 0, 0, 0);


RemainingPeriodsState remainingState = RemainingPeriodsState();
CurrentState currentPeriodState = CurrentState();
TodayState todayState = TodayState();
