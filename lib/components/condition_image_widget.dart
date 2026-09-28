import 'package:flutter/material.dart';

class ConditionImageWidget extends StatelessWidget {
  final int weatherCode;
  final bool isNight;

  const ConditionImageWidget({
    super.key,
    required this.weatherCode,
    this.isNight = false,
  });

  static const String _basePath = 'assets';

  String _resolveAsset() {
    final code = weatherCode;

    switch (code) {
    // Ясно / преимущественно ясно (0, 1)
      case 0:
      case 1:
        return '$_basePath/${isNight ? 'clear_n' : 'clear_d'}.png';

    // Переменная облачность (2)
      case 2:
        return '$_basePath/${isNight ? 'cloudy_n' : 'cloudy_d'}.png';

    // Пасмурно (3)
      case 3:
        return '$_basePath/cloudy.png';

    // Туман (45, 48)
      case 45:
      case 48:
        return '$_basePath/${isNight ? 'fog_n' : 'fog_d'}.png';

    // Морось → маленький дождь (51, 53, 55, 56, 57)
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
        return '$_basePath/smallrain.png';

    // Небольшой дождь → маленький (61)
      case 61:
        return '$_basePath/smallrain.png';

    // Умеренный дождь + лёгкий ледяной → средний (63, 66)
      case 63:
      case 66:
        return '$_basePath/bigrain.png';

    // Сильный дождь + сильный ледяной → большой (65, 67)
      case 65:
      case 67:
        return '$_basePath/bigrain.png';

    // Снег, крупа, снегопады (71, 73, 75, 77, 85, 86)
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return '$_basePath/snow.png';

    // Ливни → дождь по интенсивности (80, 81, 82)
      case 80:
        return '$_basePath/smallrain.png';
      case 81:
        return '$_basePath/middlerain.png';
      case 82:
        return '$_basePath/bigrain.png';

    // Грозы (95, 96, 99)
      case 95:
      case 96:
      case 99:
        return '$_basePath/thunderstorm.png';

    // Неизвестный код
      default:
        return '$_basePath/unknown.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final asset = _resolveAsset();

    return Image.asset(
      asset,
      width: 48,
      height: 48,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.help_outline,
        size: 48,
      ),
    );
  }
}