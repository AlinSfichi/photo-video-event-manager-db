-- Use Case: Calcularea Venitului Total din Evenimente
-- Scop: Calcularea veniturilor totale generate de evenimente într-o anumită perioadă.
-- Testare: Scriptul selectează și calculează suma veniturilor din tabelul Evenimente.

-- activarea afisarii cu DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

DECLARE
    v_venit_total NUMBER; -- Variabilă pentru stocarea venitului total
    v_data_inceput DATE := TO_DATE('2025-01-01', 'YYYY-MM-DD'); -- Data de început a perioadei
    v_data_sfarsit DATE := TO_DATE('2025-12-31', 'YYYY-MM-DD'); -- Data de sfârșit a perioadei
BEGIN
    -- Calcularea venitului total
    SELECT SUM(pret_eveniment) INTO v_venit_total
    FROM Evenimente
    WHERE data_eveniment BETWEEN v_data_inceput AND v_data_sfarsit;

    DBMS_OUTPUT.PUT_LINE('Venitul total din evenimente între ' || TO_CHAR(v_data_inceput, 'YYYY-MM-DD') || 
                         ' și ' || TO_CHAR(v_data_sfarsit, 'YYYY-MM-DD') || ' este: ' || v_venit_total);

END;

-- Verificare
/*
SELECT SUM(pret_eveniment) AS Venit_Total
FROM Evenimente
WHERE data_eveniment BETWEEN TO_DATE('2025-01-01', 'YYYY-MM-DD') AND TO_DATE('2025-12-31', 'YYYY-MM-DD');
*/
