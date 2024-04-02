--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)
select *
from potion;

--2. Liste des noms des trophées rapportant 3 points. (2 lignes)
select nom_categ 
from categorie c 
where nb_points = 3;

--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)
select nom_village
from village v 
where nb_huttes > 35;

--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)
select num_trophee
from trophee 
where date_prise 
between '2052-05-05' and '2052-06-06';

--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)
select nom
from habitant h 
where nom like 'A%' and nom like '%r%';

--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)
select num_hab
from absorber a 
where num_potion = 1 or num_potion = 3 or num_potion = 4
group by num_hab;

--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)
select  
    t.num_trophee, 
    t.date_prise, 
    c.nom_categ,
    h.nom 
from trophee t
join categorie c on t.code_cat = c.code_cat
join habitant h on t.num_preneur = h.num_hab;

--8. Nom des habitants qui habitent à Aquilona. (7 lignes)
select h.nom
from habitant h
join village v
on h.num_village =v.num_village 
where v.nom_village = 'Aquilona';

--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)
select h.nom
from habitant h
join trophee t on h.num_hab = t.num_preneur
join categorie c on t.code_cat = c.code_cat
where c.nom_categ = 'Bouclier de Légat';

--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)
select 
    p.lib_potion, 
    p.formule, 
    p.constituant_principal
from potion p
join fabriquer f on p.num_potion = f.num_potion
join habitant h on f.num_hab = h.num_hab
where h.nom = 'Panoramix';

--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)
select distinct lib_potion
from potion p 
join absorber a on p.num_potion = a.num_potion
join habitant h on a.num_hab = h.num_hab
where h.nom = 'Homéopatix';

--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)
select distinct h.nom
from habitant h
join absorber a on h.num_hab = a.num_hab
join potion p on a.num_potion = p.num_potion
join fabriquer f on p.num_potion = f.num_potion
where f.num_hab = 3;

--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)
select distinct h2.nom
from habitant h1
join fabriquer f on h1.num_hab = f.num_hab
join potion p on f.num_potion = p.num_potion
join absorber a  on p.num_potion = a.num_potion
join habitant h2 on a.num_hab = h2.num_hab 
where h1.nom = 'Amnésix';

--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)
select nom
from habitant h 
where num_qualite is null;

--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)
select h.nom
from habitant h
join absorber a on h.num_hab = a.num_hab
join potion p on a.num_potion = p.num_potion
where p.lib_potion = 'Potion magique n°1'
and extract(month from a.date_a) = 02
and extract(year from a.date_a) = 2052;

--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)
select *
from habitant
order by nom

--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)
select r.nom_resserre, v.nom_village
from resserre r
join village v on r.num_village = v.num_village
order by r.superficie desc;

--18. Nombre d'habitants du village numéro 5. (4)
select count(*)
from habitant
where num_village = 5;

--19. Nombre de points gagnés par Goudurix. (5)
select sum(c.nb_points) 
from habitant h
join trophee t on h.num_hab = t.num_preneur
join categorie c on t.code_cat = c.code_cat
where h.nom = 'Goudurix';

--20. Date de première prise de trophée. (03/04/52)
select min(date_prise)
from trophee;

--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)
select sum(a.quantite) 
from absorber a
join potion p on a.num_potion = p.num_potion
where p.lib_potion = 'Potion magique n°2';

--22. Superficie la plus grande. (895)
select max(superficie)
from resserre;

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)
select v.nom_village, count(h.num_hab) as nombre_d_habitants
from village v
join habitant h on v.num_village = h.num_village
group by v.nom_village
order by nombre_d_habitants;


--24. Nombre de trophées par habitant (6 lignes)
select distinct  h.nom, count(t.num_trophee) AS nombre_de_trophees
from habitant h
join trophee t on h.num_hab = t.num_preneur
group by h.nom
order by nombre_de_trophees;

--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)
select pr.nom_province, AVG(h.age)as moyenne_age
from province pr
join village v on pr.num_province = v.num_province
join habitant h on v.num_village = h.num_village
group by pr.nom_province
order by moyenne_age DESC;

--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9 lignes)
select h.nom, count(distinct a.num_potion) as nombre_de_potions
from habitant h
join absorber a on h.num_hab = a.num_hab
join potion p on a.num_potion = p.num_potion
group by h.nom
order by nombre_de_potions desc;

--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)
select nom h from habitant h
join absorber a on h.num_hab  = a.num_hab
join potion p on a.num_potion  = p.num_potion
where a.quantite > 2 and  p.lib_potion  = 'Potion Zen';

--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)
select distinct v.nom_village
from village v
join resserre r on v.num_village = r.num_village;

--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)
select nom_village
from village
order by nb_huttes desc
limit 1;

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).
select h.nom from habitant h
join trophee t on t.num_preneur  = h.num_hab
group by h.nom
having count(num_trophee) > (select count(num_trophee) from trophee t 
join habitant h on t.num_preneur = h.num_hab
where h.nom = 'Obélix');