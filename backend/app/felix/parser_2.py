from bs4 import BeautifulSoup
import requests as req

# Функция для отправки запроса на сайт
def parser(diagnos):
    response = req.post("https://icd.who.int/browse11/l-m/ru/ACSearch", data={"q": diagnos})
    if response.status_code == 200:
        return response.text
    else:
        return None

# Функция для парсинга одного файла
def parse_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()

    soup = BeautifulSoup(content, 'html.parser')
    results = []

    # Ищем все элементы списка условий
    for li in soup.find_all('li'):
        code_span = li.find('span', class_="")
        title_span = li.find('span', class_="titlelabel")
        
        if code_span and title_span:
            code = code_span.get_text(strip=True)
            title = title_span.get_text(strip=True)
            results.append({'code': code, 'title': title})

    return results

# Функция для обработки пользовательского запроса
def process_user_query(query):
    # Получаем содержимое веб-страницы
    html_content = parser(query)
    
    if html_content:
        soup = BeautifulSoup(html_content, 'html.parser')
    
        # Записываем содержимое soup в файл
        file_name = f"output_{query}.html"
        with open(file_name, 'w', encoding='utf-8') as file:
            file.write(str(soup))

        print(f"Содержимое soup было записано в файл '{file_name}'")

        # Обработка сохраненных данных из файла
        parsed_data = parse_file(file_name)
        for data in parsed_data:
            print(f"Номер: {data['code']}, Название: {data['title']}")
        print(f"!!!-----------------------------!!!\n      Все данные были обработаны.")
    else:
        print(f"Не получилось найти данные по запросу '{query}'.")

# Запрашиваем ввод пользователя
user_input = input("Введите диагноз для поиска: ")
print('---------------------------------------------')
process_user_query(user_input)
