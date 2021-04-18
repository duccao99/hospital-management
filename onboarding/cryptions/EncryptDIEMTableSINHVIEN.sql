CREATE OR REPLACE PROCEDURE Encrypt_SINHVIEN_DIEM
IS
len_tbl_sinhvien INT;
executer NVARCHAR2(1000);
ii INT;
c1 NVARCHAR2(100);

CURSOR c_mssv IS SELECT MSSV FROM SYS.SINHVIEN;
CURSOR c_dtb IS SELECT DTB FROM SYS.SINHVIEN;

TYPE arr_mssv IS VARRAY(100)OF SYS.SINHVIEN.MSSV%TYPE;
TYPE arr_dtb IS VARRAY(100)OF SYS.SINHVIEN.DTB%TYPE;

mssvs arr_mssv:=arr_mssv();
dtbs arr_dtb:=arr_dtb();

counter INTEGER:=0;

input_data INT;
key_string VARCHAR2(200);

encrypted_raw RAW(128);

BEGIN
    --MSSV
   FOR ms IN c_mssv LOOP
    counter:=counter+1;
    mssvs.extend;
    mssvs(counter):=ms.mssv;
   END LOOP;
   
   counter:=0;
   -- DTB
   FOR dd IN c_dtb LOOP
   counter:=counter+1;
   dtbs.extend;
   dtbs(counter):=dd.dtb;
   END LOOP;
   
   
   -- Encrypt
   executer:='SELECT COUNT(*) FROM SYS.SINHVIEN ';
   EXECUTE IMMEDIATE (executer) INTO len_tbl_sinhvien;
   FOR ii IN 1..len_tbl_sinhvien LOOP
   input_data:=  dtbs(ii);
   key_string:='a'|| mssvs(ii);
   
   encrypted_raw := Func_encrypt(input_data,key_string);
    
    executer:='UPDATE SINHVIEN SET DTB = '
    ||rawtohex(UTL_RAW.CAST_TO_RAW(encrypted_raw))
    || 'WHERE MSSV = ' ||mssvs(ii);
    
    EXECUTE IMMEDIATE(executer);
    
   
   -- debug
   -- dbms_output.put_line('Ma hoa thu: '|| ii || ' la : '|| encrypted_raw);

   
   -- debug
   -- dbms_output.put_line('diem thu: '|| ii || ' la : '|| dtbs(ii));
   -- dbms_output.put_line('mssv thu: '|| ii|| 'la: '|| mssvs(ii)); 
   END LOOP;

END Encrypt_SINHVIEN_DIEM;
/