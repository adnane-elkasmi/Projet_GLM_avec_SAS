/************************************************/
/* Programme : Projet MLG						*/
/* Auteur    : Adnane EL KASMI                  */
/* Date      : 12/12/2020                       */
/************************************************/

/*----------------------------------------------*/
/* 1/ Import de la base de données */
/*----------------------------------------------*/

/* house_data.csv */ /* La nommer house_data  */

PROC IMPORT DATAFILE     = "/folders/myfolders/sasuser.v94/house_data.csv"
				DBMS     = CSV
				OUT      = house_data;
				GETNAMES = YES;
RUN;

PROC CONTENTS DATA=	WORK.house_data ORDER = varnum; RUN;

/* 21613 observations   
   21 variables*/

PROC FREQ DATA = house_data;
	TABLES bathrooms bedrooms;
RUN;
PROC FREQ DATA = house_data;
	TABLES condition;
RUN;
PROC FREQ DATA = house_data;
	TABLES floors grade;
RUN;
PROC FREQ DATA = house_data;
	TABLES sqft_above;
RUN;
PROC FREQ DATA = house_data;
	TABLES sqft_basement sqft_living;
RUN;
PROC FREQ DATA = house_data;
	TABLES 	sqft_living15 sqft_lot;
RUN;
PROC FREQ DATA = house_data;
	TABLES sqft_lot15 view;
RUN;
PROC FREQ DATA = house_data;
	TABLES waterfront yr_built;
RUN;
PROC FREQ DATA = house_data;
	TABLES yr_renovated;
RUN;

/* bathrooms     : Regrouper certaines modalités (rééquilibrer les effectifs)    */								 */
/* bedrooms      : Regrouper certaines modalités (rééquilibrer les effectifs)	 */
/* condition     : Peu de notes 1 et 2 								             */
/* date          : Inutile ? De la forme 20140502T000000                         */
/* floors 		 : regroupement de 3 et 3.5 									 */
/* grade         : regroupement de 1:5 et de 12-13								 */
/* id 			 : Inutile car propre à chaque logement						     */						 */
/* lat           : Inutile ?  Car pas ordonnée									 */
/* long 		 : Inutile ? Car pas ordonnée								     */
/* price         : Regroupement de variables à faire 							 */
/* sqft_above    : Regroupement de variables à faire (plus de variables autour des dizaines)*/
/* sqft_basement : Regroupement de variables à faire 							 */
/* sqft_living   : Regroupement de variables à faire 							 */
/* sqft_living15 : Regroupement de variables à faire (pareil que living)		 */
/* sqft_lot      : Regroupement de variables à faire 							 */
/* sqft_lot15    : Regroupement de variables à faire (pareil que lot))		 */
/* view          : Rien à changer												 */
/* waterfront    : Rien à changer 												 */
/* yr_built      : Regroupement de certaines années ? Surtout anciennes ? 		 */
/* yr_renovated  : Regroupement de certaines années ? Surtout anciennes ? 		 */
/* zipcode       : Inutile ? Pas ordonnée										 */;



DATA house_rec;
SET house_data;
RUN;

/* Création d'une nouvelle base de données où réaliser les transormations */								 */;

DATA house_rec;
SET house_rec;
IF bedrooms < 2 then bedrooms_rec = 1;
ELSE IF bedrooms < 34 and bedrooms > 6 then bedrooms_rec = 6;
else bedrooms_rec = bedrooms;
RUN;

/* On recode bedrooms, car il n'y a pas assez de certaines valeurs*/

PROC FREQ DATA = house_rec ;
 	TABLE bedrooms_rec / NOPERCENT;
RUN;

/* On observe ce que cela donne via le proc freq */
/* On fait la même chose pour toutes les variables où c'est nécessaire */

DATA house_rec;
SET house_rec;
IF bathrooms < 1 then bathrooms_rec = 0;
ELSE IF bathrooms < 2 then bathrooms_rec = 1;
ELSE IF bathrooms < 3 then bathrooms_rec = 2;
ELSE IF bathrooms < 4 then bathrooms_rec = 3;
else bathrooms_rec = 4;
RUN;


PROC FREQ DATA = house_rec ;
 	TABLE bathrooms_rec / NOPERCENT;
RUN;


DATA house_rec;
SET house_rec;
IF floors = 3 or floors = 3.5 then floors_rec = 3;
else  floors_rec = floors;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE floors_rec / NOPERCENT;
RUN;

DATA house_rec;
SET house_rec;
IF grade < 6 then grade_rec = 5;
else if grade > 10 then grade_rec = 11;
else  grade_rec = grade;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE grade_rec / NOPERCENT;
RUN;

DATA house_rec;
SET house_rec;
IF sqft_above < 1001 then sqft_above_rec = 1000;
ELSE IF sqft_above < 2001 then sqft_above_rec = 2000;
ELSE IF sqft_above < 3001 then sqft_above_rec = 3000;
ELSE IF sqft_above< 4001 then sqft_above_rec = 4000;
else sqft_above_rec = 5000;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE sqft_above_rec / NOPERCENT;
RUN;


DATA house_rec;
SET house_rec;
IF sqft_living < 1001 then sqft_living_rec = 1000;
ELSE IF sqft_living < 2001 then sqft_living_rec = 2000;
ELSE IF sqft_living < 3001 then sqft_living_rec = 3000;
ELSE IF sqft_living< 4001 then sqft_living_rec = 4000;
ELSE IF sqft_living < 5001 then sqft_living_rec = 5000;
else sqft_living_rec = 6000;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE sqft_living_rec / NOPERCENT;
RUN;


DATA house_rec;
SET house_rec;
IF sqft_lot < 1001 then sqft_lot_rec = 1000;
ELSE IF sqft_lot < 2001 then sqft_lot_rec = 2000;
ELSE IF sqft_lot < 3001 then sqft_lot_rec = 3000;
ELSE IF sqft_lot< 4001 then sqft_lot_rec = 4000;
ELSE IF sqft_lot < 5001 then sqft_lot_rec = 5000;
ELSE IF sqft_lot < 6001 then sqft_lot_rec = 6000;
ELSE IF sqft_lot < 7001 then sqft_lot_rec = 7000;
ELSE IF sqft_lot < 8001 then sqft_lot_rec = 8000;
ELSE IF sqft_lot < 9001 then sqft_lot_rec = 9000;
ELSE IF sqft_lot < 10001 then sqft_lot_rec = 10000;
ELSE IF sqft_lot < 11001 then sqft_lot_rec = 11000;
ELSE IF sqft_lot < 12001 then sqft_lot_rec = 12000;
ELSE IF sqft_lot < 13001 then sqft_lot_rec = 13000;
else sqft_lot_rec = 14000;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE sqft_lot_rec / NOPERCENT;
RUN;

DATA house_rec;
SET house_rec;
IF sqft_basement <1 then sqft_basement_rec = 0;
ELSE IF sqft_basement < 501 then sqft_basement_rec = 500;
ELSE IF sqft_basement < 1001 and sqft_basement > 500 then sqft_basement_rec = 1000;
ELSE IF sqft_basement< 1501 and sqft_basement > 1000 then sqft_basement_rec = 1500;
else sqft_basement_rec = 2000;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE sqft_basement_rec / NOPERCENT;
RUN;



DATA house_rec;
SET house_rec;
IF sqft_living15 < 1001 then sqft_living15_rec = 1000;
ELSE IF sqft_living15 < 2001 then sqft_living15_rec = 2000;
ELSE IF sqft_living15 < 3001 then sqft_living15_rec = 3000;
ELSE IF sqft_living15< 4001 then sqft_living15_rec = 4000;
else sqft_living15_rec = 5000;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE sqft_living15_rec / NOPERCENT;
RUN;



DATA house_rec;
SET house_rec;
IF sqft_lot15 < 1001 then sqft_lot15_rec = 1000;
ELSE IF sqft_lot15 < 2001 then sqft_lot15_rec = 2000;
ELSE IF sqft_lot15 < 3001 then sqft_lot15_rec = 3000;
ELSE IF sqft_lot15< 4001 then sqft_lot15_rec = 4000;
ELSE IF sqft_lot15 < 5001 then sqft_lot15_rec = 5000;
ELSE IF sqft_lot15 < 6001 then sqft_lot15_rec = 6000;
ELSE IF sqft_lot15 < 7001 then sqft_lot15_rec = 7000;
ELSE IF sqft_lot15 < 8001 then sqft_lot15_rec = 8000;
ELSE IF sqft_lot15 < 9001 then sqft_lot15_rec = 9000;
ELSE IF sqft_lot15 < 10001 then sqft_lot15_rec = 10000;
ELSE IF sqft_lot15 < 11001 then sqft_lot15_rec = 11000;
ELSE IF sqft_lot15 < 12001 then sqft_lot15_rec = 12000;
ELSE IF sqft_lot15 < 13001 then sqft_lot15_rec = 13000;
else sqft_lot15_rec = 14000;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE sqft_lot15_rec / NOPERCENT;
RUN;

DATA house_rec;
SET house_rec;
IF yr_built<1906 then yr_built_rec=1905;
ELSE IF yr_built<1911 then yr_built_rec=1910;
ELSE IF yr_built<1916 then yr_built_rec=1915;
ELSE IF yr_built<1921 then yr_built_rec=1920;
ELSE IF yr_built<1926 then yr_built_rec=1925;
ELSE IF yr_built<1931 then yr_built_rec=1930;
ELSE IF yr_built<1936 then yr_built_rec=1935;
ELSE IF yr_built<1941 then yr_built_rec=1940;
ELSE IF yr_built>2013 then yr_built_rec=2014;
Else yr_built_rec=yr_built;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE yr_built_rec / NOPERCENT;
RUN;

DATA house_rec;
SET house_rec;
IF yr_renovated<1 then yr_renovated_rec=0;
ELSE IF yr_renovated<1981 then yr_renovated_rec=1980;
ELSE IF yr_renovated<2000 then yr_renovated_rec=2000;
ELSE IF yr_renovated<2011 then yr_renovated_rec=2010;
ELSE IF yr_renovated<2016 then yr_renovated_rec=2015;
Else yr_renovated_rec=yr_renovated;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE yr_renovated_rec / NOPERCENT;
RUN;

DATA house_rec;
SET house_rec;
IF condition<3 then condition_rec=2;
Else condition_rec=condition;
RUN;

PROC FREQ DATA = house_rec ;
 	TABLE condition_rec / NOPERCENT;
RUN;

DATA house_rec;
SET house_rec;
view_rec=view;
waterfront_rec=waterfront;
RUN;

/* On importe les deux dernières variables non modifiées */

PROC FREQ DATA = house_rec ;
 	TABLE view_rec / NOPERCENT;
 	TABLE waterfront / NOPERCENT;
RUN;



PROC SQL;
CREATE TABLE house_final AS
select bedrooms_rec, bathrooms_rec, condition_rec, floors_rec,
grade_rec, sqft_above_rec, sqft_living_rec, sqft_lot_rec,
sqft_basement_rec, sqft_living15_rec, sqft_lot15_rec,
yr_renovated_rec, yr_built_rec, view_rec, waterfront_rec, price
from house_rec;
QUIT;

/* On ne garde que les variables qu'on a modifiées */

PROC CONTENTS DATA=	house_final ORDER = varnum; 
RUN;

/* Tout va bien dans le proc contents */

TITLE 'Distribution du prix des logements';
PROC SGPLOT DATA = house_final;
	HISTOGRAM price;
	DENSITY price / TYPE = NORMAL LEGENDLABEL = 'NORMAL' LINEATTRS = (PATTERN = SOLID);
	*DENSITY price / TYPE = KERNEL LEGENDLABEL = 'KERNEL' LINEATTRS = (PATTERN = SOLID);
	KEYLEGEND / LOCATION = INSIDE POSITION = TOPRIGHT ACROSS = 1;
  	XAXIS DISPLAY = (NOLABEL);
RUN;

/* On regarde la distribution du prix du logement par rapport à celle d'une loi normale */

TITLE 'Distribution du nombre de chambre';
PROC SGPLOT DATA = house_final;
	HISTOGRAM bedrooms_rec;
	DENSITY bedrooms_rec / TYPE = NORMAL LEGENDLABEL = 'NORMAL' LINEATTRS = (PATTERN = SOLID);
	*DENSITY bedrooms_rec / TYPE = KERNEL LEGENDLABEL = 'KERNEL' LINEATTRS = (PATTERN = SOLID);
	KEYLEGEND / LOCATION = INSIDE POSITION = TOPRIGHT ACROSS = 1;
  	XAXIS DISPLAY = (NOLABEL);
RUN;

/* On fait de même pour les variables */

TITLE 'Distribution sqft_living_rec';
PROC SGPLOT DATA = house_final;
	HISTOGRAM sqft_living_rec;
	DENSITY sqft_living_rec / TYPE = NORMAL LEGENDLABEL = 'NORMAL' LINEATTRS = (PATTERN = SOLID);
	*DENSITY sqft_living_rec / TYPE = KERNEL LEGENDLABEL = 'KERNEL' LINEATTRS = (PATTERN = SOLID);
	KEYLEGEND / LOCATION = INSIDE POSITION = TOPRIGHT ACROSS = 1;
  	XAXIS DISPLAY = (NOLABEL);
RUN;

TITLE 'Distribution du nombre de salles de bain';
PROC SGPLOT DATA = house_final;
	HISTOGRAM bathrooms_rec;
	DENSITY bathrooms_rec / TYPE = NORMAL LEGENDLABEL = 'NORMAL' LINEATTRS = (PATTERN = SOLID);
	*DENSITY bathrooms_rec / TYPE = KERNEL LEGENDLABEL = 'KERNEL' LINEATTRS = (PATTERN = SOLID);
	KEYLEGEND / LOCATION = INSIDE POSITION = TOPRIGHT ACROSS = 1;
  	XAXIS DISPLAY = (NOLABEL);
RUN;

TITLE 'Distribution sqft_above_rec';
PROC SGPLOT DATA = house_final;
	HISTOGRAM sqft_above_rec;
	DENSITY sqft_above_rec / TYPE = NORMAL LEGENDLABEL = 'NORMAL' LINEATTRS = (PATTERN = SOLID);
	*DENSITY sqft_above_rec / TYPE = KERNEL LEGENDLABEL = 'KERNEL' LINEATTRS = (PATTERN = SOLID);
	KEYLEGEND / LOCATION = INSIDE POSITION = TOPRIGHT ACROSS = 1;
  	XAXIS DISPLAY = (NOLABEL);
RUN;

/* Des transformations n'aideraient pas à améliorer le modèle ici */


PROC SORT data=house_final;
	by price;
RUN;
/* On trie par ordre croissant en fonction du prix */

PROC SURVEYSELECT DATA=house_final METHOD=srs OUT=Base OUTALL SAMPRATE=0.75;
	strata price;
RUN;
/* On va décomposer la base de données en une base apprentissage et une base de validation */
/* Tout en conservant une même répartition de price */
 
data Apprent Valid;
	set Base;
	if Selected=0 then output Valid;
	if Selected=1 then output apprent;
run;

/* On introduit les deux nouvelles matrices*/


PROC SQL;
CREATE TABLE VAL AS
select bedrooms_rec, bathrooms_rec, condition_rec, floors_rec,
grade_rec, sqft_above_rec, sqft_living_rec, sqft_lot_rec,
sqft_basement_rec, sqft_living15_rec, sqft_lot15_rec,
yr_renovated_rec, yr_built_rec, view_rec, waterfront_rec, price
from Valid;
QUIT;
/* On retire les variables créées lors de la décomposition */

PROC SQL;
CREATE TABLE APP AS
select bedrooms_rec, bathrooms_rec, condition_rec, floors_rec,
grade_rec, sqft_above_rec, sqft_living_rec, sqft_lot_rec,
sqft_basement_rec, sqft_living15_rec, sqft_lot15_rec,
yr_renovated_rec, yr_built_rec, view_rec, waterfront_rec, price
from apprent;
QUIT;
/* On retire les variables créées lors de la décomposition */

PROC CONTENTS DATA=app ORDER = varnum; RUN;

PROC CONTENTS DATA=Val ORDER = varnum; RUN;

/* On vérifie que tout se passe bien dans le proc contents */

PROC REG DATA = app SIMPLE OUTEST = MODEL plots(maxpoints=none);
MODEL price = bedrooms_rec bathrooms_rec condition_rec floors_rec
grade_rec sqft_above_rec sqft_living_rec sqft_lot_rec
sqft_basement_rec sqft_living15_rec sqft_lot15_rec
yr_renovated_rec yr_built_rec view_rec waterfront_rec / selection = stepwise;
id price;
OUTPUT OUT = BASE_OUT PREDICTED = PRED RESIDUAL = RESIDU 
					 LCL = BORNE_INF UCL = BORNE_SUP 
					 COOKD = DISTANCE_COOK H = LEVIER;
RUN;
QUIT;

PROC CONTENTS DATA=MODEL ORDER = varnum; RUN;


DATA MODEL2;
SET MODEL;
CLE = 1; * clé de jointure qui permettra de faire la fusion avec la table d'échantillon;
keep CLE intercept bedrooms_rec bedrooms_rec bathrooms_rec condition_rec floors_rec
grade_rec sqft_above_rec sqft_living_rec sqft_lot_rec
sqft_basement_rec sqft_living15_rec sqft_lot15_rec
yr_renovated_rec yr_built_rec view_rec waterfront_rec ;
rename bedrooms_rec = B_bedrooms_rec
bathrooms_rec= B_bathrooms_recbedrooms_rec  
condition_rec=B_condition_rec 
floors_rec=B_floors_rec
grade_rec=B_grade_rec
sqft_above_rec=B_sqft_above_rec
sqft_living_rec=B_sqft_living_rec 
sqft_lot_rec=B_sqft_lot_rec
sqft_basement_rec=B_sqft_basement_rec
sqft_living15_rec=B_sqft_living15_rec
sqft_lot15_rec=B_sqft_lot15_rec
yr_renovated_rec=B_yr_renovated_rec 
yr_built_rec=B_yr_built_rec 
view_rec=B_view_rec 
waterfront_rec=B_waterfront_rec;
RUN;


/* Créer une clé de jointure pour la fusion */
DATA VAL2;
SET VAL;
CLE = 1;
RUN;

/* Fusionner les 2 bases et calculer le Y prédit avec les paramètres des variables */
DATA resultats;
MERGE VAL2 (in=a) MODEL2 (in=b);
By CLE;
y_pred = intercept + bedrooms_rec*B_bedrooms_rec+ bathrooms_rec* B_bathrooms_recbedrooms_rec  
+condition_rec*B_condition_rec +floors_rec*B_floors_rec
+grade_rec*B_grade_rec+sqft_above_rec*B_sqft_above_rec
+sqft_living_rec*B_sqft_living_rec+ sqft_lot_rec*B_sqft_lot_rec
+sqft_basement_rec*B_sqft_basement_rec+sqft_living15_rec*B_sqft_living15_rec
+sqft_lot15_rec*B_sqft_lot15_rec+yr_renovated_rec*B_yr_renovated_rec 
+yr_built_rec*B_yr_built_rec+ view_rec*B_view_rec 
+waterfront_rec*B_waterfront_rec;
RUN;

/* Calcul de la prédiction pour la base de Validation */

PROC CONTENTS DATA=resultats ORDER = varnum; RUN;

DATA BASE_GRAPH;
MERGE resultats (in=a) BASE_OUT (in=b);
RUN;

/* On rassemble resultats et BASE_OUT pour réaliser des graphiques */

PROC SGPLOT DATA= BASE_GRAPH;
SCATTER X=y_pred Y=RESIDU;
RUN;

/* Graphique des résidus en fonction de la prédiction de validation*/






