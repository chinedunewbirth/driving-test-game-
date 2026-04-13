import 'package:uk_driving_test/models/theory_question.dart';

class TheoryQuestionBank {
  static const List<TheoryQuestion> allQuestions = [
    // --- Alertness ---
    TheoryQuestion(
      id: 'alert_01',
      category: 'Alertness',
      question: 'What should you do before making a U-turn?',
      options: [
        'Give an arm signal as well as using your indicators',
        'Check road markings to see that U-turns are permitted',
        'Look over your shoulder for a final check',
        'Select a higher gear than normal',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Before making a U-turn, you should look over your shoulder for a final check to ensure no vehicles are overtaking you.',
    ),
    TheoryQuestion(
      id: 'alert_02',
      category: 'Alertness',
      question:
          'What\'s the most important thing you should check before reversing?',
      options: [
        'That your mirrors are properly adjusted',
        'That you\'re not close to the kerb',
        'That the area behind is clear',
        'That the reversing lights are working',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Before reversing, the most important thing to check is that the area behind is clear. Children and small objects may not be visible in mirrors.',
    ),
    TheoryQuestion(
      id: 'alert_03',
      category: 'Alertness',
      question:
          'You\'re following a large vehicle. Why should you stay a safe distance behind it?',
      options: [
        'You\'ll be able to pull into the gap if the vehicle in front slows down',
        'You\'ll be able to corner more quickly',
        'You\'ll help the large vehicle by reducing wind resistance',
        'You\'ll be able to see past it more easily',
      ],
      correctAnswerIndex: 3,
      explanation:
          'Following too closely behind a large vehicle restricts your view of the road ahead. Dropping back allows you to see past the vehicle.',
    ),

    // --- Attitude ---
    TheoryQuestion(
      id: 'att_01',
      category: 'Attitude',
      question: 'At a pelican crossing, what does a flashing amber light mean?',
      options: [
        'You must stop and wait for the green light',
        'You must give way to pedestrians still on the crossing',
        'You can proceed if the crossing is clear',
        'You should stop and flash your headlights',
      ],
      correctAnswerIndex: 1,
      explanation:
          'A flashing amber light at a pelican crossing means you must give way to pedestrians who are still on the crossing, but you may proceed if it is clear.',
    ),
    TheoryQuestion(
      id: 'att_02',
      category: 'Attitude',
      question: 'What should you do when you\'re overtaking a cyclist?',
      options: [
        'Sound your horn to alert them',
        'Speed up to get past them quickly',
        'Give them at least as much room as you would a car',
        'Flash your lights as you approach',
      ],
      correctAnswerIndex: 2,
      explanation:
          'When overtaking a cyclist, you should give them at least as much room as you would when overtaking a car. They may swerve to avoid potholes or drain covers.',
    ),
    TheoryQuestion(
      id: 'att_03',
      category: 'Attitude',
      question:
          'What must you do at a puffin crossing that\'s controlled by sensors?',
      options: [
        'Approach the crossing at high speed',
        'Wait for the green light before proceeding',
        'Sound your horn if pedestrians are slow',
        'Flash your lights to warn pedestrians',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Puffin crossings have sensors that detect when pedestrians are on the crossing. You must wait for the green light before proceeding.',
    ),

    // --- Safety & Your Vehicle ---
    TheoryQuestion(
      id: 'safe_01',
      category: 'Safety & Your Vehicle',
      question: 'What\'s the legal minimum tread depth for tyres on cars?',
      options: ['1mm', '1.6mm', '2.5mm', '4mm'],
      correctAnswerIndex: 1,
      explanation:
          'The legal minimum tread depth for car tyres in the UK is 1.6mm across the central three-quarters of the tyre, around the entire circumference.',
    ),
    TheoryQuestion(
      id: 'safe_02',
      category: 'Safety & Your Vehicle',
      question: 'When should you use your vehicle\'s rear fog lights?',
      options: [
        'When visibility is seriously reduced',
        'At night on unlit roads',
        'In heavy rain',
        'When following other vehicles closely',
      ],
      correctAnswerIndex: 0,
      explanation:
          'Rear fog lights should only be used when visibility is seriously reduced, generally to less than 100 metres. Using them in other conditions can dazzle other drivers.',
    ),
    TheoryQuestion(
      id: 'safe_03',
      category: 'Safety & Your Vehicle',
      question:
          'What should you check before starting a long motorway journey?',
      options: [
        'Your vehicle tax is valid',
        'You have enough fuel, oil and water, and your tyres are safe',
        'Your insurance covers motorway travel',
        'Your car radio is working',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Before a long motorway journey, check your fuel, oil and water levels, and ensure your tyres are in good condition with correct pressure.',
    ),

    // --- Safety Margins ---
    TheoryQuestion(
      id: 'margin_01',
      category: 'Safety Margins',
      question: 'What\'s the overall stopping distance at 70 mph?',
      options: [
        '53 metres (175 feet)',
        '73 metres (240 feet)',
        '96 metres (315 feet)',
        '120 metres (394 feet)',
      ],
      correctAnswerIndex: 2,
      explanation:
          'At 70 mph, the overall stopping distance is approximately 96 metres (315 feet). This includes thinking distance and braking distance.',
    ),
    TheoryQuestion(
      id: 'margin_02',
      category: 'Safety Margins',
      question:
          'In wet conditions, how much should you increase your following distance?',
      options: [
        'Keep the same distance',
        'Double it',
        'Triple it',
        'Quadruple it',
      ],
      correctAnswerIndex: 1,
      explanation:
          'In wet conditions, you should at least double your following distance because braking distances can be twice as long on wet roads.',
    ),
    TheoryQuestion(
      id: 'margin_03',
      category: 'Safety Margins',
      question: 'What should you do when driving in fog?',
      options: [
        'Stay close to the vehicle in front',
        'Use your full beam headlights',
        'Use dipped headlights and reduce speed',
        'Drive at the speed limit to clear the area quickly',
      ],
      correctAnswerIndex: 2,
      explanation:
          'In fog, use dipped headlights as full beam will reflect off the fog and reduce visibility further. Reduce your speed and increase following distance.',
    ),

    // --- Hazard Awareness ---
    TheoryQuestion(
      id: 'hazard_01',
      category: 'Hazard Awareness',
      question:
          'You see a pedestrian with a white stick and red band. What does this mean?',
      options: [
        'They are physically disabled',
        'They are deaf and blind',
        'They are blind',
        'They are deaf',
      ],
      correctAnswerIndex: 1,
      explanation:
          'A white stick with a red band indicates that the pedestrian is both deaf and blind. Be particularly careful and patient.',
    ),
    TheoryQuestion(
      id: 'hazard_02',
      category: 'Hazard Awareness',
      question: 'What does a triangular road sign with a red border indicate?',
      options: ['An order', 'A warning', 'Information', 'A direction'],
      correctAnswerIndex: 1,
      explanation:
          'Triangular road signs with a red border are warning signs. They alert you to a hazard ahead.',
    ),
    TheoryQuestion(
      id: 'hazard_03',
      category: 'Hazard Awareness',
      question:
          'You\'re driving past a line of parked cars. What should you watch out for?',
      options: [
        'Car doors opening suddenly',
        'Traffic wardens',
        'Other drivers looking for parking',
        'Expired parking meters',
      ],
      correctAnswerIndex: 0,
      explanation:
          'When driving past parked cars, watch for car doors being opened suddenly. Also look for children who may run out from between cars.',
    ),

    // --- Vulnerable Road Users ---
    TheoryQuestion(
      id: 'vuln_01',
      category: 'Vulnerable Road Users',
      question:
          'What should you do when driving near a school at the start or end of the school day?',
      options: [
        'Drive at the speed limit',
        'Sound your horn to warn children',
        'Drive slowly and be prepared to stop',
        'Overtake any slow vehicles immediately',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Near schools, especially at opening and closing times, drive slowly and be prepared to stop. Children may be unpredictable.',
    ),
    TheoryQuestion(
      id: 'vuln_02',
      category: 'Vulnerable Road Users',
      question: 'Why should you check for motorcyclists before turning right?',
      options: [
        'They always have right of way',
        'They are small and can be difficult to see',
        'They ride faster than cars',
        'They are usually in the wrong lane',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Motorcyclists are smaller than cars and can be easily hidden in blind spots. Always check carefully before turning.',
    ),
    TheoryQuestion(
      id: 'vuln_03',
      category: 'Vulnerable Road Users',
      question:
          'What should you do when you see an elderly person crossing the road ahead?',
      options: [
        'Flash your lights to hurry them',
        'Rev your engine',
        'Be patient and give them plenty of time',
        'Sound your horn gently',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Elderly pedestrians may take longer to cross the road. Be patient and allow them plenty of time to cross safely.',
    ),

    // --- Rules of the Road ---
    TheoryQuestion(
      id: 'rules_01',
      category: 'Rules of the Road',
      question:
          'What\'s the national speed limit on a single carriageway for cars?',
      options: ['50 mph', '60 mph', '70 mph', '80 mph'],
      correctAnswerIndex: 1,
      explanation:
          'The national speed limit for cars on a single carriageway is 60 mph.',
    ),
    TheoryQuestion(
      id: 'rules_02',
      category: 'Rules of the Road',
      question: 'You\'re approaching a roundabout. What should you do?',
      options: [
        'Stop before entering',
        'Give way to traffic from the right',
        'Give way to traffic from the left',
        'Speed up to join quickly',
      ],
      correctAnswerIndex: 1,
      explanation:
          'At a roundabout, you should give way to traffic already on the roundabout from your right, unless road markings or signs say otherwise.',
    ),
    TheoryQuestion(
      id: 'rules_03',
      category: 'Rules of the Road',
      question:
          'What do double white lines in the centre of the road mean when the line nearest to you is solid?',
      options: [
        'You may cross them to overtake',
        'You must not cross or straddle them',
        'You may park on them',
        'They are only advisory',
      ],
      correctAnswerIndex: 1,
      explanation:
          'When the white line nearest to you is solid, you must not cross or straddle it unless it is safe and you need to enter a side road or property.',
    ),

    // --- Road & Traffic Signs ---
    TheoryQuestion(
      id: 'signs_01',
      category: 'Road & Traffic Signs',
      question:
          'What does a circular road sign with a blue background indicate?',
      options: [
        'A warning',
        'A prohibition',
        'A positive instruction or mandatory requirement',
        'Tourist information',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Circular blue signs give a positive instruction, such as "turn left ahead" or "minimum speed".',
    ),
    TheoryQuestion(
      id: 'signs_02',
      category: 'Road & Traffic Signs',
      question:
          'What does a red circular sign with a white horizontal bar mean?',
      options: ['No entry', 'No waiting', 'No stopping', 'No through road'],
      correctAnswerIndex: 0,
      explanation:
          'A red circle with a white horizontal bar is the "no entry" sign. You must not enter the road or carriageway.',
    ),
    TheoryQuestion(
      id: 'signs_03',
      category: 'Road & Traffic Signs',
      question: 'What do green background signs on a motorway indicate?',
      options: [
        'Primary route directions',
        'Tourist information',
        'Motorway directions and information',
        'Local directions',
      ],
      correctAnswerIndex: 0,
      explanation:
          'Green background signs on motorways indicate primary route directions.',
    ),

    // --- Motorway Rules ---
    TheoryQuestion(
      id: 'mway_01',
      category: 'Motorway Rules',
      question:
          'What\'s the minimum engine size for a vehicle to be allowed on the motorway?',
      options: [
        'There is no minimum engine size; the vehicle must be capable of motorway speeds',
        '500cc',
        '1000cc',
        '50cc',
      ],
      correctAnswerIndex: 0,
      explanation:
          'There is no minimum engine size requirement, but vehicles must be capable of maintaining motorway speeds safely. Learner drivers, cyclists, and pedestrians are not allowed on motorways.',
    ),
    TheoryQuestion(
      id: 'mway_02',
      category: 'Motorway Rules',
      question: 'What should you do if you break down on a motorway?',
      options: [
        'Try to repair the vehicle yourself',
        'Walk to the nearest town for help',
        'Pull onto the hard shoulder, use the emergency phone, and stand behind the barrier',
        'Wait in your car for help',
      ],
      correctAnswerIndex: 2,
      explanation:
          'If you break down on a motorway, pull onto the hard shoulder, switch on hazard lights, use the emergency phone, and wait behind the barrier away from the carriageway.',
    ),
    TheoryQuestion(
      id: 'mway_03',
      category: 'Motorway Rules',
      question: 'What\'s the speed limit on the motorway for cars?',
      options: ['60 mph', '70 mph', '80 mph', '50 mph'],
      correctAnswerIndex: 1,
      explanation:
          'The speed limit for cars on motorways in the UK is 70 mph, unless signs show a lower limit.',
    ),

    // --- Additional Questions ---
    TheoryQuestion(
      id: 'add_01',
      category: 'Documents',
      question: 'At what age can you hold a full car driving licence?',
      options: ['15', '16', '17', '18'],
      correctAnswerIndex: 2,
      explanation:
          'You can apply for a provisional licence at 15 years and 9 months, but you can\'t drive on public roads until you\'re 17.',
    ),
    TheoryQuestion(
      id: 'add_02',
      category: 'Incidents',
      question: 'What should you do at the scene of an accident?',
      options: [
        'Move injured people to comfort them',
        'Keep traffic flowing',
        'Switch off the engines, call emergency services, and give first aid if trained',
        'Drive past quickly',
      ],
      correctAnswerIndex: 2,
      explanation:
          'At an accident scene, ensure engines are switched off, call 999, and give first aid if you\'re trained. Don\'t move injured people unless there\'s immediate danger.',
    ),
    TheoryQuestion(
      id: 'add_03',
      category: 'Vehicle Handling',
      question: 'When should you use the two-second rule?',
      options: [
        'When checking mirrors',
        'To measure a safe following distance in dry conditions',
        'When timing traffic lights',
        'When parallel parking',
      ],
      correctAnswerIndex: 1,
      explanation:
          'The two-second rule helps you maintain a safe following distance in dry conditions. In wet conditions, double it to four seconds.',
    ),
    TheoryQuestion(
      id: 'add_04',
      category: 'Vehicle Handling',
      question: 'What should you do if your vehicle starts to skid?',
      options: [
        'Brake hard immediately',
        'Steer into the skid and ease off the accelerator',
        'Accelerate to regain control',
        'Turn the steering wheel away from the skid',
      ],
      correctAnswerIndex: 1,
      explanation:
          'If your vehicle skids, steer into the direction of the skid and ease off the accelerator. Avoid braking hard as this can make the skid worse.',
    ),
    TheoryQuestion(
      id: 'add_05',
      category: 'Safety & Your Vehicle',
      question: 'How often should you check your vehicle\'s oil level?',
      options: [
        'Every month',
        'Every week',
        'Before every journey',
        'At every service',
      ],
      correctAnswerIndex: 1,
      explanation:
          'You should check your vehicle\'s oil level at least every week and before any long journeys.',
    ),
    TheoryQuestion(
      id: 'add_06',
      category: 'Rules of the Road',
      question: 'What must you have to legally drive on UK roads?',
      options: [
        'A valid driving licence, insurance, and road tax',
        'Just a driving licence',
        'A driving licence and insurance only',
        'Insurance and road tax only',
      ],
      correctAnswerIndex: 0,
      explanation:
          'To legally drive on UK roads, you must have a valid driving licence, valid motor insurance, and vehicle tax (road tax). The vehicle must also have a valid MOT if over 3 years old.',
    ),
    TheoryQuestion(
      id: 'add_07',
      category: 'Alertness',
      question: 'How can you avoid tiredness on a long journey?',
      options: [
        'Open the window slightly',
        'Plan regular rest stops every 2 hours',
        'Turn up the radio',
        'Drink coffee before and during the journey',
      ],
      correctAnswerIndex: 1,
      explanation:
          'The most effective way to combat tiredness is to plan regular rest stops, ideally every 2 hours. Fresh air and caffeine provide only temporary relief.',
    ),
    TheoryQuestion(
      id: 'add_08',
      category: 'Attitude',
      question: 'What should you do if a vehicle is tailgating you?',
      options: [
        'Brake suddenly to warn them',
        'Speed up to create distance',
        'Gradually increase the gap between you and the vehicle in front',
        'Gesture at the driver behind',
      ],
      correctAnswerIndex: 2,
      explanation:
          'If being tailgated, gradually increase the gap between you and the vehicle ahead. This gives both of you more time to react if the vehicle in front brakes.',
    ),
    TheoryQuestion(
      id: 'add_09',
      category: 'Safety Margins',
      question: 'What\'s the typical thinking distance at 30 mph?',
      options: ['6 metres', '9 metres', '12 metres', '15 metres'],
      correctAnswerIndex: 1,
      explanation:
          'At 30 mph, typical thinking distance is approximately 9 metres (30 feet). This can increase if you\'re tired, distracted, or under the influence.',
    ),
    TheoryQuestion(
      id: 'add_10',
      category: 'Hazard Awareness',
      question:
          'What should you do if you see brake lights ahead on a motorway?',
      options: [
        'Change lanes immediately',
        'Slow down and be prepared to stop',
        'Overtake on the hard shoulder',
        'Maintain your speed',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Brake lights ahead on a motorway indicate slowing or stopped traffic. Slow down and be prepared to stop. Use your hazard warning lights briefly to warn drivers behind.',
    ),

    // --- More Theory Questions for Full Coverage ---
    TheoryQuestion(
      id: 'add_11',
      category: 'Motorway Rules',
      question:
          'What do red flashing lights above every lane on a motorway mean?',
      options: [
        'Slow down',
        'Move to the left lane',
        'You must stop - do not go beyond the signal',
        'Change lanes',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Red flashing lights above every lane mean you must stop and not go beyond the signal. There may be an obstruction or incident ahead.',
    ),
    TheoryQuestion(
      id: 'add_12',
      category: 'Rules of the Road',
      question: 'What does a box junction with yellow criss-cross lines mean?',
      options: [
        'You can stop in the box at any time',
        'You must not enter unless your exit is clear',
        'You must stop before entering',
        'Only buses can use it',
      ],
      correctAnswerIndex: 1,
      explanation:
          'You must not enter a box junction unless your exit is clear. The only exception is when turning right and only stopped by oncoming traffic.',
    ),
    TheoryQuestion(
      id: 'add_13',
      category: 'Vulnerable Road Users',
      question:
          'What should you do when approaching a horse and rider on the road?',
      options: [
        'Sound your horn to alert them',
        'Drive past quickly',
        'Slow down, give plenty of room, and pass wide and slow',
        'Flash your headlights',
      ],
      correctAnswerIndex: 2,
      explanation:
          'When passing horses, slow down, give them plenty of room, and pass wide and slow. Horses can be easily startled by noise and fast-moving vehicles.',
    ),
    TheoryQuestion(
      id: 'add_14',
      category: 'Incidents',
      question: 'A casualty isn\'t breathing normally. What should you do?',
      options: [
        'Give them something to drink',
        'Move them to the recovery position',
        'Start CPR (cardiopulmonary resuscitation)',
        'Keep them warm and wait',
      ],
      correctAnswerIndex: 2,
      explanation:
          'If a casualty isn\'t breathing normally after ensuring the airway is clear, you should start CPR immediately and call 999.',
    ),
    TheoryQuestion(
      id: 'add_15',
      category: 'Vehicle Handling',
      question:
          'When driving in heavy rain, what effect can standing water have on your vehicle?',
      options: [
        'It cleans the tyres',
        'It can cause aquaplaning',
        'It improves braking',
        'It has no effect',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Standing water on the road can cause aquaplaning, where the tyres lose contact with the road surface. Reduce speed and avoid harsh braking or steering.',
    ),

    TheoryQuestion(
      id: 'add_16',
      category: 'Documents',
      question: 'When must you notify the DVLA?',
      options: [
        'When you change your car radio',
        'When you change your address or have a medical condition affecting your driving',
        'When you change your tyre brand',
        'When you get a car wash',
      ],
      correctAnswerIndex: 1,
      explanation:
          'You must notify the DVLA if you change your address, name, or develop a medical condition that could affect your ability to drive safely.',
    ),

    TheoryQuestion(
      id: 'add_17',
      category: 'Road & Traffic Signs',
      question: 'What does a brown sign with white text indicate?',
      options: [
        'Motorway information',
        'Primary route',
        'Tourist attraction or destination',
        'Temporary hazard',
      ],
      correctAnswerIndex: 2,
      explanation:
          'Brown signs with white text indicate tourist attractions, tourist destinations, and points of interest.',
    ),

    TheoryQuestion(
      id: 'add_18',
      category: 'Safety & Your Vehicle',
      question: 'What\'s the recommended minimum pressure for steering?',
      options: [
        'There is no minimum; check your vehicle handbook',
        '20 PSI',
        '30 PSI',
        '40 PSI',
      ],
      correctAnswerIndex: 0,
      explanation:
          'Tyre pressures vary by vehicle – always check your vehicle handbook or the sticker inside your driver\'s door frame for the correct pressure.',
    ),

    TheoryQuestion(
      id: 'add_19',
      category: 'Alertness',
      question:
          'What should you do if you feel your concentration is fading while driving?',
      options: [
        'Drive faster to arrive sooner',
        'Open the window for fresh air',
        'Find a safe place to stop and rest',
        'Turn up the heating',
      ],
      correctAnswerIndex: 2,
      explanation:
          'If your concentration is fading, the safest action is to find a safe place to stop and take a break. Opening a window provides only a temporary fix.',
    ),

    TheoryQuestion(
      id: 'add_20',
      category: 'Motorway Rules',
      question: 'When can you use the hard shoulder on a motorway?',
      options: [
        'To overtake slow-moving traffic',
        'In an emergency or breakdown',
        'To take a phone call',
        'To have a rest',
      ],
      correctAnswerIndex: 1,
      explanation:
          'The hard shoulder should only be used in an emergency or breakdown. It is not a place to stop for convenience.',
    ),
  ];

  static List<String> get categories =>
      allQuestions.map((q) => q.category).toSet().toList()..sort();

  static List<TheoryQuestion> byCategory(String category) =>
      allQuestions.where((q) => q.category == category).toList();

  static List<TheoryQuestion> mockExam({int count = 50}) {
    final shuffled = List<TheoryQuestion>.from(allQuestions)..shuffle();
    return shuffled.take(count.clamp(1, allQuestions.length)).toList();
  }
}
