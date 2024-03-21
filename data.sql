
USE `sqldm` ;
DELETE FROM cinema;
DELETE FROM salle;
DELETE FROM periodejournee;
DELETE FROM planseance;
DELETE FROM sallediffuseperiode;
DELETE FROM limiteage;
DELETE FROM genre;
DELETE FROM EstUn;
DELETE FROM jouedans;
DELETE FROM Person;
DELETE FROM Realisateur;
DELETE FROM Acteur;
DELETE FROM film;
DELETE FROM filmestdiffusedanssalle;
DELETE FROM tarif;
DELETE FROM ticket;


Start TRANSACTION;
USE `sqldm` ;
-- Création d'un cinéma --
INSERT INTO cinema (name)
VALUES ("Pathe");
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des salles --
INSERT INTO salle (nombrePlace, numeroSalle, Cinema_idCinema)
VALUES (100, 01, 1),(150, 02 , 1),(200, 03 , 1);
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des périodes de journée --
insert into periodejournee (libelle, heure)
values ("Matin", "10:00:00"),
("Après-midi 1", "14:00:00"),
("Après-midi 2", "18:15:00"),
("Soiree", "20:00:00"),
("Nuit", "12:00:00"); 
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des plans de séances --
insert into planseance (libelle)
values ("semaine"),("weekend");
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Plan de séance pour la semaine --

-- Plan séance pour la salle 1 --
insert into sallediffuseperiode (Salle_idSalle, PeriodeJournee_idPeriodeJournee, PlanSeance_idPlanSeance)
values (1, 1, 1),(1, 2, 1),(1, 4, 1);

-- Plan séance pour la salle 2 --
insert into sallediffuseperiode (Salle_idSalle, PeriodeJournee_idPeriodeJournee, PlanSeance_idPlanSeance)
values (2, 1, 1),(2, 2, 1),(2, 4, 1);

-- Plan séance pour la salle 3 --
insert into sallediffuseperiode (Salle_idSalle, PeriodeJournee_idPeriodeJournee, PlanSeance_idPlanSeance)
values (3, 1, 1),(3, 3, 1),(3, 5, 1);

-- Plan de séance pour le weekend --

-- Plan séance pour la salle 1 --
insert into sallediffuseperiode (Salle_idSalle, PeriodeJournee_idPeriodeJournee, PlanSeance_idPlanSeance)
values (1, 1, 2),(1, 2, 2),(1, 4, 2),(1, 5, 2);

-- Plan séance pour la salle 2 --
insert into sallediffuseperiode (Salle_idSalle, PeriodeJournee_idPeriodeJournee, PlanSeance_idPlanSeance)
values (2, 1, 2),(2, 2, 2),(2, 4, 2),(2, 5, 2);


-- Plan séance pour la salle 3 --
insert into sallediffuseperiode (Salle_idSalle, PeriodeJournee_idPeriodeJournee, PlanSeance_idPlanSeance)
values (3, 3, 2),(3, 4, 2),(3, 5, 2);
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des limite d'âge --
insert into limiteage (libelle)
values ("Tout public"),
("Interdit aux moins de douze ans"),
("Interdit aux moins de seize ans"),
("Interdit aux mineurs");
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des personnes --
INSERT INTO person (Nom, Prenom, DateNaissance)
VALUES ("Mortensen", "Viggo", Date("1958-10-20")),
("McKellen", "Ian",  Date("1939-05-25")),
("Jackson", "Peter", Date("1961-10-31")),
("Wood", "Elijah", Date("1981-01-28")),
("Tiret", "Justine", Date("1978-07-17")),
("Machado-Graner", "Milo", Date("2008-08-31")),
("Arlaud", "Swann", Date("1981-11-30"));
COMMIT;


Start TRANSACTION;
USE `sqldm` ;
-- Création des acteurs --
insert into acteur (Person_idPerson) values (1),(2),(4),(6),(7);
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des realisateurs --
insert into realisateur  (Person_idPerson) values (3),(5);
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des films --
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
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des genres de film --
insert into genre (libelle)
values ("Drame"),("Famille"),("Policier"),("Thriller");
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Liaison entre les films et les genres --
insert into EstUn (Genre_idGenre, Film_idFilm)
values (1,5), (2,1), (2,2), (2,3), (2,4), (3,5), (4,5);
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Liaison entre les films et les acteurs --
insert into jouedans (Film_idFilm, Acteur_Person_idPerson)
values (1, 1),(2, 1),(3, 1),(1, 2),(2, 2),(3, 2),(4, 2),(1, 4),(2, 4),(3, 4),(5, 6);
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Liaison entre les films et les salles --
insert into filmestdiffusedanssalle (langue, Film_idFilm, SalleDiffusePeriode_idSalleDiffusePeriode)
values ("VF", 2, 1),
("VF", 2, 10);

insert into filmestdiffusedanssalle (langue, Film_idFilm, SalleDiffusePeriode_idSalleDiffusePeriode)
values ("VF", 5, 8),
("VF", 5, 19);
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des tarifs --
insert into tarif(prix, libelle)
values(9.80, "Tarif plein"),
(5.00, "Tarif etudiant"),
(5.00, "Tarif Demandeur d’emploi"),
(3.80, "Tarif -14 ans");
COMMIT;

Start TRANSACTION;
USE `sqldm` ;
-- Création des tickets --
insert into ticket (Seance, Tarif_idTarif, FilmEstDiffuseDansSalle_FilmEstDiffuseDansSalleId)
values ("2024:02:27", 1, 2),
("2024:02:27", 3, 2);
COMMIT;