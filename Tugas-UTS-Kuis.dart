import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.pink[300],
      ),
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuis D4 Manajemen Informatika'),
        backgroundColor: Colors.purple[800],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/mi.jpeg',
                width: 80,
              ),
            ),
          ),
          Spacer(),
          Image.asset(
            'assets/images/quiz_image.jpeg',
            width: 200,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage()),
              );
            },
            child: Text(
              'Start',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> questions = [
    {
      'question': 'Siapa nama Kepala Prodi D4 Manajemen Informatika?',
      'options': [
        'Andi Iwan Nurhidayat, S.Kom., M.T.',
        'Dodik Arwin Dermawan, S.St., S.T., M.T.',
        'Aditya Prapanca, S.T., M.Kom.'
      ],
      'answer': 1
    },
    {
      'question': 'Kapan D4 Manajemen Informatika didirikan?',
      'options': ['2019', '2018', '2006'],
      'answer': 0
    },
    {
      'question': 'Apakah Prodi ini Pilihan pertama mu?',
      'options': ['Ya', 'Tidak'],
      'answer': null
    },
    {
      'question': 'Dari mana kamu mengetahui Prodi D4 Manajemen Informatika?',
      'options': ['Sosial Media', 'Teman', 'Rekomendasi sekolah'],
      'answer': null
    },
    {
      'question': 'Prodi ini berada di Fakultas apa?',
      'options': ['Kedokteran', 'Vokasi', 'Hukum'],
      'answer': 1
    },
    {
      'question': 'Rektor dari UNESA adalah pak Deny',
      'options': ['Benar', 'Salah'],
      'answer': 1
    },
    {
      'question': 'D4 Manajemen Informatika merupakan bagian dari Fakultas Vokasi',
      'options': ['Benar', 'Salah'],
      'answer': 0
    },
    {
      'question': 'Koorprodi dari D4MI adalah Pak Dodik',
      'options': ['Benar', 'Salah'],
      'answer': 0
    },
    {
      'question': 'Program Studi D4 Manajemen Informatika berada di bawah Fakultas Teknik UNESA',
      'options': ['Benar', 'Salah'],
      'answer': 1
    },
    {
      'question': 'Mata kuliah Pemrograman Berorientasi Objek diajarkan di D4 Manajemen Informatika UNESA',
      'options': ['Benar', 'Salah'],
      'answer': 0
    },
    {
      'question': 'D4 Manajemen Informatika UNESA memiliki fokus pada pengembangan perangkat lunak dan sistem informasi',
      'options': ['Benar', 'Salah'],
      'answer': 0
    },
    {
      'question': 'Lulusan D4 Manajemen Informatika UNESA mendapatkan gelar Sarjana Komputer (S.Kom)',
      'options': ['Benar', 'Salah'],
      'answer': 1
    },
    {
      'question': 'D4 Manajemen Informatika UNESA memiliki mata kuliah terkait kecerdasan buatan',
      'options': ['Benar', 'Salah'],
      'answer': 0
    },
    {
      'question': 'D4 Manajemen Informatika UNESA tidak memiliki kegiatan magang bagi mahasiswa',
      'options': ['Benar', 'Salah'],
      'answer': 1
    },
    {
      'question': 'Mahasiswa D4 Manajemen Informatika UNESA dapat mengikuti program MBKM (Merdeka Belajar Kampus Merdeka)',
      'options': ['Benar', 'Salah'],
      'answer': 0
    },
    {
      'question': 'D4 Manajemen Informatika UNESA memiliki kerja sama dengan perusahaan teknologi untuk program sertifikasi',
      'options': ['Benar', 'Salah'],
      'answer': 0
    },
    {
      'question': 'Mata kuliah UI/UX Design tidak diajarkan dalam kurikulum D4 Manajemen Informatika UNESA',
      'options': ['Benar', 'Salah'],
      'answer': 1
    },
  ];

  int currentQuestionIndex = 0;
  int score = 0;
  int timeLeft = 10;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 10;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          nextQuestion();
        }
      });
    });
  }

  void checkAnswer(int selectedIndex) {
    if (questions[currentQuestionIndex]['answer'] != null &&
        questions[currentQuestionIndex]['answer'] == selectedIndex) {
      setState(() {
        score++;
      });
    }
    nextQuestion();
  }

  void nextQuestion() {
    timer?.cancel();
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        startTimer();
      } else {
        showResultDialog();
      }
    });
  }

  void showResultDialog() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Quiz Finished!",
      desc: "Your Score: $score of ${questions.length}.",
      style: AlertStyle(
        titleStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        descStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              restartQuiz();
            });
          },
          width: 150,
          color: Colors.teal,
        )
      ],
    ).show();
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuis D4 Manajemen Informatika',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade900, Colors.pink.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[currentQuestionIndex]['question'],
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
            ).animate().fade(duration: 600.ms),
            SizedBox(height: 20),
            ...List.generate(
              questions[currentQuestionIndex]['options'].length,
                  (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[600]),
                  onPressed: () => checkAnswer(index),
                  child: Text(
                    questions[currentQuestionIndex]['options'][index],
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                ).animate().fade(),
              ),
            ),
            SizedBox(height: 20),
            Text('Time: $timeLeft second',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Score: $score',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
