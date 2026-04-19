def call(String message, int times = 1) {
    for (int i = 0; i < times; i++) {
        echo "${i + 1}: ${message}"
    }
}
