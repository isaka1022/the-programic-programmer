public class Car implements Drivable, Locatable {
  
}

// 以下の宣言ではコードは生成されない
// Drivableを実装するクラスでgetSpeedとstopという2つのメソッドを実装する必要があることを述べているだけ
public interface Drivable {
  double getSpeed();
  void stop();
}

public interface Locatable() {
  Corrdinate getLocation();
  boolean locationIsValid();
}
