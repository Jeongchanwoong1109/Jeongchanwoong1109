noong__
noong__
온라인



모두 
정찬웅
 님을 환영합시다! — 2025-09-15 오후 3:15

손을 흔들어 인사해보세요!
오셨군요, 
김진호
 님! — 2025-09-15 오후 3:26

손을 흔들어 인사해보세요!
강세훈 — 2025-09-15 오후 6:59
https://www.figma.com/board/DGVT6qhRg8FcI1hWqseneJ/기프랩?node-id=0-1&t=RVlR5LTs7sdhU9uo-1
FigJam
기프랩
Created with FigJam
이미지
김진호 — 2025-09-22 오후 8:10
이미지
만나서 반가워요, 
은정
 님. — 2025-09-26 오후 1:01

손을 흔들어 인사해보세요!
정찬웅 — 2025-09-29 오후 7:00
나 잠깐만
집 거의 다 도착했어
김진호 — 2025-09-29 오후 7:00
ㅇㅋㅇㅋ
강세훈 — 2025-10-13 오후 9:04
https://www.figma.com/design/FCrywcPtrmZvrVm228PuCc/Make-Clean?node-id=0-1&t=9SyC5MlR5soUOt48-1\
첨부 파일 형식: acrobat
분리수거 AI 식별 앱 발표자료.pdf
1.80 MB
정찬웅 — 2025-11-02 오후 6:32
https://ai.cnu.ac.kr/ai/board/news.do?mode=view&articleNo=567086&article.offset=0&articleLimit=10
정찬웅 — 2025-11-02 오후 7:07
https://cnuswaiproject.wixsite.com/2025-1/post/늘벗-늘-함께하는-인지-검사-ai
2025-1
[★]늘벗 : 늘 함께하는 인지 검사 AI
2025 CNU SW/AI Project Fair 주니어부문 - 구구팀명구구팀원 명단조민영, 김래아, 남영서지도교수김도헌 교수님작품 배경 및 목적치매 검사에 대한 거부감으로 인해 조기 발견이 어려워지고, 보호자 또한 적절한 대응이 어려운 상황입니다. 본 프로젝트는 자연스러운 대...
[★]늘벗 : 늘 함께하는 인지 검사 AI
김진호 — 2025-11-02 오후 7:20
https://www.ohmynews.com/NWS_Web/View/at_pg.aspx?CNTN_CD=A0003120485
오마이뉴스
재활용률 70%의 허상, 분리수거의 민낯
2025년 4월, 서울의 한 아파트 단지. 매주 화요일 주민들은 페트병, 플라스틱, 종이 등을 꼼꼼히 분리해 재활용 수거함에 내놓는다. 하지만 한 주민이 의문점을 제기한다. "이렇게 열심히 분리수거해도, 결국 수거장에서 섞여 소각된다는 얘
재활용률 70%의 허상, 분리수거의 민낯
강세훈 — 2025-11-22 오후 4:18
이미지
정찬웅 — 2025-11-22 오후 4:33
import 'package:flutter/material.dart';

// 이미지에서 확인된 연분홍색 (Pale Pink / Light Crimson)
const Color _palePink = Color(0xFFFEE7EB);

// 분리수거 항목 색상 정의
final Color _yellowRecycle = Colors.amber[800]!; // 일반쓰레기 (노란색)
final Color _greenRecycle = Colors.green[700]!; // 재활용품 (초록색)
const Color _defaultMemoColor = Color(0xFFE0E0E0); // 메모 배경색 (밝은 회색)
const Color _memoTextColor = Colors.black87;


// ----------------------------------------------------------------------
// 캘린더의 기준이 될 실제 오늘 날짜 (DateTime.now() 사용)
final DateTime _today = DateTime.now();

// ----------------------------------------------------------------------
// 앱 실행 및 기본 설정
// ----------------------------------------------------------------------
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '캘린더 메인화면',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.light(primary: Colors.black, secondary: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const CalendarScreen(),
    );
  }
}

// ----------------------------------------------------------------------
// 재활용 항목 데이터 모델
// ----------------------------------------------------------------------
class RecycleItem {
  final String title;
  final Color color;
  RecycleItem(this.title, this.color);
}

// ----------------------------------------------------------------------
// 캘린더 화면 (CalendarScreen) - 상태 관리 필요
// ----------------------------------------------------------------------
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // 캘린더가 현재 포커스하고 있는 년/월/일 상태
  late DateTime _focusedDay;
  // 사용자가 클릭하여 선택한 날짜 상태 (하이라이팅 등에 사용 가능)
  late DateTime _selectedDay;

  // 임시 메모리 저장소 (실제 앱에서는 Firestore 같은 DB 사용)
  // key: 정규화된 날짜 (년, 월, 일만 포함), value: 메모 내용
  final Map<DateTime, String> _memos = {};

  // 날짜/시간 컴포넌트를 무시하고 년/월/일만 남기는 정규화 함수
  DateTime _normalizeDate(DateTime date) => DateTime(date.year, date.month, date.day);


  @override
  void initState() {
    super.initState();
    // 초기에는 실제 오늘 날짜를 기준으로 설정
    _focusedDay = _today;
    _selectedDay = _normalizeDate(_today); // 선택된 날짜도 오늘로 초기화
  }

  // MARK: - Navigation Handlers

  void _goToPreviousYear() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year - 1, _focusedDay.month, _focusedDay.day);
      _selectedDay = _normalizeDate(_focusedDay);
    });
  }

  void _goToNextYear() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year + 1, _focusedDay.month, _focusedDay.day);
      _selectedDay = _normalizeDate(_focusedDay);
    });
  }

... (764줄 남음)
접기
Calendar.dart
30KB
import 'package:flutter/material.dart';

// ----------------------------------------------------------------------
// 퀘스트 항목의 데이터 모델
// ----------------------------------------------------------------------
class Quest {
확장
Quiz.dart
15KB
김진호 — 2025-11-22 오후 4:35
이미지
이거
이미지
ㄱㄱ
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // rootBundle
import 'package:http/http.dart' as http;
확장
challenge.dart
20KB
강세훈 — 2025-11-22 오후 4:42
이미지
﻿
import 'package:flutter/material.dart';

// 이미지에서 확인된 연분홍색 (Pale Pink / Light Crimson)
const Color _palePink = Color(0xFFFEE7EB);

// 분리수거 항목 색상 정의
final Color _yellowRecycle = Colors.amber[800]!; // 일반쓰레기 (노란색)
final Color _greenRecycle = Colors.green[700]!; // 재활용품 (초록색)
const Color _defaultMemoColor = Color(0xFFE0E0E0); // 메모 배경색 (밝은 회색)
const Color _memoTextColor = Colors.black87;


// ----------------------------------------------------------------------
// 캘린더의 기준이 될 실제 오늘 날짜 (DateTime.now() 사용)
final DateTime _today = DateTime.now();

// ----------------------------------------------------------------------
// 앱 실행 및 기본 설정
// ----------------------------------------------------------------------
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '캘린더 메인화면',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.light(primary: Colors.black, secondary: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const CalendarScreen(),
    );
  }
}

// ----------------------------------------------------------------------
// 재활용 항목 데이터 모델
// ----------------------------------------------------------------------
class RecycleItem {
  final String title;
  final Color color;
  RecycleItem(this.title, this.color);
}

// ----------------------------------------------------------------------
// 캘린더 화면 (CalendarScreen) - 상태 관리 필요
// ----------------------------------------------------------------------
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // 캘린더가 현재 포커스하고 있는 년/월/일 상태
  late DateTime _focusedDay;
  // 사용자가 클릭하여 선택한 날짜 상태 (하이라이팅 등에 사용 가능)
  late DateTime _selectedDay;

  // 임시 메모리 저장소 (실제 앱에서는 Firestore 같은 DB 사용)
  // key: 정규화된 날짜 (년, 월, 일만 포함), value: 메모 내용
  final Map<DateTime, String> _memos = {};

  // 날짜/시간 컴포넌트를 무시하고 년/월/일만 남기는 정규화 함수
  DateTime _normalizeDate(DateTime date) => DateTime(date.year, date.month, date.day);


  @override
  void initState() {
    super.initState();
    // 초기에는 실제 오늘 날짜를 기준으로 설정
    _focusedDay = _today;
    _selectedDay = _normalizeDate(_today); // 선택된 날짜도 오늘로 초기화
  }

  // MARK: - Navigation Handlers

  void _goToPreviousYear() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year - 1, _focusedDay.month, _focusedDay.day);
      _selectedDay = _normalizeDate(_focusedDay);
    });
  }

  void _goToNextYear() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year + 1, _focusedDay.month, _focusedDay.day);
      _selectedDay = _normalizeDate(_focusedDay);
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, _focusedDay.day);
      _selectedDay = _normalizeDate(_focusedDay);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, _focusedDay.day);
      _selectedDay = _normalizeDate(_focusedDay);
    });
  }

  void _goToToday() {
    setState(() {
      _focusedDay = _today;
      _selectedDay = _normalizeDate(_today);
    });
  }

  // MARK: - Recycling Logic

  // 요일별 디폴트 분리수거 항목 목록을 반환하는 헬퍼 함수
  List<RecycleItem> _getDefaultRecycleItems(int weekday) {
    // weekday: 0=일, 1=월, 2=화, 3=수, 4=목, 5=금, 6=토
    List<RecycleItem> items = [];

    // 1. 일반쓰레기 (노란색: 일, 월, 화, 수, 목)
    if (weekday >= 0 && weekday <= 4) {
      items.add(RecycleItem('일반쓰레기', _yellowRecycle));
    }

    // 2. 재활용품 (초록색: 월, 목)
    if (weekday == 1 || weekday == 4) {
      items.add(RecycleItem('재활용품', _greenRecycle));
    }
    return items;
  }

  // MARK: - Memo Handlers

  // 메모 저장 로직 (캘린더 상태 업데이트 포함)
  void _handleSaveMemo(DateTime date, String content) {
    final normalizedDate = _normalizeDate(date);
    setState(() {
      if (content.trim().isNotEmpty) {
        _memos[normalizedDate] = content.trim();
      } else {
        _memos.remove(normalizedDate);
      }
    });
  }

  // 메모 삭제 로직 (캘린더 상태 업데이트 포함)
  void _handleDeleteMemo(DateTime date) {
    final normalizedDate = _normalizeDate(date);
    setState(() {
      _memos.remove(normalizedDate);
    });
  }

  // MARK: - Dialog Implementation (날짜 클릭 시 팝업)

  void _showDayDetailDialog(DateTime date, int weekday) {
    final normalizedDate = _normalizeDate(date);

    // DayDetailDialog 위젯에 필요한 정보와 콜백 함수 전달
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _DayDetailDialog(
          date: normalizedDate,
          weekday: weekday,
          // 현재 저장된 메모 내용을 전달
          initialMemo: _memos[normalizedDate] ?? '',
          onSaveMemo: _handleSaveMemo,
          onDeleteMemo: _handleDeleteMemo,
          getDefaultRecycleItems: _getDefaultRecycleItems,
        );
      },
    );
  }

  // MARK: - Build Methods

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // ⭐ 달력 섹션
              _buildCalendarView(),
              const SizedBox(height: 20), // 하단 여백 축소
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const _CustomBottomNavBar(), // <--- 이 부분이 제거됨
    );
  }

  // 상단 앱 바 (헤더) 구현 - 위치 정보와 아이콘 추가
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      // 왼쪽 영역: '캘린더' 타이틀
      title: const Text(
        '캘린더',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w900,
        ),
      ),
      // 오른쪽 영역: 위치 아이콘과 텍스트
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.location_on, // 위치 아이콘
              color: Colors.black,
              size: 24,
            ),
            SizedBox(width: 4),
            Text(
              '대전 유성구 궁동', // 현재 위치 텍스트
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  // 달력 위젯 구성 (이전 코드와 동일)
  Widget _buildCalendarView() {
    return Container(
      // 달력 본체는 흰색 배경 (테두리만 적용)
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: LayoutBuilder(
          builder: (context, constraints) {
            final double innerWidth = constraints.maxWidth;

            const double spacing = 5.0;
            final double cellWidth = (innerWidth - (spacing * 6)) / 7;

            return Column(
              children: [
                // 1. 월/년도 헤더 (연분홍색 배경 적용)
                _buildMonthHeader(),
                const SizedBox(height: 15),
                // 2. 요일 헤더
                _buildDaysOfWeek(cellWidth),
                const SizedBox(height: 10),
                // 3. 날짜 그리드
                _buildDaysGrid(cellWidth),
                const SizedBox(height: 10),
                // 4. 월 이동 및 오늘 버튼 섹션 (연분홍색 배경 적용)
                _buildNavigationButtons(),
              ],
            );
          }
      ),
    );
  }

  // 월/년도 헤더 (동적) (이전 코드와 동일)
  Widget _buildMonthHeader() {
    final String monthYear = '${_focusedDay.year}년 ${_focusedDay.month}월';
    return Container(
      decoration: const BoxDecoration(
        color: _palePink, // 연분홍색 배경
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Center(
        child: Text(
          monthYear,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // 요일 헤더 (이전 코드와 동일)
  Widget _buildDaysOfWeek(double cellWidth) {
    final List<String> days = ['일', '월', '화', '수', '목', '금', '토'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(7, (index) {
        final day = days[index];
        return Container(
          width: cellWidth,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: index < 6 ? 5.0 : 0.0),
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: day == '일' ? Colors.red : (day == '토' ? Colors.blue : Colors.black),
            ),
          ),
        );
      }),
    );
  }

  // 날짜 그리드 구현 (이전 코드와 동일)
  Widget _buildDaysGrid(double cellWidth) {
    final DateTime firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final int startWeekday = firstDayOfMonth.weekday % 7;
    final DateTime nextMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
    final int daysInMonth = nextMonth.subtract(const Duration(days: 1)).day;

    List<Widget> dayWidgets = [];

    for (int i = 0; i < startWeekday; i++) {
      dayWidgets.add(_buildEmptyDayCell(cellWidth));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final bool isToday = day == _today.day && _focusedDay.month == _today.month && _focusedDay.year == _today.year;
      final int weekday = (startWeekday + day - 1) % 7;

      dayWidgets.add(_buildDayCell(day, isToday, cellWidth, weekday));
    }

    List<Widget> weeks = [];
    List<Widget> currentWeek = [];

    for (int i = 0; i < dayWidgets.length; i++) {
      currentWeek.add(dayWidgets[i]);
      if (currentWeek.length == 7) {
        weeks.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: currentWeek,
            ),
          ),
        );
        currentWeek = [];
      }
    }

    if (currentWeek.isNotEmpty) {
      weeks.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: currentWeek,
          ),
        ),
      );
    }

    return Column(children: weeks);
  }

  // 빈 날짜 셀 (이전 코드와 동일)
  Widget _buildEmptyDayCell(double width) {
    return Container(
      width: width,
      height: width,
      margin: const EdgeInsets.only(right: 5.0),
    );
  }


  // 개별 날짜 셀 위젯 - 클릭 이벤트 추가됨
  Widget _buildDayCell(int day, bool isToday, double width, int weekday) {
    final Color dayColor = weekday == 0 ? Colors.red : (weekday == 6 ? Colors.blue : Colors.black);

    // 텍스트 라벨 리스트
    List<Widget> labels = [];

    // 디폴트 분리수거 항목 목록을 가져옴
    final List<RecycleItem> defaultItems = _getDefaultRecycleItems(weekday);
    for (var item in defaultItems) {
      labels.add(_buildRecycleLabel(item.title, item.color));
    }

    // 현재 셀의 날짜 객체 생성 (클릭 시 사용)
    final DateTime cellDate = DateTime(_focusedDay.year, _focusedDay.month, day);
    final DateTime normalizedCellDate = _normalizeDate(cellDate);

    // 저장된 메모가 있다면 메모 라벨 추가
    final bool hasMemo = _memos.containsKey(normalizedCellDate) && _memos[normalizedCellDate]!.isNotEmpty;
    if (hasMemo) {
      // 메모 아이콘 또는 텍스트 라벨을 추가하여 메모가 있음을 달력에서 표시
      labels.add(_buildRecycleLabel('메모', _memoTextColor));
    }

    // InkWell로 감싸서 클릭 이벤트 처리
    return InkWell(
      onTap: () {
        // 날짜 선택 상태 업데이트 및 다이얼로그 표시
        setState(() {
          _selectedDay = normalizedCellDate;
        });
        // 상세 다이얼로그 호출
        _showDayDetailDialog(cellDate, weekday);
      },
      child: Container(
        width: width,
        height: width,
        margin: EdgeInsets.only(right: weekday < 6 ? 5.0 : 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 1. 날짜 및 오늘 표시
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: isToday
                  ? BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              )
                  : null,
              child: Text(
                '$day',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: dayColor,
                ),
              ),
            ),

            const Spacer(flex: 1),

            // 3. 분리수거 및 메모 텍스트 라벨
            ...labels,

            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  // 분리수거 텍스트 라벨 위젯 (이전 코드와 동일)
  Widget _buildRecycleLabel(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 8.5,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // 월 이동 및 오늘 버튼 섹션 (이전 코드와 동일)
  Widget _buildNavigationButtons() {
    return Container(
      decoration: const BoxDecoration(
        color: _palePink,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18.0),
          bottomRight: Radius.circular(18.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavButton(Icons.fast_rewind_outlined, _goToPreviousYear),
          const SizedBox(width: 10),
          _buildNavButton(Icons.arrow_back_ios_new, _goToPreviousMonth),
          const SizedBox(width: 10),
          _buildNavButtonText('오늘', _goToToday),
          const SizedBox(width: 10),
          _buildNavButton(Icons.arrow_forward_ios, _goToNextMonth),
          const SizedBox(width: 10),
          _buildNavButton(Icons.fast_forward_outlined, _goToNextYear),
        ],
      ),
    );
  }

  // 월 이동 버튼 공통 스타일 (이전 코드와 동일)
  Widget _buildNavButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 20),
        onPressed: onPressed,
      ),
    );
  }

  // '오늘' 버튼 스타일 (이전 코드와 동일)
  Widget _buildNavButtonText(String text, VoidCallback onPressed) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// 날짜 상세 다이얼로그 (StatefulWidget) - 메모 수정/삭제 실시간 관리
// ----------------------------------------------------------------------

class _DayDetailDialog extends StatefulWidget {
  final DateTime date;
  final int weekday;
  final String initialMemo;
  final Function(DateTime, String) onSaveMemo;
  final Function(DateTime) onDeleteMemo;
  final List<RecycleItem> Function(int) getDefaultRecycleItems;

  const _DayDetailDialog({
    required this.date,
    required this.weekday,
    required this.initialMemo,
    required this.onSaveMemo,
    required this.onDeleteMemo,
    required this.getDefaultRecycleItems,
  });

  @override
  State<_DayDetailDialog> createState() => _DayDetailDialogState();
}

class _DayDetailDialogState extends State<_DayDetailDialog> {
  late TextEditingController _memoController;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    // 초기 메모 내용으로 컨트롤러 설정
    _memoController = TextEditingController(text: widget.initialMemo);
    // 초기 메모가 없으면 바로 편집 모드로 시작, 있으면 읽기 모드
    _isEditing = widget.initialMemo.isEmpty;
  }

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }

  // 메모 읽기/편집 모드 토글
  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  // 메모 저장 및 다이얼로그 종료
  void _saveAndExit() {
    widget.onSaveMemo(widget.date, _memoController.text);
    Navigator.of(context).pop();
  }

  // 메모 삭제 및 다이얼로그 종료
  void _deleteAndExit() {
    widget.onDeleteMemo(widget.date);
    Navigator.of(context).pop();
  }

  // MARK: - Dialog Build Methods

  // 디폴트 분리수거 타일 위젯 (일반쓰레기, 재활용품)
  Widget _buildDefaultRecycleTile(RecycleItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: item.color.withOpacity(0.15),
        border: Border.all(color: item.color, width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: item.color,
              ),
            ),
            const Icon(Icons.check, size: 24, color: Colors.green), // 완료 표시 아이콘
          ]
      ),
    );
  }

  // 메모 타일 (읽기 모드) - 분리수거 타일과 동일 레벨로 표시
  Widget _buildMemoReadTile() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0, right: 10.0),
      decoration: BoxDecoration(
        color: _defaultMemoColor,
        border: Border.all(color: _memoTextColor, width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '나의 메모',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: _memoTextColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _memoController.text,
                  style: const TextStyle(fontSize: 15, color: _memoTextColor),
                  maxLines: null,
                ),
              ],
            ),
          ),
          // 수정 및 삭제 버튼
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                // 수정 버튼
                _buildMemoActionButton(Icons.edit_outlined, _toggleEditMode, Colors.blue),
                const SizedBox(height: 8),
                // 삭제 버튼
                _buildMemoActionButton(Icons.delete_forever_outlined, _deleteAndExit, Colors.red),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 메모 입력 필드 (작성/수정 모드)
  Widget _buildMemoEditView() {
    final bool hasExistingMemo = widget.initialMemo.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0, right: 10.0),
          decoration: BoxDecoration(
            color: _defaultMemoColor,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: _memoTextColor, width: 2.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        hasExistingMemo ? '메모 수정' : '새 메모 작성',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: _memoTextColor)
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: _memoController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: '메모를 입력하세요...',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(fontSize: 15, color: _memoTextColor),
                    ),
                  ],
                ),
              ),
              // 저장/취소 버튼
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                child: Column(
                  children: [
                    // 저장 버튼
                    _buildMemoActionButton(Icons.check, _saveAndExit, Colors.green),
                    if (hasExistingMemo)
                      const SizedBox(height: 8),
                    // 취소/편집 모드 종료 버튼 (기존 메모가 있을 때만)
                    if (hasExistingMemo)
                      _buildMemoActionButton(Icons.cancel_outlined, _toggleEditMode, Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // 메모 액션 버튼 공통 스타일
  Widget _buildMemoActionButton(IconData icon, VoidCallback onPressed, Color color) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.black, width: 2.0),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 0)],
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 22),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<RecycleItem> defaultItems = widget.getDefaultRecycleItems(widget.weekday);
    final bool hasMemo = _memoController.text.isNotEmpty;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: Colors.black, width: 2.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: _palePink,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. 헤더 (날짜 및 닫기 버튼)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 닫기 버튼
                  InkWell(
                    onTap: () => Navigator.of(context).pop(), // 다이얼로그 닫기
                    child: const Icon(Icons.close, size: 28, color: Colors.black),
                  ),
                  // 날짜 텍스트
                  Text(
                    '${widget.date.year}년 ${widget.date.month}월 ${widget.date.day}일',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  // 더미 공간 확보 (UI 대칭을 위해)
                  const SizedBox(width: 28),
                ],
              ),
            ),

            // 2. 내용 부분 (흰색 배경)
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 디폴트 분리수거 항목 표시
                  ...defaultItems.map((item) => _buildDefaultRecycleTile(item)).toList(),

                  // 메모 섹션 (편집 모드이거나, 읽기 모드 + 메모가 있을 때만 표시)
                  if (_isEditing || hasMemo)
                  // 편집 모드일 경우: 입력 필드 표시
                    if (_isEditing)
                      _buildMemoEditView()
                    // 읽기 모드이고 메모가 있을 경우: 메모 타일 표시
                    else
                      _buildMemoReadTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
