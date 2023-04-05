/*
 Author: Ruturaj

 Date: 09th Jan 2023

 Purpose:

*/

import 'package:intl/intl.dart';

void main() {
  // Conversion of AnsiToBritish
  print("-----------------------------------------------");
  var date1 = "2023-01-28";
  var testing = ansiToBritish(date1);
  print("Ansi date format = $date1");
  print("conversion of Ansi To british = $testing");
  print("-----------------------------------------------");

  //Conversion of British  to Ansi
  print("-----------------------------------------------");
  var date2 = "25-01-2023";
  var britishtoansi = britishToAnsi(date2);
  print("British date format = $date2");
  print("conversion of british To Ansi =  $britishtoansi");
  print("-----------------------------------------------");

  //Conversion of Us to British
  var date3 = "01-26-2023";
  var ustobritish = usToBritish(date3);
  print("US date format = $date3");
  print("conversion of US To Britsh = $ustobritish");
  print("-----------------------------------------------");

  //Conversion of British to US
  var date4 = "26-01-2023";
  var britishtous = britishToUs(date4);
  print("Britsh date format = $date4");
  print("conversion of Britsh To US = $britishtous");
  print("-----------------------------------------------");

  //first date by given date
  var date5 = "26-01-2023";
  var firstdate = firstDate(date5);
  print("Given Date = $date5");
  print("first date of given date  =  $firstdate");
  print("-----------------------------------------------");

  //Last date by given date
  var date6 = "26-02-2024";
  const Lastdate = ["26-02-2024", "15-01-2023", "18-02-2023", "20-04-2023"];
  var lastdate = Lastdate.map(lastDate);
  print("Given Date = $Lastdate");
  print("Last date of given dates  = $lastdate");
  print("-----------------------------------------------");

  //month Name by given date
  var date7 = "26-04-2023";
  const Dates = [
    "04-01-2023",
    "11-02-2023",
    "23-03-2023",
    "28-04-2023",
    "29-05-2023",
    "05-06-2023",
    "10-07-2023",
    "15-08-2023",
    "11-09-2023",
    "14-10-2023",
    "20-11-2023",
    "31-12-2023"
  ];
  var monthname = Dates.map(getMonthName);
  print("Given Date = $Dates");
  print("month name of given dates  = $monthname");
  print("-----------------------------------------------");

  //Day Name by given date
  // Uses NaDate.britishToAnsi()
  var date8 = DateTime.now();
  var day = getDays(date8);
  print("Given Date = $date8");
  print("Day name of given date  = ${DateFormat('EEE').format(date8)}");
  print("-----------------------------------------------");

  //Days between from given dates
  // Uses Ansi formated date

  var fromdate = "2022-01-01";
  var toDate = '2023-01-01';
  print("Given Date = $fromdate TO $toDate");
  daysBetween(fromdate, toDate);
  print("-----------------------------------------------");
}

//AnsiToBritish yyyy-mm-dd TO dd-mm-yyyy
String ansiToBritish(date1) {
  var year = date1.substring(0, 4);
  print(year);
  var month = date1.substring(5, 7);
  print(month);
  var day = date1.substring(8, 10);
  print(day);

  var convertedYear = 'ANSItoBRITISH:- $day-$month-$year';
  print(convertedYear);
  return convertedYear;
}

//BritishToAnsi dd-mm-yyyy TO yyyy-mm-dd
String britishToAnsi(date2) {
  var year = date2.substring(6, 10);
  print(year);
  var month = date2.substring(3, 5);
  print(month);
  var day = date2.substring(0, 2);
  print(day);

  var convertedYear = 'BRITISHtoANSI:- $year-$day-$month';
  print(convertedYear);
  return convertedYear;
}

//USToBritish mm-dd-yyyy TO dd-mm-yyyy
String usToBritish(date3) {
  var year = date3.substring(6, 10);

  var month = date3.substring(0, 2);

  var day = date3.substring(3, 5);

  var convertedYear = 'UStoBRITISH:- $day-$month-$year';
    return convertedYear;
}

//BritishToUS dd-mm-yyyy TO mm-dd-yyyy
String britishToUs(date4) {
  var year = date4.substring(6, 10);

  var month = date4.substring(3, 5);

  var day = date4.substring(0, 2);


  var convertedYear = 'BRITISHtoUS:- $month-$day-$year';

  return convertedYear;
}

//FirstDate 01-mm-yyyy
String firstDate(date5) {
  var year = date5.substring(6, 10);

  var month = date5.substring(3, 5);


  var convertedYear = '01-$month-$year';

  return convertedYear;
}

//LastDate 31-mm-yyyy
String lastDate(date6) {
  var year = int.parse(date6.substring(6, 10));

  var month = int.parse(date6.substring(3, 5));

  var days = '';
  if (month == "") {

  } else if ((month == 1) ||
      (month == 3) ||
      (month == 5) ||
      (month == 7) ||
      (month == 8) ||
      (month == 10) ||
      (month == 12)) {
    days = '31';
  } else if ((month == 4) || (month == 6) || (month == 9) || (month == 11)) {
    days = '30';
  } else if (month == 2) {
    // days = "28";
    // print(days);
    if ((year % 100) == 0) {
      if ((year % 400) == 0) {
        days = "29";

      } else {
        days = "28";

      }
    } else if ((year % 4) == 0) {
      days = "29";

    } else {
      days = "28";

    }
  }
  var lastD = '$days-$month-$year';

  return lastD;
}

//get month
void getMonthName(date7) {
  //
  var monthName = ["", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];
  var month = int.parse(date7.substring(3, 5));

  if (monthName == "") {
    return print('data not found');
  } else {
    month;
    print(monthName[month]);
  }
}

//get day
getDays(date8) {
  var day = DateFormat('EEE').format(date8);
  print(DateFormat('EEE').format(date8));
}

//// Uses NaDate.britishToUS()
daysBetween(fromdate, toDate) {
  DateTime fdate = DateTime.parse(fromdate);
  DateTime tdate = DateTime.parse(toDate);

  Duration diff = tdate.difference(fdate);
  print("Days between from given date  = ${diff.inDays.toString()}");
  return diff;
}
