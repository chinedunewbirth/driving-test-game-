import 'package:uk_driving_test/models/hazard_clip.dart';

class HazardClipBank {
  static const List<HazardClip> allClips = [
    HazardClip(
      id: 'haz_01',
      title: 'Residential Street – Child Running Out',
      description:
          'You are driving along a residential street. Watch for a child chasing a ball between parked cars.',
      scenarioType: 'residential',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 18.0,
          deadlineSeconds: 28.0,
          description: 'A ball rolls into the road from between parked cars',
          positionX: 0.6,
          positionY: 0.5,
        ),
        HazardEvent(
          appearTimeSeconds: 22.0,
          deadlineSeconds: 30.0,
          description: 'A child runs into the road chasing the ball',
          positionX: 0.55,
          positionY: 0.45,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_02',
      title: 'Country Road – Tractor Emerging',
      description:
          'You are driving along a country road. Watch for slow-moving vehicles emerging from farm entrances.',
      scenarioType: 'rural',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 25.0,
          deadlineSeconds: 35.0,
          description:
              'A tractor begins pulling out from a farm gate on the left',
          positionX: 0.3,
          positionY: 0.5,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_03',
      title: 'Motorway – Vehicle Cutting In',
      description:
          'You are in the middle lane of a motorway. Watch for vehicles making sudden lane changes.',
      scenarioType: 'motorway',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 15.0,
          deadlineSeconds: 22.0,
          description:
              'A car in the left lane suddenly moves into your lane without signalling',
          positionX: 0.4,
          positionY: 0.45,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_04',
      title: 'Town Centre – Pedestrian Crossing',
      description:
          'You are approaching a busy town centre with shops on either side. Watch for pedestrians stepping into the road.',
      scenarioType: 'urban',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 12.0,
          deadlineSeconds: 20.0,
          description: 'A pedestrian steps off the kerb looking at their phone',
          positionX: 0.7,
          positionY: 0.5,
        ),
        HazardEvent(
          appearTimeSeconds: 35.0,
          deadlineSeconds: 45.0,
          description:
              'A group of children begin crossing at an unmarked point',
          positionX: 0.5,
          positionY: 0.45,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_05',
      title: 'Dual Carriageway – Breakdown Ahead',
      description:
          'You are travelling on a dual carriageway. Watch for a stationary vehicle in the lane ahead.',
      scenarioType: 'dual_carriageway',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 20.0,
          deadlineSeconds: 30.0,
          description:
              'A broken-down vehicle with hazard lights is stationary in the left lane',
          positionX: 0.5,
          positionY: 0.4,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_06',
      title: 'Roundabout – Cyclist in Blind Spot',
      description:
          'You are approaching a roundabout. Watch for vulnerable road users as you navigate the junction.',
      scenarioType: 'junction',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 10.0,
          deadlineSeconds: 18.0,
          description:
              'A cyclist is in your blind spot as you signal left to exit the roundabout',
          positionX: 0.3,
          positionY: 0.55,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_07',
      title: 'Suburban Road – Door Opening',
      description:
          'You are driving through a suburban area with parked cars. Watch for hazards from parked vehicles.',
      scenarioType: 'residential',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 22.0,
          deadlineSeconds: 30.0,
          description: 'A parked car door opens into your path',
          positionX: 0.35,
          positionY: 0.5,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_08',
      title: 'Night Driving – Unlit Vehicle',
      description:
          'You are driving on a country road at night. Watch for poorly lit or unlit hazards.',
      scenarioType: 'night',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 28.0,
          deadlineSeconds: 38.0,
          description: 'An unlit cyclist appears ahead in the road',
          positionX: 0.5,
          positionY: 0.45,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_09',
      title: 'School Zone – End of Day',
      description:
          'You are passing a school as children are being collected. Watch for unpredictable movements.',
      scenarioType: 'school',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 8.0,
          deadlineSeconds: 16.0,
          description: 'A school patrol officer steps into the road',
          positionX: 0.5,
          positionY: 0.5,
        ),
        HazardEvent(
          appearTimeSeconds: 30.0,
          deadlineSeconds: 40.0,
          description: 'A child runs across the road toward a waiting parent',
          positionX: 0.6,
          positionY: 0.48,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_10',
      title: 'Wet Road – Emergency Braking',
      description:
          'You are driving on a wet road. Watch for sudden stops from vehicles ahead.',
      scenarioType: 'wet',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 20.0,
          deadlineSeconds: 27.0,
          description:
              'The vehicle ahead brakes suddenly due to standing water',
          positionX: 0.5,
          positionY: 0.4,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_11',
      title: 'T-Junction – Obscured View',
      description:
          'You are approaching a T-junction with hedgerows limiting your view. Watch for emerging vehicles.',
      scenarioType: 'junction',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 18.0,
          deadlineSeconds: 26.0,
          description: 'A van pulls out from the side road without stopping',
          positionX: 0.6,
          positionY: 0.5,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_12',
      title: 'High Street – Delivery Van',
      description:
          'You are driving through a town. Watch for hazards caused by delivery vehicles.',
      scenarioType: 'urban',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 15.0,
          deadlineSeconds: 24.0,
          description:
              'A delivery van double-parked forces you into oncoming traffic',
          positionX: 0.4,
          positionY: 0.5,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_13',
      title: 'Bend in Road – Oncoming Vehicle',
      description:
          'You are on a winding B-road. Watch for oncoming vehicles on bends.',
      scenarioType: 'rural',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 22.0,
          deadlineSeconds: 29.0,
          description:
              'An oncoming vehicle drifts onto your side of the road around a blind bend',
          positionX: 0.5,
          positionY: 0.45,
        ),
      ],
    ),
    HazardClip(
      id: 'haz_14',
      title: 'Traffic Lights – Amber Gambler',
      description:
          'You are approaching traffic lights. Watch for vehicles running amber/red lights.',
      scenarioType: 'urban',
      durationSeconds: 60,
      hazards: [
        HazardEvent(
          appearTimeSeconds: 25.0,
          deadlineSeconds: 33.0,
          description:
              'A vehicle from the cross road runs a red light as you start to move on green',
          positionX: 0.6,
          positionY: 0.5,
        ),
      ],
    ),
  ];

  static HazardClip getById(String id) =>
      allClips.firstWhere((c) => c.id == id);

  static List<HazardClip> byType(String type) =>
      allClips.where((c) => c.scenarioType == type).toList();
}
