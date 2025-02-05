-- 1. Vizualizarea tuturor evenimentelor împreună cu informațiile clientului și locației
-- Cerință: Afișarea datelor din mai multe tabele utilizând JOIN
SELECT e.tip_eveniment, e.data_eveniment, c.nume || ' ' || c.prenume AS client, l.nume_locatie, e.pret_eveniment
FROM evenimente e
JOIN clienti c ON e.client_id = c.client_id
JOIN loc_ev_fk lef ON e.eveniment_id = lef.eveniment_id
JOIN locatii l ON lef.locatie_id = l.locatie_id;



-- 2. Afișarea colaboratorilor care participă la evenimente și costul serviciilor lor
-- Cerință: Relația între colaboratori și evenimente
SELECT e.tip_eveniment, c.nume || ' ' || c.prenume AS colaborator, cef.pret_colaborator
FROM colaboratori c
JOIN col_ev_fk cef ON c.colaborator_id = cef.colaborator_id
JOIN evenimente e ON cef.eveniment_id = e.eveniment_id;



-- 3. Vizualizarea materialelor realizate pentru fiecare eveniment
-- Cerință: Detalii materiale și evenimente
SELECT e.tip_eveniment, m.nr_fotografii, m.durata_video, m.link_foto, m.link_video
FROM materiale m
JOIN evenimente e ON m.eveniment_id = e.eveniment_id;



-- 4. Calcularea sumei totale câștigate, sumei plătite colaboratorilor și a profitului net
-- Cerință: Sume totale și profit
SELECT 
    SUM(e.pret_eveniment) AS castig_total,
    SUM(cef.pret_colaborator) AS suma_platita_colaboratori,
    (SUM(e.pret_eveniment) - SUM(cef.pret_colaborator)) AS profit_net
FROM evenimente e
LEFT JOIN col_ev_fk cef ON e.eveniment_id = cef.eveniment_id;



-- 5. Vizualizarea detaliilor evenimentelor în funcție de stare
-- Cerință: Filtrarea evenimentelor în funcție de starea lor
SELECT e.tip_eveniment, e.data_eveniment, e.stare, c.nume || ' ' || c.prenume AS client, e.pret_eveniment
FROM evenimente e
JOIN clienti c ON e.client_id = c.client_id
WHERE e.stare = 'Confirmat';



-- 6. Generarea unui raport complet despre evenimente, colaboratori și locații
-- Cerință: O combinație de informații din mai multe tabele
SELECT e.tip_eveniment, 
       e.data_eveniment, 
       c.nume || ' ' || c.prenume AS client, 
       l.nume_locatie, 
       col.nume || ' ' || col.prenume AS colaborator, 
       cef.pret_colaborator, 
       e.pret_eveniment
FROM evenimente e
JOIN clienti c ON e.client_id = c.client_id
-- Folosim LEFT JOIN pentru a include și evenimentele fără locații sau colaboratori
LEFT JOIN loc_ev_fk lef ON e.eveniment_id = lef.eveniment_id
LEFT JOIN locatii l ON lef.locatie_id = l.locatie_id
LEFT JOIN col_ev_fk cef ON e.eveniment_id = cef.eveniment_id
LEFT JOIN colaboratori col ON cef.colaborator_id = col.colaborator_id;
