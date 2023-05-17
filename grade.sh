CPATH='.;lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [ ! -e student-submission/ListExamples.java ]; then
  echo "ERROR: Could not find ListExamples.java in the submission."
  exit 1
fi

# Copy the necessary files to the grading area
cp -r student-submission/ListExamples.java grading-area
cp -r TestListExamples.java grading-area
cp -r lib grading-area


# Compile the student's code and the JUnit test cases
cd grading-area

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java

# Check if the compilation was successful
if [ $? -ne 0 ]; then
  echo "ERROR: Compilation failed. Please check your code and try again."
  exit 1
fi

# Run the JUnit tests and print the results
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > results.txt

# Check if the tests were successful
if grep -q "FAILURES!!!" results.txt; then
  echo "FAIL"
else
  echo "PASS"
fi


