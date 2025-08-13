# Configuração de Variáveis de Ambiente

Este projeto usa variáveis de ambiente apenas para a versão web, mantendo as credenciais hardcoded para mobile (onde é seguro).

## Configuração

### Para Web (Firebase Hosting):

1. **Copie o arquivo de exemplo:**
   ```bash
   cp .env.example .env
   ```

2. **Edite o arquivo `.env` com suas credenciais reais:**
   ```env
   FIREBASE_EMAIL=seu_email@gmail.com
   FIREBASE_PASSWORD=sua_senha_aqui
   ```

3. **Para deploy no Firebase Hosting:**
   ```bash
   flutter build web
   firebase deploy
   ```

### Para Mobile (Android/iOS):

Não é necessário configurar nada! As credenciais estão hardcoded no código, o que é seguro porque:
- O código compilado não pode ser acessado pelos usuários
- As credenciais ficam protegidas dentro do APK/IPA

## Segurança

- ✅ **Web**: Credenciais no arquivo `.env` (não commitado)
- ✅ **Mobile**: Credenciais hardcoded (seguro pois ninguém tem acesso)
- ✅ O arquivo `.env` está no `.gitignore` e não será commitado
- ✅ O arquivo `.env.example` serve como template

## Como Funciona

### Web:
- Carrega credenciais do arquivo `.env` usando `flutter_dotenv`
- Arquivo `.env` é carregado apenas na web

### Mobile:
- Usa valores hardcoded diretamente no código
- Não carrega arquivo `.env` (não necessário)

## Estrutura dos Arquivos

- `.env` - Arquivo com credenciais reais (apenas para web, não commitado)
- `.env.example` - Template para configuração web
- `lib/config/env_config.dart` - Classe que gerencia as credenciais por plataforma
- `lib/main.dart` - Uso das variáveis de ambiente

## Uso no Código

```dart
import 'package:quiz_code/config/env_config.dart';

// Acessar credenciais (funciona automaticamente em todas as plataformas)
String email = EnvConfig.firebaseEmail;
String password = EnvConfig.firebasePassword;

// Verificar se as credenciais estão configuradas
if (EnvConfig.hasValidCredentials) {
  // Fazer login
} else {
  // Tratar erro
}
```

## Deploy

### Web (Firebase Hosting):
```bash
# 1. Configure o .env com suas credenciais
# 2. Build e deploy
flutter build web
firebase deploy
```

### Mobile:
```bash
# Build normal, sem configuração adicional
flutter build apk  # Android
flutter build ios  # iOS
```

## Importante

- Para web: Nunca commite o arquivo `.env` com credenciais reais
- Para mobile: As credenciais hardcoded são seguras
- Use sempre `EnvConfig` para acessar as credenciais
- O arquivo `.env` só é usado na web 