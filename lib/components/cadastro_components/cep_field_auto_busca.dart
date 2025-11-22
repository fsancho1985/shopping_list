import 'package:app_shopping_list/components/cadastro_components/cadastro_text_field.dart';
import 'package:flutter/cupertino.dart';

class CepFieldAutoBusca extends StatelessWidget {
  final TextEditingController cepController;
  final VoidCallback onBuscar;

  const CepFieldAutoBusca({
    super.key,
    required this.cepController,
    required this.onBuscar,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          onBuscar();
        }
      },
      child: CadastroTextField(controller: cepController, label: 'CEP', keyboartType: TextInputType.number),
    );
  }


}