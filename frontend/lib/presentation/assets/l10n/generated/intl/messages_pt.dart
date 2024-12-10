// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt';

  static String m0(provider) => "Acessar com ${provider}";

  static String m1(provider) => "Registrar-se com ${provider}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "authGreetingsLogin": MessageLookupByLibrary.simpleMessage(
            "É ótimo ver você de volta novamente!"),
        "authGreetingsSignUp": MessageLookupByLibrary.simpleMessage(
            "Junte-se a nós agora e ouça seu coração bater!"),
        "downloadedMusic": MessageLookupByLibrary.simpleMessage("Baixadas"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailTip":
            MessageLookupByLibrary.simpleMessage("nickname@example.com"),
        "favoriteMusic": MessageLookupByLibrary.simpleMessage("Favoritas"),
        "forgotPwd": MessageLookupByLibrary.simpleMessage("Esqueceu a senha?"),
        "hasAccount":
            MessageLookupByLibrary.simpleMessage("Eu já tenho uma conta!"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Digite um email válido."),
        "invalidForm": MessageLookupByLibrary.simpleMessage(
            "O formulário é inválido! Por favor, verifique os campos."),
        "invalidFormat":
            MessageLookupByLibrary.simpleMessage("Formato inválido."),
        "invalidNumber":
            MessageLookupByLibrary.simpleMessage("Digite um número válido."),
        "invalidPassword":
            MessageLookupByLibrary.simpleMessage("Senha inválida."),
        "listenMusic": MessageLookupByLibrary.simpleMessage("Ouvir músicas"),
        "login": MessageLookupByLibrary.simpleMessage("Acessar"),
        "loginWith": m0,
        "logout": MessageLookupByLibrary.simpleMessage("Sair"),
        "menu": MessageLookupByLibrary.simpleMessage("Menu"),
        "noAccount": MessageLookupByLibrary.simpleMessage("Não tenho conta!"),
        "noResultsFound": MessageLookupByLibrary.simpleMessage(
            "Nenhum resultado encontrado. Tente um termo de busca diferente."),
        "noTitle": MessageLookupByLibrary.simpleMessage("Sem título"),
        "noViews": MessageLookupByLibrary.simpleMessage("Sem visualizações"),
        "password": MessageLookupByLibrary.simpleMessage("Senha"),
        "passwordTip": MessageLookupByLibrary.simpleMessage(
            "8+ caracteres, 1 maiúscula, 1 minúscula, 1 número, 1 símbolo (@, #, \$)."),
        "requiredField":
            MessageLookupByLibrary.simpleMessage("Este campo é obrigatório."),
        "search": MessageLookupByLibrary.simpleMessage("Procurar"),
        "searchBarPhrase":
            MessageLookupByLibrary.simpleMessage("Procure músicas aqui..."),
        "searchErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Ocorreu um erro ao buscar. Tente novamente mais tarde."),
        "selectedLanguage": MessageLookupByLibrary.simpleMessage("Idioma"),
        "signUp": MessageLookupByLibrary.simpleMessage("Registrar-se"),
        "signUpWith": m1,
        "unknowErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Ocorreu um erro. Por favor, tente novamente mais tarde."),
        "unknownChannel":
            MessageLookupByLibrary.simpleMessage("Canal desconhecido"),
        "unknownDuration":
            MessageLookupByLibrary.simpleMessage("Duração desconhecida")
      };
}
