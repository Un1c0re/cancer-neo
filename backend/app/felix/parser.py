from bs4 import BeautifulSoup

def parse_local_html(file_path):
    try:
        # Открываем файл для чтения (в режиме текста)
        with open(file_path, 'r', encoding='utf-8') as file:
            # Читаем содержимое файла
            html_content = file.read()

        # Создаем объект BeautifulSoup
        soup = BeautifulSoup(html_content, 'html.parser')

        # Теперь можно парсить soup так же, как и при запросах через requests
        # Например, найдем все элементы с определенным классом
        elements = soup.find_all('div', class_='ygtvitem')
        for element in elements:
            print(element.text)

        # Возвращаем результаты
        return elements
    except Exception as e:
        print(f"Error: {e}")

# Путь к вашему HTML файлу
file_path = 'index.html'

# Вызываем функцию
parse_local_html(file_path)
