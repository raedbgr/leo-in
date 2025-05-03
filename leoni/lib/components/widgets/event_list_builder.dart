import '/imports.dart';

Widget buildEventListView(List<EventModel> events) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: GestureDetector(
          onTap: () {
            Get.toNamed('/eventInfo', arguments: events[index]);
          },
          child: EventCard(currentEvent: events[index]),
        ),
      ),
    ),
  );
}
