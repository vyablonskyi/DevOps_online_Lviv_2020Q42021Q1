'''
CREATE DATABASE busroutes;

+--------------------+
| Database           |
+--------------------+
| busroutes          |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+

CREATE TABLE `BUS` (`ID` int NOT NULL AUTO_INCREMENT, `carlicence` char(8) NOT NULL UNIQUE, `inspection` DATE NOT NULL, `route_id` int NOT NULL,PRIMARY KEY (ID`));
CREATE TABLE `route` (`ID` int NOT NULL AUTO_INCREMENT, `lenght` int NOT NULL, `start_time` TIME NOT NULL, `end_time` TIME NOT NULL, PRIMARY KEY (`ID`));
CREATE TABLE `driver` (`ID` int NOT NULL AUTO_INCREMENT, `licence` char(10) NOT NULL UNIQUE, `Name` char(30) NOT NULL, `lname` char(30) NOT NULL, `bus_id` int NOT NULL, PRIMARY KEY (`ID`));
CREATE TABLE `daylog` (`ID` int NOT NULL AUTO_INCREMENT, `route_id` int NOT NULL, `bus_id` int NOT NULL, `driver_id` int NOT NULL, `start_time` DATETIME NOT NULL, `end_time` DATETIME NOT NULL, `countoftrips` int NOT NULL, PRIMARY KEY (`ID`));

+---------------------+
| Tables_in_busroutes |
+---------------------+
| BUS                 |
| daylog              |
| driver              |
| route               |
+---------------------+

INSERT INTO BUS (`carlicence`, `inspection`, `route_id`) VALUES ('BC0345AA','2012-03-20',23);

+----+------------+------------+----------+
| ID | carlicence | inspection | route_id |
+----+------------+------------+----------+
|  1 | BC0345AA   | 2012-03-20 |       23 |
|  2 | BC0335AA   | 2021-04-20 |       23 |
|  3 | BC0325AA   | 2021-04-20 |       23 |
|  4 | BC0315AA   | 2028-11-20 |       45 |
|  5 | BC3467BC   | 2018-10-20 |       45 |
|  6 | BC3468BC   | 2018-10-20 |       45 |
|  7 | BC4563CA   | 2031-12-20 |       23 |
|  8 | BC7777BB   | 2023-01-20 |       23 |
|  9 | BC0987BB   | 2023-01-20 |       76 |
| 10 | BC5463BC   | 2013-04-20 |       76 |
+----+------------+------------+----------+

INSERT INTO driver (`licence`,`Name`,`lname`,`bus_id`)VALUES('AA7654675','John','Lennon',9);

+----+-----------+--------+------------+--------+
| ID | licence   | Name   | lname      | bus_id |
+----+-----------+--------+------------+--------+
|  1 | AA7654675 | John   | Lennon     |      9 |
|  2 | XT6755425 | Sarra  | Konnor     |      3 |
|  3 | BX4785434 | Elton  | John       |      1 |
|  4 | BX4785433 | Koty   | Riker      |      1 |
|  5 | AS4573903 | Tom    | Morris     |     10 |
|  6 | AS4763898 | Neo    | Matrix     |      8 |
|  7 | XX4763845 | Atrhur | King       |      4 |
|  8 | XS3763834 | Pappa  | Roach      |      2 |
|  9 | OO3345534 | Vasia  | Pupkin     |      6 |
| 10 | BB0998876 | Vitia  | Yanukovych |      7 |
| 11 | BB6666666 | Mikola | Azirov     |      7 |
| 12 | GT9595959 | Vova   | Bubochka   |      5 |
+----+-----------+--------+------------+--------+

INSERT INTO route (`ID`,`lenght`,`start_time`,`end_time`)VALUES(23,16,'06:00:00','23:30:00');

+----+--------+------------+----------+
| ID | lenght | start_time | end_time |
+----+--------+------------+----------+
| 23 |     16 | 06:00:00   | 23:30:00 |
| 45 |      8 | 06:30:00   | 22:45:00 |
| 76 |     25 | 05:45:00   | 00:15:00 |
+----+--------+------------+----------+

INSERT INTO `daylog` (`route_id`,`bus_id`,`driver_id`,`start_time`,`end_time`,`countoftrips`)VALUES(76,10,5,'2020-12-24 06:30','2020-12-24 15:30',4);

+----+----------+--------+-----------+---------------------+---------------------+--------------+
| ID | route_id | bus_id | driver_id | start_time          | end_time            | countoftrips |
+----+----------+--------+-----------+---------------------+---------------------+--------------+
|  1 |       76 |     10 |         5 | 2020-12-24 06:30:00 | 2020-12-24 15:30:00 |            4 |
|  2 |       23 |      7 |        11 | 2020-12-24 06:40:00 | 2020-12-24 15:45:00 |            4 |
|  3 |       23 |      1 |         3 | 2020-12-24 06:40:00 | 2020-12-24 15:45:00 |            4 |
|  4 |       76 |      9 |         1 | 2020-12-24 05:45:00 | 2020-12-24 13:45:00 |            3 |
|  5 |       45 |      6 |         9 | 2020-12-24 06:30:00 | 2020-12-24 15:30:00 |            7 |
+----+----------+--------+-----------+---------------------+---------------------+--------------+

mysql> SELECT `carlicence` FROM `BUS` WHERE `route_id`='45';
+------------+
| carlicence |
+------------+
| BC0315AA   |
| BC3467BC   |
| BC3468BC   |
+------------+

mysql> SELECT Name,lname,bus_id FROM  driver WHERE bus_id>5 ORDER BY lname;
+--------+------------+--------+
| Name   | lname      | bus_id |
+--------+------------+--------+
| Mikola | Azirov     |      7 |
| John   | Lennon     |      9 |
| Neo    | Matrix     |      8 |
| Tom    | Morris     |     10 |
| Vasia  | Pupkin     |      6 |
| Vitia  | Yanukovych |      7 |
+--------+------------+--------+
'''



