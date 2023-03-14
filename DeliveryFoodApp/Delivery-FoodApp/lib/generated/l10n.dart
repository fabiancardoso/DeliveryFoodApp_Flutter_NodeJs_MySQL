// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Welcome`
  String get bienvenido {
    return Intl.message(
      'Welcome',
      name: 'bienvenido',
      desc: '',
      args: [],
    );
  }

  /// `Seen lately`
  String get vistosUltimamente {
    return Intl.message(
      'Seen lately',
      name: 'vistosUltimamente',
      desc: '',
      args: [],
    );
  }

  /// `Most viewed products`
  String get productosMasVistos {
    return Intl.message(
      'Most viewed products',
      name: 'productosMasVistos',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get ofertas {
    return Intl.message(
      'Offers',
      name: 'ofertas',
      desc: '',
      args: [],
    );
  }

  /// `My data`
  String get misDatos {
    return Intl.message(
      'My data',
      name: 'misDatos',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get direccion {
    return Intl.message(
      'Address',
      name: 'direccion',
      desc: '',
      args: [],
    );
  }

  /// `Sign off`
  String get cerrarSesion {
    return Intl.message(
      'Sign off',
      name: 'cerrarSesion',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get correo {
    return Intl.message(
      'Email',
      name: 'correo',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nombre {
    return Intl.message(
      'Name',
      name: 'nombre',
      desc: '',
      args: [],
    );
  }

  /// `Lastname`
  String get apellido {
    return Intl.message(
      'Lastname',
      name: 'apellido',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get nombreDeUsuario {
    return Intl.message(
      'Username',
      name: 'nombreDeUsuario',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get contrasenia {
    return Intl.message(
      'Password',
      name: 'contrasenia',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmarContrasenia {
    return Intl.message(
      'Confirm password',
      name: 'confirmarContrasenia',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get cambiar {
    return Intl.message(
      'Change',
      name: 'cambiar',
      desc: '',
      args: [],
    );
  }

  /// `My profile`
  String get miPerfil {
    return Intl.message(
      'My profile',
      name: 'miPerfil',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get misPedidos {
    return Intl.message(
      'My Orders',
      name: 'misPedidos',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delivery`
  String get confirmarEntrega {
    return Intl.message(
      'Confirm delivery',
      name: 'confirmarEntrega',
      desc: '',
      args: [],
    );
  }

  /// `To confirm`
  String get aConfirmar {
    return Intl.message(
      'To confirm',
      name: 'aConfirmar',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get cantidad {
    return Intl.message(
      'Amount',
      name: 'cantidad',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categorias {
    return Intl.message(
      'Categories',
      name: 'categorias',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get comprar {
    return Intl.message(
      'Buy',
      name: 'comprar',
      desc: '',
      args: [],
    );
  }

  /// `My address`
  String get miDireccion {
    return Intl.message(
      'My address',
      name: 'miDireccion',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get producto {
    return Intl.message(
      'Product',
      name: 'producto',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
