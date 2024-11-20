import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  String selectedOption = ""; // Cabinet ou Clinique
  String selectedGovernorate = ""; // Gouvernorat
  String selectedSpeciality = ""; // Spécialité

  final List<String> _governorates = [
    "Tunis", "Ariana", "Ben Arous", "Manouba", "Nabeul",
    "Bizerte", "Beja", "Jendouba", "Zaghouan", "Kairouan",
    "Sousse", "Monastir", "Mahdia", "Sfax", "Gabes",
    "Mednine", "Tataouine", "Kebili", "Tozeur", "Gafsa",
    "Kasserine", "Sidi Bouzid", "Siliana", "Le Kef"
  ];

  final List<Map<String, dynamic>> _specialities = [
    {"label": "Anesthésiologie", "icon": Icons.local_hospital},
    {"label": "Cardiologie", "icon": Icons.favorite},
    {"label": "Dermatologie", "icon": Icons.spa},
    {"label": "Endocrinologie", "icon": Icons.medical_services},
    {"label": "Gastro-entérologie", "icon": Icons.lunch_dining},
    {"label": "Médecine interne", "icon": Icons.healing},
    {"label": "Pédiatrie", "icon": Icons.child_friendly},
    {"label": "Ophtalmologie", "icon": Icons.visibility},
    {"label": "Psychiatrie", "icon": Icons.psychology},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: Text(
          "Prendre un rendez-vous",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 75,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Votre santé, Notre priorité!",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text("Sélectionner", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelectOptionCard(
                  icon: Icons.local_hospital,
                  label: "Clinique",
                  isActive: selectedOption == "Clinique",
                  onPressed: () => setState(() => selectedOption = "Clinique"),
                ),
                SelectOptionCard(
                  icon: Icons.medical_services,
                  label: "Cabinet",
                  isActive: selectedOption == "Cabinet",
                  onPressed: () => setState(() => selectedOption = "Cabinet"),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text("Quelle ville ou quel gouvernorat ?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.teal.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              hint: Text("Sélectionnez un gouvernorat"),
              items: _governorates.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) => setState(() => selectedGovernorate = value!),
            ),
            SizedBox(height: 30),
            Text("Spécialités", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _specialities.length,
              itemBuilder: (context, index) {
                final speciality = _specialities[index];
                return SpecialityCard(
                  icon: speciality["icon"],
                  label: speciality["label"],
                  isActive: selectedSpeciality == speciality["label"],
                  onPressed: () => setState(() => selectedSpeciality = speciality["label"]),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedOption.isEmpty || selectedGovernorate.isEmpty || selectedSpeciality.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Veuillez remplir tous les champs !")),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          option: selectedOption,
                          governorate: selectedGovernorate,
                          speciality: selectedSpeciality,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: Text(
                  "Rechercher",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectOptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  SelectOptionCard({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? Colors.teal.shade200 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: isActive ? Colors.teal.shade600 : Colors.blue),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class SpecialityCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  SpecialityCard({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Colors.teal.shade200 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: isActive ? Colors.teal.shade600 : Colors.blue),
            SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String option;
  final String governorate;
  final String speciality;

  ResultPage({required this.option, required this.governorate, required this.speciality});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Résultats"),
      ),
      body: Center(
        child: Text(
          "Option: $option\nGouvernorat: $governorate\nSpécialité: $speciality",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
