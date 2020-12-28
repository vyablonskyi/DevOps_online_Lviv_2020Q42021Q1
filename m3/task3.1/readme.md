**Part 1**

During working on this task I installed on Ubuntu VM MySQL server, designed small database that descrides city buses routes.
Database schema is accessible at the [link](screenshots/001.JPG)

There was created database:
```
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
```
And tables:
```
CREATE TABLE `BUS` (`ID` int NOT NULL AUTO_INCREMENT, `carlicence` char(8) NOT NULL UNIQUE, `inspection` DATE NOT NULL, `route_id` int NOT NULL,PRIMARY KEY (`ID`));
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
```
Each table was filled by data:
```
INSERT INTO BUS (`carlicence`, `inspection`, `route_id`) VALUES ('BC0345AA','2012-03-20',23);
...
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
...
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
....
+----+--------+------------+----------+
| ID | lenght | start_time | end_time |
+----+--------+------------+----------+
| 23 |     16 | 06:00:00   | 23:30:00 |
| 45 |      8 | 06:30:00   | 22:45:00 |
| 76 |     25 | 05:45:00   | 00:15:00 |
+----+--------+------------+----------+
INSERT INTO `daylog` (`route_id`,`bus_id`,`driver_id`,`start_time`,`end_time`,`countoftrips`)VALUES(76,10,5,'2020-12-24 06:30','2020-12-24 15:30',4);
...
+----+----------+--------+-----------+---------------------+---------------------+--------------+
| ID | route_id | bus_id | driver_id | start_time          | end_time            | countoftrips |
+----+----------+--------+-----------+---------------------+---------------------+--------------+
|  1 |       76 |     10 |         5 | 2020-12-24 06:30:00 | 2020-12-24 15:30:00 |            4 |
|  2 |       23 |      7 |        11 | 2020-12-24 06:40:00 | 2020-12-24 15:45:00 |            4 |
|  3 |       23 |      1 |         3 | 2020-12-24 06:40:00 | 2020-12-24 15:45:00 |            4 |
|  4 |       76 |      9 |         1 | 2020-12-24 05:45:00 | 2020-12-24 13:45:00 |            3 |
|  5 |       45 |      6 |         9 | 2020-12-24 06:30:00 | 2020-12-24 15:30:00 |            7 |
+----+----------+--------+-----------+---------------------+---------------------+--------------+
```
After that was run a few different ***SELECT*** commands:
```
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
mysql> SELECT route_id, COUNT(*) AS carlicence FROM BUS GROUP BY route_id;
+----------+------------+
| route_id | carlicence |
+----------+------------+
|       23 |          5 |
|       45 |          3 |
|       76 |          2 |
+----------+------------+
```
I experimented with different SQL queries, for example:
```
mysql> ALTER TABLE BUS RENAME COLUMN `carlicence` TO `license_plate`;
+----+---------------+------------+----------+
| ID | license_plate | inspection | route_id |
+----+---------------+------------+----------+
```
Then there was created new user ***tester*** that can access mysql databases  from ***localhost***:
```
mysql>  CREATE USER `tester`@`localhost` IDENTIFIED BY 'firstpass';
```
also was created new database:
```
mysql> CREATE DATABASE dbfortest;
```
and there were added all permissons for new user for this database:
```
mysql> GRANT ALL ON dbfortest.* TO `tester`@`localhost`;
```
after running mysql as the ***tester*** I was able to create new table in the ***dbfortest*** database:
```
mysql> CREATE TABLE `person` (`ID` int NOT NULL, `first_name` char(30) NOT NULL, `last_name` char(30) NOT NULL, `birth` DATETIME NOT NULL, PRIMARY KEY (`ID`));
Query OK, 0 rows affected (0.04 sec)
```
as a final test in this section I have run the following SELECTs on the mysql database:
```
mysql> select Host,User,Select_priv,Insert_priv,Update_priv,Delete_priv,Create_priv,Drop_priv,Reload_priv,Shutdown_priv,Process_priv,File_priv from user where user='tester';
+-----------+--------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+
| Host      | User   | Select_priv | Insert_priv | Update_priv | Delete_priv | Create_priv | Drop_priv | Reload_priv | Shutdown_priv | Process_priv | File_priv |
+-----------+--------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+
| localhost | tester | N           | N           | N           | N           | N           | N         | N           | N             | N            | N         |
+-----------+--------+-------------+-------------+-------------+-------------+-------------+-----------+-------------+---------------+--------------+-----------+
1 row in set (0.00 sec)
mysql>  select Host,Db,User,Select_priv,Insert_priv,Update_priv,Delete_priv,Create_priv,Drop_priv,Grant_priv,References_priv,Index_priv from db where db='dbfortest';
+-----------+-----------+--------+-------------+-------------+-------------+-------------+-------------+-----------+------------+-----------------+------------+
| Host      | Db        | User   | Select_priv | Insert_priv | Update_priv | Delete_priv | Create_priv | Drop_priv | Grant_priv | References_priv | Index_priv |
+-----------+-----------+--------+-------------+-------------+-------------+-------------+-------------+-----------+------------+-----------------+------------+
| localhost | dbfortest | tester | Y           | Y           | Y           | Y           | Y           | Y         | N          | Y               | Y          |
+-----------+-----------+--------+-------------+-------------+-------------+-------------+-------------+-----------+------------+-----------------+------------+
1 row in set (0.00 sec)
```
So as a conclusion I may say that it is possible to change user permissions directly in the ***db*** and ***user*** tables of ***mysql*** database


**Part 2**

The ***busroutes*** database was dumped by running the following command in root session:
```
mysqldump busroutes > busroutes.sql
```
which ceated /root/busroutes.sql file which is [attached](busroutes.sql) to this project.

After that the ***driver*** table was deleted:
```
mysql> USE busroutes; DROP TABLE driver;
+---------------------+
| Tables_in_busroutes |
+---------------------+
| BUS                 |
| daylog              |
| route               |
+---------------------+
```
and restoration got database back to the previous state:
```
# mysql busroutes < busroutes.sql
+---------------------+
| Tables_in_busroutes |
+---------------------+
| BUS                 |
| daylog              |
| driver              |
| route               |
+---------------------+
```
There was created ***d1*** databas einstance in Amazon RDS [see here](screnshots/002.JPG)
