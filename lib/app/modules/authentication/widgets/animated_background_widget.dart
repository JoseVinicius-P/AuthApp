import 'package:flutter/material.dart';
import 'package:auth/app/shared/services/my_colors.dart';

class AnimatedBackgroundWidget extends StatefulWidget {
  const AnimatedBackgroundWidget({
    super.key,
    required this.image,
    required this.child,
  });

  final Image image;
  final Widget child;

  @override
  State<AnimatedBackgroundWidget> createState() => _AnimatedBackgroundWidgetState();
}

class _AnimatedBackgroundWidgetState extends State<AnimatedBackgroundWidget>
    with TickerProviderStateMixin /*Usado para sincronizar animação com frame rate do dispositivo*/{
  late AnimationController _animationController; //Usado para controlar a animação
  late Animation<double> _animation; //Armazena o tipo da animaçãdicion

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this, //sincronizando com atualização da tela
      duration: const Duration(seconds: 15), // Duração da animação
    );

    _animation = Tween(begin: 1.0, end: 1.1).animate(_animationController); //Tipo da animação

    // Inicia a animação automaticamente
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose(); //Desativando animação quando tela for fechada
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          //Widget esponsavel por animar
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  color: MyColors.backgroundColor,
                  child: widget.image
              ),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}