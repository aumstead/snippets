--page numbering
with mycte
as
(select id, [first name], [last name], ROW_NUMBER() over (order by [base rate] desc) as row_num 
from employees)
select id, [first name], [last name] 
from mycte
where row_num between 11 and 20

--a function for paging
create function getEmployeePage(@page int, @pageSize int)
returns table
as
return
with rows
as
(select id, [first name], [last name], ROW_NUMBER() over (order by [base rate] desc) as row_num 
from employees)
select id, [first name], [last name] 
from rows
where row_num between (@page - 1) * @pageSize and (@page * @pageSize)

select * from getEmployeePage(3, 25)