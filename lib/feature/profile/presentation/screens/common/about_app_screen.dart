import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("About App"),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "📍 Hatchr – Explorez la ville avec ceux qui y vivent vraiment\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "Hatchr transforme votre façon de voyager. L’application vous connecte avec des habitants passionnés, prêts à vous faire découvrir leur ville comme si vous y viviez. Oubliez les itinéraires touristiques classiques : vivez une expérience locale, humaine et sur mesure, partout dans le monde.\n\n"
                "Sur Hatchr, chaque local propose un accompagnement personnalisé. À votre arrivée, il peut venir vous chercher à l’aéroport, vous aider à prendre les transports, trouver votre logement ou simplement vous orienter dans le quartier. Vous gagnez du temps, vous évitez les erreurs, et vous vous sentez tout de suite plus à l’aise.\n\n"
                "Envie de découvrir les meilleurs endroits pour manger ? Votre local vous partage ses adresses favorites, loin des zones touristiques. Certains proposent même de vous accueillir chez eux pour un repas authentique, cuisiné maison. L’occasion parfaite de goûter la vraie cuisine locale et d’échanger autour d’un moment convivial.\n\n"
                "Vous cherchez à sortir des sentiers battus ? Partez en balade avec un local pour explorer les recoins cachés de la ville : une ruelle historique méconnue, un café secret, un point de vue sublime au coucher du soleil. Ce sont des expériences uniques, qui ne figurent dans aucun guide.\n\n"
                "Besoin de vous déplacer facilement ? Louez un vélo, un scooter ou une voiture directement à un habitant via l’application. Plus simple, plus souple, et bien plus humain qu’une agence classique.\n\n"
                "Vous voulez immortaliser votre séjour ? Certains locaux peuvent vous accompagner pour une session photo devant les plus beaux spots, au bon moment, loin de la foule. D’autres vous aideront à réserver des activités confidentielles, organiser un moment romantique ou faire du shopping artisanal.\n\n"
                "Tout se passe sur Hatchr : choix du local, messagerie intégrée, réservation, paiement sécurisé. Vous choisissez la durée et le type d’accompagnement selon vos besoins. Hatchr se rémunère via une commission transparente sur chaque service.\n\n"
                "Chaque local est vérifié, noté, et animé par l’envie de partager ce qu’il aime dans sa ville. Ce n’est pas du tourisme guidé, c’est une rencontre.\n\n"
                "Téléchargez Hatchr et découvrez une nouvelle façon de voyager : plus simple, plus vraie, plus humaine.\n",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, height: 1.6),
              ),
              SizedBox(height: 24),
              Text(
                "🌍 Hatchr – Explore like a local\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "Hatchr transforms the way you travel. The app connects you with passionate locals who will help you experience their city as if you lived there. Forget generic tourist routes—Hatchr offers a local, human, and personalized experience, anywhere in the world.\n\n"
                "On Hatchr, each local offers tailored support. Upon arrival, they can meet you at the airport, help you navigate public transport, find your accommodation, or simply get your bearings. You’ll save time, avoid mistakes, and feel at ease right away.\n\n"
                "Want to discover the best places to eat? Your local will share their favorite hidden gems, far from tourist traps. Some even invite you to dine at their home for a truly authentic meal, cooked with love—an unforgettable way to connect through culture and cuisine.\n\n"
                "Looking to explore beyond the obvious? Go for a walk with a local and uncover hidden corners of the city: a historic backstreet, a secret café, a breathtaking viewpoint at sunset. These are the kinds of experiences no guidebook can offer.\n\n"
                "Need to get around easily? Rent a bike, scooter, or car directly from a local via the app. It’s more flexible, more affordable, and more personal than a rental agency.\n\n"
                "Want to capture special memories? Some locals offer photo sessions at the city’s most iconic spots—at the right time, from the perfect angle, far from the crowds. Others help you plan surprises, book hidden activities, or shop for local treasures.\n\n"
                "Everything happens within the app: browse local profiles, chat, book, and pay securely. You decide how much time and support you want. Hatchr earns a transparent commission on each service.\n\n"
                "Every local is verified, rated, and motivated by a genuine desire to share their city. This isn’t just guided tourism—it’s about meaningful connection.\n\n"
                "Download Hatchr today and discover a new way to travel: simpler, deeper, more human.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class AboutAppScreen extends StatelessWidget {
//   const AboutAppScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(),
//         title: const Text("About App"),
//         centerTitle: true,
//       ),
//       body: const Padding(
//         padding: EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Text(
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lobortis risus eget magna euismod rhoncus. Vivamus eu lectus et lectus interdum placerat.\n\n"
//             "Praesent consectetur ante orci, non mattis massa posuere in. Integer blandit ut mi eu efficitur. Praesent congue, arcu vitae malesuada vehicula, lacus velit facilisis velit, ut vehicula sapien erat id dui. Proin nisi ante, ullamcorper vitae libero eu, mollis venenatis lectus. Integer auctor et sem at sollicitudin. Sed eget diam nisi. Nulla in id.\n\n"
//             "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
//             style: TextStyle(fontSize: 14),
//           ),
//         ),
//       ),
//     );
//   }
// }
