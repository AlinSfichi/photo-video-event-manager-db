
-- Inserarea datelor în tabelul clienti
INSERT INTO clienti (nume, prenume, email, telefon, adresa, alte_detalii)
VALUES ('Popescu', 'Ion', 'ion.popescu@example.com', '0740123456', 'Str. Libertatii, Nr. 10', 'Client fidel');

INSERT INTO clienti (nume, prenume, email, telefon, adresa, alte_detalii)
VALUES ('Ionescu', 'Maria', NULL, '0740987654', 'Str. Pacea, Nr. 15', 'Client nou');

INSERT INTO clienti (nume, prenume, email, telefon, adresa, alte_detalii)
VALUES ('Marinescu', 'Andrei', 'andrei.marinescu@example.com', '0740998877', 'Str. Florilor, Nr. 3', 'Client ocazional');

INSERT INTO clienti (nume, prenume, email, telefon, adresa, alte_detalii)
VALUES ('Stan', 'Elena', 'elena.stan@example.com', '0740887766', 'Str. Primaverii, Nr. 12', 'Client nou');

INSERT INTO clienti (nume, prenume, email, telefon, adresa, alte_detalii)
VALUES ('Munteanu', 'Radu', 'radu.munteanu@example.com', '0740112233', 'Str. Toamnei, Nr. 8', 'Recomandat de alt client');



-- Inserarea datelor în tabelul colaboratori
INSERT INTO colaboratori (nume, prenume, email, telefon, alte_detalii)
VALUES ('Vasilescu', 'George', 'george.vasilescu@example.com', '0740567890', 'Fotograf');

INSERT INTO colaboratori (nume, prenume, email, telefon, alte_detalii)
VALUES ('Dumitrescu', 'Ana', 'ana.dumitrescu@example.com', '0740789564', 'Videograf');

INSERT INTO colaboratori (nume, prenume, email, telefon, alte_detalii)
VALUES ('Iacob', 'Cristina', 'cristina.iacob@example.com', '0740567899', 'Editor');

INSERT INTO colaboratori (nume, prenume, email, telefon, alte_detalii)
VALUES ('Petrescu', 'Ioana', 'ioana.petrescu@example.com', '0740334455', 'Decoratiuni');

INSERT INTO colaboratori (nume, prenume, email, telefon, alte_detalii)
VALUES ('Georgescu', 'Alexandru', 'alex.georgescu@example.com', '0740778899', 'Organizator de evenimente');



-- Inserarea datelor în tabelul evenimente
INSERT INTO evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata, stare, alte_detalii)
VALUES ((SELECT client_id FROM clienti WHERE nume = 'Popescu' AND prenume = 'Ion'), TO_DATE('2027-12-15', 'YYYY-MM-DD'), 'Nunta', 15000, 5000, 8.5, 'Confirmat', 'Pachet premium');

INSERT INTO evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata, stare)
VALUES ((SELECT client_id FROM clienti WHERE nume = 'Popescu' AND prenume = 'Ion'), TO_DATE('2025-02-10', 'YYYY-MM-DD'), 'Petrecere aniversară', 5000, 2000, 5, 'Confirmat');

INSERT INTO evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata, stare)
VALUES ((SELECT client_id FROM clienti WHERE nume = 'Ionescu' AND prenume = 'Maria'), TO_DATE('2025-01-20', 'YYYY-MM-DD'), 'Botez', 8000, 3000, 6, 'In asteptare');

INSERT INTO evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata, stare, alte_detalii)
VALUES ((SELECT client_id FROM clienti WHERE nume = 'Marinescu' AND prenume = 'Andrei'), TO_DATE('2025-03-15', 'YYYY-MM-DD'), 'Cununie civila', 4000, 1000, 3, 'Confirmat', 'Pachet standard');

INSERT INTO evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata, stare, alte_detalii)
VALUES ((SELECT client_id FROM clienti WHERE nume = 'Stan' AND prenume = 'Elena'), TO_DATE('2025-04-10', 'YYYY-MM-DD'), 'Zi de nastere', 6000, 2000, 5, 'In asteptare', 'Pachet complet');

INSERT INTO evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata, stare, alte_detalii)
VALUES ((SELECT client_id FROM clienti WHERE nume = 'Munteanu' AND prenume = 'Radu'), TO_DATE('2025-05-20', 'YYYY-MM-DD'), 'Corporate party', 10000, 5000, 7, 'Confirmat', 'Pachet business');



-- Inserarea datelor în tabelul locatii
INSERT INTO locatii (nume_locatie, adresa, telefon, alte_detalii)
VALUES ('Hotel Central', 'Str. Unirii, Nr. 1', '0212233445', 'Capacitate 200 persoane');

INSERT INTO locatii (nume_locatie, adresa, telefon, alte_detalii)
VALUES ('Casa de Cultura', 'Str. Mihai Eminescu, Nr. 2', '0234234567', 'Capacitate 500 persoane');

INSERT INTO locatii (nume_locatie, adresa, telefon, alte_detalii)
VALUES ('Restaurant Elegance', 'Str. Independentei, Nr. 5', '0234234111', 'Capacitate 100 persoane');

INSERT INTO locatii (nume_locatie, adresa, telefon, alte_detalii)
VALUES ('Club Luna', 'Str. Victoriei, Nr. 18', '0213344556', 'Capacitate 150 persoane');

INSERT INTO locatii (nume_locatie, adresa, telefon, alte_detalii)
VALUES ('Gradina Botanica', 'Str. Botanica, Nr. 1', '0215566778', 'Evenimente in aer liber');



-- Inserarea datelor în tabelul col_ev_fk
INSERT INTO col_ev_fk (eveniment_id, colaborator_id, pret_colaborator)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Nunta' AND data_eveniment = TO_DATE('2027-12-15', 'YYYY-MM-DD')), (SELECT colaborator_id FROM colaboratori WHERE nume = 'Vasilescu' AND prenume = 'George'), 2000);

INSERT INTO col_ev_fk (eveniment_id, colaborator_id, pret_colaborator)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Nunta' AND data_eveniment = TO_DATE('2027-12-15', 'YYYY-MM-DD')), (SELECT colaborator_id FROM colaboratori WHERE nume = 'Dumitrescu' AND prenume = 'Ana'), 1500);

INSERT INTO col_ev_fk (eveniment_id, colaborator_id, pret_colaborator)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Petrecere aniversară' AND data_eveniment = TO_DATE('2025-02-10', 'YYYY-MM-DD')), (SELECT colaborator_id FROM colaboratori WHERE nume = 'Dumitrescu' AND prenume = 'Ana'), 1500);

INSERT INTO col_ev_fk (eveniment_id, colaborator_id, pret_colaborator)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Petrecere aniversară' AND data_eveniment = TO_DATE('2025-02-10', 'YYYY-MM-DD')), (SELECT colaborator_id FROM colaboratori WHERE nume = 'Iacob' AND prenume = 'Cristina'), 1200);

INSERT INTO col_ev_fk (eveniment_id, colaborator_id, pret_colaborator)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Botez' AND data_eveniment = TO_DATE('2025-01-20', 'YYYY-MM-DD')), (SELECT colaborator_id FROM colaboratori WHERE nume = 'Vasilescu' AND prenume = 'George'), 1800);

INSERT INTO col_ev_fk (eveniment_id, colaborator_id, pret_colaborator)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Cununie civila' AND data_eveniment = TO_DATE('2025-03-15', 'YYYY-MM-DD')), (SELECT colaborator_id FROM colaboratori WHERE nume = 'Petrescu' AND prenume = 'Ioana'), 800);

INSERT INTO col_ev_fk (eveniment_id, colaborator_id, pret_colaborator)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Zi de nastere' AND data_eveniment = TO_DATE('2025-04-10', 'YYYY-MM-DD')), (SELECT colaborator_id FROM colaboratori WHERE nume = 'Georgescu' AND prenume = 'Alexandru'), 1200);



-- Inserarea datelor în tabelul loc_ev_fk
INSERT INTO loc_ev_fk (eveniment_id, locatie_id, nr_locatie)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Nunta' AND data_eveniment = TO_DATE('2027-12-15', 'YYYY-MM-DD')), (SELECT locatie_id FROM locatii WHERE nume_locatie = 'Hotel Central'), 1);

INSERT INTO loc_ev_fk (eveniment_id, locatie_id, nr_locatie)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Nunta' AND data_eveniment = TO_DATE('2027-12-15', 'YYYY-MM-DD')), (SELECT locatie_id FROM locatii WHERE nume_locatie = 'Casa de Cultura'), 2);

INSERT INTO loc_ev_fk (eveniment_id, locatie_id, nr_locatie)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Petrecere aniversară' AND data_eveniment = TO_DATE('2025-02-10', 'YYYY-MM-DD')), (SELECT locatie_id FROM locatii WHERE nume_locatie = 'Casa de Cultura'), 1);

INSERT INTO loc_ev_fk (eveniment_id, locatie_id, nr_locatie)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Petrecere aniversară' AND data_eveniment = TO_DATE('2025-02-10', 'YYYY-MM-DD')), (SELECT locatie_id FROM locatii WHERE nume_locatie = 'Restaurant Elegance'), 2);

INSERT INTO loc_ev_fk (eveniment_id, locatie_id, nr_locatie)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Cununie civila' AND data_eveniment = TO_DATE('2025-03-15', 'YYYY-MM-DD')), (SELECT locatie_id FROM locatii WHERE nume_locatie = 'Club Luna'), 1);

INSERT INTO loc_ev_fk (eveniment_id, locatie_id, nr_locatie)
VALUES ((SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Corporate party' AND data_eveniment = TO_DATE('2025-05-20', 'YYYY-MM-DD')), (SELECT locatie_id FROM locatii WHERE nume_locatie = 'Gradina Botanica'), 1);



-- Inserarea datelor în tabelul materiale
INSERT INTO materiale (eveniment_id, nr_fotografii, link_foto, durata_video, link_video, alte_detalii)
VALUES (
    (SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Nunta' AND data_eveniment = TO_DATE('2027-12-15', 'YYYY-MM-DD')),
    250, 
    'http://photos.event1.com', 
    3.5, 
    'http://videos.event1.com', 
    'Editare video inclusa'
);

INSERT INTO materiale (eveniment_id, nr_fotografii, durata_video, alte_detalii)
VALUES (
    (SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Petrecere aniversară' AND data_eveniment = TO_DATE('2025-02-10', 'YYYY-MM-DD')),
    150, 
    2.0, 
    'Editare de baza inclusa'
);

INSERT INTO materiale (eveniment_id, nr_fotografii, durata_video, alte_detalii)
VALUES (
    (SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Botez' AND data_eveniment = TO_DATE('2025-01-20', 'YYYY-MM-DD')),
    300, 
    4.0, 
    'Editare avansata inclusa'
);

INSERT INTO materiale (eveniment_id, nr_fotografii, link_foto, durata_video, link_video, alte_detalii)
VALUES (
    (SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Cununie civila' AND data_eveniment = TO_DATE('2025-03-15', 'YYYY-MM-DD')),
    100, 
    'http://photos.cununie.com', 
    1.5, 
    'http://videos.cununie.com', 
    'Editare simpla inclusa'
);

INSERT INTO materiale (eveniment_id, nr_fotografii, durata_video, alte_detalii)
VALUES (
    (SELECT eveniment_id FROM evenimente WHERE tip_eveniment = 'Corporate party' AND data_eveniment = TO_DATE('2025-05-20', 'YYYY-MM-DD')),
    500, 
    6.0, 
    'Film complet inclus'
);
