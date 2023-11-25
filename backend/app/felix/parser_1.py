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
items = root_div.find_all('a', class_='ygtvlabel')
# print(items)

# Извлекаем информацию из каждого элемента
for item in items:
    text = item.get_text(strip=True)
    print(text)
