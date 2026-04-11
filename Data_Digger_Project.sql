CREATE DATABASE event_management;
USE  event_management;
CREATE TABLE events(
event_id INT PRIMARY KEY,
event_name VARCHAR(100),
event_date DATE,
venue_id INT,
organizer_id INT,
ticket_price DECIMAL(10,2),
total_seats int); 

CREATE TABLE venues(
venue_id INT PRIMARY KEY,
venue_name VARCHAR(100),
location VARCHAR(100),
capacity int
);

CREATE TABLE Organizers (
organizer_id INT PRIMARY KEY,
organizer_name VARCHAR(100),
contact_email VARCHAR(100),
phone_number VARCHAR(15)
);

CREATE TABLE Attendees (
attendee_id INT PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100),
phone_number VARCHAR(15)
);

CREATE TABLE Tickets(
ticket_id INT PRIMARY KEY,
event_id INT,
attendee_id INT,
booking_date DATE,
status VARCHAR(20),
FOREIGN KEY (event_id) REFerences Events (event_id),
FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id)
);

CREATE TABLE Payments(
payment_id INT PRIMARY KEY,
ticket_id INT,
amount_paid DECIMAL(10,2),
payment_status VARCHAR (20),
payment_data DATE,
FOREIGN KEY (ticket_id) references Tickets (ticket_id)
);
INSERT INTO Venues VALUES
(1, 'Hall A', 'Mumbai', 200),
(2, 'Hall B', 'Delhi', 150);
INSERT INTO Organizers VALUES
(1, 'ABC Events', 'abc@gmail.com', '9876543210'),
(2, 'XYZ Pvt Ltd', 'xyz@gmail.com', '9123456780');
INSERT INTO Events VALUES
(1, 'Music Fest', '2026-05-10', 1, 1, 500.00, 200),
(2, 'Tech Conference', '2026-06-15', 2, 2, 1000.00, 150);
INSERT INTO Attendees VALUES
(1, 'Pooja', 'pooja@gmail.com', '9999999999'),
(2, 'Rahul', 'rahul@gmail.com', '8888888888');
INSERT INTO Tickets VALUES
(1, 1, 1, '2026-04-01', 'Confirmed'),
(2, 2, 2, '2026-04-02', 'Pending');
INSERT INTO Payments VALUES
(1, 1, 500.00, 'Success', '2026-04-01'),
(2, 2, 1000.00, 'Pending', '2026-04-02');
SELECT * FROM venues;
SELECT * FROM Organizers;
SELECT * FROM Events;
SELECT * FROM Attendees;
SELECT * FROM Tickets;
SELECT * FROM Payments;
INSERT INTO Events values (3, 'Workshop', '2026-07-01', 1, 1, 300, 100);
SELECT * FROM Events;


UPDATE Events
SET ticket_price = 350
WHERE event_id = 2;

UPDATE Events
SET ticket_price = 200
WHERE event_id = 3;
DELETE FROM Events
where event_id = 3;
select * from Events
where event_date > curdate();

SELECT e.event_name,sum(p.amount_paid) AS revenue
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
JOIN Payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_name
ORDER BY revenue DESC
LIMIT 5;
SELECT * FROM Tickets
WHERE booking_date >= CURDATE() - INTERVAL 7 DAY;

SELECT e.event_name
FROM Events e
LEFT JOIN Tickets t ON e.event_id = t.event_id
WHERE MONTH(e.event_date) = 12
GROUP BY e.event_id, e.event_name, e.total_seats
HAVING (e.total_seats - COUNT(t.ticket_id)) > (e.total_seats / 2);
SELECT DISTINCT a.name
FROM Attendees a
JOIN Tickets t ON a.attendee_id = t.attendee_id
LEFT JOIN Payments p ON t.ticket_id = p.ticket_id
WHERE p.payment_status = 'Pending' OR t.status = 'Confirmed';
select e.event_name
from events e
left join tickets t on e.event_id = t.event_id
group by e.event_id,e.event_name,e.total_seats
having count(t.ticket_id) < e.total_seats;
select * from events
order by event_date asc;
select e.event_name, count(t.attendee_id) as total_attendees
from events e
left join tickets t on e.event_id = t.event_id
group by e.event_name;
select sum(amount_paid) as total_revenue
from payments;
SELECT e.event_name, COUNT(t.attendee_id) AS total
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
GROUP BY e.event_name
ORDER BY total DESC
LIMIT 1;
select e.event_name,count(t.attendee_id) as total
from events e 
join tickets t on e.event_id = t.event_id
group by e.event_name
order by total DESC
limit 1;
select avg(ticket_price) as avg_price
from events; 
ALTER TABLE tickets
ADD CONSTRAINT unique_booking UNIQUE(event_id, attendee_id);

select e.event_name, v.venue_name
from events e 
inner join venues v on e.venue_id = v.venue_id;

select a.name
from attendees a 
join tickets t on a.attendee_id = t.attendee_id
left join payments p on t.ticket_id = p.ticket_id
where p.payment_id is null;

select e.event_name 
from tickets t
right join events e on t.event_id = e.event_id
where t.ticket_id is null;
select e.event_name, t.ticket_id
from Events e
left join Tickets t on e.event_id = t.event_id

UNION

select e.event_name, t.ticket_id
from Events e
right join Tickets t on e.event_id = t.event_id;
SELECT event_name
FROM Events
WHERE ticket_price > (
    SELECT AVG(ticket_price) FROM Events
);
SELECT a.name
FROM Attendees a
JOIN Tickets t ON a.attendee_id = t.attendee_id
GROUP BY a.attendee_id
HAVING COUNT(DISTINCT t.event_id) > 1;
SELECT o.organizer_name
FROM Organizers o
JOIN Events e ON o.organizer_id = e.organizer_id
GROUP BY o.organizer_id
HAVING COUNT(e.event_id) > 3;
SELECT event_name, MONTH(event_date) AS month
FROM Events;


SELECT payment_id,
DATE_FORMAT(payment_data, '%Y-%m-%d %H:%i:%s') AS formatted_date
FROM Payments;
SELECT UPPER(organizer_name) AS organizer_name
FROM Organizers;
SELECT TRIM(name) AS cleaned_name
FROM Attendees;
SELECT name,
IFNULL(email, 'Not Provided') AS email
FROM Attendees;
SELECT e.event_name,
SUM(p.amount_paid) AS revenue,
RANK() OVER (ORDER BY SUM(p.amount_paid) DESC) AS rank_no
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
JOIN Payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_name;
SELECT event_id,
SUM(ticket_price) OVER (ORDER BY event_id) AS cumulative_sales
FROM Events;
SELECT event_id,
COUNT(attendee_id) OVER (PARTITION BY event_id) AS total_attendees
FROM Tickets;
SELECT e.event_name,
CASE
    WHEN (e.total_seats - COUNT(t.ticket_id)) < (0.2 * e.total_seats) THEN 'High Demand'
    WHEN (e.total_seats - COUNT(t.ticket_id)) BETWEEN (0.2 * e.total_seats) AND (0.5 * e.total_seats) THEN 'Moderate Demand'
    ELSE 'Low Demand'
END AS demand_status
FROM Events e
LEFT JOIN Tickets t ON e.event_id = t.event_id
GROUP BY e.event_id;
SELECT payment_id,
CASE
    WHEN payment_status = 'Success' THEN 'Successful'
    WHEN payment_status = 'Failed' THEN 'Failed'
    ELSE 'Pending'
END AS final_status
FROM Payments;


