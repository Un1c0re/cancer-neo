bool isPdf(String path) {
    return path.toLowerCase().endsWith('.pdf');
  }

  bool isImage(String path) {
    return path.toLowerCase().endsWith('.png') ||
           path.toLowerCase().endsWith('.jpg') ||
           path.toLowerCase().endsWith('.jpeg');
  }