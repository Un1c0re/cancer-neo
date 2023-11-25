import requests
from bs4 import BeautifulSoup

def parse_icd_site(url):
    try:
        # Отправляем запрос на сайт
        response = requests.get(url)
        response.raise_for_status()  # Проверяем, что запрос выполнен успешно

        # Создаём объект BeautifulSoup для анализа HTML
        soup = BeautifulSoup(response.content, 'html.parser')

        div_elements = soup.find_all('div', class_='ygtvitem')
        print(div_elements)
        
        # здесь то чтот парсим
        
        # return 
    except Exception as e:
        return f"Error: {e}"

# Пример использования функции
url = "https://icd.who.int/browse11/l-m/ru"
result = parse_icd_site(url)
print()
