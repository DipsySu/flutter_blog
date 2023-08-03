// import 'dart:math';
//
// import 'package:complex/complex.dart';
// import 'package:equatable/equatable.dart';
//
// class FilterCoefficients extends Equatable {
//   final List<num> b;
//   final List<num> a;
//
//   FilterCoefficients({required this.b, required this.a});
//
//   @override
//   List<Object?> get props => [b, a];
// }
//
// Complex evaluatePolynomial(List<Complex> polynomial, Complex x) {
//   Complex result = Complex.zero;
//   for (int i = 0; i < polynomial.length; i++) {
//     result += polynomial[i] * x.pow(polynomial.length - i - 1);
//   }
//   return result;
// }
//
// FilterCoefficients butterworthLowpass(
//     int order, num cutoffFrequency, num sampleRate) {
//   num nyquistFrequency = sampleRate / 2;
//   num normalizedCutoff = cutoffFrequency / nyquistFrequency;
//
//   // Calculate the Butterworth filter's poles
//   List<Complex> poles = [];
//   for (int i = 0; i < 2 * order; i++) {
//     double theta = (2 * i + order + 1) * (pi / (2 * order));
//
//     poles.add(Complex.polar(1, theta));
//   }
//
//   // Calculate the coefficients of the transfer function's denominator polynomial
//   List<Complex> denominatorCoefficients = [];
//   for (int i = 0; i < order; i++) {
//     List<Complex> subPoles = poles.sublist(i * 2, i * 2 + 2);
//     List<Complex> subCoefficients = [
//       Complex.one,
//       -subPoles[0] - subPoles[1],
//       subPoles[0] * subPoles[1]
//     ];
//     if (denominatorCoefficients.isEmpty) {
//       denominatorCoefficients = subCoefficients;
//     } else {
//       List<Complex> newDenominatorCoefficients =
//           List.filled(denominatorCoefficients.length + 1, Complex.zero);
//       for (int j = 0; j < newDenominatorCoefficients.length; j++) {
//         Complex sum = Complex.zero;
//         for (int k = 0; k <= j; k++) {
//           if (k < denominatorCoefficients.length &&
//               j - k < subCoefficients.length) {
//             sum += denominatorCoefficients[k] * subCoefficients[j - k];
//           }
//         }
//         newDenominatorCoefficients[j] = sum;
//       }
//       denominatorCoefficients = newDenominatorCoefficients;
//     }
//   }
//
//   // Calculate the gain
//   Complex gain = evaluatePolynomial(denominatorCoefficients, Complex.i);
//   gain = Complex(1 / gain.real, 0);
//
//   // Calculate the coefficients of the transfer function's numerator polynomial
//   List<Complex> numeratorCoefficients = [gain];
//   for (int i = 1; i < denominatorCoefficients.length; i++) {
//     numeratorCoefficients.add(Complex.zero);
//   }
//
//   // Convert the coefficients to real numbers
//   List<num> b = numeratorCoefficients.map((c) => c.real).toList();
//   List<num> a = denominatorCoefficients.map((c) => c.real).toList();
//
//   return FilterCoefficients(b: b, a: a);
// }
