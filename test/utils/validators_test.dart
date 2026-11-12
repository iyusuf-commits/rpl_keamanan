import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validators.dart';

void main() {
  group('Validators Test', () {
    test('isValidEmail mengembalikan nilai yang benar', () {
      expect(Validators.isValidEmail('test@email.com'), isTrue);
      expect(Validators.isValidEmail('testemail.com'), isFalse);
    });

    test('sanitize menghapus karakter berbahaya (XSS)', () {
      final input = '<script>alert("XSS")</script>';
      final expected = '&lt;script&gt;alert(&quot;XSS&quot;)&lt;/script&gt;';
      expect(Validators.sanitize(input), expected);
    });

    test('validateText menangani berbagai kondisi', () {
      expect(Validators.validateText(null), 'Field tidak boleh kosong');
      expect(Validators.validateText('A', minLength: 2), 'Field harus antara 2-100 karakter');
      expect(Validators.validateText('Aman', minLength: 1), isNull);
    });
  });
}