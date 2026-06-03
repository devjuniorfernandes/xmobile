# x_mobile

Um aplicativo Flutter modular e baseado em features, usado como base
para desenvolvimento móvel, web e desktop.

## Índice

- Visão geral
- Pré-requisitos
- Instruções rápidas (rodar, construir)
- Estrutura do projeto
- Arquitetura e convenções
- Testes
- Contribuindo
- Arquivos importantes

## Visão geral

`x_mobile` é um template/projeto Flutter organizado por features e com
separação clara entre camadas (`core`, `data`, `features`). Serve como
ponto de partida para aplicações móveis (Android/iOS), web e desktop.

## Pré-requisitos

- Flutter SDK (compatível com a versão especificada em [pubspec.yaml](pubspec.yaml)).
- Android Studio / Xcode (para emuladores e builds de plataforma).
- Ferramentas opcionais: Visual Studio Code, Chrome (para web).

## Instalação e execução (rápido)

1. Clone o repositório:

```
git clone <repo-url>
cd xmobile
```

2. Instale dependências:

```
flutter pub get
```

3. Rodar em modo de desenvolvimento:

- Android (emulador ou dispositivo conectado):

```
flutter run -d android
```

- iOS (macOS com Xcode instalado):

```
flutter run -d ios
```

- Web (Chrome):

```
flutter run -d chrome
```

## Builds de release

- Android (APK):

```
flutter build apk --release
```

- Android (App Bundle):

```
flutter build appbundle --release
```

- iOS (release, via Xcode ou CLI):

```
flutter build ios --release
```

## Estrutura do projeto

Principais diretórios e arquivos:

- `lib/` – código-fonte principal.
  - `main.dart` – ponto de entrada do app ([lib/main.dart](lib/main.dart)).
  - `core/` – utilitários, constantes, tema, roteamento e storage.
  - `data/` – modelos, repositórios e serviços de acesso a dados.
  - `features/` – implementação por feature (ex.: `auth`, `dashboard`, `profile`).
  - `widgets/` – componentes reutilizáveis.
- `assets/` – imagens, fontes e outros recursos estáticos.
- `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` – código específico de plataforma.
- `pubspec.yaml` – dependências, assets e metadados do projeto ([pubspec.yaml](pubspec.yaml)).

## Arquitetura e convenções

O projeto segue uma organização feature-first com separação de camadas:

- Camada de apresentação: widgets e telas dentro de cada feature.
- Camada de domínio/serviços: casos de uso e serviços reutilizáveis.
- Camada de dados: repositórios, fontes remotas (APIs) e locais (storage).

Regras comuns:

- Coloque código compartilhado no `core/`.
- Cada feature tem seu próprio subdiretório em `features/`.
- Prefira injeção de dependências via construtores para facilitar testes.

## Dependências importantes

Verifique [pubspec.yaml](pubspec.yaml) para a lista atualizada. Exemplos
de pacotes comumente usados aqui: `http`, `dio`, `provider`/`riverpod`,
`flutter_localizations`, `intl`, `sqflite`/`hive`, `flutter_secure_storage`.

## Testes

Executar testes unitários e de widget:

```
flutter test
```

Para testes de integração, use o framework de integração do Flutter
ou ferramentas específicas (ver diretório `test/`).

## Depuração e análise

- Analisar código e problemas:

```
flutter analyze
```

- Ver alertas de performance e inspeção:

```
flutter pub global activate devtools
flutter pub global run devtools
```

## Contribuindo

- Fork e clone o repositório.
- Crie uma branch com descrição clara: `feature/descricao` ou `fix/issue`.
- Abra um Pull Request com descrição das alterações e passos para testar.

## Problemas comuns e soluções rápidas

- Erro de dependências: rode `flutter pub get` e `flutter clean`.
- Problemas no iOS: abra `ios/Runner.xcworkspace` no Xcode e atualize
  pods com `pod install` em `ios/`.
- Emulsor Android travando: recrie o AVD ou reinicie o adb:

```
adb kill-server && adb start-server
```

## Arquivos importantes

- Ponto de entrada: [lib/main.dart](lib/main.dart)
- Dependências: [pubspec.yaml](pubspec.yaml)
- Configurações Android: `android/` (gradle, manifest)
- Configurações iOS: `ios/` (Xcode project, Info.plist)

## Próximos passos sugeridos

- Atualizar este README com informações de CI/CD (GitHub Actions, Fastlane).
- Documentar convenções de commit e estilo de código.

## Licença

Especifique a licença do projeto aqui (ex.: MIT). Se quiser, posso
adicionar um arquivo `LICENSE` com o texto apropriado.

## Contato

Para dúvidas ou contribuições, abra uma issue ou PR no repositório.

---

Arquivo atualizado: veja [README.md](README.md) para este conteúdo.
