import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";

// a cannister that stores a single value
actor DBank {
  //stable var currentValue: Nat = 300; // type nat -> natural number
  stable var currentValue: Float = 300.0;
  currentValue := 300; // in place 
  Debug.print(debug_show(currentValue));

  stable var startTime: Int = Time.now();
  startTime := Time.now();
  Debug.print("Start time: " # debug_show(startTime));

  public func topUp(amount: Float) {
    currentValue += amount;

    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    let tempValue: Float  = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Insufficient funds");
    }
  };

  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNanoSec = currentTime - startTime;
    let timeElapsedSec = timeElapsedNanoSec / 1000000000;
    currentValue := currentValue * 1.01 ** Float.fromInt(timeElapsedSec);
    startTime := currentTime;
  }

  // topUp();
}