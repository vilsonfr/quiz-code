// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_code/chave.dart';
import 'package:quiz_code/contants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:quiz_code/firebaseManager.dart';
import 'package:quiz_code/main.dart';
import 'package:quiz_code/usuarioModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  final TextEditingController _setorController = TextEditingController();

  // format celular
  final maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####', //formato do celular com 9 digitos e 8 digitos
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  //2cx
  var listSetor = ["Menos de 50", "50-250", "250-500", "Mais de 500"];
  var listCargo = [
    "CIO",
    "CTO",
    "Diretor de Atendimento/Relacionamento",
    "Diretor de Marketing",
    "Relacionamento",
    "Gerente de Marketing",
    "Gerente de TI",
    "Coordenador de Atendimento/Relacionamento",
    "Analista de Negócios",
    "Analista Operacional",
    "Analista de Marketing",
    "Analista de Planejamento",
    "Supervisor",
    "Estagiário/Estudante",
  ];
  //lista de dominios proibidos, preciso somente dominios de empresas
  var listDominiosProibidos = [
    "gmail.com",
    "hotmail.com",
    "yahoo.com",
    "outlook.com",
    "live.com",
    "msn.com",
    "bol.com.br",
    "terra.com.br",
    "ig.com.br",
    "globo.com",
  ];
  @override
  void initState() {
    super.initState();
    // _cargoController.text = listCargo[0];
    // _setorController.text = listSetor[0];
  }

  /*<select name="cargo" id="ff_6_cargo" class="ff-el-form-control" data-name="cargo" data-calc_value="0" aria-invalid="false" aria-required="false"><option value="">- Selecione -</option><option value="CIO">CIO</option><option value="CTO">CTO</option><option value="Diretor de Atendimento/Relacionamento">Diretor de Atendimento/Relacionamento</option><option value="Diretor de Marketing">Diretor de Marketing</option><option value="Relacionamento">Relacionamento</option><option value="Gerente de Marketing">Gerente de Marketing</option><option value="Gerente de TI">Gerente de TI</option><option value="Coordenador de Atendimento/Relacionamento">Coordenador de Atendimento/Relacionamento</option><option value="Analista de Negócios">Analista de Negócios</option><option value="Analista Operacional">Analista Operacional</option><option value="Analista de Marketing">Analista de Marketing</option><option value="Analista de Planejamento">Analista de Planejamento</option><option value="Supervisor">Supervisor</option><option value="Estagiário/Estudante">Estagiário/Estudante</option></select> */
  @override
  void dispose() {
    _celularController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    _cargoController.dispose();
    _setorController.dispose();
    super.dispose();
  }

  Color colorTermo = Colors.white;

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          //imagem de fundo from assets/Fundo.png
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Fundo.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 50),
                          Image.asset('assets/LOGO_01.png', height: 40),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Text(
                                'Registro',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                  fontFamily: "Helvetica",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Preencha todos os dados. Você vai receber a chave para ter acesso ao Sorteio de brindes!',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 45),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                _buildField(
                                  controller: _celularController,
                                  inputFormatters: [maskFormatter],
                                  label: 'Celular',
                                  hint: 'Digite seu celular',
                                  icon: Icons.phone,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Campo obrigatório'
                                      : isTelefoneValid(value)
                                      ? null
                                      : 'Telefone inválido. Insira um telefone válido!',
                                  onSaved: (value) =>
                                      _celularController.text = value ?? '',
                                ),
                                const SizedBox(height: 18),
                                _buildField(
                                  controller: _nomeController,
                                  label: 'Nome completo',
                                  hint: 'Digite seu nome completo',
                                  icon: Icons.person,
                                  keyboardType: TextInputType.name,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Campo obrigatório'
                                      : null,
                                  onSaved: (value) =>
                                      _nomeController.text = value ?? '',
                                ),
                                const SizedBox(height: 18),
                                _buildField(
                                  controller: _emailController,
                                  label: 'Email',
                                  hint: 'Digite seu email',
                                  keyboardType: TextInputType.emailAddress,
                                  icon: Icons.email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo obrigatório';
                                    }
                                    if (!isEmailValid(value)) {
                                      return 'Email inválido. Insira um email válido!';
                                    }
                                    if (listDominiosProibidos.any(
                                      (dominio) => value.endsWith(dominio),
                                    )) {
                                      return 'Email inválido. Insira um email corporativo!';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) =>
                                      _emailController.text = value ?? '',
                                ),
                                const SizedBox(height: 18),
                                //dropdown setor
                                DropdownButtonFormField(
                                  onChanged: (value) =>
                                      _setorController.text = value ?? '',

                                  //obrigatorio
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Campo obrigatório'
                                      : null,
                                  items: listSetor.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  selectedItemBuilder: (context) {
                                    return listSetor.map((item) {
                                      //caso o texto ja grande, colocar ...
                                      if (item.length > 20) {
                                        return Text(
                                          '${item.substring(0, 20)}...',
                                          style: const TextStyle(
                                            color: primaryColor,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          item,
                                          style: const TextStyle(
                                            color: primaryColor,
                                          ),
                                        );
                                      }
                                    }).toList();
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: primaryColor,
                                  ),
                                  hint: Text(
                                    'Selecione seu setor',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Setor',
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    hintText: 'Selecione seu setor',
                                    hintStyle: const TextStyle(
                                      color: primaryColor,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.work,
                                      color: primaryColor,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,

                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                //dropdown cargo
                                DropdownButtonFormField(
                                  onChanged: (value) =>
                                      _cargoController.text = value ?? '',

                                  //obrigatorio
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Campo obrigatório'
                                      : null,
                                  items: listCargo.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),

                                  selectedItemBuilder: (context) {
                                    return listCargo.map((item) {
                                      //caso o texto ja grande, colocar ...
                                      if (item.length > 20) {
                                        return Text(
                                          '${item.substring(0, 20)}...',
                                          style: const TextStyle(
                                            color: primaryColor,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          item,
                                          style: const TextStyle(
                                            color: primaryColor,
                                          ),
                                        );
                                      }
                                    }).toList();
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: primaryColor,
                                  ),
                                  hint: Text(
                                    'Selecione seu cargo',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Cargo',
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    hintStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.work,
                                      color: primaryColor,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,

                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 42),

                                //botao  imagem background  assets/TELA02/botao_02.png
                                InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      salvarUsuario(context);
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/TELA02/botao_02.png',
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    //event click
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text.rich(
                                  textAlign: TextAlign.center,

                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Ao registrar, você concorda com nossos',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 14,
                                          fontFamily: "Helvetica",
                                        ),
                                      ),
                                      TextSpan(text: ' '),
                                      TextSpan(
                                        text: 'Termos de Serviço',
                                        style: TextStyle(
                                            color: colorTermo,
                                          fontSize: 14,
                                          fontFamily: "Helvetica",
                                        ),
                                        onEnter: (details) {
                                          //alterar efeito mouse over
                                          setState(() {
                                            colorTermo = Colors.white54;
                                          });
                                        },
                                        onExit: (details) {
                                          //alterar efeito mouse over
                                          setState(() {
                                            colorTermo = Colors.white;
                                          });
                                        },
                                        //list
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            //abrir url
                                            launchUrl(
                                                Uri.parse(
                                                    'https://www.google.com'));
                                          },  
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // logo alamidia fixed in bottom, independente do tamanho da tela
              Container(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: Image(
                    width: double.infinity,
                    height: 100,
                    image: AssetImage('assets/ALAMIDIA_LOGO.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Adicione este método dentro do _RegisterPageState:
  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
    List<TextInputFormatter>? inputFormatters,
  }) {
    //deixar menor a altura do input
    return TextFormField(
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      style: const TextStyle(color: primaryColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: primaryColor),
        filled: true,
        fillColor: Colors.white10,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }

  //verificar se o email é valido
  bool isEmailValid(String email) {
    // Validações básicas
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      debugPrint('isValido: false email: $email (validações básicas falharam)');
      return false;
    }
    
    // Verificar se não começa ou termina com pontos
    if (email.startsWith('.') || email.endsWith('.') || email.startsWith('@') || email.endsWith('@')) {
      debugPrint('isValido: false email: $email (começa ou termina com caracteres inválidos)');
      return false;
    }
    
    // Verificar se tem apenas um @
    if (email.split('@').length != 2) {
      debugPrint('isValido: false email: $email (múltiplos @ ou nenhum @)');
      return false;
    }
    
    // Separar local part e domain
    final parts = email.split('@');
    final localPart = parts[0];
    final domain = parts[1];
    
    // Verificar local part
    if (localPart.isEmpty || localPart.length > 64) {
      debugPrint('isValido: false email: $email (local part inválido)');
      return false;
    }
    
    // Verificar se local part não tem caracteres consecutivos inválidos
    if (localPart.contains('..') || localPart.contains('.-') || localPart.contains('._')) {
      debugPrint('isValido: false email: $email (caracteres consecutivos inválidos no local part)');
      return false;
    }
    
    // Verificar domain
    if (domain.isEmpty || !domain.contains('.')) {
      debugPrint('isValido: false email: $email (domain inválido)');
      return false;
    }
    
    // Verificar se domain não tem pontos consecutivos
    if (domain.contains('..')) {
      debugPrint('isValido: false email: $email (pontos consecutivos no domain)');
      return false;
    }
    
    // Verificar se o TLD tem pelo menos 2 caracteres
    final tld = domain.split('.').last;
    if (tld.length < 2) {
      debugPrint('isValido: false email: $email (TLD muito curto)');
      return false;
    }
    
    // Regex final para validação completa
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9]([a-zA-Z0-9._-]*[a-zA-Z0-9])?@[a-zA-Z0-9]([a-zA-Z0-9.-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$'
    );
    var isValido = emailRegex.hasMatch(email);
    debugPrint('isValido: $isValido email: $email');
    return isValido;
  }

  //verifica telefone
  bool isTelefoneValid(String telefone) {
    //remover todos os caracteres nao numericos
    var telefoneLimpo = telefone.replaceAll(RegExp(r'[^0-9]'), '');
    //verificar se o telefone tem 11 digitos
    return telefoneLimpo.length >= 10;
  }

  int count = 0;
  Future<void> salvarUsuario(BuildContext context) async {
    //gerar codigo
    count++;
    if (count > 20) {
      //show alert
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Atenção'),
          content: Text('Não foi possível gerar um código único'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }

    //verificar se o usuario ja criou um codigo com o email
    var usuarioExiste = await FirebaseManager().verificarUsuario(
        _emailController.text);
    if (usuarioExiste) {
      //show alert
      showDialog(context: context, builder: (context) => AlertDialog(title: Text('Atenção'),
       content: Text('Você já criou um código com este email'), 
       actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Ok'))],),);
      return;
    }

    var codigo = await FirebaseManager().generateUniqueCode();
    //verificar se o codigo ja existe no firebase, caso exista, gerar outro codigo, recursivamente até que o codigo nao exista por 20 vezes
    var codigoExiste = await FirebaseManager().verificarCodigo(codigo);
    if (codigoExiste) {
      //gerar outro codigo
      codigo = await FirebaseManager().generateUniqueCode();
      //recursivamente até que o codigo nao exista por 20 vezes
      salvarUsuario(context);
    } else {
      //salvar o usuario no firebase
      usuario = Usuario(
        codigo: codigo,
        nome: _nomeController.text,
        email: _emailController.text,
        cargo: _cargoController.text,
        setor: _setorController.text,
        uid: '',
        createdAt: DateTime.now().toIso8601String(),
        deviceType: deviceType,
      );
      var saved = await FirebaseManager().saveUsuarioToFirebase(usuario!);
      if (saved) {
        count = 0;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Código criado com sucesso!'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            showCloseIcon: true,
          ),
        );
        //show alert
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChavePage(title: 'Chave', chave: codigo.toString()),
          ),
        );
      } else {
        //show toast
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Não foi possível criar o código, tente novamente mais tarde.',
            ),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            showCloseIcon: true,
          ),
        );
      }
    }
  }
}
