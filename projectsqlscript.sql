DROP TABLE staffs CASCADE CONSTRAINTS PURGE;
DROP TABLE clients CASCADE CONSTRAINTS PURGE;
DROP TABLE sites CASCADE CONSTRAINTS PURGE;
DROP TABLE security_arrangement CASCADE CONSTRAINTS PURGE;
DROP TABLE staff_assignment CASCADE CONSTRAINTS PURGE;
DROP TABLE availability CASCADE CONSTRAINTS PURGE;
DROP TABLE booking_status CASCADE CONSTRAINTS PURGE;
DROP TABLE master_calendar CASCADE CONSTRAINTS PURGE;
DROP TABLE payments CASCADE CONSTRAINTS PURGE;
DROP TABLE invoice CASCADE CONSTRAINTS PURGE;

SET SQLPROMPT "w22057585>"
CREATE TABLE staffs
(
  staff_id varchar(3) not null,
  staff_type varchar(20) not null,
  staff_name varchar(20) not null,
  staff_role varchar(20) not null,
  staff_phone_number varchar(20) not null,
  staff_address varchar(80) not null,
  CONSTRAINT staffs PRIMARY KEY (staff_id),
  CONSTRAINT staff_phone_number UNIQUE (staff_phone_number)
);
CREATE TABLE clients
(
  client_id varchar(3) not null,
  client_name varchar(30) not null,
  client_type varchar(20) not null,
  client_address varchar(80) not null,
  cl_phone_number varchar(20) not null,
  CONSTRAINT clients PRIMARY KEY (client_id),
  CONSTRAINT cl_phone_number UNIQUE (cl_phone_number)
);
CREATE TABLE sites
(
  site_id varchar(6) not null,
  site_type varchar(20) not null,
  site_name varchar(70) not null,
  site_location varchar(80) not null,
  site_distance varchar(20) not null,
  site_incharge varchar(20) not null,
  site_phone_number varchar(20) not null,
  staff_id varchar(3) not null,
  client_id varchar(3) not null,
  CONSTRAINT sites PRIMARY KEY (site_id),
  CONSTRAINT site_phone_number UNIQUE (site_phone_number),
  CONSTRAINT site_staffs FOREIGN KEY (staff_id) REFERENCES staffs(staff_id),
  CONSTRAINT site_clients FOREIGN KEY (client_id) REFERENCES clients(client_id)
);
CREATE TABLE security_arrangement
(
  arrangement_id varchar(5) not null,
  deposit_status varchar(20) not null,
  time_period varchar(30) not null,
  start_date DATE not null,
  end_date DATE not null,
  client_id varchar(6) not null,
  site_id varchar(6) not null,
  arrangement_duration varchar(15) not null,
  arrangement_days varchar(13) not null,
  arrangement_hours integer not null,
  rate_per_hour integer not null,
  gross_cost integer not null,
  contingency_cost integer not null,
  tax integer not null,
  total_price integer not null,
  base_deposit decimal not null,
  CONSTRAINT security_arrangement PRIMARY KEY (arrangement_id),
  CONSTRAINT security_arrangement_site FOREIGN KEY (site_id) REFERENCES sites(site_id),
  CONSTRAINT security_arrangement_clients FOREIGN KEY (client_id) REFERENCES clients(client_id)
);
CREATE TABLE staff_assignment
(
  assignment_id varchar(5) not null,
  start_date DATE not null,
  end_date DATE not null,
  staff_id varchar(3) not null,
  site_id varchar(6) not null,
  arrangement_id varchar(5) not null,
  CONSTRAINT staff_assignment PRIMARY KEY (assignment_id),
  CONSTRAINT staff_assignment_sites FOREIGN KEY (site_id) REFERENCES sites(site_id),
  CONSTRAINT staff_assignment_staffs FOREIGN KEY (staff_id) REFERENCES staffs(staff_id),
  CONSTRAINT staff_assignment_arrangement FOREIGN KEY (arrangement_id) REFERENCES security_arrangement(arrangement_id)
);
CREATE TABLE availability
(
  availability_id varchar(5) not null,
  availability_status varchar(30) not null,
  start_date DATE not null,
  end_date DATE not null,
  staff_id varchar(3) not null,
  CONSTRAINT availability PRIMARY KEY (availability_id),
  CONSTRAINT availability_staff FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);
CREATE TABLE booking_status
(
  booking_id varchar(5) not null,
  start_date DATE not null,
  staff_id varchar(3) not null,
  site_id varchar(6) not null,
  arrangement_id varchar(5) not null,
  availability_id varchar(5) not null,
  CONSTRAINT booking_status PRIMARY KEY (booking_id),
  CONSTRAINT booking_status_sites FOREIGN KEY (site_id) REFERENCES sites(site_id),
  CONSTRAINT booking_status_staffs FOREIGN KEY (staff_id) REFERENCES staffs(staff_id),
  CONSTRAINT booking_status_arrangement FOREIGN KEY (arrangement_id) REFERENCES security_arrangement(arrangement_id),
  CONSTRAINT booking_status_availability FOREIGN KEY (availability_id) REFERENCES availability(availability_id)
);
CREATE TABLE master_calendar
(
  calendar_id varchar(5) not null,
  start_date DATE not null,
  end_date DATE not null,
  staff_id varchar(3) not null,
  client_id varchar(6),
  site_id varchar(6),
  booking_id varchar(3),
  CONSTRAINT master_calendar PRIMARY KEY (calendar_id),
  CONSTRAINT master_calendar_staffs FOREIGN KEY (staff_id) REFERENCES staffs(staff_id),
  CONSTRAINT master_calendar_clients FOREIGN KEY (client_id) REFERENCES clients(client_id),
  CONSTRAINT master_calendar_sites FOREIGN KEY (site_id) REFERENCES sites(site_id),
  CONSTRAINT master_calendar_booking_status FOREIGN KEY (booking_id) REFERENCES booking_status(booking_id)
);
CREATE TABLE payments
(
  payment_id varchar(5) not null,
  total_price decimal not null,
  payment_method varchar(15) not null,
  amount_paid decimal not null,
  payment_date DATE not null,
  payment_status varchar(10) not null,
  client_id varchar(6) not null,
  CONSTRAINT payments PRIMARY KEY (payment_id),
  CONSTRAINT payments_clients FOREIGN KEY (client_id) REFERENCES clients(client_id),
  CONSTRAINT payments_amount_paid UNIQUE (amount_paid)
);
CREATE TABLE invoice
(
  invoice_id varchar(10) not null,
  invoice_date DATE not null,
  amount_paid decimal not null,
  Invoice_amount_due decimal not null,
  client_id varchar(6) not null,
  payment_id varchar(5) not null,
  CONSTRAINT invoice PRIMARY KEY (invoice_id),
  CONSTRAINT invoice_clients FOREIGN KEY (client_id) REFERENCES clients(client_id),
  CONSTRAINT invoice_payments FOREIGN KEY (payment_id) REFERENCES payments(payment_id),
  CONSTRAINT invoice_payments2 FOREIGN KEY (amount_paid) REFERENCES payments(amount_paid)
);

INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S1','Full Time','Antara das','Manager','7523456789','2 Sidney Grove, Newcastle upon Tyne NE4 5PD');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S2','Full Time','Bulbul shami','Manager','7125456790','27 Brookfield,  Newcastle upon Tyne NE27 0BJ');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S3','Full Time','George kittle','Manager','7323456791','5 High Bridge, Newcastle upon Tyne NE1 1EW');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S4','Full Time','Diana ross','Employee','7155556792',' 35 Welbeck Rd, Newcastle upon Tyne NE6 2DY');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S5','Full Time','Elena gilbert','Employee','7234346793','55 Grey St, Newcastle upon Tyne NE1 6EE');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S6','Full Time','Flaura saini','Employee','7123456794','45 Lime St, Newcastle upon Tyne NE1 2PQ');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S7','Full Time','Chitra ramakrishna','Employee','7569876541','34 George St, Newcastle upon Tyne NE4 7JN');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S8','Full Time','Harry styles','Employee','7451877548','39 Bath Ln, Newcastle upon Tyne NE4 5SP');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S9','Full Time','Ishan khatter','Employee','7745876543','35 Market St, Newcastle upon Tyne NE1 6JE');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S10','Full Time','Jackie chan','Employee','7123456798','37 Elswick Rd, Newcastle upon Tyne NE4 6JE');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S11','Part time','Kiara advani','Employee','7123456799','49 Groat Market, Newcastle upon Tyne NE1 1UQ');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S12','Part time','Lavanya tripathi','Employee','7123456800','57 Starbeck Ave, Newcastle upon Tyne NE2 1RJ');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S13','Part time','Monika naidu','Employee','7123456801','35 Clayton St, Newcastle upon Tyne NE1 5PN');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S14','Part time','Nora fatehi','Employee','7123456802','7 Osborne Ave, Newcastle upon Tyne NE2 1JS');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address)
values('S15','Part time','Ola mioni','Employee','7123456803','12 George St, Newcastle upon Tyne NE4 7JN');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S16','Part time','Preeti sutara','Employee','7123456804','27 Grainger Park Rd, Newcastle upon Tyne NE4 8SA');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address) 
values('S17','Part time','querreshi gupta','Employee','7123456805','68 Moor Ln, Newcastle upon Tyne NE3 3EE');
INSERT INTO staffs(staff_id,staff_type,staff_name,staff_role,staff_phone_number,staff_address)
values('S18','Part time','Rita shroff','Employee','7123456806','45 Manorfields, Newcastle upon Tyne NE12 8AG');


INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C1','Private individual','Tom Watson','45 Frederick St, Sunniside, Sunderland SR1 1NF','0191 514 2022');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C2','Business','keith sequirra','11 Northumberland St, Darlington DL3 7HJ','01325 462550');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C3','Business','manim mushir','86 The Green, Coventry, Cv63 4ya','0191 432 5484');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C4','Business','jayanth choudary','870 The Avenue, Guildford, Gu31 4uk','0800 092 1607');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C5','Private individual','farsil fathima','56 Queensway, Oldham, Ol76 4qj','0191 206 9719');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C6','Private individual','ashish bhatia','38 The Drive Slough, Sl79 5ye','0191 286 8744');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C7','Business','barbara museem','77 Victoria Road, Luton, Lu9 0za','0800 678 3699');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C8','Business','churchill kunt','53 Green Lane, Dumfries, Dg92 6aw','0191 651 1998');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C9','Private individual','dickson charles','911 Alexander Road, Blackpool, Fy60 8tf','0191 281 6159');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C10','Private individual','elison stephen','9966 Broadway, Guildford, Gu15 6pb','0300 303 6326');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C11','Business','frank farsin','46 School Lane, Hemel Hempstead, Hp48 2oz','0191 691 3879');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C12','Private individual','grove minson','674 Chester Road, Preston, Pr29 3cg','0191 447 0210');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C13','Business','hasmin fazil','88 York Road, Liverpool, L10 6dj','0191 603 1055');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C14','Private individual','ishika singh','10 Church Lane, Walsall, Ws52 7gq','0191 261 6319');
INSERT INTO clients(client_id,client_type,client_name,client_address,cl_phone_number) 
values ('C15','Private individual','latika padukone','794 Highfield Road, Harrow, Ha69 7dq','0191 303 9601');

INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site1','Property','Abodus Portland Green Student Village - Student Accommodation','Portland Rd, Shieldfield, Newcastle upon Tyne NE2 1DT','0.5 mile','Diana ross','0191 484 0112','S4','C1');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site2','Business Premises','Regus - Newcastle, Cloth Market','Merchant House, 30 Cloth Market, Newcastle upon Tyne NE1 1EE','1.4 miles','Elena gilbert','0800 060 8704','S5','C2');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site3','construction','Ponteland Plant Limited','Main St, Ponteland, Newcastle upon Tyne NE20 9SS','8.8 miles','Flaura saini','0191 228 0847','S6','C3');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site4','industrial site','UK Industrial Tapes Ltd','Brumwell House, Westway Industrial Park, Throckley, Newcastle upon Tyne NE15 9EW','7.5 miles','Chitra ramakrishna','0191 269 7819','S7','C4');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site5','construction','Sendrig Construction Ltd','4 Benton Ter, Jesmond, Newcastle upon Tyne NE2 1QU','0.3 mile','Harry styles',' 0191 281 0836','S8','C5');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site6','Property','Gainsborough House','34-40 Grey St, Newcastle upon Tyne NE1 6AE','1.5 miles','Ishan khatter','0191 261 7063','S9','C6');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site7','Business Premises','Collingwood Buildings Business Centre','38 Collingwood St, Newcastle upon Tyne NE1 1JF','1.6 miles','Jackie chan','0191 229 9504','S10','C7');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site8','industrial site','Utex Industries UK Limited Formerly','17 Queens Ln, Newcastle upon Tyne NE1 1RN','1.1 miles','Kiara advani','01670 819516','S11','C8');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site9','Property','Yetholm Properties Ltd','28 St Marys Pl, Newcastle upon Tyne NE1 7PQ','0.2 mile','Lavanya tripathi','0191 221 0402','S12','C9');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site10','construction','G M R Construction-Maintenance Ltd','Clayton House, Walbottle Rd, Newburn, Newcastle upon Tyne NE15 9RU','7.2 miles','Monika naidu','0191 267 7904','S13','C10');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site11','industrial site',' Integral UK Ltd','Block B, Holland Park, Holland Dr, Spital Tongues, Newcastle upon Tyne NE2 4LD','1.7 miles','Nora fatehi','0191 261 1073','S14','C11');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site12','Property','Knight Frank Newcastle Commercial Agents','St Anns Quay, 124 Quayside, Newcastle upon Tyne NE1 3BD','1.8 miles','Ola mioni','0191 640 7987','S15','C12');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site13','Business Premises','Real Business Rescue - Newcastle',' 4, Cathedral Buildings, Dean St, Newcastle upon Tyne NE1 1PG','1.3 miles','Preeti sutara','0191 206 9717','S16','C13');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site14','construction','Red Kite Construction Development Ltd ','Brunswick Industrial Estate, 2, Sandison Ct, Newcastle upon Tyne NE13 7BA','6.2 miles','querreshi gupta','0191 233 4609','S17','C14');
INSERT INTO sites(site_id,site_type,site_name,site_location,site_distance,site_incharge,site_phone_number,staff_id,client_id) 
values ('Site15','Business Premises','LSL Property Services plc. Newcastle','Newcastle House, Newcastle Business park, Albany Ct, Newcastle upon Tyne NE4 7YB','3.2 miles','Rita shroff','0191 228 0849','S18','C15');

INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A1','received','weekdays','01-Jan-23','31-Mar-23','C1','Site1','12 weeks 5 days','65 weekdays','1560','13','20280','2028','1014','23322','4664.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A2','received','weekends','01-Jan-23','31-Mar-23','C2','Site2','12 weeks 5 days','25 weekends','600','13','7800','780','390','8970','1794');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A3','received','weekdays and weekend','01-Jan-23','31-Mar-23','C3','Site3','12 weeks 5 days','90 days','2160','13','28080','2808','1404','32292','6458.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A4','received','weekdays','01-Jan-23','31-Mar-23','C4','Site4','12 weeks 5 days','65 weekdays','1560','13','20280','2028','1014','23322','4664.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A5','received','weekdays and weekend','01-Jan-23','31-Mar-23','C5','Site5','12 weeks 5 days','90 days','2160','13','28080','2808','1404','32292','6458.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A6','received','weekdays','01-Jan-23','31-Mar-23','C6','Site6','12 weeks 5 days','65 weekdays','1560','13','20280','2028','1014','23322','4664.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A7','received','weekdays','01-Jan-23','31-Mar-23','C7','Site7','12 weeks 5 days','65 weekdays','1560','13','20280','2028','1014','23322','4664.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A8','received','weekends','01-Jan-23','31-Mar-23','C8','Site8','12 weeks 5 days','25 weekends','600','13','7800','780','390','8970','1794');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A9','received','weekdays and weekend','01-Jan-23','31-Mar-23','C9','Site9','12 weeks 5 days','90 days','2160','13','28080','2808','1404','32292','6458.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A10','received','weekdays','01-Jan-23','31-Mar-23','C10','Site10','12 weeks 5 days','65 weekdays','1560','13','20280','2028','1014','23322','4664.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A11','received','weekdays','01-Jan-23','31-Mar-23','C11','Site11','12 weeks 5 days','65 weekdays','1560','13','20280','2028','1014','23322','4664.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A12','received','weekends','01-Jan-23','31-Mar-23','C12','Site12','12 weeks 5 days','25 weekends','600','13','7800','780','390','8970','1794');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A13','received','weekdays and weekend','01-Jan-23','31-Mar-23','C13','Site13','12 weeks 5 days','90 days','2160','13','28080','2808','1404','32292','6458.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A14','received','weekdays and weekend','01-Jan-23','31-Mar-23','C14','Site14','12 weeks 5 days','90 days','2160','13','28080','2808','1404','32292','6458.4');
INSERT INTO security_arrangement(arrangement_id,deposit_status,time_period,start_date,end_date,client_id,site_id,arrangement_duration,arrangement_days,arrangement_hours,rate_per_hour,gross_cost,contingency_cost,tax,total_price,base_deposit) values('A15','received','weekends','01-Jan-23','31-Mar-23','C15','Site15','12 weeks 5 days','25 weekends','600','13','7800','780','390','8970','1794');

INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As1','01-Jan-23','31-Mar-23','S4','Site1','A1');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As2','01-Jan-23','31-Mar-23','S5','Site2','A2');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As3','01-Jan-23','31-Mar-23','S6','Site3','A3');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As4','01-Jan-23','31-Mar-23','S7','Site4','A4');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As5','01-Jan-23','31-Mar-23','S8','Site5','A5');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As6','01-Jan-23','31-Mar-23','S9','Site6','A6');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As7','01-Jan-23','31-Mar-23','S10','Site7','A7');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As8','01-Jan-23','31-Mar-23','S11','Site8','A8');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As9','01-Jan-23','31-Mar-23','S12','Site9','A9');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As10','01-Jan-23','31-Mar-23','S13','Site10','A10');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As11','01-Jan-23','31-Mar-23','S14','Site11','A11');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As12','01-Jan-23','31-Mar-23','S15','Site12','A12');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As13','01-Jan-23','31-Mar-23','S16','Site13','A13');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As14','01-Jan-23','31-Mar-23','S17','Site14','A14');
INSERT INTO staff_assignment(assignment_id,start_date,end_date,staff_id,site_id,arrangement_id) values('As15','01-Jan-23','31-Mar-23','S18','Site15','A15');

INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av1','weekdays','01-Jan-23','31-Mar-23','S1');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av2','weekends','01-Jan-23','31-Mar-23','S2');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av3','weekdays and weekend','01-Jan-23','31-Mar-23','S3');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av4','weekdays','01-Jan-23','31-Mar-23','S4');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av5','weekdays and weekend','01-Jan-23','31-Mar-23','S5');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av6','weekdays','01-Jan-23','31-Mar-23','S6');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av7','weekdays','01-Jan-23','31-Mar-23','S7');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av8','weekends','01-Jan-23','31-Mar-23','S8');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av9','weekdays and weekend','01-Jan-23','31-Mar-23','S9');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av10','weekdays','01-Jan-23','31-Mar-23','S10');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av11','weekdays','01-Jan-23','31-Mar-23','S11');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av12','weekends','01-Jan-23','31-Mar-23','S12');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av13','weekdays and weekend','01-Jan-23','31-Mar-23','S13');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av14','weekdays and weekend','01-Jan-23','31-Mar-23','S14');
INSERT INTO availability(availability_id,availability_status,start_date,end_date,staff_id) values('Av15','weekends','01-Jan-23','31-Mar-23','S15');


INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B1','01-Jan-23','S4','Site1','A1','Av1');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B2','01-Jan-23','S5','Site2','A2','Av2');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B3','01-Jan-23','S6','Site3','A3','Av3');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B4','01-Jan-23','S7','Site4','A4','Av4');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B5','01-Jan-23','S8','Site5','A5','Av5');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B6','01-Jan-23','S9','Site6','A6','Av6');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B7','01-Jan-23','S10','Site7','A7','Av7');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B8','01-Jan-23','S11','Site8','A8','Av8');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B9','01-Jan-23','S12','Site9','A9','Av9');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B10','01-Jan-23','S13','Site10','A10','Av10');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B11','01-Jan-23','S14','Site11','A11','Av11');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B12','01-Jan-23','S15','Site12','A12','Av12');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B13','01-Jan-23','S16','Site13','A13','Av13');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B14','01-Jan-23','S17','Site14','A14','Av14');
INSERT INTO booking_status(booking_id,start_date,staff_id,site_id,arrangement_id,availability_id) values('B15','01-Jan-23','S18','Site15','A15','Av15');

INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c1','01-Jan-23','31-Mar-23','S1',null,null,null);
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c2','01-Jan-23','31-Mar-23','S2',null,null,null);
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c3','01-Jan-23','31-Mar-23','S3',null,null,null);
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c4','01-Jan-23','31-Mar-23','S4','C1','Site1','B1');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c5','01-Jan-23','31-Mar-23','S5','C2','Site2','B2');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c6','01-Jan-23','31-Mar-23','S6','C3','Site3','B3');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c7','01-Jan-23','31-Mar-23','S7','C4','Site4','B4');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c8','01-Jan-23','31-Mar-23','S8','C5','Site5','B5');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c9','01-Jan-23','31-Mar-23','S9','C6','Site6','B6');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c10','01-Jan-23','31-Mar-23','S10','C7','Site7','B7');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c11','01-Jan-23','31-Mar-23','S11','C8','Site8','B8');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c12','01-Jan-23','31-Mar-23','S12','C9','Site9','B9');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c13','01-Jan-23','31-Mar-23','S13','C10','Site10','B10');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c14','01-Jan-23','31-Mar-23','S14','C11','Site11','B11');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c15','01-Jan-23','31-Mar-23','S15','C12','Site12','B12');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c16','01-Jan-23','31-Mar-23','S16','C13','Site13','B13');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c17','01-Jan-23','31-Mar-23','S17','C14','Site14','B14');
INSERT INTO master_calendar(calendar_id,start_date,end_date,staff_id,client_id,site_id,booking_id) values ('c18','01-Jan-23','31-Mar-23','S18','C15','Site15','B15');

INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P1','23322','cheque','4250','12-Nov-23','success','C1');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P2','8970','cash','1794','03-Nov-23','success','C2');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P3','32292','credit card','5800','22-Nov-23','success','C3');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P4','23322','cash','4000','23-Nov-23','success','C4');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P5','32292','cheque','6300','24-Nov-23','success','C5');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P6','23322','cash','4300','17-Nov-23','success','C6');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P7','23322','credit card','3500','18-Nov-23','success','C7');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P8','8970','cash','1600','05-Nov-23','success','C8');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P9','32292','cash','6400','20-Nov-23','success','C9');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P10','23322','credit card','4200','21-Nov-23','success','C10');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P11','23322','cheque','3600','14-Nov-23','success','C11');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P12','8970','credit card','1700','15-Nov-23','success','C12');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P13','32292','cash','6150','16-Nov-23','success','C13');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P14','32292','credit card','5500','25-Nov-23','success','C14');
INSERT INTO payments(payment_id,total_price,payment_method,amount_paid,payment_date,payment_status,client_id) values ('P15','8970','cash','1650','06-Nov-23','success','C15');

INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice1','17-Nov-23','4000','19322','C1','P1');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice2','8-Nov-23','1794','7176','C2','P2');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice3','27-Nov-23','5800','26492','C3','P3');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice4','28-Nov-23','4000','4970','C4','P4');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice5','29-Nov-23','6300','25992','C5','P5');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice6','22-Nov-23','4300','19022','C6','P6');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice7','23-Nov-23','3500','19822','C7','P7');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice8','10-Nov-23','1600','7370','C8','P8');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice9','25-Nov-23','6400','25892','C9','P9');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice10','26-Nov-23','4200','19122','C10','P10');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice11','19-Nov-23','3600','19722','C11','P11');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice12','20-Nov-23','1700','7270','C12','P12');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice13','21-Nov-23','6150','26142','C13','P13');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice14','30-Nov-23','5500','26792','C14','P14');
INSERT INTO invoice(invoice_id,invoice_date,amount_paid,Invoice_amount_due,client_id,payment_id) values ('Invoice15','11-Nov-23','1794','7176','C15','P15');