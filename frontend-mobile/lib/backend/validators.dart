abstract class ValidateField {
  bool validatePhoneNumber(String phoneNumber) {
    // Удаляем все символы, кроме цифр
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Проверяем, что длина строки равна 11
    if (digitsOnly.length != 11) {
      return false;
    }

    // Проверяем, что строка начинается со знака "+"
    if (!phoneNumber.startsWith('+')) {
      return false;
    }

    return true;
  }

  bool validateName(String name) {
    // Проверяем, что строка не пустая и имеет длину не меньше 10 символов
    if (name.isEmpty || name.length < 10) {
      return false;
    }
  
    // Проверяем, что в строке нет цифр, знаков пунктуации и спецсимволов
    var exp = RegExp(r'[0-9!"#$%&()*+,-./:;<=>?@\[\\\]^_`{|}~]');
  
    if (exp.hasMatch(name)) {
      return false;
    }
  
    // Проверяем, что в строке есть хотя бы 2 пробела
    if (name.split(' ').length < 3) {
      return false;
    }
  
    // Проверяем, что в строке есть хотя бы одна буква
    if (!RegExp(r'[a-zA-Zа-яА-Я]').hasMatch(name)) {
      return false;
    }
  
    return true;
  }

  bool validateCity(String city) {
      // Проверяем, что строка не пустая и имеет длину не меньше 4 символов
      if (city.isEmpty || city.length < 4) {
        return false;
      }

      // Проверяем, что в строке есть хотя бы одна буква
      if (!RegExp(r'[a-zA-Zа-яА-Я]').hasMatch(city)) {
        return false;
      }

      // Проверяем, что в строке нет цифр, знаков пунктуации и спецсимволов
      if (RegExp(r'[0-9!"#$%&()*+,-./:;<=>?@\[\\\]^_`{|}~]').hasMatch(city)) {
        return false;
      }

    return true;
  }
}