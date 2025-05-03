import '/imports.dart';

class EventCard extends StatelessWidget {
  final EventModel currentEvent;
  late final Color color;

  EventCard({
    super.key,
    required this.currentEvent,
  });

  @override
  Widget build(BuildContext context) {
    if (currentEvent.dateB.isAfter(DateTime.now())) {
      color = Colors.cyan;
    } else if (currentEvent.dateB.isBefore(DateTime.now()) &&
        currentEvent.dateE.isAfter(DateTime.now())) {
      color = const Color(0xff69D138);
    } else if (currentEvent.dateE.isBefore(DateTime.now())) {
      color = const Color(0xffEA2D2D);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3C4E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentEvent.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location,
                          color: Colors.cyan,
                        ),
                        Text(
                          currentEvent.region,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffcbcbcb)),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.clock,
                          color: Colors.cyan,
                        ),
                        Text(
                          DateFormat('hh:mm a').format(currentEvent.dateB),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffcbcbcb)),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('dd').format(currentEvent.dateB),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  DateFormat('MMM').format(currentEvent.dateB),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
