DECLARE
  VAR1 LONG;
  VAR2 VARCHAR2(4000);
  D_TYPE VARCHAR2(100);
  CHAR_USED VARCHAR2(20);
  
  CURSOR C_ALL_TAB_COLUMNS
  IS
  SELECT *
  FROM ALL_TAB_COLUMNS
  WHERE TABLE_NAME = 'D_SCD_HOUSEHOLD'
  ORDER BY COLUMN_ID;
BEGIN
  DBMS_OUTPUT.PUT_LINE('|| ||Field Name||Data Type||MDM Column||Comments||Source Table||Source Field/Logic||');
  FOR R IN C_ALL_TAB_COLUMNS
  LOOP
    VAR2 := SUBSTR(R.DATA_DEFAULT, 1, 4000);
    IF R.DATA_TYPE = 'VARCHAR2' THEN
      D_TYPE := R.DATA_TYPE ||'('||R.CHAR_LENGTH;
      IF R.CHAR_USED = 'C' THEN
        CHAR_USED := 'CHAR';
      ELSIF R.CHAR_USED = 'B' THEN
        CHAR_USED := 'BYTE';
      END IF;
      D_TYPE := D_TYPE || ' ' || CHAR_USED || ')';
      DBMS_OUTPUT.PUT_LINE('|' || R.COLUMN_ID || '|' || R.COLUMN_NAME || '|' || D_TYPE || '|' || ' ' || '|' || ' ' || '|' || ' ' || '|' || REPLACE(REPLACE(NVL(VAR2,' '), '-', '&#45;'), '|', '&#124;') || '|');
    ELSE
      D_TYPE := R.DATA_TYPE;
      DBMS_OUTPUT.PUT_LINE('|' || R.COLUMN_ID || '|' || R.COLUMN_NAME || '|' || D_TYPE || '|' || ' ' || '|' || ' ' || '|' || ' ' || '|' || REPLACE(REPLACE(NVL(VAR2,' '), '-', '&#45;'), '|', '&#124;') || '|');
    END IF;
  END LOOP;
END;
/