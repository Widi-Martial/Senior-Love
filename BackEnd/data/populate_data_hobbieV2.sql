-- Active: 1719840209096@@localhost@5432@senior@public
-- Insertion des hobbies pour les utilisateurs de 63 à 85, deux hobbies par utilisateur
INSERT INTO "users_hobbies" ("user_id", "hobby_id", "created_at") VALUES
(63, 1, NOW()), (63, 5, NOW()),  -- Utilisateur 63, hobbies 1 et 5
(64, 2, NOW()), (64, 8, NOW()),  -- Utilisateur 64, hobbies 2 et 8
(65, 3, NOW()), (65, 9, NOW()),  -- Utilisateur 65, hobbies 3 et 9
(66, 4, NOW()), (66, 10, NOW()), -- Utilisateur 66, hobbies 4 et 10
(67, 5, NOW()), (67, 11, NOW()), -- Utilisateur 67, hobbies 5 et 11
(68, 6, NOW()), (68, 12, NOW()), -- Utilisateur 68, hobbies 6 et 12
(69, 7, NOW()), (69, 1, NOW()), -- Utilisateur 69, hobbies 7 et 13
(70, 8, NOW()), (70, 1, NOW()),  -- Utilisateur 70, hobbies 8 et 1
(71, 9, NOW()), (71, 2, NOW()),  -- Utilisateur 71, hobbies 9 et 2
(72, 10, NOW()), (72, 3, NOW()), -- Utilisateur 72, hobbies 10 et 3
(73, 11, NOW()), (73, 4, NOW()), -- Utilisateur 73, hobbies 11 et 4
(74, 12, NOW()), (74, 5, NOW()), -- Utilisateur 74, hobbies 12 et 5
(75, 12, NOW()), (75, 6, NOW()), -- Utilisateur 75, hobbies 13 et 6
(76, 1, NOW()), (76, 7, NOW()),  -- Utilisateur 76, hobbies 1 et 7
(77, 2, NOW()), (77, 8, NOW()),  -- Utilisateur 77, hobbies 2 et 8
(78, 3, NOW()), (78, 9, NOW()),  -- Utilisateur 78, hobbies 3 et 9
(79, 4, NOW()), (79, 10, NOW()), -- Utilisateur 79, hobbies 4 et 10
(80, 5, NOW()), (80, 11, NOW()), -- Utilisateur 80, hobbies 5 et 11
(81, 6, NOW()), (81, 12, NOW()), -- Utilisateur 81, hobbies 6 et 12
(82, 7, NOW()), (82, 12, NOW()), -- Utilisateur 82, hobbies 7 et 13
(83, 8, NOW()), (83, 1, NOW()),  -- Utilisateur 83, hobbies 8 et 1
(84, 9, NOW()), (84, 2, NOW()),  -- Utilisateur 84, hobbies 9 et 2
(85, 10, NOW()), (85, 3, NOW())  -- Utilisateur 85, hobbies 10 et 3
;