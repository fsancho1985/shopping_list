import 'package:app_shopping_list/components/abre_tela_components/app_bar_title.dart';
import 'package:flutter/material.dart';

import '../components/abre_tela_components/auth_buttons_row.dart';
import '../components/abre_tela_components/feature_subtitle.dart';
import '../components/abre_tela_components/feature_title.dart';
import '../components/abre_tela_components/footer_section.dart';
import '../components/abre_tela_components/logo_section.dart';
import '../components/abre_tela_components/subtitle_section.dart';
import '../components/abre_tela_components/title_section.dart';

class AbreTela extends StatelessWidget {
  const AbreTela({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.orange.shade100,
        title: const AppBarTitle(),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: AbreTelaBody(),
        ),
      ),
    );
  }
}

class AbreTelaBody extends StatelessWidget {
  const AbreTelaBody({ super.key });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleSection(),
        SizedBox(height: 2),
        SubtitleSection(),
        SizedBox(height: 2),
        AuthButtonsRow(),
        SizedBox(height: 2),
        LogoSection(),
        SizedBox(height: 2),
        FeatureTitle(),
        SizedBox(height: 2),
        FeatureSubtitle(),
        SizedBox(height: 2),
        FooterSection(),
      ],
    );
  }


}

