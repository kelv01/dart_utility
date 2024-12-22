// Import necessary Dart libraries
import 'dart:io';

void main() async {
  print("Welcome to the Dart Utility Application!\n");

  while (true) {
    print("Choose an option:\n"
        "1. String Manipulation\n"
        "2. Collections Management\n"
        "3. File Handling\n"
        "4. Date and Time Operations\n"
        "5. Exit\n");

    stdout.write("Enter your choice: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stringManipulation();
        break;
      case '2':
        collectionsManagement();
        break;
      case '3':
        await fileHandling();
        break;
      case '4':
        dateTimeOperations();
        break;
      case '5':
        print("Exiting the application. Goodbye!");
        return;
      default:
        print("Invalid choice. Please try again.\n");
    }
  }
}

void stringManipulation() {
  stdout.write("Enter a string: ");
  String? input = stdin.readLineSync()?.trim();
  if (input == null || input.isEmpty) {
    print("Invalid input.\n");
    return;
  }

  print("Original String: $input");
  print("Reversed String: ${input.split('').reversed.join()}");
  print("Uppercase: ${input.toUpperCase()}");
  print("Lowercase: ${input.toLowerCase()}\n");

  stdout.write(
      "Enter a substring to extract (start index and length separated by a space): ");
  String? substringInput = stdin.readLineSync();
  if (substringInput != null) {
    var parts = substringInput.split(' ');
    if (parts.length == 2) {
      int start = int.tryParse(parts[0]) ?? -1;
      int length = int.tryParse(parts[1]) ?? -1;
      if (start >= 0 && length > 0 && start + length <= input.length) {
        print(
            "Extracted Substring: ${input.substring(start, start + length)}\n");
      } else {
        print("Invalid indices for substring extraction.\n");
      }
    }
  }
}

void collectionsManagement() {
  List<String> list = [];
  Set<String> set = {};
  Map<int, String> map = {};

  list.addAll(["Apple", "Banana", "Cherry"]);
  set.addAll({"Dog", "Cat", "Bird"});
  map.addAll({1: "One", 2: "Two", 3: "Three"});

  print("List: $list");
  print("Set: $set");
  print("Map: $map\n");

  print("Adding 'Dragonfruit' to list...");
  list.add("Dragonfruit");
  print("Updated List: $list\n");

  stdout.write("Enter an item to remove from the list: ");
  String? itemToRemove = stdin.readLineSync()?.trim();
  if (itemToRemove != null && list.contains(itemToRemove)) {
    list.remove(itemToRemove);
    print("Updated List after removal: $list\n");
  } else {
    print("Item not found in the list.\n");
  }
}

Future<void> fileHandling() async {
  stdout.write("Enter the source file name: ");
  String? sourceFileName = stdin.readLineSync()?.trim();

  stdout.write("Enter the destination file name: ");
  String? destinationFileName = stdin.readLineSync()?.trim();

  if (sourceFileName == null ||
      sourceFileName.isEmpty ||
      destinationFileName == null ||
      destinationFileName.isEmpty) {
    print("Invalid file names.\n");
    return;
  }

  try {
    final sourceFile = File(sourceFileName);
    final destinationFile = File(destinationFileName);

    if (await sourceFile.exists()) {
      String content = await sourceFile.readAsString();
      await destinationFile.writeAsString(content);
      print(
          "File copied successfully from '$sourceFileName' to '$destinationFileName'.\n");
    } else {
      print("Source file does not exist.\n");
    }

    stdout.write(
        "Do you want to append additional content to the file? (yes/no): ");
    String? appendChoice = stdin.readLineSync()?.toLowerCase();
    if (appendChoice == 'yes') {
      stdout.write("Enter content to append: ");
      String? appendContent = stdin.readLineSync();
      if (appendContent != null && appendContent.isNotEmpty) {
        await destinationFile.writeAsString(appendContent,
            mode: FileMode.append);
        print("Content appended successfully.\n");
      }
    }
  } catch (e) {
    print("An error occurred: $e\n");
  }
}

void dateTimeOperations() {
  DateTime now = DateTime.now();
  stdout.write("Enter a date (YYYY-MM-DD): ");
  String? dateString = stdin.readLineSync()?.trim();

  if (dateString == null || dateString.isEmpty) {
    print("Invalid date format. Please use YYYY-MM-DD.\n");
    return;
  }

  try {
    DateTime userDate = DateTime.parse(dateString);
    Duration difference = now.difference(userDate);

    print("Current Date and Time: $now");
    print("Entered Date: $userDate");
    print("Difference: ${difference.inDays} days\n");

    stdout
        .write("Enter another date (YYYY-MM-DD) to calculate weeks between: ");
    String? secondDateString = stdin.readLineSync()?.trim();
    if (secondDateString != null && secondDateString.isNotEmpty) {
      DateTime secondDate = DateTime.parse(secondDateString);
      int weeksDifference =
          (userDate.difference(secondDate).inDays.abs() / 7).floor();
      print("Weeks difference between dates: $weeksDifference weeks\n");
    }
  } catch (e) {
    print("Invalid date format. Please use YYYY-MM-DD.\n");
  }
}
