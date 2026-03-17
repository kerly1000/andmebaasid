create database TARge25

--db valimine
use master

-- kustutamine


--tabeli tegemine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--lisame nr piirangu vanuse sisestamisel 
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kui sa tead veergude järjekorda peast,ei pea neid sisestama
insert into Person 
values (10, 'Green Arrow', 'ga@ga.ee', 2, 154)

--constrainti kusutamine
alter table Person
drop constraint CK_Person_Age

alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 160)

--kustutame rea 
delete from Person where Id = 10

--kuidas uendada andmemid koodiga
--Id 3 uus vanus on 50
update Person
set Age = 50
where Id = 3

--lisame Person tabelisse veeru City ja nvarchar 50
alter table Person
add City nvarchar(50)

--päring kõikidele, kes elavad gothami linnas
select * from Person where City = 'Gotham'
--päring: kõik kes ei ela gothamis
select * from Person where City != 'Gotham'
select * from Person where City <> 'Gotham'
select * from Person where not City = 'Gotham'

-- päring teatud vanusega inimestele 
--35, 42, 23
select * from Person where Age = 35 or Age = 42 or Age = 23
select * from Person where Age in (35, 42, 23)

--näitab teatud vanusevahemikku 22 kuni 39
select * from Person where Age between 22 and 39 

--wildcardi kasutamine
--näitab kõik g-tähega algavad linnad
select * from Person where City LIKE 'G%'
--email, kus on @ märk sees
select * from Person where Email like '%@%'

--näitab, kellel on emailis ees ja peale @ märki ainult 1 täht ja .ee
select * from Person where Email like '_@_.ee'

--kõik, kellel on nimes esimene täht W, A, S/ kautsega välistab need tähed alguses
select * from Person where Name like 'W%' or Name like 'A%' or Name like 'S%'
select * from Person where Name like '[WAS]%'
select * from Person where Name like '[^WAS]%'

--kes elavad Gothamis ja New Yorkis
select * from Person where City = 'Gotham' or City = 'New York'

--kes elavad Gothamis ja New Yorkis ja on vanemad kui 29
select * from Person where (City = 'Gotham' or City = 'New York') and Age > 29

--kuvab tähestikulises järjekorras inimesi ja võtab aluseks nime
select * from Person order by Name

--kuvab tagurpidi tähestikulises järjekorras
select * from Person order by Name DESC

--võtab kolm esimest rida person tabelist
select top 3 * from Person

--kolm esimest, aga tabeli järjestus on Age ja siis Name
select * from Person
select top 3 Age, Name from Person order by CAST(Age as int)

--näita esimesed 50% tabelist
select top 50 percent * from Person

--kõikide isikute koondvanus
select SUM(cast(Age as int)) from Person

--näitab kõige nooremat isikut
select MIN(CAST(Age as int)) from person

--näitab kõige vanemat
select Max(CAST(Age as int)) from person

--muudame Age veeru int andmetüübiks/ saab ka tabeli disainimise alt 
alter table Person
alter column Age int;

--näeme konkreetsetes linnades olevate isikte koondvanus
select City, SUM(Age) as TotalAge from Person group by City
select SUM(Age) from Person where City = 'Gotham'

--kuvab esimeses reas välja toodudjärjestuses ja kuvab Age TotalAge-ks
--järjestab City-s olevate nimede järgi ja siis GenderId järgi
select City, GenderId, SUM(Age) as TotalAge from Person
group by City, GenderId order by City

--näitab mitu rida on selles tabelis
select COUNT(*) from Person

--näitab tulemust mitu inimest on GenderId väärtusega 2 konkreetses linnas
--arvutab vanuse kokku konkreetses linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
Where Genderid = '2'
group by GenderId, City

--näitab ära inimeste koondvanuse, mis on üle 41 aasta ja 
--kui palju neid igas linnas elab
--eristab soo järgi
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where Age > 41
group by GenderId, City 

select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
group by GenderId, City having SUM(Age) >41

--loome tabelid Employees ja Department

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50), 
Salary nvarchar(50),
DepartmentId int
)


create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

insert into Employees 
values (1, 'Tom', 'Male', '4000', 1)

insert into Employees 
values (2, 'Pam', 'Female', '3000', 2)

insert into Employees 
values (3, 'John', 'Male', '3500', 3)

insert into Employees 
values (4, 'Sam', 'Male', '4500', 4)

insert into Employees 
values (5, 'Todd', 'Male', '2800', 5)

insert into Employees 
values (6, 'Ben', 'Male', '7000', 6)

insert into Employees 
values (7, 'Sara', 'Female', '4800', 7)

insert into Employees 
values (8, 'Valarie', 'Female', '5500', 8)

insert into Employees 
values (9, 'James', 'Male', '6500', 9)

insert into Employees 
values (10, 'Russell', 'Male', '8800', 10)

insert into Department
values (1, 'IT', 'London', 'Rick')
insert into Department
values (2, 'Payroll', 'Delhi', 'Rick')
insert into Department
values (3, 'HR', 'New York', 'Christie')
insert into Department
values (4, 'Other Department', 'Sydney', 'Cindrella')

--
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutame kõikide palgad kokku
select SUM(cast(Salary as int)) from Employees

--min palk on
select MIN(cast(Salary as int)) from Employees

select Location, SUM(CAST(Salary as int)) as TotalSalary
from Employees
left join Department 
on Employees.DepartmentId = Department.Id
group by Location --ühe kuu palgafond linnade lõikes

--teeme veeru nimega City Employees tabelisse
--nvarchar 30
alter table Employees
add City nvarchar(30)

select * from Employees

--peale selecti tulevad veergude nimed
select City, Gender, SUM(cast(Salary as int)) as totalSalary
--tabelist nimega Employees ja on grupitatud city ja genderiga
from Employees group by City, Gender

--on vaja, et linnad on tähestikulises järjestuses
select City, Gender, SUM(cast(Salary as int)) as totalSalary
from Employees group by City, Gender
order by City
--order by järjestab linnad tähestikiliselt, aga kui on nullid, siis need tulevadkõige ette

--loeb ära, mitu rida on tabelis empoyees
--* asemele võib panna ka konkreetse veeru nime, aga siis loeb ainult need nimed, 
--mis pole nullid
select COUNT(*) from Employees

--mitu töötajat on soo ja linna kaupa
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count(Id) as [Total Employees(s)]
from Employees 
group by Gender, City

--kuvab ainult kõik mehed linnade kaupa
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count(Id) as [Total Employees(s)]
from Employees where Gender = 'Male'
group by Gender, City

--sama tulemus, aga having klauslit
select Gender, City, sum(cast(Salary as int)) as TotalSalary,
count(Id) as [Total Employees(s)]
from Employees 
group by Gender, City
having Gender = 'male'

--näitab meile ainult need töötajad, kelle palk on üle 4000
select City, Name, Gender, Salary, 
count(Id) as [Total Employees(s)]
from Employees 
where Salary > 4000
group by City, Name, Gender, Salary

--loome tabeli, milles hakatakse automaatselt nummerdama id-d
create table Test1
(
Id int identity(1,1) primary key,
Value nvarchar(30)
)

insert into Test1 values('X')
select * from Test1

--kustutame veeru nimega city employees tabelist
alter table Employees
drop Column City

--inner join
--kuvab neid, kellel on DepartmentName all olemas väärtus
--department name tuleb department tabelist, employees tabel on seotus department id-ga.
select Name, Gender, Salary, DepartmentName from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--left join
--kuvab kõik read Employees tabelist, aga DepartmentName näitab ainult siis, kui on olemas
select Name, Gender, Salary, DepartmentName from Employees
left join Department
on Employees.DepartmentId = Department.Id

--right join
--ülemine (antud juhul employees) on vasak poolne tabel ja alumine (st department) 
--parempoolne. Kuvab kõik read Department tabelist, aga Name näitab ainult siis
--kui on olemas väärtus DepartmentId-s, mis on sama Department tabeli Id-ga
select Name, Gender, Salary, DepartmentName from Employees
right join Department
on Employees.DepartmentId = Department.Id

--full outer join ja full join on sama asi
--kuvab kõik read mõlemast tabelist
--kui ei ole vastet, siis näitab nulli
select Name, Gender, Salary, DepartmentName from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

--cross join
--kuvab kõik read mõlemast tabélist, aga ei võa aluseks mingit veergu, vaid lihtsalt
--kombineerib kõik read omavahel
--kasutatakse harva, aga kui on vaja kombineerida kõiki võimalikku kombinatsioone
select Name, Gender, Salary, DepartmentName from Employees
cross join Department

--päringu sisu
select ColumnList
from LeftTablejoinType RightTable
on JoinCondition

select Name, Gender, Salary, DepartmentName from Employees
inner join Department
on Department.Id = Employees.DepartmentId

--kuidas kuvada ainult need isikud, kellel on Departmentname NULL
select Name, Gender, Salary, DepartmentName 
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where  DepartmentName is NULL

--või
select Name, Gender, Salary, DepartmentName 
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--kuidas saame department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName 
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--full join
--kus on vaja kuvada kõik read mõlemast tabelist, millel ei ole vastet
select Name, Gender, Salary, DepartmentName 
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

--tabelite nimetuse muutmine koodiga
sp_rename 'Employees', 'Employees1'
sp_rename 'Employees1', 'Employees'

--kasutame Employees tabeli asemel lühendit E ja M
--enne seda lisame uue veeru nimega ManagerID ja see on int
alter table Employees
add ManagerID int

--antud juhul E on employees tabeli lühend ja M on samuti Employees tabeli lühend, aga
--me kasutame seda, et näidata, et see on manageri tabel
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--inner join ja kasutame lühendit
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--cross join ja kasutame lühendeid
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

select FirstName, LastName, Phone, AddressID, AddressType
from SalesLT.CustomerAddress
left join SalesLT.Customer
on SalesLT.CustomerAddress.CustomerID = SalesLT.Customer.CustomerID

--teha päring, kus kasutada ProductModelit ja Product tabelit, et näha, 
--millised tooted on millise mudeliga seotud
select PM.Name as ProductModel, P.Name as Product
from SalesLT.Product P
left join SalesLT.ProductModel PM
on PM.ProductModelid = P.ProductModelId
