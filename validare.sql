-- Test pentru constrângerea UNIQUE (verificarea că email-ul trebuie să fie unic)
-- Încercarea de a insera un email duplicat în tabelul 'clienti' ar trebui să genereze o eroare.
INSERT INTO clienti (nume, prenume, email, telefon, adresa, alte_detalii)
VALUES (
    'Alex', 
    'Ionescu', 
    'ion.popescu@example.com',  -- email duplicat
    '0740987654', 
    'Str. Y, Nr. 8', 
    'Email duplicat'
);
-- Așteptat: ORA-00001: unique constraint (-.CLIENTI_EMAIL_UN) violated



-- Test pentru constrângerea PRIMARY KEY (verificarea că client_id trebuie să fie unic)
-- Încercarea de a insera un client cu un client_id duplicat ar trebui să genereze o eroare.
INSERT INTO clienti (client_id, nume, prenume, email, telefon, adresa, alte_detalii)
VALUES (
    (SELECT client_id FROM clienti WHERE nume = 'Popescu' AND prenume = 'Ion'), -- Folosim un client_id deja existent
    'Maria', 
    'Popa', 
    'maria.popa@example.com', 
    '0740000000', 
    'Str. Z, Nr. 9', 
    'Client duplicat'
);
-- Așteptat: ORA-00001: unique constraint (-.CLIENTI_PK) violated



-- Test pentru constrângerea CHECK (verificarea unui email valid)
-- Încercarea de a insera un email invalid (care nu respectă formatul corect) ar trebui să genereze o eroare.
INSERT INTO clienti (nume, prenume, email, telefon, adresa, alte_detalii)
VALUES (
    'Gheorghiu', 
    'Ion', 
    'gheorghiu_ion_at_example.com',  -- email invalid
    '0740112233', 
    'Str. P, Nr. 5', 
    'Email invalid'
);
-- Așteptat: ORA-02290: check constraint (-.CLIENTI_EMAIL_CK) violated



-- Test pentru constrângerea FOREIGN KEY (verificarea că client_id există în tabela 'evenimente')
-- Încercarea de a insera un eveniment cu un client_id care nu există în tabela 'clienti' ar trebui să genereze o eroare.
INSERT INTO evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata, stare)
VALUES (
    99999,  -- client_id care nu există
    TO_DATE('2025-03-15', 'YYYY-MM-DD'),
    'Aniversare', 
    3000, 
    1500, 
    5, 
    'Confirmat'
);
-- Așteptat: ORA-02291: integrity constraint (-.EVENIMENTE_CLIENTI_FK) violated - parent key not found



-- Test pentru constrângerea CHECK (verificarea că pret_eveniment nu este negativ)
-- Încercarea de a insera un eveniment cu un preț negativ ar trebui să genereze o eroare.
INSERT INTO evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata, stare)
VALUES (
    (SELECT client_id FROM clienti WHERE nume = 'Popescu' AND prenume = 'Ion'),  -- Folosim clientul existent
    TO_DATE('2025-04-01', 'YYYY-MM-DD'),
    'Petrecere', 
    -5000,  -- Pret negativ
    1000, 
    5, 
    'Confirmat'
);
-- Așteptat: ORA-02290: check constraint (-.EVENIMENTE_PRET_EVENIMENT_CK) violated



-- Test pentru constrângerea PRIMARY KEY (verificarea că combinația eveniment_id și colaborator_id trebuie să fie unică)
-- Încercarea de a adăuga un colaborator pentru un eveniment existent ar trebui să genereze o eroare, dacă aceleași valori sunt deja prezente.
INSERT INTO col_ev_fk (eveniment_id, colaborator_id, pret_colaborator)
VALUES (
    (SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Nunta' AND data_eveniment = TO_DATE('2027-12-15', 'YYYY-MM-DD')), 
    (SELECT colaborator_id FROM colaboratori WHERE nume = 'Vasilescu' AND prenume = 'George'), 
    2500
);
-- Așteptat: ORA-00001: unique constraint (-.COL_EV_FK_PK) violated



-- Test pentru constrângerea FOREIGN KEY (verificarea că colaboratorul există în tabela 'colaboratori')
-- Încercarea de a insera un colaborator care nu există în tabela 'colaboratori' ar trebui să genereze o eroare.
INSERT INTO col_ev_fk (eveniment_id, colaborator_id, pret_colaborator)
VALUES (
    (SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Petrecere aniversară' AND data_eveniment = TO_DATE('2025-02-10', 'YYYY-MM-DD')), 
    99,  -- colaborator_id care nu există
    1000
);
-- Așteptat: ORA-02291: integrity constraint (-.COL_EV_FK_COLABORATOR_FK) violated - parent key not found



-- Test pentru constrângerea FOREIGN KEY (verificarea că locatie_id există în tabela 'locatii')
-- Încercarea de a insera o locație care nu există în tabela 'locatii' ar trebui să genereze o eroare.
INSERT INTO loc_ev_fk (eveniment_id, locatie_id, nr_locatie)
VALUES (
    (SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Nunta' AND data_eveniment = TO_DATE('2027-12-15', 'YYYY-MM-DD')), 
    999,  -- locatie_id care nu există
    1
);
-- Așteptat: ORA-02291: integrity constraint (-.LOC_EV_FK_LOCATIE_FK) violated - parent key not found



-- Test pentru constrângerea UNIQUE pe combinația eveniment_id și nr_fotografii
-- Încercăm să inserăm un record în tabela `materiale` cu același eveniment_id și nr_fotografii.
-- Asta va încălca restricția UNIQUE care impune ca pentru același eveniment_id să fie un număr unic de fotografii.
INSERT INTO materiale (eveniment_id, nr_fotografii, durata_video, alte_detalii)
VALUES (
    (SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Nunta' AND data_eveniment = TO_DATE('2027-12-15', 'YYYY-MM-DD')),
    250,  -- nr_fotografii duplicat pentru evenimentul cu eveniment_id respectiv
    3.0, 
    'Fotografii suplimentare'
);
-- Așteptat: ORA-00001: unique constraint (-.MATERIALE_PK) violated



-- Test pentru trigger care verifică data_eveniment să fie în viitor
INSERT INTO evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata, stare)
VALUES (
    (SELECT client_id FROM clienti WHERE nume = 'Popescu' AND prenume = 'Ion'),  -- Folosim un client existent
    TO_DATE('2023-12-15', 'YYYY-MM-DD'),  -- Dată din trecut
    'Conferință', 
    2000, 
    1000, 
    3, 
    'Planificat'
);
-- Așteptat: Eroare generată de trigger "Data evenimentului trebuie sa fie mai mare decat data curenta"
