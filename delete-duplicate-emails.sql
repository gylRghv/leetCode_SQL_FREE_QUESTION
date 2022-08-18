# Please write a DELETE statement and DO NOT write a SELECT statement.
# Write your MySQL query statement below


with min_ids as (
    select min(id) as min_id from person
    group by email
)
delete from Person p2 where id not in (
    select min_id
    from min_ids 
)


--M2- delete join
DELETE p1 FROM Person p1,
    Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id;
    
    
--Below code wouldnt work bcoz you can modify the table from which you are currenlty selecting.#
-- DELETE FROM Person
-- WHERE id NOT IN (SELECT MIN(id) FROM Person
--                 GROUP BY email);
                
--Below will work - added extra layer

--M3
DELETE FROM Person
WHERE id NOT IN (SELECT * 
                 FROM ( SELECT MIN(id) 
                       FROM Person
                       GROUP BY email
                      )
                );
