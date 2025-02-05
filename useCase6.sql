-- Use Case: Listarea Evenimentelor viitoare ale unui Client
-- Scop: Obținerea listei de evenimente viitoare pentru un client specific.
-- Testare: Scriptul verifică existența clientului și selectează evenimentele cu date viitoare.

-- activarea afisarii cu DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

DECLARE
    v_client_id NUMBER; -- Variabilă pentru identificarea clientului
    x_client_id NUMERIC(5);
BEGIN
    x_client_id:=3000;

    -- Verificare existență client
    SELECT COUNT(*) INTO v_client_id
    FROM Clienti 
    WHERE client_id = x_client_id;

    IF v_client_id = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Eroare: Clientul nu există în sistem.');
    END IF;

    -- Selectarea evenimentelor viitoare
    FOR event_rec IN (
        SELECT eveniment_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata
        FROM Evenimente
        WHERE client_id = x_client_id
        AND data_eveniment > SYSDATE
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Eveniment ID: ' || event_rec.eveniment_id || 
                             ', Data: ' || TO_CHAR(event_rec.data_eveniment, 'YYYY-MM-DD HH24:MI:SS') ||
                             ', Tip: ' || event_rec.tip_eveniment ||
                             ', Pret: ' || event_rec.pret_eveniment ||
                             ', Avans: ' || event_rec.avans ||
                             ', Durata: ' || event_rec.durata || ' ore');
    END LOOP;

END;

-- Verificare
/*
SELECT * FROM Evenimente
WHERE client_id = 3000
AND data_eveniment > SYSDATE;
*/
