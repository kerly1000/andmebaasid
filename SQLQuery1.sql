create database TARge25

--db valimine
use master

--04.03.26
--2 tund

--db kustutamine
drop database TARge25

--tabeli tegemine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male'),
(1, 'Female'),
(3, 'Unknown')

--tabeli sisu vaatamine
select * from Gender

--tehke tabel nimega Person
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'cat@cat.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)

--soovime näha Person tabeli sisu
select * from Person

--võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--kui sisestad uue rea andmeid aj ei ole sisestanud genderId alla väärtust, siis
--see automaatselt sisestab sellele reale väärtuse 3 e mis meil on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Person (Id, Name, Email, GenderId)
values (7, 'Flash','f@f.com', NULL)

insert into Person (Id, Name, Email)
values (9, 'Plack Panther','p@p.com')

select * from Person

--kustutada DF_Persons_GenderId piirang koodiga
alter table Person
drop constraint DF_Persons_GenderId

--lisame koodiga veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kui sa tead veergude järjekorda peast, 
--siis ei pea neid sisestama
insert into Person 
values (10, 'Green Arrow', 'g@g.com', 2, 154)

--constrainti kustutamine
alter table Person
drop constraint CK_Person_Age

alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 130)

-- kustutame rea
delete from Person where Id = 10

--kuidas uuendada andmeid koodiga
--Id 3 uus vanus on 50
update Person
set Age = 50
where Id = 3

--lisame Person tabelisse veeru City ja nvarchar 50
alter table Person
add City nvarchar(50)

--kõik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--k]ik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'
select * from Person where not City = 'Gotham'

--n'itab teatud vanusega inimesi
--35, 42, 23
select * from Person where Age = 35 or Age = 42 or Age = 23
select * from Person where Age in (35, 42, 23)

--näitab teatud vanusevahemikus olevaid isikuid 22 kuni 39
select * from Person where Age between 22 and 39

--wildcardi kasutamine
--näitab kõik g-tähega algavad linnad
select * from Person where City like 'g%'
--email, kus on @ märk sees
select * from Person where Email like '%@%'

--näitab, kellel on emailis ees ja peale @-märki ainult üks täht ja omakorda .com
select * from Person where Email like '_@_.com'

--kõik, kellel on nimes esimene täht W, A, S
--katusega v'listab
select * from Person where  Name like '[^WAS]%'

select * from Person where  Name like '[WAS]%'

--kes elavad Gothamis ja New Yorkis
select * from Person where City = 'Gotham' or City = 'New York'

--kes elavad Gothamis ja New Yorkis ja on vanemad, kui 29
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 30

--rida 124
-- 3 tund
--10.03.26

--kuvab tähestikulises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name
--kuvab vastupidises järjestuses nimed
select * from Person order by Name desc

--võtab kolm esimest rida person tabelist
select top 3 * from Person

--kolm esimest, aga tabeli järjestus on Age ja siis Name
select * from Person
select top 3 Age, Name from Person order by cast(Age as int)

--näita esimesed 50% tabelist
select top 50 percent * from Person

--kõikide isikute koondvanus
select sum(cast(Age as int)) from Person

--näitab kõige nooremat isikut
select min(cast(Age as int)) from Person

--kõige vanem isik
select max(cast(Age as int)) from Person

--muudame Age veeru int andmetüübiks
alter table Person
alter column Age int;

--näeme konkreetsetes linnades olevate isikute koondvanust
select City, sum(Age) as TotalAge from Person group by City

--kuvab esimeses reas välja toodud järjestuses ja kuvab Age TotalAge-ks
--järjestab City-s olevate nimede järgi ja siis GenderId järgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

--näitab, et mitu rida on selles tabelis
select * from Person
select count(*) from Person

--näitab tulemust, et mitu inimest on GenderId väärtusega 2 konkreetses linnas
--arvutab vanuse kokku konkreetses linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

--näitab ära inimeste koondvanuse, mis on üle 41 a ja 
--kui palju neid igas linnas elab
--eristab soo järgi
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
group by GenderId, City having sum(Age) > 41

--loome tabelid Employees ja Department
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

--
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutame kõikide palgad kokku
select sum(cast(Salary as int)) from Employees
--min palga saaja
select min(cast(Salary as int)) from Employees

--- rida 251
--- 4 tund
--- 17.03.26
--teeme left join päringu
select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location --ühe kuu palgafond linnade lõikes

--teem veeru nimega City Employees tabelisse
--nvarchar 30
alter table Employees
add City nvarchar(30)

select * from Employees

--peale selecti tulevad veergude nimed
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
--tabelist nimega Employees ja mis on grupitatud City ja Gender järgi
from Employees group by City, Gender

--oleks vaja, et linnad oleksid tähestikulises järjekorras
select City, Gender, sum(cast(Salary as int)) as TotalSalary 
from Employees group by City, Gender
order by City
--order by järjestab linnad tähesitkuliselt, 
--aga kui on nullid, siis need tulevad kõige ette

-- loeb ära, mitu rida on tabelis Employees
-- * asemele võib panna ka veeru nime,
-- aga siis loeb ainult selle veeru väärtused, mis ei ole nullid
select COUNT(*) from Employees

--mitu töötajat on soo ja linna kaupa
select City, Gender, sum(cast(Salary as int)) as TotalSalary,
count(Id) as [Total Employee(s)]
from Employees 
group by City, Gender

--kuvab ainult kõik mehed linnade kaupa
select City, Gender, sum(cast(Salary as int)) as TotalSalary,
count(Id) as [Total Employee(s)]
from Employees 
where Gender = 'Female'
group by City, Gender

--sama tulemuse, aga kasutage having klauslit
select City, Gender, sum(cast(Salary as int)) as TotalSalary,
count(Id) as [Total Employee(s)]
from Employees 
group by City, Gender
having Gender = 'Male'

--näitab meile ainult need töötajad, kellel on palga summa üle 4000
select * from Employees
where sum(cast(Salary as int)) > 4000

select City, sum(cast(Salary as int)) as TotalSalary, Name,
count(Id) as [Total Employee(s)]
from Employees 
group by Salary, City, Name
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1) primary key,
Value nvarchar(30)
)

insert into Test1 values('X')
select * from Test1

--- kustutame veeru nimega City Employees tabelist
alter table Employees
drop column City

-- inner join
--kuvab neid, kellel on DepartmentName all olemas väärtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- kuvab kõik read Employees tabelist, 
-- aga DepartmentName näitab ainult siis, kui on olemas
-- kui DepartmentId on null, siis DepartmentName näitab nulli
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

-- right join
-- kuvab kõik read Department tabelist
-- aga Name näitab ainult siis, kui on olemas väärtus DepartmentId-s, mis on sama 
-- Department tabeli Id-ga
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id

-- full outer join ja full join on sama asi
-- kuvab kõik read mõlemast tabelist, 
-- aga kui ei ole vastet, siis näitab nulli
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id

-- cross join
-- kuvab kõik read mõlemast tabelist, aga ei võta aluseks mingit veergu,
-- vaid lihtsalt kombineerib kõik read omavahel
-- kasutatakse harva, aga kui on vaja kombineerida kõiki 
-- võimalikke kombinatsioone kahe tabeli vahel, siis võib kasutada cross joini
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

-- päringu sisu
select ColumnList
from LeftTable
joinType RightTable
on JoinCondition

select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Department.Id = Employees.DepartmentId

-- kuidas kuvada ainult need isikud, kellel on DepartmentName NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

-- kuidas saame department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--full join
--kus on vaja kuvada kõik read mõlemast tabelist, 
--millel ei ole vastet
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

--tabeli nimetuse muutmine koodiga
sp_rename 'Employees1', 'Employees'

-- kasutame Employees tabeli asemel lühendit E ja M
-- aga enne seda lisame uue veeru nimega ManagerId ja see on int
alter table Employees
add ManagerId int

-- antud juhul E on Employees tabeli lühend ja M 
-- on samuti Employees tabeli lühend, aga me kasutame 
-- seda, et näidata, et see on manageri tabel
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--inner join ja kasutame lühendeid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--cross join ja kasutame lühendeid
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M


select FirstName, LastName, Phone, AddressID, AddressType
from SalesLT.CustomerAddress CA
left join SalesLT.Customer C
on CA.CustomerID = C.CustomerID

-- teha päring, kus kasutate ProductModelit ja Product tabelit, 
-- et näha, millised tooted on millise mudeliga seotud

select PM.Name as ProductModel, P.Name as Product
from SalesLT.Product P
left join SalesLT.ProductModel PM
on PM.ProductModelId = P.ProductModelId

--rida 412
--4 tund
--31.03.26
select isnull('Sinu Nimi', 'No Manager') as Manager

select COALESCE(null, 'No Manager') as Manager

--neil kellel ei ole ülemust, siis paneb neile No Manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- kui Expression on õige, siis paneb väärtuse, mida soovid või 
--vastasel juhul paneb No Manager teksti
case when Expression Then '' else '' end

--teeme päringu, kus kasutame case-i
-- tuleb kasutada ka left join
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

--muudame veeru nime koodiga
sp_rename 'Employees.Middlename', 'MiddleName'
select* from Employees

update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

--igast reast võtab esimesena mitte nulli väärtuse ja paneb Name veergu
--kasutada coalesce
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutate union all
--kahe tabeli andmete vaatamiseks
--näitab kõik read mõlemast tabelist
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--korduvate väärtuste eemaldamiseks kasutame unionit
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--kuidas tulemust sorteerida nime järgi
--kasutada union all-i
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

--stored procedure
--salvestatud protseduurid on SQL-i koodid, mis on salvest
--salvestatud andmebaasis ja mida saab käivitada, 
--et teha mingi kindel töö ära
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

--nüüd saame kasutada spGetEmployees-i
spGetEmployees
exec spGetEmployees
execute spGetEmployees

---
create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(10),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees 
	where Gender = @Gender and DepartmentId = @DepartmentId
end

--miks saab veateate
spGetEmployeesByGenderAndDepartment
--õige variant
spGetEmployeesByGenderAndDepartment 'female', 1
--kuidas minna sp järjekorrast mööda parameetrite sisestamisel
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

sp_helptext spGetEmployeesByGenderAndDepartment

--muudame sp-d ja võti peale, et keegi teine 
--peale teie ei saaks seda muuta
alter procedure spGetEmployeesByGenderAndDepartment
@Gender nvarchar(10),
@DepartmentId int
with encryption --paneb võtme peale
as begin
	select FirstName, Gender, DepartmentId from Employees 
	where Gender = @Gender and DepartmentId = @DepartmentId
end

--
create proc spGetEmployeeCountByGender
@Gender nvarchar(10),
--output on parameeter, mis võimaldab meil salvestada protseduuri 
--sees tehtud arvutuse tulemuse ja kasutada seda väljaspool protseduuri
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees 
	where Gender = @Gender
end


--annab tulemuse, kus loendab ära nõuetele vastavad read
--prindib tulemuse, mis on parameetris @EmployeeCount
declare @TotalCount int
exec spGetEmployeeCountByGender 'Female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@TotalCount is not null'
print @TotalCount

--näitab ära, et mitu rida vastab nõuetele
declare @TotalCount int
execute spGetEmployeeCountByGender 
--mis on out?
--out on parameeter, mis võimaldab meil salvestada protseduuri
@EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

--sp sisu vaatamine
sp_help spGetEmployeeCountByGender
--tabeli info
sp_help Employees
--kui soovid sp teksti näha
sp_helptext spGetEmployeeCountByGender

--vaatame, millest sõltub see sp
sp_depends spGetEmployeeCountByGender
--vaatame tabelit sp_depends-ga
sp_depends Employees

---
create proc spGetNameById
@Id int,
@Name nvarchar(30) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end

--tahame näha kogu tabelite ridade arvu
--count kasutada
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end

--saame teada, et mitu rida on tabelis
declare @TotalEmployees int
execute spTotalCount2 @TotalEmployees output
select @TotalEmployees

--mis id all on keegi nime järgi
create proc spGetIdByName1
@Id int,
@FirstName nvarchar(30) output
as begin
	select @FirstName = FirstName from Employees where @Id = Id
end

--annab tulemuse, kus id 1 real on keegi koos nimega
declare @FirstName nvarchar(30)
execute spGetIdByName1 9, @FirstName output
print 'Name of the employee = ' + @FirstName

---
declare @FirstName nvarchar(30)
execute spGetNameById 9, @FirstName output
print 'Name of the employee = ' + @FirstName
--ei anna tulemust, sest sp-s on loogika viga
--sp-s on viga, sest @Id on parameeter, 
--mis on mõeldud selleks, et me saaksime sisestada id-d 
--ja saada nime, aga sp-s on loogika viga, sest see 
--üritab määrata @Id väärtuseks Id veeru väärtust, mis on vale

-- rida 662
--tund 5
--

declare @FirstName nvarchar(30)
execute spGetNameById 1, @FirstName out
print 'Name of the employee = ' + @FirstName

sp_help spGetNameById

create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

declare @EmployeeName nvarchar(30)
execute @EmployeeName = spGetNameById2 'Tom'
print 'Name of the employee = ' + @EmployeeName

---sisseehitatud string funktsioonid
-- see konverteerib ASCI tähe väärtuse numbriks
select ASCII('A')
--kuvab A-tähe
select CHAR(65)

--prindime kogu tähestiku välja A-st Z-ni
--kasutame while tsüklit
declare @start int
set @start = 65

while @start <= 90
begin
	print char(@start)
	set @start = @start +1
end

--sama asi, aga tähed prinditakse üksteisejärel
DECLARE @start INT
DECLARE @text VARCHAR(100)

SET @start = 65
SET @text = ''

WHILE @start <= 90
BEGIN
    SET @text = @text + CHAR(@start) + ' '
    SET @start = @start + 1
END

PRINT @text

--eemdaldame tühjad kohad sulgudes vasakul
select LTRIM('   Hello')

--tühikute eemaldamine sõnas
select LTRIM(FirstName) as FirstName, MiddleName, LastName 
from Employees

select TRIM('   Mari Liis   ')

--keerab kooloni sees olevad andmed vastupidiseks
--vastavalt upper ja loweriga saab muuta märkide suurust
--reverse funktsioon keerab stringi tagurpidi
select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName,
LOWER(LastName), RTRIM(LTRIM(FirstName)) + '' +
MiddleName + ' ' + LastName as FullName
from Employees

--left, right, substring
--left võtab stringi vasakult poolt 4 esimest tähte
select LEFT('ABCDEF', 4)
--right võtab stringi paremalt poolt 4 esimest tähte
select RIGHT('ABCDEF', 4)

--kuvab @tähemärgi asetust
select CHARINDEX('@', 'sara@aaa.com')

--alates viiendast sümbolist kuvab 2 sümbolit
select SUBSTRING('leo@bbb.com', 5, 2)

--@märgist kuvab kolm tähemärki. Viimane nr saab määrata pikkust
select SUBSTRING('leo@bbb.com', charindex('@', 'leo@bbb.com') + 1, 3)

---peale @ m'rki reguleerin tähemärkide pikkuse näitamist
select SUBSTRING('leo@bbb.com', CHARINDEX('@', 'leo@bbb.com') + 2, 
LEN('leo@bbb.com') - CHARINDEX('@', 'leo@bbb.com'))

--saame teada domeeni nimed emailidest
--kasutame Person tabelit ja substringi. len ja charindexi
select SUBSTRING(Email, CHARINDEX('@', Email) + 1,
LEN(Email) - charindex('@', Email)) as DomainName 
from Person

alter table Employees
add Email nvarchar(20)

update Employees set Email = 'tom@aaa.com' where Id = 1
update Employees set Email = 'pam@bbb.com' where Id = 2
update Employees set Email = 'john@aaa.com' where Id = 3
update Employees set Email = 'sam@bbb.com' where Id = 4
update Employees set Email = 'todd@bbb.com' where Id = 5
update Employees set Email = 'ben@ccc.com' where Id = 6
update Employees set Email = 'sara@ccc.com' where Id = 7
update Employees set Email = 'valarie@aaa.com' where Id = 8
update Employees set Email = 'james@bbb.com' where Id = 9
update Employees set Email = 'russell@bbb.com' where Id = 10

--lisame * märgi alates teatud kohast
select FirstName, LastName,
	SUBSTRING(Email, 1, 2) + REPLICATE('*', 5) +
	--peale teist tähemärki paneb 5 tärni
	SUBSTRING(Email, charindex('@', Email), LEN(Email))
	- CHARINDEX('@', Email) + 1) as MaskedEmail
	--kuni @ märgini paneb tärnid ja siis jätkab emaili näitamist
	--on dünaamiline, set kui emaili pikkus on erinev,
	--siis paneb vastavalt tärne

--kolm korda näitab stringis olevar väärtust
select REPLICATE('Hello', 3)

--kuidas sisestada tühikut kahe nime vahele
select SPACE(5)

--võtame tabeli Employees ja kuvame eesnime ja perenime vahele tühikut
select FirstName + SPACE(25) + LastName as FullName from Employees

--PATINDEX
--sama, mis charindex, aga parindex võimaldab kasutada wildcardi
--kasutame tabelit Employees ja leiame kõik read, kus emaili lõpus on aaa.com
select Email, PATINDEX('%aaa.com', Email) as Position
from Employees
where PATINDEX('%aaa.com', Email) > 0
--leian kõik read, kus emaili lõpus on aaa.com või bbb.com

--asendame emaili lõpus olevad domeeni nime .com asemel .netiga replacega
select FirstName, LastName, Email, 
REPLACE(Email, '.com', '.net') as NewEmail
from Employees

--soovin asendada peale esimest märki olevad tähed viie tärniga
select FirstName, LastName, Email,
stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

--ajaga seotud andmetüübid
create table DateTest
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTest

--sinu masina kellaaeg
select GETDATE() as CurrentDateTime

insert into DateTest
values (GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE())
select *from DateTest

update DateTest set c_datetimeoffset = '2026-04-07 19:51:31.9033333 +05:00'
where c_datetimeoffset = '2026-04-07 17:13:31.9033333 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --aja päring
select SYSDATETIME(), 'SYSDATETIME' --veel täpsem ajapäring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --täpne aja ja ajavööndi päring
select GETUTCDATE(), 'GETUTCDATE' --UTC aja päring

select ISDATE('asdasd') --tagastab 0, sest see pole kehtiv aeg
select ISDATE(GETDATE()) -- tagastab 1, sest on kuupäev
select ISDATE('2026-04-07 19:51:31.903333') --tagastab 0, sesst max 3 komakohta võib olla
select ISDATE('2026-04-07 19:51:31.903') --tagastab 1
select DAY(GETDATE()) --annab tänase kuupäeva
select DAY('03/30/2026') -- annab stringis oleva kp. järjestus peab olema õige
select MONTH(GETDATE()) -- annab jooksva kuu
select MONTH('03/30/2026') --annab stringis jooksva kuu
select YEAR(GETDATE()) --annab jooksva aasta nr
select YEAR('03/30/2026') --annab stringis oleva aasta nr

--
