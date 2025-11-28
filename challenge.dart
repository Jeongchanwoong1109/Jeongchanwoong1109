import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // rootBundle
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'TmoneyRoundWind',
      primaryColor: Color(0xFF83F2DC),
    ),
    home: ChallengePage(),
  ));
}

const mint = Color(0xFF83F2DC);
const gray = Color(0xFFD9D9D9);
const green = Color(0xFF5AB74E);
const red = Color(0xFFFF2007);

// 챌린지 페이지
class ChallengePage extends StatelessWidget {
  final List<Map<String, dynamic>> challengeGroups = [
    {"name": "그루비룸", "score": 1098},
    {"name": "쓰레기즈", "score": 1011},
    {"name": "플라스틱 파이터즈", "score": 989},
    {"name": "쌈닭s", "score": 947},
    {"name": "어벤져스", "score": 928},
    {"name": "분리왕국", "score": 920},
    {"name": "깨끗쓰", "score": 899},
    {"name": "지사모", "score": 871},
    {"name": "히어로즈", "score": 801},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              '10월 분리수거 챌린지',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mint, foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => AiPage()),
                    );
                  },
                  child: Text('챌린지 참여하기'),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mint, foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => GroupJoinPage()),
                    );
                  },
                  child: Text('그룹 참가하기'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: challengeGroups.length,
                separatorBuilder: (_, __) => SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final rank = i + 1;
                  final g = challengeGroups[i];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: mint.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Text('$rank. ${g['name']}', style: TextStyle(fontSize: 18)),
                        Spacer(),
                        Text('${g['score']}점', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 그룹 참가하기 페이지
// ...생략(위의 기존코드와 동일)...
class GroupJoinPage extends StatefulWidget {
  @override
  State<GroupJoinPage> createState() => _GroupJoinPageState();
}

class _GroupJoinPageState extends State<GroupJoinPage> {
  final TextEditingController _controller = TextEditingController();
  String? _message;

  // 그룹 소개 데이터
  final List<Map<String, String>> groupInfoList = [
    {
      "name": "그루비룸",
      "intro": "환경 보호에 앞장서는 재활용 마스터 집단!",
    },
    {
      "name": "쓰레기즈",
      "intro": "쓰레기는 분리수거부터! 작지만 강한 실천가들.",
    },
    {
      "name": "플라스틱 파이터즈",
      "intro": "플라스틱 줄이기 운동을 실천하는 모임.",
    },
    {
      "name": "쌈닭s",
      "intro": "모두 함께 깔끔한 분리수거 습관 들이기!",
    },
    {
      "name": "깨끗쓰",
      "intro": "아름다운 거리와 환경을 위해 모였어요!",
    },
  ];

  void _joinGroup() {
    if (_controller.text.trim().isEmpty) {
      setState(() {
        _message = '그룹 이름을 입력해주세요!';
      });
      return;
    }
    setState(() {
      _message = '"${_controller.text}" 그룹에 참가 신청이 완료되었습니다!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 28),
            Text('그룹 참가하기',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "참가할 그룹 이름을 입력하세요",
                  filled: true,
                  fillColor: gray.withOpacity(0.27),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mint, foregroundColor: Colors.black,
                minimumSize: Size(180, 48),
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onPressed: _joinGroup,
              child: Text('참가 신청'),
            ),
            SizedBox(height: 18),
            if (_message != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  _message!,
                  style: TextStyle(
                    fontSize: 16,
                    color: green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            // 그룹 소개 카드 영역
            SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: groupInfoList.length,
                separatorBuilder: (_, __) => SizedBox(height: 18),
                itemBuilder: (_, i) {
                  final info = groupInfoList[i];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: mint.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0,2)
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(info['name']!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(info['intro']!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 분리수거 AI 솔루션 페이지
class AiPage extends StatefulWidget {
  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  Uint8List? _imageData;
  bool _loading = false;
  String? _error;

  Future<void> _loadAssetImage() async {
    try {
      final bytes = await rootBundle.load('assets/test.jpg');
      setState(() {
        _imageData = bytes.buffer.asUint8List();
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = '이미지 불러오기 실패: $e';
      });
    }
  }

  Future<void> _evaluateImage() async {
    if (_imageData == null) return;
    setState(() { _loading = true; _error = null; });

    final base64Img = base64Encode(_imageData!);
    final apiKey = 'AIzaSyAUGIo7C5hQKH2siyRtGPxm7WKZ3vOFkGM'; // 본인 API 키 넣기!
    final url = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey';
    final prompt = '아래 이미지를 분리수거 관점에서 50점 만점 기준으로 평가해줘. 점수와 피드백을 JSON 형태로 줘. 예시: {"score": 40, "feedback":["내용물이 남아있음","뚜껑 안 닫힘"]}';

    final requestBody = jsonEncode({
      "contents": [
        {
          "parts": [
            { "text": prompt },
            {
              "inline_data": {
                "mime_type": "image/jpeg",
                "data": base64Img,
              }
            }
          ]
        }
      ]
    });

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: { 'Content-Type': 'application/json', },
        body: requestBody,
      );
      setState(() { _loading = false; });

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final String rawText = data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? '';
        int score = 0;
        List<String> feedback = [];
        final reg = RegExp(r'"score"\s*:\s*(\d+).*?"feedback"\s*:\s*\[(.*?)\]', dotAll: true);
        final match = reg.firstMatch(rawText);

        if (match != null) {
          score = int.parse(match.group(1)!);
          feedback = match.group(2)!
              .split(',')
              .map((s) => s.replaceAll(RegExp(r'"'), '').trim())
              .where((s) => s.isNotEmpty)
              .toList();
        } else {
          feedback = [rawText];
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AiFeedbackPage(
              score: score,
              feedback: feedback,
              imageData: _imageData,
            ),
          ),
        );
      } else {
        setState(() {
          _error = 'AI 평가 요청 실패: ${res.statusCode}\n${res.body}';
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'AI 평가 중 에러: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAssetImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('분리수거 AI 솔루션', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 36),
              height: 160,
              decoration: BoxDecoration(
                color: gray,
                borderRadius: BorderRadius.circular(16),
              ),
              child: _imageData == null
                  ? Center(child: Text('이미지 미리보기 영역'))
                  : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(_imageData!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: gray,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              onPressed: _loading ? null : _loadAssetImage,
              child: Text('촬영하기'),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mint,
                foregroundColor: Colors.black,
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: (_imageData == null || _loading) ? null : _evaluateImage,
              child: _loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('분리수거 평가받기'),
            ),
            if (_error != null)
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(_error!, style: TextStyle(color: Colors.red)),
              ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

// AI 피드백 결과 페이지
class AiFeedbackPage extends StatelessWidget {
  final int score;
  final List<String> feedback;
  final Uint8List? imageData;

  const AiFeedbackPage({
    required this.score,
    required this.feedback,
    this.imageData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 18),
            Text('AI 피드백', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 18),
            if (imageData != null)
              Container(
                height: 120,
                margin: EdgeInsets.symmetric(horizontal: 36),
                decoration: BoxDecoration(
                  color: gray,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.memory(imageData!, fit: BoxFit.cover),
                ),
              ),
            SizedBox(height: 18),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: gray),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final f in feedback)
                    Padding(
                      padding: EdgeInsets.only(top: 6, bottom: 2),
                      child: Text(f, style: TextStyle(fontSize: 16)),
                    ),
                ],
              ),
            ),
            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: green, foregroundColor: Colors.white),
                  icon: Icon(Icons.check),
                  label: Text('점수보기'),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => AiScorePage(aiScore: score)),
                  ),
                ),
                SizedBox(width: 18),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: red, foregroundColor: Colors.white),
                  icon: Icon(Icons.refresh),
                  label: Text('다시하기'),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => AiPage()),
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

// 점수/랭킹 변화 페이지
class AiScorePage extends StatelessWidget {
  final int aiScore;
  AiScorePage({required this.aiScore});

  @override
  Widget build(BuildContext context) {
    final beforeScore = 928;
    final afterScore = beforeScore + aiScore;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 22),
            Text('$aiScore점 / 50점', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
            Text('조금 아쉬워요 분발해주세요!', style: TextStyle(fontSize: 18, color: Colors.black54)),
            SizedBox(height: 18),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 34),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: mint.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.emoji_events, color: Colors.amber[600], size: 32),
                      SizedBox(width: 10),
                      Text('랭킹 변화', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Before', style: TextStyle(color: Colors.black45)),
                  Text('5. 어벤져스', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('$beforeScore 점'),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.arrow_upward, color: green, size: 20),
                      Text('4. 어벤져스', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text('$afterScore 점'),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
