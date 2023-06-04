# YouApp Test

Welcome to the YouApp Test repository! This repository contains the unit tests for the YouApp project.

## Code Coverage

To generate the code coverage report, follow these steps:

1. Run the following command to generate the code coverage report:

flutter test --coverage

2. Generate the HTML report by running the following command:

genhtml coverage/lcov.info -o coverage/html


3. Open the generated HTML report in your browser to view the code coverage results.

The code coverage report will provide valuable insights into the test coverage of the YouApp project.

Happy testing! If you have any questions or need further assistance, feel free to reach out.


## running integration test

flutter drive --target=test_driver/app.dart 