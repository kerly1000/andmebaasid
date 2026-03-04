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



