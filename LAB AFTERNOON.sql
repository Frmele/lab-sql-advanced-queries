# List each pair of actors that have worked together.

Use sakila;

with ideal_cols as (
select fa1.film_id,fa1.actor_id,a1.first_name,a1.last_name
from sakila.film_actor as fa1
join sakila.actor as a1
on fa1.actor_id=a1.actor_id
group by fa1.film_id, fa1.actor_id
order by fa1.actor_id
)

select cte.film_id,cte.actor_id as actor_match,concat( cte.first_name, ' ', cte.last_name) as actor_name1, fa2.actor_id as actor_pair,
concat(a2.first_name, ' ', a2.last_name) as actor_name2
from ideal_cols as cte
join sakila.film_actor as fa2
on cte.film_id=fa2.film_id
and cte.actor_id<>fa2.actor_id
and cte.actor_id < fa2.actor_id
join sakila.actor as a2
on fa2.actor_id=a2.actor_id;

#OR

use sakila;
select 
    fa1.film_id, 
    fa1.actor_id as actor_id1, 
    concat(a1.first_name, ' ', a1.last_name) as actor_name1, 
    fa2.actor_id as actor_id2, 
    concat(a2.first_name, ' ', a2.last_name) as actor_name2
from film_actor as fa1
join actor as a1
on fa1.actor_id = a1.actor_id
join film_actor as fa2
on fa1.actor_id <> fa2.actor_id
and fa1.actor_id < fa2.actor_id
and fa1.film_id = fa2.film_id
join actor as a2
on a2.actor_id = fa2.actor_id
group by actor_id2, actor_id1
order by actor_id1 asc;

# For each film, list actor that has acted in more films.

# film = title , film_id
# film_actor = film_id , actor_id
# actor = actor_id, first_name , last_name

#select title, film_id from film;
#select actor_id, count(film_id) as total_movies from film_actor group by actor_id;
#select actor_id, first_name, last_name from actor;

SELECT a.film_id,a.title,b.actor_id, count(b.film_id) as total_movies,c.first_name,c.last_name
from film as a
join film_actor as b
on a.film_id=b.film_id
join actor as c
on b.actor_id=c.actor_id
group by c.actor_id
having total_movies>1
order by actor_id asc;
