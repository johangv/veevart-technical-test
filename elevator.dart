/* 
Author: Johan Alberto Gil
Email: johan.gil@uao.edu.co*/

void main() {
  Map<int, int> map = {5:2, 29: 10, 13: 1, 10:1};
  elevatorMovement([5, 29, 13, 10], 4, map);
}

/* 
- Method to simulate elevator movement in a building.
- Receive a List of int, which are the registered floors that the elevator would move.
  An int which is the start floor and a map which indicates the registered floors at this
  form:
  key: floor,
  value: registeredFloor.
- The method go throught list of floors to searching for the most near floor, so the
  elevator chooses if starts going up or going down.
  When the elevator is going up, it just go to upper floors. On the other hand if it is going 
  down, it just go to below floors until finish a complete tour.
*/
void elevatorMovement(List<int> receivedFloors, int initialFloor, Map<int, int> floorsMap) {
  int currentFloor = initialFloor;
  // Integer to save the min floor difference, it starts on 29 beacuse is the 
  List<int> movedFloors = [initialFloor];
  List<int> aditionalFloors = [];
  int iteration = 0;
  bool up = getDirection(currentFloor);
  List<int> floors = [...receivedFloors];
  int? registeredFloor;

    while (iteration < 2) {
      // Initialize inFloor diference with the max building floor
      int minFloorDiference = 29;
      late int selectedFloor;
      // Initialize my movedFloors with my current floor
      movedFloors.add(currentFloor);
      print("Elevador en piso $currentFloor");
      // This condition is beacuse I want that this message not print if the elevator is
      // in the initial floor. 
      if(currentFloor != initialFloor) print("Elevador se detiene");
      if(registeredFloor != null) {
        print("Piso ingresado ${registeredFloor}");
        if (iteration == 1) registeredFloor = null;
      } 
      print("Elevador ${up ? "subiendo" : "bajando"}");
      /* Loop to find the next near floor for the elevator using a diference between
         currentFloors and list floors. I used .abs at this result to compare just
         positive numbers. 
      */
      for (int i = 0; i < floors.length; i++) {
        int currentFloorDiference = currentFloor - floors[i] ;
        if (minFloorDiference > currentFloorDiference.abs() && !movedFloors.contains(floors[i]) && ((up && (floors[i] > currentFloor) || (!up && (floors[i] < currentFloor))))) {
          minFloorDiference = currentFloorDiference.abs();
          selectedFloor = floors[i];
        }
      }
      // With the next floor obtained, the elevator start moving to it
      if ((currentFloor - selectedFloor).abs() != 1) {
        printElevatorMovement(currentFloor: currentFloor, objetiveFloor: selectedFloor, up: up);
      }

      // Finish the movement, mi new currentFloor is the selectedFloor obtained in my loop
      currentFloor = selectedFloor;

      // If the elevator is doing the first tour (just up or down) get the registered floor
      // at this floor and save the registered floor on my aditionalFloors list for the next tour 
      if (iteration < 1){
        registeredFloor = searchFloor(floorsMap, currentFloor);
        if (registeredFloor != null) aditionalFloors.add(registeredFloor);
      }
      /* Condition to change the elevator movement if it is at the last or the first floor
       I clear my moved floor and my floors beacause I want to do a new iteration with
       new floors*/
      if (currentFloor == 29 || currentFloor == 1){
        movedFloors.clear();
        iteration++;
        up = getDirection(currentFloor);
        floors.clear();
        floors = [...aditionalFloors];
      } 
    }

    print("Elevador en piso $currentFloor");
    print("Elevador se detiene");
}

/*Function to know if the elevator is going up or going down
  It should returns true if the elevator is going up or false is going down
  If the currentFloor - 29 is negative, so the elevator is going up and going down otherwise
 */
bool getDirection(int currentFloor) {
  late bool up;
  if ((currentFloor - 29) < 0) {
    up = true;
  } else {
    up = false;
  }

  return up;
}

/* 
  *Method to print the elevator movement if the next floor is most far than one floor
  *Receive an int which is the current elevator floor, the objective floor wich is the
  floor wich the elevator is going to move and a bool which indicates the elevator direction (up = true, down = false)
  *Example: If the currentValue is 1, objetiveFloor is 5 and the elevator is going up, 
  It should print something like this: "Elevador en piso 2,...3,...4"
*/
void printElevatorMovement({required int currentFloor, required int objetiveFloor, required bool up}) {
  int changerValue = up ? -1 : 1;
  
  int initial = currentFloor + (up ? 1 : -1);
  String numbers = "Elevador en piso $initial";

  while(initial != objetiveFloor + changerValue) {
    up ? initial ++ : initial--;
    numbers = "$numbers,...$initial";
  }

  print(numbers);
}

/*
  Method to get the registered floor in the current elevator floor
*/ 
int? searchFloor(Map<int, int> floorsMap, int currentFloor){
  int? floor;
  floorsMap.forEach((key, value) { 
    if (key == currentFloor){
      floor = value;
    }
  });

  return floor;
}
