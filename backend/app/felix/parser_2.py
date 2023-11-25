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
        print(code_span)
        title_span = li.find('span', class_="titlelabel")
        print(title_span)
        
        if code_span and title_span:
            code = code_span.get_text(strip=True)
            print(code)
            title = title_span.get_text(strip=True)
            print(title)
            results.append({'code': code, 'title': title})

    return results

# Получаем содержимое веб-страницы
html_content = parser("панкреатит")

if html_content:
    soup = BeautifulSoup(html_content, 'html.parser')

    # Записываем содержимое soup в файл
    with open('index1_1.html', 'w', encoding='utf-8') as file:
        file.write(str(soup))

    print("Содержимое soup было записано в файл 'index1_1.html'")

    # Обработка данных непосредственно из HTML-ответа
    root_div = soup.find('div', {'class': 'ygtvchildren', 'id': 'ygtvc1'})
    if root_div:
        labels = root_div.find_all('a', class_='ygtvlabel')
        for label in labels:
            text = label.get_text(strip=True)
            print(text)
else:
    print("Не получилось найти данные.")

# Обработка сохраненных данных из файла
parsed_data = parse_file('index1_1.html')
for data in parsed_data:
    print(f"Номер: {data['code']}, Название: {data['title']}")
