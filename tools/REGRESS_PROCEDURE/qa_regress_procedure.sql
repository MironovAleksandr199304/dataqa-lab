create or replace PROCEDURE         QA_REGRES (p_procedure IN varchar2,
                                       v_table_name IN varchar2,
                                       v_backup_name IN varchar2,
                                       p_date IN date,
                                       p_column_list IN COLUMN_LIST
                                       ) 
                                       
                                       --$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                                       --права вызывающего
                                       authid current_user
                                       --$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                                       
                                       AS
                                  l_date_in varchar2(100);
                                  l_sql_backup varchar2(1000);
                                  l_column varchar2(4000) := '';
                                  l_sql varchar2(1000);
                                  v_count number;
                                  l_sql_compare varchar2 (4000);
                                  l_bkp_table_name varchar2(256);
                                  
                                  
--смысл: запуск процедуры, создание бэкапа, сравнение через минус  
    BEGIN
    
    --удаляем старую таблицу бэкап, если она существовала. нужно для ретеста.
    --записываем в переменную l_bkp_table_name название таблицы бэкапа, если она существовала ранее    
    l_date_in:= TO_char(p_date,'dd.mm.yyyy');
    l_date_in:= 'TO_DATE('''||l_date_in||''',''dd.mm.yyyy'')';
    l_sql := 'BEGIN ' || p_procedure || '('||l_date_in||'); END;';
    FOR i IN 1 .. p_column_list.COUNT LOOP
      IF i > 1
        THEN l_column := l_column || ', ';
      END IF;
      l_column := l_column || p_column_list(i);
      END LOOP;
    l_sql_backup := 'CREATE TABLE BACKUP_' || v_table_name || ' AS SELECT ' || l_column ||' FROM ' || v_table_name || ' WHERE repdate = ' || l_date_in;
    l_sql_compare := ' SELECT COUNT (*) FROM (SELECT ' || l_column || ' FROM ' || v_table_name || ' WHERE repdate = :1'  || '
                        MINUS
                      SELECT ' || l_column || ' FROM ' || v_backup_name || ')';
                      
   
    --1) создаем таблицу бэкап, предварительно проверив на наличие старой версии бэкапа
    SELECT MAX(table_name) INTO l_bkp_table_name FROM user_tables WHERE table_name = 'BACKUP_' || upper(v_table_name);
   --падало на 59 строке если не находило таблицу бэкап. Исправил, используя агрегацию
    dbms_output.put_line ('Таблица бэкап найдена : ' || l_bkp_table_name);
    
    --17.01.2025 изменено с all_tables --> user_tables
    --04.02.2025 - переместил присвоение l_bkp_table_name наверх
    --теперь условие, которое проверяет, если бэкап найден был, тогда чистим, а потом вставляем обновленные данные.
    IF l_bkp_table_name IS NULL THEN
    
       EXECUTE IMMEDIATE l_sql_backup;
      
    ELSE
      BEGIN
      EXECUTE IMMEDIATE 'DELETE FROM ' || l_bkp_table_name;
      EXECUTE IMMEDIATE 'INSERT INTO ' || l_bkp_table_name || ' ( ' || l_column || ' ) SELECT ' || l_column || ' FROM ' || v_table_name || ' WHERE repdate = ' || l_date_in ;
      END;
    END IF;   

dbms_output.put_line('Данные в таблице бэкап обновлены');
  
 dbms_output.put_line('Блок с бэкапом завершен.');   
    
       
    
    --2) запускаем процедуру обновления данных после наката изменений
    EXECUTE IMMEDIATE l_sql;
    
        
    dbms_output.put_line(l_sql_compare); --фиксируем, что скрипт сравнения собрался
    
    --3) сравниваем через MINUS значения до изменений и значения после изменений и записываем результат в лог
    EXECUTE IMMEDIATE l_sql_compare INTO v_count using p_date; 
    IF v_count > 0
    THEN
      INSERT INTO qa_regres_log (table_name, check_date, count, result, regres_date) VALUES (v_table_name, p_date, v_count, 'Регрессионное тестирование не пройдено', SYSDATE);
    ELSE
      INSERT INTO qa_regres_log (table_name, check_date, count, result, regres_date) VALUES (v_table_name, p_date, v_count, 'Регрессионное тестирование пройдено', SYSDATE);
    END IF;
    
    dbms_output.put_line ('Запись в журнал занесена.'); --фиксируем вставку записи в журнал
    
END QA_REGRES;