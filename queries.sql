use `sqldm`;

-- Question 1 --
create view sessions_plan_week as 
select (select libelle from periodejournee p  where idPeriodeJournee = PeriodeJournee_idPeriodeJournee) as creaneaux_semaine, 
group_concat("Salle 0", numeroSalle ORDER BY numeroSalle ) as salles 
from sallediffuseperiode s 
inner join salle ON salle.idSalle = s.Salle_idSalle
where PlanSeance_idPlanSeance = (select idPlanseance from planseance p where libelle = 'semaine')
group by creaneaux_semaine order by MIN(s.PeriodeJournee_idPeriodeJournee);

select * from sessions_plan_week;

create view sessions_plan_weekend as 
select (select libelle from periodejournee p  where idPeriodeJournee = PeriodeJournee_idPeriodeJournee) as creaneaux_semaine, 
group_concat("Salle 0", numeroSalle ORDER BY numeroSalle ) as salles 
from sallediffuseperiode s 
inner join salle ON salle.idSalle = s.Salle_idSalle
where PlanSeance_idPlanSeance = (select idPlanseance from planseance p where libelle = 'weekend')
group by creaneaux_semaine order by MIN(s.PeriodeJournee_idPeriodeJournee);

select * from sessions_plan_weekend;


-- Question 2 --
-- Creation des acteurs et des realisateurs --
INSERT INTO person (Nom, Prenom, DateNaissance)
VALUES ("Mortensen", "Viggo", Date("1958-10-20"));

insert into acteur (Person_idPerson) values (last_insert_id());

INSERT INTO person (Nom, Prenom, DateNaissance)
VALUES ("McKellen", "Ian",  Date("1939-05-25"));

insert into acteur (Person_idPerson) values (last_insert_id());

INSERT INTO person (Nom, Prenom, DateNaissance)
VALUES ("Jackson", "Peter", Date("1961-10-31"));

insert into realisateur  (Person_idPerson) values (last_insert_id());

INSERT INTO person (Nom, Prenom, DateNaissance)
VALUES ("Wood", "Elijah", Date("1981-01-28"));

insert into acteur (Person_idPerson) values (last_insert_id());

INSERT INTO person (Nom, Prenom, DateNaissance)
VALUES ("Tiret", "Justine", Date("1978-07-17"));

insert into realisateur  (Person_idPerson) values (last_insert_id());

INSERT INTO person (Nom, Prenom, DateNaissance)
VALUES ("Machado-Graner", "Milo", Date("2008-08-31"));

insert into acteur (Person_idPerson) values (last_insert_id());

INSERT INTO person (Nom, Prenom, DateNaissance)
VALUES ("Arlaud", "Swann", Date("1981-11-30"));

insert into acteur (Person_idPerson) values (last_insert_id());


-- Question 3 --
-- Creation des films --
INSERT INTO film (Titre, Duree, DateDeSortie, Synopsis, AvantPremiere, Realisateur_Person_idPerson, LimiteAge_idLimiteAge, StartExploitation, Commentaire)
VALUES ("Le seigneur des anneaux : Le Retour du Roi", 263, Date("2003-12-1"), 
"Les armees de Sauron ont attaque Minas Tirith  la capitale de Gondor. Jamais ce royaume autrefois puissant n'a eu autant besoin de son roi. Mais Aragorn trouvera-t-il en lui la volonte d'accomplir sa destinee ?",
false, 3, 1, Date("2003-12-1"),""),
("Le seigneur des anneaux : La communaute de l'anneau", 228, Date("2001-12-19"), 
"Dans ce chapitre de la trilogie, le jeune et timide Hobbit, Frodon Sacquet, herite d'un anneau. Bien loin d'être une simple babiole, il s'agit de l'Anneau Unique, un instrument de pouvoir absolu qui permettrait à Sauron, le Seigneur des tenèbres, de regner sur la Terre du Milieu et de reduire en esclavage ses peuples. Etc.",
false, 3, 1, Date("2001-12-19"),""),
("Le seigneur des anneaux : Les Deux Tours", 235, Date("2002-12-19"), 
"Après la mort de Boromir et la disparition de Gandalf,  la Communaute s'est scindee en trois. Perdus dans les collines d'Emyn Muil  Frodon et Sam decouvrent qu'ils sont suivis par Gollum  une creature versatile corrompue par l'Anneau etc.",
false, 3, 1, Date("2002-12-19"),""),
("The Hobbit : Un voyage inattendu", 182, Date("2012-11-13"), 
"Alors que ses amis hobbits de la Comte s'apprêtent à fêter son cent onzième anniversaire, Bilbon Sacquet entame le recit de ses aventures dans un livre destine à son neveu Frodon Sacquet.",
false, 3, 1, Date("2012-11-13"),""),
("Anatomie d'une chute", 150, Date("2023-08-23"), 
"Sandra, Samuel et leur fils malvoyant de 11 ans, Daniel, vivent depuis un an loin de tout, à la montagne. Un jour, Samuel est etc.",
false, 5, 1, Date("2023-08-23"), "Coup de coeur !"); 


-- Question 4 --
select Titre as "Films realises par Peter Jackson" from film f 
where Realisateur_Person_idPerson = (
select idPerson from person p where nom = "Jackson" and prenom = "Peter") 
order by DateDeSortie;

-- Question 5 --
select Titre as "Filmsdans lequels a joue Viggo Mortensen" from film f 
inner join jouedans j on f.idFilm = j.Film_idFilm 
inner join acteur a on j.Acteur_Person_idPerson = a.Person_idPerson 
inner join person p on p.idPerson = a.Person_idPerson 
where p.Nom = "Mortensen" and p.Prenom = "Viggo" 
order by DateDeSortie;

-- Question 6 --
SELECT f.Titre AS "Films dans lesquels a joue Viggo Mortensen et Ian McKellen" FROM film f 
inner JOIN jouedans j ON f.idFilm = j.Film_idFilm 
inner JOIN acteur a ON j.Acteur_Person_idPerson = a.Person_idPerson 
inner JOIN person p ON p.idPerson = a.Person_idPerson 
WHERE (p.Nom = "McKellen" AND p.Prenom = "Ian") OR (p.Nom = "Mortensen" AND p.Prenom = "Viggo")
GROUP BY f.idFilm, f.Titre
HAVING COUNT(DISTINCT p.idPerson) = 2
ORDER BY f.DateDeSortie;

-- Question 7 --

DELIMITER $$
CREATE FUNCTION format_movie_duration(duree INT)
RETURNS CHAR(5)
BEGIN
    DECLARE dureeHeureMinute CHAR(5);
    SET dureeHeureMinute = CONCAT(FLOOR(duree / 60), "h", LPAD(duree % 60, 2, '0'));
    RETURN dureeHeureMinute;
END$$
DELIMITER ;

select format_movie_duration(150);

-- Question 8 --
select Titre, format_movie_duration(Duree), Synopsis,  Concat(p.prenom, " ", p.nom) as "Real.", group_concat(distinct concat(p2.prenom, " ", p2.nom) order by p2.idPerson) as acteur,  group_concat(distinct g.libelle) as "Genre", Commentaire  
from film f 
inner join person p on f.Realisateur_Person_idPerson = p.idPerson 
inner join estun e on e.Film_idFilm = idFilm 
inner join genre g on e.Genre_idGenre = g.idGenre
inner join jouedans j on j.Film_idFilm = f.idFilm 
inner join acteur a on a.Person_idPerson = j.Acteur_Person_idPerson
inner join person p2 on p2.idPerson = a.Person_idPerson 
where Titre = "Anatomie d'une chute"
GROUP BY Titre, format_movie_duration(Duree), Synopsis, CONCAT(p.prenom, ' ', p.nom), Commentaire;

create view movie_summary as 
select Titre, format_movie_duration(Duree), Synopsis,  Concat(p.prenom, " ", p.nom) as "Real.", group_concat(distinct concat(p2.prenom, " ", p2.nom) order by p2.idPerson) as acteur,  group_concat(distinct g.libelle) as "Genre", Commentaire  
from film f 
inner join person p on f.Realisateur_Person_idPerson = p.idPerson 
inner join estun e on e.Film_idFilm = idFilm 
inner join genre g on e.Genre_idGenre = g.idGenre
inner join jouedans j on j.Film_idFilm = f.idFilm 
inner join acteur a on a.Person_idPerson = j.Acteur_Person_idPerson
inner join person p2 on p2.idPerson = a.Person_idPerson 
GROUP BY Titre, format_movie_duration(Duree), Synopsis, CONCAT(p.prenom, ' ', p.nom), Commentaire;
   
select * from movie_summary; 

-- Question 9 --

DELIMITER $$
CREATE PROCEDURE print_movie_summary(in titreFilm VARCHAR(100))
begin
	select Titre, format_movie_duration(Duree), Synopsis,  Concat(p.prenom, " ", p.nom) as "Real.",
	group_concat(distinct concat(p2.prenom, " ", p2.nom) order by p2.idPerson) as acteur,
	group_concat(distinct g.libelle) as "Genre", Commentaire  
from film f 
inner join person p on f.Realisateur_Person_idPerson = p.idPerson 
inner join estun e on e.Film_idFilm = idFilm 
inner join genre g on e.Genre_idGenre = g.idGenre
inner join jouedans j on j.Film_idFilm = f.idFilm 
inner join acteur a on a.Person_idPerson = j.Acteur_Person_idPerson
inner join person p2 on p2.idPerson = a.Person_idPerson 
where Titre = titreFilm
GROUP BY 
    Titre, format_movie_duration(Duree), Synopsis, CONCAT(p.prenom, ' ', p.nom), Commentaire;   
end$$
DELIMITER ;

call print_movie_summary("Anatomie d'une chute");

-- Question 10 --
-- Liaison entre les films et les salles --
insert into filmestdiffusedanssalle (langue, Film_idFilm, SalleDiffusePeriode_idSalleDiffusePeriode)
values ("VF", 2, 1),
("VF", 2, 10);

insert into filmestdiffusedanssalle (langue, Film_idFilm, SalleDiffusePeriode_idSalleDiffusePeriode)
values ("VF", 5, 8),
("VF", 5, 19);

-- Question 11 --
select f2.titre, f.langue, p.libelle, p2.heure from filmestdiffusedanssalle f 
inner join film f2 on f2.idFilm = f.Film_idFilm
inner join sallediffuseperiode s on f.SalleDiffusePeriode_idSalleDiffusePeriode = s.idSalleDiffusePeriode
inner join planseance p on p.idPlanSeance = s.PlanSeance_idPlanSeance
inner join periodejournee p2 on p2.idPeriodeJournee = s.PeriodeJournee_idPeriodeJournee
group by f2.titre, f.langue, p.libelle, p2.heure order by f2.titre;

-- Question 12 --
-- Creation des tarifs --

insert into tarif(prix, libelle)
values(9.80, "Tarif plein"),
(5.00, "Tarif etudiant"),
(5.00, "Tarif Demandeur d’emploi"),
(3.80, "Tarif -14 ans");

-- Creation des tickets --
insert into ticket (Seance, Tarif_idTarif, FilmEstDiffuseDansSalle_FilmEstDiffuseDansSalleId)
values ("2024:02:27", 1, 2),
("2024:02:27", 3, 2);


select t.numeroTicket as numero_ticket, f2.titre as film, t.Seance as date, f.langue as version, t2.prix as "prix (euros)", p.heure as heure, s2.numeroSalle as salle from ticket t
inner join tarif t2 on t.Tarif_idTarif = t2.idTarif 
inner join filmestdiffusedanssalle f on t.FilmEstDiffuseDansSalle_FilmEstDiffuseDansSalleId = f.FilmEstDiffuseDansSalleId
inner join film f2 on f2.idFilm = f.Film_idFilm
inner join sallediffuseperiode s on f.SalleDiffusePeriode_idSalleDiffusePeriode = s.idSalleDiffusePeriode 
inner join periodejournee p on p.idPeriodeJournee = s.PeriodeJournee_idPeriodeJournee 
inner join salle s2 on s2.idSalle = s.Salle_idSalle
where f2.titre = "Le Seigneur des Anneaux : La communaute de l'anneau" and t.Seance = "2024-02-27" and p.heure = "10:00:00";

-- Question 13 --
select (s2.nombrePlace - count(t.numeroTicket)) as "Nombre de places restante", f2.titre as film, t.Seance as date, f.langue as version, t2.prix as "prix (euros)", p.heure as heure, s2.numeroSalle as salle from ticket t
inner join tarif t2 on t.Tarif_idTarif = t2.idTarif 
inner join filmestdiffusedanssalle f on t.FilmEstDiffuseDansSalle_FilmEstDiffuseDansSalleId = f.FilmEstDiffuseDansSalleId
inner join film f2 on f2.idFilm = f.Film_idFilm
inner join sallediffuseperiode s on f.SalleDiffusePeriode_idSalleDiffusePeriode = s.idSalleDiffusePeriode 
inner join periodejournee p on p.idPeriodeJournee = s.PeriodeJournee_idPeriodeJournee 
inner join salle s2 on s2.idSalle = s.Salle_idSalle
where f2.titre = "Le Seigneur des Anneaux : La communaute de l'anneau" and t.Seance = "2024-02-27" and p.heure = "10:00:00";