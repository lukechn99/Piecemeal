import 'package:flutter_braintree/flutter_braintree.dart';

// see https://pub.dev/packages/flutter_braintree
class Payment {
  Future<void> processCard(
      String _cardNumber, String exMonth, String exYear, String _cvv) async {
    final request = BraintreeCreditCardRequest(
        cardNumber: _cardNumber, // example: '4111111111111111'
        expirationMonth: exMonth, // example: '12'
        expirationYear: exYear, // example: '2021'
        cvv: _cvv); // example: '367'
    BraintreePaymentMethodNonce result = await Braintree.tokenizeCreditCard(
      '<Insert your tokenization key or client token here>',
      request,
    );
    print(result.nonce);
  }

  Future<void> processPayPal(String _amount) async {
    final request = BraintreePayPalRequest(amount: _amount); // example: '13.37'
    BraintreePaymentMethodNonce result = await Braintree.requestPaypalNonce(
      '<Insert your tokenization key or client token here>',
      request,
    );
    if (result != null) {
      print('Nonce: ${result.nonce}');
    } else {
      print('PayPal flow was canceled.');
    }
  }
}
