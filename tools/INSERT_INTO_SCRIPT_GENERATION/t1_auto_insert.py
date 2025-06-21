import random, string
# Генерация случайного числа с указанной точностью
def random_number(max_digits, decimal_places):
    return round(random.uniform(0, 10 ** (max_digits - decimal_places)), decimal_places)
#Генерация случайного текстового значения
def random_string(length):
   letters = string.ascii_lowercase
   return ''.join(random.choice(letters) for i in range(length))
# Генерация случайного значения для столбца
def generate_value(column_name):
    if column_name in ["tdate1","sdate1"]:
        return "TO_DATE('03.03.2025', 'dd.mm.yyyy')"
    elif column_name in ["tsdate1"]:
        return "TO_DATE('03.03.2025','dd.mm.yyyy')"
    elif column_name == "tp":
        return "'W'"
    elif column_name == "tno":
        return 9999999
    elif column_name == "bll":
        return "'B'"
    elif column_name == "buid":
        return "'LOAZ'"
    elif column_name == "sic":
        return "'OO'"
    elif column_name == "sat":
        return "'A'"
    elif column_name == "cifid":
        return "'FAXXX'"
    elif column_name == "pecc":
        return 15000
    elif column_name == "atou":
        return 15000
    elif column_name == "ainci":
        return random_number(16,2)
    elif column_name == "comrcco":
        return random_number(16,2)
    elif column_name == "qytiaa":
        return random_number(16,0)
    elif column_name == "coeeid":
        return random_number(16,0)
    elif column_name == "rikbenc":
        return f"'{random.choice(['VAR1', 'VAR2', 'VAR3', 'VAR4'])}'"
    elif column_name == "rarepo":
        return random_number(16,0)
    elif column_name == "osxx":
        return "'Y'"
    elif column_name == "kacciera":
        return "'ZHHJ'"
    elif column_name == "traecpe":
        return "'G'"

# Генерация данных вставки
def auto_insert(table_name, columns, num_rows, file):
    file.write(f"-- Insert into {table_name}\n")
    for _ in range(num_rows):
        values = [generate_value(col) for col in columns]
        insert_statement = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({', '.join(map(str, values))});\n COMMIT; \n"
        file.write(insert_statement)
    file.write("\n")
# Параметры таблицы
tables = {
    "FAKE.FAKE_TABLE":
    [
        "tp","tno","bll","buid","sic","cifid","pecc","atou","ainci",
    "sdate1","comrcco","tdate1","qytiaa","coeeid","rikbenc","rarepo","osxx",
    "kacciera","tsdate1", "traecpe", "sat"
    ]
}

file_name = "FAXXX_insert.sql"

# Запуск генерации SQL-файлов
with open(file_name, "w", encoding="utf-8") as f:
    for table_name, columns in tables.items():
        num_rows = 1
        print(f"Генерация SQL для {table_name} началась...")
        auto_insert(table_name, columns, num_rows, f)
        print(f"Генерация SQL для {table_name} завершена.")

print(f"Файл создан: {file_name}")