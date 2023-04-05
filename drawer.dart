import 'package:flutter/material.dart';
import 'package:myapp/igst/igstoncredit.dart';
import 'package:myapp/old/calendar/calendarTwo.dart';
import 'package:myapp/old/countryState/countryState.dart';
import 'package:myapp/old/uomList/UomList.dart';
import 'package:myapp/old/workCenter/work_center.dart';
import 'package:myapp/onlinePayment/onlinePayment.dart';
import 'package:myapp/dbutils.dart';
import 'paystructure/payStructure.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Ruturaj Patil'),
            accountEmail: Text('ruturaj.patil.rp45@gmail.com'),
          ),
          ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('uomlist'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const UomDataList(),
                  ),
                );
              }),
          ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('StateList'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const StateList(),
                  ),
                );
              }),
          ListTile(
              leading: const Icon(Icons.free_cancellation),
              title: const Text('Leave Section'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const CalendarTwo(),
                  ),
                );
              }),
          ListTile(
              leading: const Icon(Icons.precision_manufacturing),
              title: const Text('Machine List'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const WorkCenter(),
                  ),
                );
              }),
          ListTile(
              leading: const Icon(Icons.payments),
              title: const Text('GST Form'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const IgstonExportConf(),
                  ),
                );
              }),
          ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('PayStructure'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const PayStructure(),
                  ),
                );
              }),
          ListTile(
              leading: const Icon(Icons.paypal),
              title: const Text('OnlinePayment'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const OnlinePayment(),
                  ),
                );
              })
        ],
      ),
    );
  }
}



//https://images.pexels.com/photos/691668/pexels-photo-691668.jpeg