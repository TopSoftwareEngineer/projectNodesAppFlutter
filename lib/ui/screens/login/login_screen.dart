import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectx/bloc/bloc.dart';
=======
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/router/router_path.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
<<<<<<< HEAD
import 'package:projectx/ui/widgets/loading_window.dart';
import 'package:projectx/ui/widgets/qr_dialog.dart';

=======
import 'package:projectx/ui/widgets/qr_dialog.dart';

import '../../widgets/custom_dialog_box.dart';
import '../../widgets/genrateQr.dart';

>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
<<<<<<< HEAD
      body: Stack(
        children: [
          Form(
            child: SafeArea(
              minimum: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  SizedBox(
                    width: 200,
                    child: Image.asset(
                      "assets/images/Favicons/paytm.png",
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  const SizedBox(
                    height: 45,
                    child: Text(
                      PxStrings.loginTitle,
                      style: textStyleFontWeightDark,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                    child: Text(
                      PxStrings.loginSbuTitle,
                      style: textStyleFontLight,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(kBlue),
                      ),
                      onPressed: () {
                        _showDialog(context);
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GenerateQR()));
                        //_prueba();
                        //   Navigator.of(context).pushNamed(
                        //   PxPathCfg.homeScreenPageRoute,
                        // );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/LogoMasters/walletconnect.png", width: 36, height: 36,),
                          const SizedBox(width: 6,),
                          const Text(
                            PxStrings.setPrivateKey,
                            style: textStyleFont,
                          ),
                          const SizedBox(width: 40,)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                        PxPathCfg.walletImportScreenRoute,
                      ),
                      child: const Text(
                        PxStrings.setTestKey,
                        style: textStyleFontLightBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountLoadingState) {
                  return const LoadingWidget();
                } else {
                  return Container();
                }
              },
          )
        ],
=======
      body: Form(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.2,
              ),
              SizedBox(
                width: 200,
                child: Image.network(
                  'https://1000marcas.net/wp-content/uploads/2021/06/Paytm-emblem.png',
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              const SizedBox(
                height: 45,
                child: Text(
                  PxStrings.loginTitle,
                  style: textStyleFontWeightDark,
                ),
              ),
              const SizedBox(
                height: 60,
                child: Text(
                  PxStrings.loginSbuTitle,
                  style: textStyleFontLight,
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kBlue),
                  ),
                  onPressed: () {
                    _showDialog(context);
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GenerateQR()));
                    //_prueba();
                    //   Navigator.of(context).pushNamed(
                    //   PxPathCfg.homeScreenPageRoute,
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/LogoMasters/walletconnect.png", width: 36, height: 36,),
                      const SizedBox(width: 6,),
                      const Text(
                        PxStrings.setPrivateKey,
                        style: textStyleFont,
                      ),
                      const SizedBox(width: 40,)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    PxPathCfg.nodeWalletScreenPageRoute,
                  ),
                  child: const Text(
                    PxStrings.setTestKey,
                    style: textStyleFontLightBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
      ),
    );
  }

<<<<<<< HEAD
=======
  Future _prueba() async {
    print("hola");
  }

>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
  void _showDialog(BuildContext context) {
    showDialog(context: context,
        builder: (BuildContext context){
          return const QrDialog();
        }
    );
  }
}
