import 'package:flutter/material.dart';

class IndianLottery extends StatefulWidget {
  const IndianLottery({super.key});

  @override
  State<IndianLottery> createState() => _IndianLotteryState();
}

class _IndianLotteryState extends State<IndianLottery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          child: Column(
            children: [
              Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          Text(
                            "한국 로또 정보",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "평균 당첨금: ₩2,000,000,000",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "추첨 빈도: 주간",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "티켓 가격: ₩1,000",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "추첨일: 토요일",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              SizedBox(height: 16),
              Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "한국 로또 작동 방식",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "1. 지정된 판매점에서 로또 티켓을 구매합니다.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "2. 1부터 45까지의 숫자 중 6개를 선택합니다.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "3. 추첨은 매주 토요일 밤에 이루어집니다.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "4. 6개의 당첨 번호와 보너스 번호가 추첨됩니다.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "5. 최소 3개의 숫자를 맞추면 상금을 받을 수 있습니다.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "6. 모든 6개의 숫자를 맞추면 잭팟에 당첨됩니다.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "7. 보너스 번호는 5개의 숫자를 맞춘 경우 상금을 증가시킵니다.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                   backgroundColor: Colors.grey[850],
                   padding: EdgeInsets.symmetric(horizontal: 100)
                ),
                child: Text(
                  "번호 뽑기",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),

            ],
          ),
        ),
      ],
    );
  }
}