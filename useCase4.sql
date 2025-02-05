-- Use Case: Anularea unui Eveniment
-- Scop: Anularea unui eveniment existent, setarea stării la „Anulat” și gestionarea avansului.
-- Testare: Scriptul verifică existența evenimentului și testează constrângerile de consistență.

-- activarea afisarii cu DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

DECLARE
    v_exista_eveniment NUMBER; -- Verificare existență eveniment
    x_eveniment_id NUMERIC(5); 
BEGIN
    -- Atribuire eveniment_id din subinterogare
    SELECT eveniment_id 
    INTO x_eveniment_id
    FROM Evenimente
    WHERE client_id = (
        SELECT client_id 
        FROM Clienti 
        WHERE email = 'andrei.ionescu@example.com'
    )
    AND data_eveniment = TO_DATE('2025-03-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS');
    
    
    SAVEPOINT before;
    
    -- Verificare existență eveniment
    SELECT COUNT(*) INTO v_exista_eveniment
    FROM Evenimente
    WHERE eveniment_id = x_eveniment_id
    AND (stare IS NULL or stare != 'Anulat');

    IF v_exista_eveniment = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Eroare: Evenimentul nu există sau a fost deja anulat.');
    END IF;

    -- Actualizare stare eveniment
    UPDATE Evenimente
    SET stare = 'Anulat', avans = 0
    WHERE eveniment_id = x_eveniment_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Eroare: Anularea evenimentului a eșuat.');
    END IF;

    -- Commit dacă toate operațiunile au fost efectuate cu succes
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('TOTUL A FUNCTIONAT CU SUCCES!');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO before;
        RAISE_APPLICATION_ERROR(-20003, 'A apărut o eroare: ' || SQLERRM);
END;


--verificare
/*
select * from evenimente WHERE 
        client_id = (
        SELECT client_id 
        FROM Clienti 
        WHERE email = 'andrei.ionescu@example.com'
    )
    AND data_eveniment = TO_DATE('2025-03-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS');
*/
