--Production
call umo.basculer_env('PROD');

--Développement
call umo.basculer_env('DEV');

--Integration
call umo.basculer_env('INTEGRATION');

select param_creat_dir_path,* from parametres p;

--// DOUBLON
SELECT   COUNT(*) as doublon, ss.salarie_num_cnib as cni , f_get_doublon(ss.salarie_num_cnib) as proprietaire
FROM     salaries ss
GROUP BY ss.salarie_num_cnib 
HAVING   COUNT(*) > 1 and ss.salarie_num_cnib  != ''

select f_get_doublon('2191200700246')



-- // ===================================================== 
--// UPDATE > PAYS ratacher  


UPDATE umo.salaries s
SET salarie_pays = (SELECT client_pays FROM umo.clients c where c.client_code = s.salarie_client_code)
WHERE salarie_typologie not in ('VIVIER', 'BAC A SABLE')


 
	
========== ========== =
-- DELETE FICHE 

587HGYXY-SAL CT-U6Y7I
527VJTYV-SAL CT-YKO7J
886WBYGF-SAL CT-VY2A9
686MPXLB-SAL CT-KX2K4


delete from pointage c where c.contrat_reference in ('CT-U6Y7I', 'CT-YKO7J', 'CT-VY2A9', 'CT-KX2K4')
delete from contrat c where c.contrat_reference in ('CT-U6Y7I', 'CT-YKO7J', 'CT-VY2A9', 'CT-KX2K4')
delete from cumul_soc_fisc s where s.salarie_code in ('587HGYXY-SAL', '527VJTYV-SAL', '886WBYGF-SAL', '686MPXLB-SAL')
delete from salaries s where s.salarie_code in ('587HGYXY-SAL', '527VJTYV-SAL', '886WBYGF-SAL', '686MPXLB-SAL')




========== ========== =
-- TRANSFERT FICHE 
> to CONTRAT JOURNALIER
CT-B751H 348VYDMR-SAL DNY_J013
CT-J5J2J 423YPQWS-SAL DNY_J014
CT-0FFOE 325OFBDS-SAL DNY_J015

select salarie_typologie,* from salaries s where s.salarie_code in (
'348VYDMR-SAL', '423YPQWS-SAL', '325OFBDS-SAL')

delete from pointage 
where contrat_reference in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
 -- AND salarie_typologie ='JOURNALIER'
  AND salarie_code in (
'348VYDMR-SAL', '423YPQWS-SAL', '325OFBDS-SAL'
 ) 
);


delete from contrat_avenant  
where contrat_reference in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
-- AND salarie_typologie ='JOURNALIER'
  AND salarie_code in 
('348VYDMR-SAL', '423YPQWS-SAL', '325OFBDS-SAL')
);

update contrat c 
set 
 contrat_reference = replace(contrat_reference, 'CT-', 'JR-'),
 contrat_journalier = true,
 contrat_salaire_base_hor = true,
 contrat_statut = 'CONTRAT JOURNALIER'
where c.contrat_reference 
in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
-- AND salarie_typologie ='JOURNALIER'
  AND salarie_code in 
('348VYDMR-SAL', '423YPQWS-SAL', '325OFBDS-SAL')
);

 
update salaries 
set 
 salarie_typologie='JOURNALIER',
  contrat_reference = replace(contrat_reference, 'CT-', 'JR-')
WHERE 1=1
 -- AND salarie_typologie ='JOURNALIER'
  AND salarie_code in (
  '348VYDMR-SAL', '423YPQWS-SAL', '325OFBDS-SAL'
 ) 

 
 
 =====================================
-- TO PRESTATER   FROM SALARIE 

update salaries 
set 
 salarie_typologie ='PRESTATAIRE',
 salarie_type_contrat = 'CONTRAT DE PRESTATION'
WHERE 1=1
 AND salarie_code in (
'462TQUUI-SAL',
'762SLOYC-SAL',
'993EFONK-SAL',
'453KYFHV-SAL',
'285EYQPS-SAL',
'663LPWOF-SAL'
 ) 

 =====================================
-- TO SALARIE
 
select salarie_typologie,contrat_reference  ,* from salaries s where s.salarie_code in ('373BHSQV-SAL')
select contrat_statut ,* from contrat c where contrat_reference = 'CT-4FASY'

select distinct contrat_statut from contrat 

update contrat c
set contrat_statut='CONTRAT EN COURS'
where
c.contrat_reference
 = 'CT-4FASY'
in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
 AND salarie_code in (
'395DQYUY-SAL'
 ) 
 --and salarie_client_code = '796TLYBC-CL'
);


delete FROM umo.contrat_horaire WHERE salarie_code in ('462TQUUI-SAL',
'762SLOYC-SAL',
'993EFONK-SAL',
'453KYFHV-SAL',
'285EYQPS-SAL',
'663LPWOF-SAL')

update salaries 
set 
	contrat_reference = 'CT-4FASY',
 salarie_typologie ='SOUS CONTRAT'
 -- salarie_type_contrat = 'CONTRAT JOURNALIER',
 --salarie_date_embauche = '2024-03-18'::date,
 --salarie_date_debauche = '2024-04-17'::date
 
WHERE 1=1
 --AND salarie_typologie ='VIVIER'
 AND salarie_code in (
'373BHSQV-SAL'
 ) 
 =====================================
-- TO VIVIER 
 
select salarie_typologie ,* from salaries s where s.salarie_code IN (
'444SABQE-SAL')

select distinct contrat_statut  from contrat


update contrat c
set contrat_statut='ANCIEN CONTRAT'
where c.contrat_reference in (
'JR-IG3IJ')

in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
 AND salarie_code in (
'664VFJON-SAL'
 ) 
 --and salarie_client_code = '796TLYBC-CL'
);


update salaries 
set 
 salarie_typologie ='VIVIER'
WHERE 1=1
 --AND salarie_typologie ='VIVIER'
 AND salarie_code in (
'528UDYKN-SAL'
 ) 
 
 delete from contrat where contrat_reference = 'CT-P9ATI'
 
 =====================================
 >> change SOCIETE

 SELECT s.salarie_soc_code, soc_code ,contrat_reference  ,* FROM salaries s where s.salarie_code = '754ALLRE-SAL'
 CT-QMHEL 754ALLRE-SAL 
 
 select * from societe s where s.soc_raison_soc ~~ '%UMO%'
 
 update contrat c 
set 
 soc_code = 'SG_UMO_9'
where c.contrat_reference in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
 AND salarie_code in (
'265QKSFR-SAL'
 ) 
 --and salarie_client_code = '796TLYBC-CL'
);
 
update salaries 
set 
 soc_code = 'SG_UMO_16'
WHERE 1=1
 AND salarie_code in (
'754ALLRE-SAL'
 ) 
 
 =====================================
>> change CLIENT 

NEEMBA MALI SASU
CT-5VFVM 652ZIGCR-SAL MA231 

select * from clients c where upper(c.client_raison_soc)  ~~ '%NEEMBA%' > 173WKENN-CL  -  NEEMBA MALI SASU

select salarie_typologie ,salarie_client_code,salarie_client, salarie_soc_code, salarie_soc_nom  from salaries s where s.salarie_code ='758OMJKV-SAL'

select client_code from contrat c2 where c2.contrat_reference = 'CT-QMHEL'

 
 update contrat c 
set 
client_code = '173WKENN-CL'
where c.contrat_reference in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
 AND salarie_code in (
'652ZIGCR-SAL'
 ) 
 --and salarie_client_code = '796TLYBC-CL'
);
 
update salaries 
set 
 salarie_client_code = '173WKENN-CL',
 salarie_client = '173WKENN-CL',
 salarie_soc_code = '173WKENN-CL',
 salarie_soc_nom = 'NEEMBA MALI SASU'
WHERE 1=1
 AND salarie_code in (
'652ZIGCR-SAL'
 ) 
 --and salarie_client_code = '796TLYBC-CL'
 
 =====================================

 salarie_client_code = 'CLIENT'
 salarie_client = 'CLIENT'
 salarie_soc_code = 'CLIENT'
 salarie_soc_nom = 'CLIENT NOM'
 
 client_code = 'CLIENT'
 

 ============================================================
 
754TLDPV-SAL JR-TVMQU NB-J04
313UORHB-SAL JR-TXFHG NB-J05
528UDYKN-SAL JR-A6M56 NB_J0 
 367SOXCD-SAL Soloina TRB247
select salarie_typologie , contrat_reference ,* from salaries where salarie_code ='816VQDHF-SAL'

select * from contrat where contrat_reference ='CT-KLE7W'

--> change MATRICULE 
 
select * from f__change_matricule(
ARRAY[
'563BOMRH-SAL'
], 
ARRAY[
'CJSF001B'
]
);

-- VERIFICATION 

select 
(select p.pointage_salarie_matricule from pointage p 
	where p.contrat_reference = 'CT-WDAE3' ) as mat_pointage,
(select c.salarie_matricule from contrat c 
	where c.contrat_reference = 'CT-WDAE3') as mat_contra,
(select s.salarie_matricule  from salaries s
	where s.salarie_code = '317QMMBE-SAL') as mat_sal

============================================
FAYE SH
H9W2EQCJ

===========================





select * from sal_enfant se limit 1






















