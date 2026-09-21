import 'package:flutter/material.dart';

void main() {
  runApp(const TradutorApp());
}

class TradutorApp extends StatelessWidget {
  const TradutorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tradutor top do Destro',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F8FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7AA7D9),
          brightness: Brightness.light,
        ),
      ),
      home: const TradutorPage(),
    );
  }
}

class Palavra {
  final String portugues;
  final String ingles;
  final String japones;

  const Palavra({
    required this.portugues,
    required this.ingles,
    required this.japones,
  });
}

class TradutorPage extends StatefulWidget {
  const TradutorPage({super.key});

  @override
  State<TradutorPage> createState() => _TradutorPageState();
}

class _TradutorPageState extends State<TradutorPage> {
  final List<Palavra> palavras = const [
    Palavra(
      portugues: 'Apostar',
      ingles: 'Bet',
      japones: '賭ける (Kakeru)',
    ),
    Palavra(
      portugues: 'Chave',
      ingles: 'Key',
      japones: '鍵 (Kagi)',
    ),
    Palavra(
      portugues: 'Diferenciado',
      ingles: 'Unique',
      japones: '特別な (Tokubetsu na)',
    ),
    Palavra(
      portugues: 'Competir',
      ingles: 'Compete',
      japones: '競う (Kisou)',
    ),
    Palavra(
      portugues: 'Insano',
      ingles: 'Insane',
      japones: '狂った (Kurutta)',
    ),
    Palavra(
      portugues: 'Dica',
      ingles: 'Tip',
      japones: 'ヒント (Hinto)',
    ),
    Palavra(
      portugues: 'Genial',
      ingles: 'Brilliant',
      japones: '天才的な (Tensaiteki na)',
    ),
    Palavra(
      portugues: 'Lindo',
      ingles: 'Beautiful',
      japones: '美しい (Utsukushii)',
    ),
    Palavra(
      portugues: 'Macaco',
      ingles: 'Monkey',
      japones: '猿 (Saru)',
    ),
    Palavra(
      portugues: 'Abismado',
      ingles: 'Astonished',
      japones: '驚いた (Odoroita)',
    ),
  ];

  int indiceAtual = 0;
  bool mostrarTraducao = false;

  void mostrarTraducoes() {
    setState(() {
      mostrarTraducao = true;
    });
  }

  void proximaPalavra() {
    setState(() {
      indiceAtual = (indiceAtual + 1) % palavras.length;
      mostrarTraducao = false;
    });
  }

  void palavraAnterior() {
    setState(() {
      indiceAtual = (indiceAtual - 1 + palavras.length) % palavras.length;
      mostrarTraducao = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palavraAtual = palavras[indiceAtual];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tradutor top do Destro',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF26364A),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 36,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 18,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          palavraAtual.portugues,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF26364A),
                          ),
                        ),
                        if (mostrarTraducao) ...[
                          const SizedBox(height: 28),
                          TraducaoItem(
                            lingua: 'Inglês',
                            texto: palavraAtual.ingles,
                          ),
                          const SizedBox(height: 16),
                          TraducaoItem(
                            lingua: 'Japonês',
                            texto: palavraAtual.japones,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      BotaoTradutor(
                        texto: 'Anterior',
                        onPressed: palavraAnterior,
                      ),
                      BotaoTradutor(
                        texto: 'Mostrar tradução',
                        onPressed: mostrarTraducoes,
                        destaque: true,
                      ),
                      BotaoTradutor(
                        texto: 'Próxima',
                        onPressed: proximaPalavra,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TraducaoItem extends StatelessWidget {
  final String lingua;
  final String texto;

  const TraducaoItem({
    super.key,
    required this.lingua,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F7FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            lingua,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6D829B),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(0xFF26364A),
            ),
          ),
        ],
      ),
    );
  }
}

class BotaoTradutor extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final bool destaque;

  const BotaoTradutor({
    super.key,
    required this.texto,
    required this.onPressed,
    this.destaque = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            destaque ? const Color(0xFF7AA7D9) : Colors.white,
        foregroundColor:
            destaque ? Colors.white : const Color(0xFF40566F),
        elevation: destaque ? 1 : 0,
        side: destaque
            ? BorderSide.none
            : const BorderSide(color: Color(0xFFD6E0EC)),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
