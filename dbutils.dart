/*
 * AUthor: Pavan Mane
 *
 * Date: 3rd january 2023
 *
 * Purpose:
 *
 */
/*
*Depends on:
  -flutter pub add postgres
*/

library calculator_lib;

import 'package:postgres/postgres.dart';

Future connection(String host, int port, String databaseName, String userName, String password) async {
  var connection = PostgreSQLConnection(
    host,
    port,
    databaseName,
    username: userName,
    password: password,
  );

  try {
    //await connection.open();
    print("Database Connected");
  } catch (error) {
    print("Database not Conneted");
    print(error);
  }
  return connection;
}

Future getNameByid(PostgreSQLConnection connection, String tableName, String id) async {
   await connection.open();
  try {
    var result = await connection.query("SELECT name FROM $tableName WHERE id='$id'");
    // Print the results
    print(result.toString());
    // Close the connection
    await connection.close();
  } catch (error) {
    print(error);
  }
}

Future getDescriptionByid(PostgreSQLConnection connection, String tableName, String id) async {
  try {
    await connection.open();
    var result = await connection.query("SELECT description From data.pd_product WHERE id='$id'");
    // Print the results
    print(result.toString());
    // Close the connection
    await connection.close();
  } catch (error) {
    print(error);
  }
}

Future getDescriptionByCode(PostgreSQLConnection connection, String tableName, String code) async {
  try {
    await connection.open();
    var result = await connection.query("SELECT description From data.pd_product WHERE id='$code'");
    // Print the results
    print(result.toString());
    // Close the connection
    await connection.close();
  } catch (error) {
    print(error);
  }
}

Future getValueByField(
    PostgreSQLConnection connection, String value, String tableName, String field, String fieldValue) async {
  try {
    await connection.open();
    var result = await connection.query("SELECT $value From $tableName WHERE $field='$fieldValue'");
    // Print the results
    print(result.toString());
    // Close the connection
    await connection.close();
  } catch (error) {
    print(error);
  }
}










































/*
void main() async {
  // Connect to the database
  var connection = PostgreSQLConnection('10.0.0.127', 5432, 'postgres',
      username: 'postgres', password: 'RtD2?+~De1779');
  await connection.open();

  // Execute a query
  var result = await connection.query('SELECT * FROM cc_company ');

  // Print the results
  print(result.toString());

  // Close the connection
  await connection.close();
  connectionPostgres('datta-india.narkeassociates.in', 5432, 'postgres',
       'postgres', "RtD2?+~De1779");
     GetNameById("ac_account", "01fe2841f93840e19a3b801d90ea3980");
}

 connectionPostgres(String host, int Port, String databaseName, String Username,
    String Password) async {
  try {
    var connection = PostgreSQLConnection(host, Port, databaseName,
        username: Username, password: Password);
    await connection.open();
    var result = connection.query(
        'SELECT name FROM ac_account  Where id= "01fe2841f93840e19a3b801d90ea3980"');
    print("database connected");
    await connection.open();
    print(result);
  } catch (error) {
    rethrow;
  }
}

GetNameById(String tablename, String Id) {
 ConnectionPostgres(String host, int Port, String databaseName,
      String Username, String Password) {
    try {
       var connection = PostgreSQLConnection(host, Port, databaseName,
          username: Username, password: Password);
      connection.open();
     var result = connection.query('SELECT name FROM $tablename Where id=$Id');
      print(result);
       connection.close();
    } catch (error) {
       print(error);
    }
   }
 }
 */