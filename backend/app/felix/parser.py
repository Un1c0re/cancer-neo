from bs4 import BeautifulSoup

# Здесь предполагается, что html_content - это ваш HTML-код, который вы загрузили

file_path = "index.html"

with open(file_path, 'r', encoding='utf-8') as file:
            # Читаем содержимое файла
            html_content = file.read()

soup = BeautifulSoup(html_content, 'html.parser')
# print(soup)

# Находим корневой div
root_div = soup.find('div', {'class': 'ygtvchildren', 'id': 'ygtvc1'})
# print(root_div)
# Находим все вложенные div с классом ygtvitem
items = root_div.find_all('div', class_='ygtvitem')
print(items)

# Извлекаем информацию из каждого элемента
for item in items:
    # Находим внутренний div с текстовой информацией
    text_div = item.find('div', class_='ygtvcontent')
    if text_div:
        # Извлекаем текст, удаляя лишние пробелы
        text = text_div.get_text(strip=True)
        # Дополнительно обрабатываем текст, если это необходимо
        text = text.replace('\n', ' ').replace('\r', ' ').strip()
        print(text)
