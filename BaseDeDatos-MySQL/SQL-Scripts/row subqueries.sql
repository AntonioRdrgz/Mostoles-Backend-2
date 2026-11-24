create temporary table t1 (c1 int not null, c2 int not null, c3 int not null);
create temporary table t2 (c1 int not null, c2 int not null, c3 int not null);

insert into t1 values (1,2,3), (2, 2, 2), (3, 3, 3);
insert into t2 values (5, 5, 5), (2, 2, 2), (4, 4, 4), (3, 3, 3);

table t1;
table t2;

select c1, c2, c3
from t2
where row(c1,c2,c3) > (select c1, c2, c3 from t1 limit 1,1);



