import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactEncadreurScreen extends StatefulWidget {
  const ContactEncadreurScreen({Key? key}) : super(key: key);

  @override
  _ContactEncadreurScreenState createState() => _ContactEncadreurScreenState();
}

class _ContactEncadreurScreenState extends State<ContactEncadreurScreen> {
  final String avatarUrl =
      'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=';

  String nom = "Inconnu";
  String prenom = "Inconnu";
  String postnom = "Inconnu";
  String phoneNumber = "";
  String ligne = "Inconnu";
  String parcoursLigne = "Inconnu";
  Map? dataEncadreur;
  Map? dataLigne;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final idLigne = context.read<SignupCubit>().state.field?['lignes'];

    if (idLigne != null) {
      try {
        final response = await SignUpRepository.getInfosEncadreur(idLigne);
        setState(() {
          dataEncadreur = response["data"]["encadreur_id"];
          dataLigne = response["data"]["ligne_service"];
          nom = dataEncadreur?["nom"] ?? "Inconnu";
          prenom = dataEncadreur?["prenom"] ?? "Inconnu";
          postnom = dataEncadreur?["postnom"] ?? "Inconnu";
          phoneNumber = dataEncadreur?["telephone"] ?? "";
          ligne = dataLigne?["libele_ligne"] ?? "Inconnu";
          parcoursLigne = dataLigne?["parcours"] ?? "Inconnu";
        });
      } catch (e) {
        showError('Erreur lors de la récupération des données.');
      }
    } else {
      showError('Aucune ligne assignée.');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> openWhatsApp(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      showError('Numéro de téléphone non disponible.');
      return;
    }

    final whatsappUrl = Uri.parse('https://wa.me/243$phoneNumber');

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      showError('WhatsApp n\'est pas installé.');
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      showError('Numéro de téléphone non disponible.');
      return;
    }

    final telUrl = Uri.parse('tel:0$phoneNumber');

    if (await canLaunchUrl(telUrl)) {
      await launchUrl(telUrl, mode: LaunchMode.externalApplication);
    } else {
      showError('Appel téléphonique non disponible.');
    }
  }

  void exitPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/routestackkelasi',
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exitPage();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            if (dataEncadreur == null || dataLigne == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return buildContent();
          },
        ),
      ),
    );
  }

  Widget buildContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Contactez l'encadreur pour plus de détails.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              buildInfoRow("Nom :", "$nom $postnom $prenom"),
              const Divider(thickness: 1,),
              buildInfoRow("Ligne :", ligne),
               const Divider(thickness: 1,),
              buildInfoRow("Parcours :", parcoursLigne),
               const Divider(thickness: 1,),
              buildContactRow(),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: exitPage,
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Quitter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff204F97),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  minimumSize: const Size(double.infinity, 20),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget buildContactRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Téléphone : 0$phoneNumber",
          style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        Row(
          children: [
            InkWell(
              onTap: () => openWhatsApp(phoneNumber),
              child: const Icon(Icons.whatsapp, color: Colors.green, size: 30),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () => makePhoneCall(phoneNumber),
              child: const Icon(Icons.call, color: Color(0xff204F97), size: 30),
            ),
          ],
        ),
      ],
    );
  }
}
