# При значении поля XXX = 'O' поле TSENA_V_RUB не пересчитывается



## Описание:

    - Шаги воспроизведения:
      1) в источнике torp.torgi_torgi поменять значение поля crr на 'O' у одной записи
         (для тестирования была выбрана запись со значениями idtrade = 4234) AND TRUNC(data) = TO_DATE('08.02.2025','dd.mm.yyyy') AND compid = 'RTRT2'
      2) запустить процедуру обновления данных PROCEDURA(TO_DATE('10.02.2025','dd.mm.yyyy'))
      3) Выполнить запрос
        SELECT * FROM table_name WHERE idtrade = 4234 AND TRUNC(data) = TO_DATE('08.02.2025','dd.mm.yyyy') AND compid = 'RTRT2'
        Убедиться, что в поле tsena_v_rub значение расчитано по t1.tsena * nvl(xr1_rate,1),2
      Ожидаемый результат: поле tsena_v_rub рассчитано по t1.tsena * xr1.rate
      Фактический результат: поле tsena_v_rub рассчитано некорректно, вместо t1.tsena * xr1.rate рассчитано по t1.tsena * 1

*Далее были скриншоты, которые я сюда прикладывать конечно же не буду.*

## Анализ ошибки (копипаста из переписки, сообщение от меня разработчикам):

    - на тестовом стенде был проведен анализ. В процедуре PROCEDURA на 424 строке идет джоин
    LEFT JOIN torp.spravochnik xr1 ON xr1.data = t.torgdata AND xr1.curid1 = htc.ascod AND xr1.curid2 = 'RUB'
    я правильно понимаю, что если в таблице spravochnik не будет записей за сб вскр или праздничный день
    то и джоин вернет пустые значения и пересчет валюты не будет учитывать курс, т.е.
    вместо t1.tsena*nvl(xr1_rate,1),2  будет по факту t1.tsena*1
    т.е. для корректной работы получается ON xr1.date = t.torgdata надо поменять на xr1.date = t.repdate?

## Результат:
    - были внесены правки, теорию про возможную причину проблему разработчики подтвердили, проведен ретест и зафиксировано, что поле tsena_v_rub рассчитывается
    корректно с учетом курса.