import 'dart:math';

String generateOTP() {
  // Define the range for the 6-digit OTP (100000 to 999999)
  const min = 100000;
  const max = 999999;

  // Create an instance of Random class
  final random = Random();

  // Generate a random number within the defined range
  final otp = min + random.nextInt(max - min);

  // Convert the number to a string and return
  return otp.toString();
}
