import 'package:flutter/material.dart';


// 🌟 사주 데이터 모델 (SajuModel)
class SajuModel {
  final String yearZhu;
  final String monthZhu;
  final String dayZhu;
  // final String hourZhu;
  final String description;

  SajuModel({
    required this.yearZhu,
    required this.monthZhu,
    required this.dayZhu,
    // required this.hourZhu,
    required this.description,
  });
}

/// 🌟 ResultScreen: 사주 데이터 상세 화면
class ResultScreen extends StatelessWidget {
  final SajuModel saju;

  const ResultScreen({super.key, required this.saju});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("사주 결과")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("연주: ${saju.yearZhu}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("월주: ${saju.monthZhu}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("일주: ${saju.dayZhu}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // Text("시주: ${saju.hourZhu}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(saju.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("닫기"),
            ),
          ],
        ),
      ),
    );
  }
}

// 🌟 사주 데이터베이스 (sajuDb - 연주, 월주, 일주, 시주의 특징 저장)
const Map<String, String> sajuDb = {
  "갑자(甲子)": "창의적이고 독립적인 성향",
  "을축(乙丑)": "끈기와 책임감이 강한 성향",
  "병인(丙寅)": "리더십과 열정적인 성향",
  "정묘(丁卯)": "섬세하고 조화로운 성향",
  "무진(戊辰)": "결단력이 강하고 현실적인 성향",
  "기사(己巳)": "사려 깊고 계획적인 성향",
  "경오(庚午)": "강한 의지와 추진력을 가진 성향",
  "신미(辛未)": "섬세하면서도 신중한 성향",
  "임신(壬申)": "분석적이고 논리적인 성향",
  "계유(癸酉)": "예술적 감각이 뛰어난 성향",
  "갑술(甲戌)": "진취적이며 정의로운 성향",
  "을해(乙亥)": "온화하고 배려심이 깊은 성향",
  "병자(丙子)": "활동적이고 적극적인 성향",
  "정축(丁丑)": "끈기 있으며 성실한 성향",
  "무인(戊寅)": "강한 책임감을 가진 성향",
  "기묘(己卯)": "예의 바르고 신중한 성향",
  "경진(庚辰)": "대담하면서도 합리적인 성향",
  "신사(辛巳)": "열정적이며 예술적인 성향",
  "임오(壬午)": "유연하고 창의적인 성향",
  "계미(癸未)": "조용하면서도 내면이 강한 성향",
  "갑신(甲申)": "새로운 도전을 좋아하는 성향",
  "을유(乙酉)": "꼼꼼하고 세심한 성향",
  "병술(丙戌)": "솔직하고 정직한 성향",
  "정해(丁亥)": "지혜롭고 학구적인 성향",
  "무자(戊子)": "진취적이며 추진력 있는 성향",
  "기사(己丑)": "현실적이며 실용적인 성향",
  "경인(庚寅)": "결단력 있고 강한 카리스마",
  "신묘(辛卯)": "예술적 감각과 섬세한 성향",
  "임진(壬辰)": "상상력이 풍부한 성향",
  "계사(癸巳)": "분석적이며 논리적인 사고",
  "갑오(甲午)": "독립적이며 열정적인 성향",
  "을미(乙未)": "신중하고 배려 깊은 성향",
  "병신(丙申)": "창조적이며 독창적인 성향",
  "정유(丁酉)": "세밀하고 체계적인 사고",
  "무술(戊戌)": "강한 정의감과 책임감",
  "기해(己亥)": "평온하고 조용한 성향",
  "경자(庚子)": "지혜롭고 현실적인 성향",
  "신축(辛丑)": "성실하며 안정적인 성향",
  "임인(壬寅)": "도전 정신이 강한 성향",
  "계묘(癸卯)": "창의적이며 감성적인 성향",
  "갑진(甲辰)": "리더십이 뛰어난 성향",
  "을사(乙巳)": "직관적이고 감각적인 성향",
  "병오(丙午)": "열정적이며 강한 추진력",
  "정미(丁未)": "세심하고 조화로운 성향",
  "무신(戊申)": "단호하며 논리적인 사고",
  "기사(己酉)": "현실적이며 신중한 성향",
  "경술(庚戌)": "강한 정의감과 결단력",
  "신해(辛亥)": "내면이 깊고 사려 깊은 성향",
  "임자(壬子)": "분석력과 통찰력이 뛰어난 성향",
  "계축(癸丑)": "끈기 있고 신중한 성향",
  "갑인(甲寅)": "도전 정신이 강하며 추진력 있는 성향",
  "을묘(乙卯)": "섬세하고 조화로운 성향",
  "병진(丙辰)": "리더십과 추진력이 강한 성향",
  "정사(丁巳)": "예술적 감각과 창의력이 뛰어난 성향",
  "무오(戊午)": "자신감과 독립적인 성향",
  "기미(己未)": "신중하며 배려 깊은 성향",
  "경신(庚申)": "합리적이며 논리적인 성향",
  "신유(辛酉)": "꼼꼼하고 체계적인 성향",
  "임술(壬戌)": "강한 신념과 책임감",
  "계해(癸亥)": "조용하고 사려 깊은 성향"
};
