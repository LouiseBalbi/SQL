-- a) Liste des articles dans l’ordre alphabétique des désignations
SELECT * FROM `article` ORDER BY designation

-- b) Liste des articles dans l’ordre des prix du plus élevé au moins elevé
SELECT * FROM `article` ORDER BY prix DESC

-- c) Liste des articles dont le prix est supérieur à 25€
SELECT * FROM `article` WHERE prix > 25

-- d) Liste de tous les articles qui sont des « boulons » et tri des résultats par ordre de prix ascendant
SELECT * FROM `article` WHERE `designation` like 'Boulon%'
ORDER BY prix;

-- e) Liste de tous les articles dont la désignation contient le mot « sachet ».
SELECT * FROM `article` WHERE `designation` LIKE '%sachet%'

-- f) Liste de tous les articles dont la désignation contient le mot « sachet »indépendamment de la casse
SELECT * FROM `article` WHERE Lower(`designation`) LIKE '%sachet%'

-- g) Liste des articles avec les informations fournisseur correspondantes. Les résultats
-- doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le
-- plus élevé au moins élevé.
SELECT * FROM `article` as A INNER JOIN fournisseur as F on A.id_fou = F.id
ORDER by F.nom, A.prix

-- h) Liste des articles de la société « Dubois & Fils »
SELECT * FROM `article` as A INNER JOIN fournisseur as F on A.id_fou = F.id
WHERE F.id = 3

-- i) Calcule de la moyenne des prix des articles de la société « Dubois & Fils »
SELECT fournisseur.nom, AVG(article.prix) FROM fournisseur INNER JOIN article ON
fournisseur.id = article.id_fou WHERE fournisseur.id = 3
GROUP BY fournisseur.nom;

-- j) Calcul de la moyenne des prix des articles de chaque fournisseur
SELECT fournisseur.nom, AVG(article.prix) FROM fournisseur INNER JOIN article ON
fournisseur.id = article.id_fou 
GROUP BY fournisseur.nom
 
-- k) Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT * FROM `bon` WHERE date_cmde BETWEEN '2019/03/01' AND '2019/04/05 12:00:00'


-- l) Sélectionnez les divers bons de commande qui contiennent des boulons 
SELECT * FROM `bon` INNER JOIN `compo` on bon.id = compo.id_bon
INNER JOIN `article` ON  article.id = compo.id_art 
WHERE article.designation LIKE '%boulon%'
GROUP BY bon.id

-- m) Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom
--du fournisseur associé.
SELECT article.designation, fournisseur.nom, bon.* FROM `bon` 
INNER JOIN `compo` on bon.id = compo.id_bon
INNER JOIN `article` ON  article.id = compo.id_art 
INNER JOIN `fournisseur` on article.id_fou = fournisseur.id
WHERE article.designation LIKE '%boulon%' 
GROUP BY bon.id

-- n)Calculez le prix total de chaque bon de commande
SELECT b.numero,sum(a.prix) as `Prix Total` from bon as b 
inner join compo as c on b.id = c.id_bon 
inner join article as a on a.id = c.id_art 
inner join fournisseur as f on f.id = a.idfou
group by b.numero;

-- o) Comptez le nombre d’articles de chaque bon de commande
SELECT b.numero, SUM(c.qte) as Quantite from bon as b 
inner join compo as c on b.id = c.id_bon 
inner join article as a on a.id = c.id_art
GROUP BY b.numero

-- p) Affichez les numéros de bons de commande qui contiennent plus de 25 articles et
-- affichez le nombre d’articles de chacun de ces bons de commande
SELECT b.numero, SUM(c.qte) as Quantite from bon as b 
inner join compo as c on b.id = c.id_bon 
inner join article as a on a.id = c.id_art
GROUP BY b.numero
HAVING Quantite > 25

-- q) Calculez le coût total des commandes effectuées sur le mois d’avril
select SUM(A.prix * C.qte) as count from bon as B inner join compo as C on  B.id = C.id_bon
inner join article as A on A.id = C.id_art
where month(B.date_cmde) = 4;


