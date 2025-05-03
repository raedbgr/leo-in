import '/imports.dart';

class MemberCard extends StatefulWidget {
  @override
  _MemberCardState createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffECECEC),
          border: Border.all(
            color: const Color(0xffD0D0D0),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 30,
              ),
            ),
            const Expanded(
              flex: 3,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Department - Post',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Color(0xff696969)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: !isAdded
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            isAdded = !isAdded;
                          });
                        },
                        child: Container(
                            height: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff69D138)),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            isAdded = !isAdded;
                          });
                        },
                        child: Container(
                            height: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffEA542D)),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            )),
                      )),
          ],
        ),
      ),
    );
  }
}
