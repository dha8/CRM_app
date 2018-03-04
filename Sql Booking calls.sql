-- MySQL Script - Queries towards the Booking DB
-- Fri Feb 23 16:10:28 2018
-- Model: New Model    Version: 1.0
-- W.Gromov

-- -----------------------------------------------------
-- Insert new users
-- -----------------------------------------------------
USE `mydb` ;

Select * from Employees;

INSERT INTO `mydb`.`Employees` (`PersID`, `Name`, `Surname`, `Position`, `Active`) VALUES (1006, 'John', 'Smith', 'SQL wiz', 1);

Select * from Employees;

-- -----------------------------------------------------
-- Delete users
-- -----------------------------------------------------
update employees
set Active = 0
where PersID = 1006
;

-- -----------------------------------------------------
-- Insert and delete teams
INSERT INTO `mydb`.`Teams` (`GroupID`, `Name`, `Employees_PersID`, `Active`) VALUES (19, 'Best', 1005, 1);
Select * from Teams;

update Teams
set Active = 0
where GroupID = 19
;

-- --------------------------
-- Delete future meetings
-- ---------------------------
Delete from Meeting
Where timeStart > curdate() 
;

Select * from Meeting;
-- --------------------------
-- Occupation lists
-- ---------------------------

Select R.Name, M.timeStart as occupiedFrom, M.timeEnd as occupiedTo 
	from Rooms R
	Left join Meeting as M on R.Name = M.Rooms_name 
		AND date(timeStart) = '2018-04-01'; 

-- --------------------------
-- Who booked the meeting?
-- ---------------------------
Select e.Name, e.Surname, m.Rooms_name, m.timeStart, m.timeEnd from Meeting m
	left join Employees e on m.BookedBy=e.PersID
    order by e.Name, e.Surname
;
-- --------------------------
-- Meeting participants
-- ---------------------------
Select Name From Employees
where PersID in (
	Select Employees_PersID from Participants_int 
    where Meeting = 1
)                
Union 
Select Name From Partners
where PartnerID in (
	Select Partners_PartnerID from Participants_ext 
    where Meeting = 1
);

-- --------------------------
-- Team costs 
-- ---------------------------
Select t.Name, sum(m.Cost) as teamCost from Meeting m
join Teams t on  m.Team=t.GroupID 
and m.timeStart > '2018-01-01 00:00'
and m.timeEnd   < '2018-03-01 00:00'
group by t.Name;


-- -------------------
-- Remove team
-- -------------------
select 

