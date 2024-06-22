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


--// SET NEXT VAL 
SELECT setval('prestataires_prest_id_seq', 124);


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
538GFNCF-SAL CT-NCR2A
 
 
select salarie_typologie,contrat_reference  ,* from salaries s where s.salarie_code in ('974SRLUT-SAL')
select contrat_statut ,* from contrat c where contrat_reference = 'CT-MW3UP'

select distinct contrat_statut from contrat 

update contrat c
set contrat_statut='CONTRAT EN COURS'
where
c.contrat_reference
 = 'CT-NCR2A'
in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
 AND salarie_code in (
'974SRLUT-SAL'
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
	contrat_reference = 'CT-MW3UP',
 salarie_typologie ='SOUS CONTRAT'
 -- salarie_type_contrat = 'CONTRAT JOURNALIER',
 --salarie_date_embauche = '2024-03-18'::date,
 --salarie_date_debauche = '2024-04-17'::date
 
WHERE 1=1
 --AND salarie_typologie ='VIVIER'
 AND salarie_code in (
'538GFNCF-SAL'
 ) 
 =====================================
-- TO VIVIER 
CT-XX03R 267EUJDO-SAL
 
select salarie_typologie,soc_code ,* from salaries s where s.salarie_code IN (
'538GFNCF-SAL')

select salarie_code from contrat where contrat_reference ='CT-S5NY1'


update contrat c
set contrat_statut='ANCIEN CONTRAT'
where c.contrat_reference in (
'CT-XX03R')

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
'267EUJDO-SAL'
 ) 
 
 delete from contrat where contrat_reference = 'CT-P9ATI'
 
 =====================================
 >> change SOCIETE

>> SG_UMO_7
538GFNCF-SAL 
CT-NCR2A

 select * from societe s where s.soc_raison_soc ~~ '%SPI%'
 
 update contrat c 
set 
 soc_code = 'SG_UMO_7'
where c.contrat_reference in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
 AND salarie_code in (
'538GFNCF-SAL'
 ) 
 --and salarie_client_code = '796TLYBC-CL'
);
 
update salaries 
set 
 soc_code = 'SG_UMO_7'
WHERE 1=1
 AND salarie_code in (
'538GFNCF-SAL'
 ) 
 
 =====================================
>> change CLIENT 

AFRICA FORWARDING SERVICES
538GFNCF-SAL 
CT-NCR2A

select * from clients c where upper(c.client_raison_soc)  ~~ '%FORWARDING%' > 567CVWKD-CL  -  AFRICA FORWARDING SERVICES 

select salarie_typologie ,salarie_client_code,salarie_client, salarie_soc_code, salarie_soc_nom  from salaries s where s.salarie_code ='758OMJKV-SAL'

select client_code from contrat c2 where c2.contrat_reference = 'CT-QMHEL'

 
 update contrat c 
set 
client_code = '567CVWKD-CL'
where c.contrat_reference in (
SELECT contrat_reference FROM umo.salaries WHERE 1=1
 AND salarie_code in (
'538GFNCF-SAL'
 ) 
 --and salarie_client_code = '796TLYBC-CL'
);
 
update salaries 
set 
 salarie_client_code = '567CVWKD-CL',
 salarie_client = '567CVWKD-CL',
 salarie_soc_code = '567CVWKD-CL',
 salarie_soc_nom = 'AFRICA FORWARDING SERVICES'
WHERE 1=1
 AND salarie_code in (
'538GFNCF-SAL'
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
'747BSQIC-SAL',
'955HYWAK-SAL',
'331DKZXL-SAL',
'617IFUQR-SAL',
'253PFIMY-SAL',
'636PJUVS-SAL',
'436DNLUB-SAL',
'948DXNJE-SAL',
'524SJJID-SAL',
'351LNLHS-SAL'
], 
ARRAY[
'RAST-J001',
'RAST-J002',
'RAST-J003',
'RAST-J004',
'RAST-J005',
'RAST-J006',
'RAST-J007',
'RAST-J008',
'RAST-J009',
'RAST-J010'
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

drop table umo.facture_ipm_prestataire;

CREATE TABLE umo.facture_ipm_prestataire (
	fact_ipm_prest_id serial4 not NULL,
	fact_ipm_prest_num varchar not NULL,
	fact_ipm_prest_date date null,
	fact_ipm_prest_periode varchar NULL,
	fact_ipm_prest_code varchar not null,
	fact_ipm_prest_montant_ht numeric null,
	fact_ipm_prest_tva numeric null,
	fact_ipm_prest_ttc numeric null,
	fact_ipm_prest_nb_objet numeric null,
	fact_ipm_prest_totalise numeric null,
	fact_ipm_prest_valide bool null,
	fact_ipm_prest_date_valide timestamp null,
	CONSTRAINT fact_ipm_prest_num_pk PRIMARY KEY (fact_ipm_prest_num)
);


drop table facture_ipm_prest_details;

CREATE TABLE umo.facture_ipm_prest_details (
	fact_ipm_prest_det_id serial4 not NULL,
	fact_ipm_prest_det_code varchar NULL,
	fact_ipm_prest_date date null,
	fact_ipm_prest_num varchar not null,
	fact_ipm_prest_matricule varchar NULL,
	fact_ipm_prest_code varchar NULL,
	fact_ipm_prest_nom_prenom varchar NULL,
	fact_ipm_prest_profession varchar NULL,
	fact_ipm_prest_benef_type varchar null,
	fact_ipm_prest_benef_nom varchar null,
	fact_ipm_prest_soc_code varchar NULL,
	fact_ipm_prest_soc_nom varchar NULL,
	fact_ipm_prest_cli_code varchar NULL,
	fact_ipm_prest_cli_nom varchar NULL,
	fact_ipm_prest_contrat_ref varchar NULL,
	fact_ipm_prest_prestation varchar NULL,
	fact_ipm_prest_pu numeric NULL,
	fact_ipm_prest_nombre numeric NULL,
	fact_ipm_prest_montant numeric NULL,
	fact_ipm_prest_valide bool null,
	fact_ipm_prest_date_valide timestamp null,
	fact_ipm_prest_valide_par varchar null,
	CONSTRAINT facture_ipm_details_pk PRIMARY KEY (fact_ipm_prest_det_id)
	--,CONSTRAINT FOREIGN KEY (fact_ipm_prest_num) REFERENCES umo.facture_ipm_prestataire(fact_ipm_prest_num) ON DELETE RESTRICT ON UPDATE RESTRICT
);

ALTER TABLE umo.prestataires ADD prest_code_unique varchar NULL;
update prestataires set prest_code_unique =concat(left(prest_specialiste, 3), prest_id)
ALTER TABLE umo.prestataires ADD prest_code_unique varchar NOT NULL;


====================================


SELECT 
s.salarie_matricule,
concat(s.salarie_nom, ' ', s.salarie_prenom) as salarie_fullname,
(select c.contrat_emploi from contrat c where c.contrat_reference = s.contrat_reference),
s.soc_code,
s.salarie_client_code,
s.contrat_reference ,
(select c.client_raison_soc from clients c where c.client_code = s.salarie_client_code),
(select sc.soc_raison_soc from societe sc where sc.soc_code = s.soc_code),
s.salarie_code ,
i.*
FROM umo.ipm i, umo.salaries s where s.salarie_code = i.salarie_code and i.reference = '537KDUNB-24-0001'


select * from ipm i where  i.reference = '537KDUNB-24-0001';




salarie_matricule;salarie_fullname;contrat_emploi;soc_code;salarie_client_code;contrat_reference;client_raison_soc;soc_raison_soc
