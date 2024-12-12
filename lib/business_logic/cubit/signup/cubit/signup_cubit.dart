import 'package:bloc/bloc.dart';
import 'package:toleka/data/repository/signUp_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState(field: initialState()));

  initForm() async {
    List universiteData = await SignUpRepository.getUniversiteData();
    emit(SignupState(field: {
      ...state.field!,
      "universiteData": universiteData,
    }));
  }

  loadFaculteData() async {
    List faculteData = await SignUpRepository.getFaculteData(
        idUniversite: state.field!["universite"]);
    emit(SignupState(field: {...state.field!, "faculteData": faculteData}));
  }

   loadAllVehicule() async {
    Map vehiculeData = await SignUpRepository.getAllVehicule();
    emit(SignupState(field: {...state.field!, "vehiculeData": vehiculeData}));
  }

  loadDepartementData() async {
    List departementData = await SignUpRepository.getDepartementData(
        idFaculte: state.field!["faculte"]);
    emit(SignupState(
        field: {...state.field!, "departementData": departementData}));
  }

  loadPromotionData() async {
    List promotionData = await SignUpRepository.getPromotionData(
        idDepartement: state.field!["departement"]);
    emit(SignupState(field: {...state.field!, "promotionData": promotionData}));
  }

  loadProvinceData() async {
    List faculteData = await SignUpRepository.getFaculteData(
        idUniversite: state.field!["universite"]);
    emit(SignupState(field: {...state.field!, "faculteData": faculteData}));
  }

  initFormProvince() async {
    List provinceData = await SignUpRepository.getProvinceData();
    emit(SignupState(field: {
      ...state.field!,
      "provinceData": provinceData,
    }));
  }

  initFormProvinceTac() async {
    List provinceData = await SignUpRepository.getProvinceData();
    emit(SignupState(field: {
      ...state.field!,
      "provinceDataTac": provinceData,
    }));
  }

  loadVilleDataTac() async {
    List villeData = await SignUpRepository.getVilleDataTac(
        idProvince: state.field!["provinceTac"]);
    emit(SignupState(field: {...state.field!, "villeDataTac": villeData}));
  }

  loadCommuneDataTac() async {
    List communeData = await SignUpRepository.getCommuneData(
        idVille: state.field!["villeTac"]);
    emit(SignupState(field: {...state.field!, "communeDataTac": communeData}));
  }

  loadVilleData() async {
    List villeData = await SignUpRepository.getVilleData(
        idProvince: state.field!["province"]);
    emit(SignupState(field: {...state.field!, "villeData": villeData}));
  }

  loadEtablissementData() async {
    var response = await SignUpRepository.getEtablissementsKelasi();
    List? ecoleData = response["data"];
    emit(SignupState(field: {...state.field!, "ecoleData": ecoleData}));
  }

  loadSectionData() async {
    var response = await SignUpRepository.getSectionKelasi();
    List? sectionData = response["data"];
    emit(SignupState(field: {...state.field!, "sectionData": sectionData}));
  }

  loadOptionData() async {
    var response =
        await SignUpRepository.getOptionKelasi(state.field!["section"]);
    List? optionData = response["data"];
    emit(SignupState(field: {...state.field!, "optionData": optionData}));
  }

  loadLeveltData() async {
    var response = await SignUpRepository.getLevel();
    List? levelData = response["data"];
    emit(SignupState(field: {...state.field!, "levelData": levelData}));
  }

  loadCommuneData() async {
    List communeData =
        await SignUpRepository.getCommuneData(idVille: state.field!["ville"]);
    emit(SignupState(field: {...state.field!, "communeData": communeData}));
  }

  loadProvincesKelasi() async {
    var response = await SignUpRepository.getProvinceKelasi();
    List? provincesDataKelasi = response["data"];
    emit(SignupState(field: {
      ...state.field!,
      "provinceDataKelasi": provincesDataKelasi,
    }));
  }

  loadVillesKelasi() async {
    var response =
        await SignUpRepository.getVilleKelasi(state.field!["province"]);
    List? villeDataKelasi = response["data"];
    emit(SignupState(field: {
      ...state.field!,
      "villeDataKelasi": villeDataKelasi,
    }));
  }

  loadCommunesKelasi() async {
    var response = await SignUpRepository.getCommuneKelasi();
    List? communeDataKelasi = response["data"];
    emit(SignupState(field: {
      ...state.field!,
      "communeDataKelasi": communeDataKelasi,
    }));
  }

  loadServicesKelasi() async {
    var response = await SignUpRepository.getServicesKelasi();
    List serviceDataKelasi = response["data"];
    // print(serviceDataKelasi);
    emit(SignupState(field: {
      ...state.field!,
      "serviceDataKelasi": serviceDataKelasi,
    }));
  }

  loadPersonneRef() async {
    var response = await SignUpRepository.getPersonneRefByParent(
        int.tryParse(state.field!["parentId"]));
    List PersonneRefData = response["data"];
    // print(PersonneRefData);
    emit(SignupState(field: {
      ...state.field!,
      "PersonneRefData": PersonneRefData,
    }));
  }

  loadOperateurKelasi() async {
    var response = await SignUpRepository.getOperateurKelasi();
    List operateurData = response["data"];
    // print(operateurData);
    emit(SignupState(field: {
      ...state.field!,
      "operateurData": operateurData,
    }));
  }

  loadEnfant() async {
    var response =
        await SignUpRepository.getEnfantsActive((state.field!["parentId"]));
    List enfantData = response["data"];
    // print(enfantData);
    emit(SignupState(field: {
      ...state.field!,
      "enfantData": enfantData,
    }));
  }

  loadLignesKelasi() async {
    try {
      Map<String, dynamic> response = await SignUpRepository.getLignesKelasi();
      List<dynamic> lignesDatakelasi = response["data"];
      emit(SignupState(field: {
        ...state.field!,
        "lignesDatakelasi": lignesDatakelasi,
      }));
    } catch (e) {
      print("Erreur lors du chargement des arrêts: $e");
    }
  }

  loadArretsKelasi() async {
    try {
      Map<String, dynamic> response = await SignUpRepository.getArretsKelasi(
          int.tryParse(state.field!["lignes"]));
      List<dynamic> arretDatakelasi = response["data"];
      emit(SignupState(field: {
        ...state.field!,
        "arretDatakelasi": arretDatakelasi,
      }));
    } catch (e) {
      print("Erreur lors du chargement des arrêts: $e");
    }
  }

 Future<void> loadInfosEncadreur() async {
  try {
    // Vérification préalable que la clé "lignes" est présente et non nulle
    if (state.field == null || state.field!["lignes"] == null) {
      throw Exception("Clé 'lignes' manquante dans state.field");
    }

    Map<String, dynamic> response = await SignUpRepository.getInfosEncadreur(
      int.tryParse(state.field!["lignes"].toString()) ?? 0,
    );

    // Assurez-vous que la clé "data" contient bien les infos attendues
    if (response["data"] == null) {
      throw Exception("Données d'encadreur manquantes dans la réponse");
    }

    Map<String, dynamic> infoEncadreur = response["data"];
    emit(SignupState(field: {
      ...state.field!,
      "infoEncadreur": infoEncadreur,
    }));
  } catch (e) {
    print("Erreur lors du chargement des infos encadreur: $e");
  }
}


  void updateField(context, {required String field, data}) {
    emit(SignupState(field: {
      ...state.field!,
      field: data,
    }));

    if (field == 'universite') {
      loadFaculteData();
    }

    if (field == 'faculte') {
      loadDepartementData();
    }

    if (field == 'departement') {
      loadPromotionData();
    }
    if (field == 'province') {
      loadVillesKelasi();
    }
    if (field == 'ville') {
      loadCommunesKelasi();
    }

    if (field == 'lignes') {
      loadArretsKelasi();
    }

    if (field == 'section') {
      loadOptionData();
    }
    if (field == 'provinceTac') {
      loadVilleDataTac();
    }
    if (field == 'villeTac') {
      loadCommuneDataTac();
    }
  }
}
