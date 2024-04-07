class Holidays {
  
   String ocassion;
   String date;

  Holidays({required this.ocassion, required this.date});
}

List<Holidays> holidays = [
  Holidays(ocassion: "", date: 'Every Sunday'),
  Holidays(ocassion: "Gandhi's Birthday", date: '2nd October'),
  Holidays(ocassion: "Dashera", date: '24th October(Evening)'),
  Holidays(ocassion: "Meri Marzi", date: '25th October'),
];
