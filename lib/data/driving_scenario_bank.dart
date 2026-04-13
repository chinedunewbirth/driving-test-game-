import 'package:uk_driving_test/models/driving_scenario.dart';

class DrivingScenarioBank {
  static const List<DrivingScenario> allScenarios = [
    DrivingScenario(
      id: 'ds_01',
      title: 'Parallel Parking on a Busy Street',
      description:
          'Practice parallel parking between two vehicles on a residential street.',
      difficulty: 'Medium',
      steps: [
        ScenarioStep(
          narrative:
              'You\'ve found a parking space between a red car and a blue van on a residential street. The space is about 1.5 car lengths.',
          situation:
              'You are level with the front car. What should you do first?',
          choices: [
            ScenarioChoice(
              text: 'Signal left and begin reversing immediately',
              isCorrect: false,
              feedback:
                  'You should check mirrors and surroundings first before beginning the manoeuvre.',
              safetyScore: 30,
            ),
            ScenarioChoice(
              text:
                  'Pull alongside the front car, check mirrors and blind spots, then signal',
              isCorrect: true,
              feedback:
                  'Correct! Always check mirrors and blind spots before starting the parallel park.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Drive straight into the space forwards',
              isCorrect: false,
              feedback:
                  'Parallel parking requires reversing into the space for proper alignment.',
              safetyScore: 20,
            ),
            ScenarioChoice(
              text: 'Sound your horn to warn other road users',
              isCorrect: false,
              feedback:
                  'Sounding your horn is unnecessary and may cause confusion.',
              safetyScore: 10,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'re now beside the front car, about half a metre away. You\'ve checked your mirrors and signalled.',
          situation:
              'A pedestrian is walking along the pavement towards the space. What should you do?',
          choices: [
            ScenarioChoice(
              text:
                  'Continue the manoeuvre quickly before they reach the space',
              isCorrect: false,
              feedback:
                  'Rushing could endanger the pedestrian. Always wait for them to pass safely.',
              safetyScore: 20,
            ),
            ScenarioChoice(
              text:
                  'Wait for the pedestrian to pass before starting to reverse',
              isCorrect: true,
              feedback:
                  'Correct! Always give priority to pedestrians and ensure the area is clear.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Sound your horn to warn them',
              isCorrect: false,
              feedback:
                  'This could startle the pedestrian. Patience is the safest approach.',
              safetyScore: 15,
            ),
            ScenarioChoice(
              text: 'Abandon the parking attempt',
              isCorrect: false,
              feedback:
                  'There\'s no need to abandon – simply wait for the pedestrian to pass.',
              safetyScore: 40,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'The pedestrian has passed. You begin reversing slowly, turning the wheel to the left.',
          situation:
              'You notice your rear wheel is getting very close to the kerb. What do you do?',
          choices: [
            ScenarioChoice(
              text: 'Continue – the closer to the kerb the better',
              isCorrect: false,
              feedback:
                  'Getting too close risks hitting the kerb and damaging your tyre or wheel.',
              safetyScore: 30,
            ),
            ScenarioChoice(
              text: 'Straighten the wheel and adjust your position',
              isCorrect: true,
              feedback:
                  'Correct! Straighten up and make small adjustments to finish the park safely.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Accelerate to complete the manoeuvre faster',
              isCorrect: false,
              feedback:
                  'Never accelerate during a parking manoeuvre – slow and controlled is safest.',
              safetyScore: 10,
            ),
            ScenarioChoice(
              text: 'Pull forward and start the whole manoeuvre again',
              isCorrect: false,
              feedback:
                  'While this is safe, a small adjustment would be more efficient.',
              safetyScore: 60,
            ),
          ],
        ),
      ],
    ),
    DrivingScenario(
      id: 'ds_02',
      title: 'Roundabout Navigation',
      description:
          'Navigate a multi-lane roundabout during busy traffic conditions.',
      difficulty: 'Medium',
      steps: [
        ScenarioStep(
          narrative:
              'You\'re approaching a busy roundabout and need to take the third exit to go right.',
          situation: 'Which lane should you position your car in?',
          choices: [
            ScenarioChoice(
              text: 'The left lane',
              isCorrect: false,
              feedback:
                  'The left lane is for going straight ahead or turning left at a roundabout.',
              safetyScore: 20,
            ),
            ScenarioChoice(
              text: 'The right lane, signalling right',
              isCorrect: true,
              feedback:
                  'Correct! For right turns (past 12 o\'clock), use the right lane and signal right on approach.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Either lane – it doesn\'t matter',
              isCorrect: false,
              feedback:
                  'Lane discipline at roundabouts is important for safety and traffic flow.',
              safetyScore: 15,
            ),
            ScenarioChoice(
              text: 'Straddle both lanes',
              isCorrect: false,
              feedback: 'This is dangerous and blocks other road users.',
              safetyScore: 0,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'re in the right lane approaching the roundabout. Traffic is coming from your right on the roundabout.',
          situation: 'What should you do?',
          choices: [
            ScenarioChoice(
              text: 'Speed up to merge into the roundabout',
              isCorrect: false,
              feedback:
                  'You must give way to traffic from the right on the roundabout.',
              safetyScore: 10,
            ),
            ScenarioChoice(
              text:
                  'Give way to traffic from the right and wait for a safe gap',
              isCorrect: true,
              feedback:
                  'Correct! You must give way to traffic already on the roundabout from your right.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Flash your lights to ask them to let you in',
              isCorrect: false,
              feedback:
                  'Flashing lights can be misinterpreted. Wait for a natural gap in traffic.',
              safetyScore: 25,
            ),
            ScenarioChoice(
              text: 'Stop completely and wait until the roundabout is empty',
              isCorrect: false,
              feedback:
                  'You don\'t need to wait for the roundabout to be empty – just wait for a safe gap from the right.',
              safetyScore: 50,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'ve entered the roundabout and passed the second exit. Your exit is next.',
          situation: 'When should you signal left to leave the roundabout?',
          choices: [
            ScenarioChoice(
              text: 'After you\'ve passed the exit before yours',
              isCorrect: true,
              feedback:
                  'Correct! Signal left after passing the exit before the one you want to take, and check your left mirror.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'As soon as you enter the roundabout',
              isCorrect: false,
              feedback:
                  'Signalling left immediately would confuse other road users into thinking you\'re taking an earlier exit.',
              safetyScore: 20,
            ),
            ScenarioChoice(
              text: 'You don\'t need to signal when leaving',
              isCorrect: false,
              feedback:
                  'You should always signal left to show other road users your intention to leave the roundabout.',
              safetyScore: 15,
            ),
            ScenarioChoice(
              text: 'Only if there are other vehicles nearby',
              isCorrect: false,
              feedback:
                  'Always signal regardless of whether you think there are other vehicles – you may not see them all.',
              safetyScore: 30,
            ),
          ],
        ),
      ],
    ),
    DrivingScenario(
      id: 'ds_03',
      title: 'Emergency Stop',
      description: 'An unexpected hazard requires immediate emergency braking.',
      difficulty: 'Hard',
      steps: [
        ScenarioStep(
          narrative:
              'You\'re driving at 30 mph along a tree-lined residential road.',
          situation:
              'A child suddenly runs out from behind an ice cream van 30 metres ahead. What is your immediate reaction?',
          choices: [
            ScenarioChoice(
              text: 'Swerve to avoid the child',
              isCorrect: false,
              feedback:
                  'Swerving at speed could cause you to lose control or hit oncoming traffic. Braking firmly is safer.',
              safetyScore: 30,
            ),
            ScenarioChoice(
              text:
                  'Apply maximum braking pressure while keeping the steering straight',
              isCorrect: true,
              feedback:
                  'Correct! Brake firmly and progressively. Keep both hands on the wheel and steer straight.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Sound your horn to warn the child',
              isCorrect: false,
              feedback:
                  'While alerting the child might help, your first priority is to stop the vehicle.',
              safetyScore: 25,
            ),
            ScenarioChoice(
              text: 'Take your foot off the accelerator and coast to a stop',
              isCorrect: false,
              feedback:
                  'Coasting is too slow in an emergency. You need maximum braking effort.',
              safetyScore: 20,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'ve applied the brakes firmly. The car has ABS (Anti-lock Braking System), which you can feel pulsing through the brake pedal.',
          situation: 'What should you do about the pulsing brake pedal?',
          choices: [
            ScenarioChoice(
              text: 'Release the brake – something is wrong',
              isCorrect: false,
              feedback:
                  'The pulsing is the ABS working normally. Releasing the brake would increase stopping distance.',
              safetyScore: 10,
            ),
            ScenarioChoice(
              text:
                  'Keep firm pressure on the brake pedal – the ABS is working correctly',
              isCorrect: true,
              feedback:
                  'Correct! ABS prevents wheel lock-up. Maintain firm brake pressure and let the system work.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Pump the brakes on and off',
              isCorrect: false,
              feedback:
                  'With ABS, you should maintain steady pressure. Pumping reduces the system\'s effectiveness.',
              safetyScore: 35,
            ),
            ScenarioChoice(
              text: 'Apply the handbrake instead',
              isCorrect: false,
              feedback:
                  'The handbrake only works on the rear wheels and could cause a skid. Keep using the foot brake.',
              safetyScore: 15,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'ve stopped safely. The child has returned to the pavement. Traffic behind you has also stopped.',
          situation: 'What should you do now?',
          choices: [
            ScenarioChoice(
              text: 'Drive off immediately – the danger has passed',
              isCorrect: false,
              feedback:
                  'Take a moment to check your surroundings and ensure it\'s safe before moving off.',
              safetyScore: 40,
            ),
            ScenarioChoice(
              text:
                  'Check your mirrors, check for other hazards, and move off when safe',
              isCorrect: true,
              feedback:
                  'Correct! After an emergency stop, take a moment to assess your surroundings before moving off safely.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Get out of the car to check on the child',
              isCorrect: false,
              feedback:
                  'While concern for the child is good, leaving your vehicle in the road creates another hazard.',
              safetyScore: 45,
            ),
            ScenarioChoice(
              text: 'Rev the engine to warn other road users',
              isCorrect: false,
              feedback: 'This serves no purpose and could startle people.',
              safetyScore: 5,
            ),
          ],
        ),
      ],
    ),
    DrivingScenario(
      id: 'ds_04',
      title: 'Motorway Joining & Lane Discipline',
      description: 'Join a busy motorway and navigate lane changes safely.',
      difficulty: 'Hard',
      steps: [
        ScenarioStep(
          narrative:
              'You\'re on the slip road joining the M25. Traffic on the motorway is flowing at about 60 mph.',
          situation: 'What should you do on the slip road?',
          choices: [
            ScenarioChoice(
              text: 'Stop at the end of the slip road and wait for a gap',
              isCorrect: false,
              feedback:
                  'You should build up speed on the slip road to match motorway traffic, not stop.',
              safetyScore: 20,
            ),
            ScenarioChoice(
              text:
                  'Build up speed to match the motorway traffic, check mirrors & signal',
              isCorrect: true,
              feedback:
                  'Correct! Use the slip road to build speed, check mirrors and blind spot, and merge safely.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Drive slowly and let motorway traffic adjust around you',
              isCorrect: false,
              feedback:
                  'Entering a motorway at low speed is extremely dangerous.',
              safetyScore: 10,
            ),
            ScenarioChoice(
              text: 'Flash your lights to alert motorway traffic',
              isCorrect: false,
              feedback:
                  'Focus on matching speed and finding a safe gap rather than flashing lights.',
              safetyScore: 25,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'ve successfully joined the motorway in the left lane (lane 1). There\'s a slow-moving lorry ahead.',
          situation: 'You want to overtake. What\'s the correct procedure?',
          choices: [
            ScenarioChoice(
              text: 'Undertake on the left',
              isCorrect: false,
              feedback:
                  'Undertaking (passing on the left) is illegal on motorways except in congestion.',
              safetyScore: 10,
            ),
            ScenarioChoice(
              text:
                  'Check mirrors, signal right, check blind spot, move to lane 2',
              isCorrect: true,
              feedback:
                  'Correct! Mirror-Signal-Manoeuvre. Check mirrors, signal, check blind spot, then move to lane 2.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Flash headlights at the lorry to move over',
              isCorrect: false,
              feedback:
                  'The lorry is in the correct lane. You should overtake using the proper procedure.',
              safetyScore: 15,
            ),
            ScenarioChoice(
              text: 'Tailgate the lorry until it moves',
              isCorrect: false,
              feedback:
                  'Tailgating is dangerous and illegal. Maintain a safe following distance.',
              safetyScore: 5,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'ve overtaken the lorry and you\'re now in lane 2. Lane 1 is clear ahead.',
          situation: 'What should you do?',
          choices: [
            ScenarioChoice(
              text: 'Stay in lane 2 – it\'s the faster lane',
              isCorrect: false,
              feedback:
                  'You should return to lane 1 when it\'s safe. Lane 2 is for overtaking only.',
              safetyScore: 30,
            ),
            ScenarioChoice(
              text: 'Check your mirrors and move back to lane 1 when safe',
              isCorrect: true,
              feedback:
                  'Correct! Always return to the left-hand lane when you\'ve finished overtaking. This keeps traffic flowing.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Move directly to lane 3 for higher speed',
              isCorrect: false,
              feedback:
                  'You should only use lane 3 for overtaking traffic in lane 2. Return to lane 1 first.',
              safetyScore: 15,
            ),
            ScenarioChoice(
              text: 'Brake to reduce speed in lane 2',
              isCorrect: false,
              feedback:
                  'Braking without reason in lane 2 is dangerous. Return to lane 1 instead.',
              safetyScore: 20,
            ),
          ],
        ),
      ],
    ),
    DrivingScenario(
      id: 'ds_05',
      title: 'Night Driving in Rain',
      description:
          'Navigate safely through urban and country roads at night in heavy rain.',
      difficulty: 'Hard',
      steps: [
        ScenarioStep(
          narrative:
              'It\'s 10 PM and raining heavily. You\'re driving on a well-lit urban road at 30 mph. Visibility is reduced.',
          situation: 'What lights should you be using?',
          choices: [
            ScenarioChoice(
              text: 'Full beam headlights and fog lights',
              isCorrect: false,
              feedback:
                  'Full beam will reflect off the rain and dazzle other drivers. Fog lights are only for when visibility drops below 100m.',
              safetyScore: 20,
            ),
            ScenarioChoice(
              text: 'Dipped headlights',
              isCorrect: true,
              feedback:
                  'Correct! In rain, use dipped headlights. They help you see and be seen without dazzling others.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Sidelights only',
              isCorrect: false,
              feedback:
                  'Sidelights alone don\'t provide enough illumination in heavy rain.',
              safetyScore: 25,
            ),
            ScenarioChoice(
              text: 'Hazard warning lights',
              isCorrect: false,
              feedback:
                  'Hazard lights should not be used while driving – they indicate you\'re stationary.',
              safetyScore: 10,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'ve left the urban area and are now on a country road. There are no street lights and the rain continues.',
          situation:
              'You see an oncoming vehicle approaching. What should you do with your headlights?',
          choices: [
            ScenarioChoice(
              text: 'Keep full beam on – you need to see ahead',
              isCorrect: false,
              feedback:
                  'Full beam headlights dazzle oncoming drivers. You must dip them.',
              safetyScore: 10,
            ),
            ScenarioChoice(
              text:
                  'Switch to dipped beam to avoid dazzling the oncoming driver',
              isCorrect: true,
              feedback:
                  'Correct! Always dip your headlights when you see oncoming traffic to avoid dazzling them.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Turn off your headlights completely',
              isCorrect: false,
              feedback:
                  'Turning off headlights makes you invisible and is extremely dangerous.',
              safetyScore: 0,
            ),
            ScenarioChoice(
              text: 'Flash your headlights to warn them',
              isCorrect: false,
              feedback:
                  'Flashing headlights could confuse or dazzle the other driver.',
              safetyScore: 20,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'The rain has intensified and there\'s standing water on the road.',
          situation:
              'You notice your steering feels lighter than normal. What\'s happening?',
          choices: [
            ScenarioChoice(
              text: 'Your power steering has failed',
              isCorrect: false,
              feedback:
                  'Light steering in standing water usually indicates aquaplaning, not a mechanical failure.',
              safetyScore: 25,
            ),
            ScenarioChoice(
              text:
                  'Your tyres may be aquaplaning – ease off the accelerator gently',
              isCorrect: true,
              feedback:
                  'Correct! Light steering in water means your tyres may have lost contact with the road. Ease off the accelerator gently – don\'t brake sharply.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Accelerate to drive through the water faster',
              isCorrect: false,
              feedback:
                  'Accelerating during aquaplaning can cause a complete loss of control.',
              safetyScore: 5,
            ),
            ScenarioChoice(
              text: 'Brake hard to slow down quickly',
              isCorrect: false,
              feedback:
                  'Braking hard during aquaplaning can cause the car to spin. Ease off the accelerator gently instead.',
              safetyScore: 15,
            ),
          ],
        ),
      ],
    ),
    DrivingScenario(
      id: 'ds_06',
      title: 'Bay Parking in a Car Park',
      description:
          'Reverse into a bay parking space in a supermarket car park.',
      difficulty: 'Easy',
      steps: [
        ScenarioStep(
          narrative:
              'You\'ve arrived at a busy supermarket car park. You spot an empty bay.',
          situation: 'What\'s the safest way to park in the bay?',
          choices: [
            ScenarioChoice(
              text: 'Drive forward into the space quickly',
              isCorrect: false,
              feedback:
                  'Reversing in gives better visibility when leaving. Rushing is never safe.',
              safetyScore: 40,
            ),
            ScenarioChoice(
              text:
                  'Reverse into the bay slowly, using mirrors and looking around',
              isCorrect: true,
              feedback:
                  'Correct! Reversing in is generally safer as you have better visibility when leaving.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Double park next to another car',
              isCorrect: false,
              feedback:
                  'Double parking blocks other vehicles and is inconsiderate and potentially illegal.',
              safetyScore: 5,
            ),
            ScenarioChoice(
              text: 'Park across two bays for easy exit',
              isCorrect: false,
              feedback:
                  'Taking two spaces is inconsiderate and selfish. Park properly in one bay.',
              safetyScore: 10,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'re reversing into the bay. A shopper walks behind your car.',
          situation: 'What should you do?',
          choices: [
            ScenarioChoice(
              text: 'Continue slowly – they\'ll move',
              isCorrect: false,
              feedback:
                  'Never assume a pedestrian will move. Stop immediately.',
              safetyScore: 15,
            ),
            ScenarioChoice(
              text: 'Stop immediately and wait for them to pass',
              isCorrect: true,
              feedback:
                  'Correct! Always stop and wait for pedestrians to clear before continuing.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Sound your horn',
              isCorrect: false,
              feedback:
                  'Sounding the horn in a car park could startle the pedestrian.',
              safetyScore: 20,
            ),
            ScenarioChoice(
              text: 'Speed up to get into the space before they cross',
              isCorrect: false,
              feedback: 'Speeding up near a pedestrian is extremely dangerous.',
              safetyScore: 0,
            ),
          ],
        ),
      ],
    ),
    DrivingScenario(
      id: 'ds_07',
      title: 'Traffic Light Sequence',
      description:
          'Navigate through various traffic light scenarios correctly.',
      difficulty: 'Easy',
      steps: [
        ScenarioStep(
          narrative:
              'You\'re approaching traffic lights at green. As you get closer, the light changes to amber.',
          situation:
              'You\'re close to the stop line and can\'t stop safely. What should you do?',
          choices: [
            ScenarioChoice(
              text: 'Brake hard to stop before the line',
              isCorrect: false,
              feedback:
                  'If you can\'t stop safely, braking hard could cause a rear-end collision.',
              safetyScore: 25,
            ),
            ScenarioChoice(
              text: 'Continue through if you cannot stop safely',
              isCorrect: true,
              feedback:
                  'Correct! If the light changes to amber and you cannot stop safely before the line, continue through.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Accelerate to beat the red light',
              isCorrect: false,
              feedback:
                  'Accelerating through a changing light is dangerous. Only continue if you cannot stop safely.',
              safetyScore: 20,
            ),
            ScenarioChoice(
              text: 'Reverse to give yourself more room',
              isCorrect: false,
              feedback: 'Reversing at a junction is dangerous.',
              safetyScore: 0,
            ),
          ],
        ),
        ScenarioStep(
          narrative:
              'You\'re first in the queue at a red traffic light. The lights change to red and amber together.',
          situation: 'What does red and amber together mean?',
          choices: [
            ScenarioChoice(
              text: 'Go immediately',
              isCorrect: false,
              feedback:
                  'Red and amber means the light is about to change to green, but you should wait for green.',
              safetyScore: 20,
            ),
            ScenarioChoice(
              text: 'Get ready to go, but wait for green before moving',
              isCorrect: true,
              feedback:
                  'Correct! Red and amber together means "prepare to go" but you must wait for the green light.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'It means the lights are broken',
              isCorrect: false,
              feedback:
                  'Red and amber is a normal part of the UK traffic light sequence.',
              safetyScore: 10,
            ),
            ScenarioChoice(
              text: 'Rev your engine to be ready',
              isCorrect: false,
              feedback:
                  'Revving your engine is unnecessary and demonstrates poor driving habits.',
              safetyScore: 15,
            ),
          ],
        ),
      ],
    ),
    DrivingScenario(
      id: 'ds_08',
      title: 'Navigating a Level Crossing',
      description: 'Safely approach and cross a railway level crossing.',
      difficulty: 'Medium',
      steps: [
        ScenarioStep(
          narrative:
              'You\'re approaching a level crossing. The warning lights begin to flash and the barriers start lowering.',
          situation: 'What should you do?',
          choices: [
            ScenarioChoice(
              text: 'Speed up to cross before the barriers come down',
              isCorrect: false,
              feedback:
                  'Never try to beat the barriers. This is extremely dangerous and could be fatal.',
              safetyScore: 0,
            ),
            ScenarioChoice(
              text: 'Stop behind the white line and wait',
              isCorrect: true,
              feedback:
                  'Correct! Stop behind the white line and wait for the lights to stop flashing and barriers to rise.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Reverse away from the crossing',
              isCorrect: false,
              feedback:
                  'Reversing could be dangerous if there\'s traffic behind. Stop and wait.',
              safetyScore: 30,
            ),
            ScenarioChoice(
              text: 'Zigzag around the barriers',
              isCorrect: false,
              feedback:
                  'Driving around barriers at a level crossing is illegal and potentially fatal.',
              safetyScore: 0,
            ),
          ],
        ),
        ScenarioStep(
          narrative: 'The train has passed but the lights are still flashing.',
          situation: 'What should you do?',
          choices: [
            ScenarioChoice(
              text: 'Cross now – the train has gone',
              isCorrect: false,
              feedback:
                  'Another train may be coming from the other direction. Wait for the lights to stop.',
              safetyScore: 10,
            ),
            ScenarioChoice(
              text:
                  'Wait until the lights stop flashing and the barriers are fully raised',
              isCorrect: true,
              feedback:
                  'Correct! Always wait until the lights stop flashing and barriers are fully raised – another train may follow.',
              safetyScore: 100,
            ),
            ScenarioChoice(
              text: 'Edge forward slowly to check',
              isCorrect: false,
              feedback: 'Do not move forward while lights are still flashing.',
              safetyScore: 15,
            ),
            ScenarioChoice(
              text: 'Follow the car in front across',
              isCorrect: false,
              feedback:
                  'Never follow another vehicle across while lights are flashing – make your own safety decisions.',
              safetyScore: 10,
            ),
          ],
        ),
      ],
    ),
  ];

  static DrivingScenario getById(String id) =>
      allScenarios.firstWhere((s) => s.id == id);
}
