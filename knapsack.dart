void main() {
  Element element1 = Element(weight: 2, value: 3);
  Element element2 = Element(weight: 3, value: 4);
  Element element3 = Element(weight: 4, value: 5);
  Element element4 = Element(weight: 5, value: 6);
  List<Element> elements = [
    element1,
    element2,
    element3,
    element4,
  ];
  backValues(elements, 8);
}

void backValues(List<Element> incomingValues, int backCapacity) {
  List<Element> result = [];

  // Entero que almacena el valor máximo que se puede tener en la mochila
  int maxValue = 0;

  for (int i = 0; i < incomingValues.length; i++) {
    // El peso por el que vamos a iniciar
    int testWeight = incomingValues[i].weight;
    // Usamos el peso de la mochila como inicial, porque es el máximo valor que puede tener el diferencial entre el peso de la mochila y el peso de un elemento
    int nearWeight = backCapacity;
    // Elemento que guarda el elemento elegido
    Element selectElement = incomingValues[i];
    // Entero que guarda la suma de los valores de los elementos que se van a agregar
    int totalValue = incomingValues[i].value;
    // Lista para guardar los pesos usados
    List<int> usedWeights = [testWeight];
    // Lista para guardar los elementos usados, se agrega el elemento i porque es en el que se basa la búsqueda de la mejor combinación
    List<Element> usedElements = [incomingValues[i]];
    bool changeTest = false;

    while (testWeight < backCapacity) {
      // El peso que queda en la mochila
      int remainingWeight = backCapacity - testWeight;

      for (int j = 0; j < incomingValues.length; j++) {
        // El peso que queda en la mochila si se agrega el elemento j
        int testNearWeight = remainingWeight - incomingValues[j].weight;
        if ((testNearWeight.abs() < nearWeight) &&
            ((incomingValues[j].weight + testWeight) <= backCapacity) &&
            !usedWeights.contains(incomingValues[j].weight)) {
          // Si el peso que queda en la mochila es menor al peso que se tenía antes, significa que mi peso actual es el más cercano al peso que necesito
          // Entonces guardo el peso actual y el peso del elemento que se va a agregar para sumarlo después
          nearWeight = testNearWeight;
          selectElement = incomingValues[j];
          changeTest = true;
        }
      }
      // Agrego el elemento que se va a agregar a la lista de elementos usados
      usedElements.add(selectElement);
      // Agrego el peso del elemento que se va a agregar a la lista de pesos usados
      usedWeights.add(selectElement.weight);
      // Hago la suma de los pesos de los elementos que se van a agregar
      if(changeTest){
        testWeight = testWeight + selectElement.weight;
        changeTest = false;
        testWeight = backCapacity;
      } 
      // Hago la suma de los pesos que se van agregar para tener el total
      totalValue = totalValue + selectElement.value;
    }

    if (totalValue > maxValue) {
      maxValue = totalValue;
      result.clear();
      result = [...usedElements];
    }

    usedWeights.clear();
  }

  print("El valor máximo que se puede tener en la mochila es: $maxValue" +
      "\nY los elementos que se pueden agregar son los siguientes: \n");
  for (int i = 0; i < result.length; i++) {
    print("Peso: ${result[i].weight}, Valor: ${result[i].value}");
  }
}

class Element {
  int weight;
  int value;
  Element({required this.weight, required this.value});
}
