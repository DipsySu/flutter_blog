import 'dart:math';

List<Complex> simpleFFT(List<Complex> samples) {
  int n = samples.length;
  if (n <= 1) return samples;

  List<Complex> evenSamples = [];
  List<Complex> oddSamples = [];
  for (int i = 0; i < n; i++) {
    if (i % 2 == 0) {
      evenSamples.add(samples[i]);
    } else {
      oddSamples.add(samples[i]);
    }
  }

  List<Complex> evenFFT = simpleFFT(evenSamples);
  List<Complex> oddFFT = simpleFFT(oddSamples);

  List<Complex> combinedFFT = List<Complex>.filled(n, Complex(0, 0));
  for (int k = 0; k < n ~/ 2; ++k) {
    double theta = -2 * pi * k / n;
    Complex t = Complex(cos(theta), sin(theta)) * oddFFT[k];
    combinedFFT[k] = evenFFT[k] + t;
    combinedFFT[k + n ~/ 2] = evenFFT[k] - t;
  }
  return combinedFFT;
}

List<Complex> simpleIFFT(List<Complex> samples) {
  int n = samples.length;

  // 对样本取共轭
  List<Complex> conjugateSamples = samples.map((s) => s.conjugate()).toList();

  // 对共轭样本执行 FFT
  List<Complex> conjugateFFT = simpleFFT(conjugateSamples);

  // 对 FFT 结果取共轭并除以 n
  List<Complex> ifft = conjugateFFT.map((s) => s.conjugate() / n.toDouble()).toList();

  return ifft;
}

const int sampleRate = 1000;
const double frequency = 50;
const double noiseFrequency = 250;
const int numSamples = 1024;
List<Complex> generateSignalWithNoise() {
  List<Complex> samples = [];

  for (int i = 0; i < numSamples; i++) {
    double t = i / sampleRate;

    // 生成原始信号
    double signal = sin(2 * pi * frequency * t);

    // 添加噪声
    double noise = 0.3 * sin(2 * pi * noiseFrequency * t);

    samples.add(Complex(signal + noise, 0));
  }

  return samples;
}

double calculateEnergy(List<Complex> signal) {
  return signal.fold(
      0, (double energy, Complex sample) => energy + sample.real * sample.real);
}

testFFT() {
  List<Complex> signalWithNoise = generateSignalWithNoise();
  List<Complex> signalFFT = simpleFFT(signalWithNoise);
  List<Complex> filteredSignalFFT = List<Complex>.from(signalFFT);

// 设计低通滤波器：将高于阈值的频率成分设置为 0
  double thresholdFrequency = 100;
  int thresholdIndex = (thresholdFrequency / (sampleRate / numSamples)).round();

  for (int i = thresholdIndex; i < numSamples - thresholdIndex; i++) {
    filteredSignalFFT[i] = Complex(0, 0);
  }
  List<Complex> filteredSignal = simpleIFFT(filteredSignalFFT);

  List<Complex> originalSignal =
      signalWithNoise.map((s) => Complex(s.real - 0.3, 0)).toList();
  double originalEnergy = calculateEnergy(originalSignal);
  double noisySignalEnergy = calculateEnergy(signalWithNoise);
  double filteredSignalEnergy = calculateEnergy(filteredSignal);

  print('Original signal energy: $originalEnergy');
  print('Noisy signal energy: $noisySignalEnergy');
  print('Filtered signal energy: $filteredSignalEnergy');
}

class Complex {
  final double real;
  final double imaginary;

  Complex(this.real, this.imaginary);

  Complex operator +(Complex other) {
    return Complex(real + other.real, imaginary + other.imaginary);
  }

  Complex operator -(Complex other) {
    return Complex(real - other.real, imaginary - other.imaginary);
  }

  Complex operator *(Complex other) {
    return Complex(real * other.real - imaginary * other.imaginary,
        real * other.imaginary + imaginary * other.real);
  }

  Complex operator /(double scalar) {
    return Complex(real / scalar, imaginary / scalar);
  }

  Complex conjugate() {
    return Complex(real, -imaginary);
  }

  @override
  String toString() {
    return '(${real.toStringAsFixed(2)}, ${imaginary.toStringAsFixed(2)})';
  }
}
